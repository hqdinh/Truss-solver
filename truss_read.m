function [nodes, els] = truss_read(filename)
    input_path = 'input_files';
    filename = char(filename);
    filename = [filename '.inp'];
    fname = fullfile(pwd, input_path, filename);

    % File reading
    fid = fopen(fname,'rt');
    s = textscan(fid,'%s','Delimiter','\n'); 
    lines = lower(convertCharsToStrings(s{1}));  % makes everything lowercase
    lines = lines(~startsWith(lines, '**'));  % removes all comments
    lines = replace(lines, ' ', '');  % removes all spaces for simplicity
    fclose(fid);

    % Input reading
    [els, elset_map] = get_els(lines);
    [nodes, nset_map, els] = get_nodes(lines, els); 
    nodes = get_transform(lines, nodes, nset_map); 
    mat = get_elastic(lines);
    els = get_section(lines, els, elset_map, mat);
    nodes = get_bcs(lines, nodes, nset_map);
    nodes = get_cloads(lines, nodes, nset_map);
    % at this point:
    %     els = [ids  node1  node2  x1  y1  x2  y2  length  angles  A   k]
    %     nodes = [ids   x   y   angle  Dp1 Dp2  Qp1 Qp2]

end
 
function [els, elset_map] = get_els(lines)
    els = [];
    elset_map = containers.Map();
    for i=1:length(lines)
        line = lines(i); 
        if startsWith(line, "*element,")  
            assert(contains(line, "type=t2d2"), ['Element type must be T2D2. Error at line ', num2str(i)])
            tokens = strsplit(line, ',');
            elset_name = strsplit(tokens(contains(tokens, "elset=")), '=');
            elset_name = char(elset_name(end)); 
                        
            % reading elements and their nodes
            j = i + 1;
            temp = [];
            while ~startsWith(lines(j), '*')
                temp_line = lines(j); 
                % temp = [ node_id  x  y 0 ] 
                temp = [temp; str2double(strsplit(temp_line, ','))];
                j = j + 1;
            end 
            % temp = [ node_id  x  y  elset_id ] 
            el_ids = temp(:,1)';
            elset_map = set_add(elset_map, elset_name, el_ids);
            els = [els; temp];
        end  
        
        if startsWith(line, "*elset")
            elset_name = strsplit(line,'='); elset_name = char(elset_name(end));
            el_ids = str2double(strsplit(lines(i+1), ','));
            elset_map = set_add(elset_map, elset_name, el_ids);
        end
    end     
end

function [nodes, nset_map, els] = get_nodes(lines, els)
    nodes = [];
    nset_map = containers.Map();
    nset_name = '';
    % read input into nodes
    for i=1:length(lines)
        line = lines(i);
        if get_key(line) == "*node"
            if contains(line, "nset") 
                nset_name = strsplit(line,'=');
                nset_name = char(nset_name(end));
            end 
            j = i + 1;
            temp = [];
            while ~startsWith(lines(j), '*')
                temp_line = lines(j); 
                temp = [temp; str2double(strsplit(temp_line, ','))];
                j = j + 1;
            end 
            if length(nset_name) ~= 0
                nset_map = set_add(nset_map, nset_name, temp(:,1)');     
            end
            
            nodes = [nodes; temp];
            
        end

        if startsWith(line, "*nset")
            nset_name = strsplit(line,'='); nset_name = char(nset_name(end));
            nset_nodes = str2double(strsplit(lines(i+1), ','));
            nset_map = set_add(nset_map, nset_name, nset_nodes);
        end
    end
    
    % match nodes' coordinates to elements 
    find_indices(els(:,2), nodes(:,1));
    find_indices(els(:,3), nodes(:,1));
    xy1 = nodes(find_indices(els(:,2), nodes(:,1)), 2:3);
    xy2 = nodes(find_indices(els(:,3), nodes(:,1)), 2:3);
    coors = [xy1 xy2];
    % els = [ id node1 node2 x1 y1 x2 y2 lengths angles ]
    [lengths, angles] = lengths_n_angles(coors);
    els = [els coors lengths angles];
end

function nodes = get_transform(lines, nodes, nset_map)
    % add transformation angles to nodes (0 if not transformed)
    node_num = size(nodes, 1);
    nodes = [nodes zeros(node_num, 1)];
    angles = zeros(node_num, 1);
    for i=1:length(lines)
        line = lines(i); 
        if get_key(line) == "*transform"
            tokens = strsplit(line, ',');
            nset_name = strsplit(tokens(contains(tokens, "nset=")), '=');
            nset_name = char(nset_name(end)); 
            node_ids = nset_map(nset_name);
            indices = find_indices(node_ids, nodes(:,1));
            assert(isKey(nset_map, nset_name), 'nset in transform not defined')            
            coors = str2double(strsplit(lines(i+1), ',')); 
            angle = 180 * atan2(coors(2), coors(1)) / pi;  
            
            angles(indices) = angle;
            nodes(:, end) = nodes(:, end) + angles;
        end
    end
    % nodes = [ids   nset   x   y   angle]
end

function mat = get_elastic(lines)
    mat = containers.Map();
    for i=1:length(lines)
        if startsWith(lines(i), "*material")
            tokens = strsplit(lines(i), ',');
            mat_name = strsplit(tokens(contains(tokens, "name=")), '=');
            mat_name = char(mat_name(end));
            
            assert(startsWith(lines(i+1),'*elastic'), 'Material card must be followed by Elastic card');

            line = str2double(strsplit(lines(i+2), ',')); 
            E = line(1);
            set_add(mat, mat_name, E); 
        end
    end 
end

function els = get_section(lines, els, elset_map, mat)
    % add cross-section areas and stiffness to els
    % now: els = [ids  node1  node2  x1  y1  x2  y2  lengths  angles]
    node_num = size(els, 1);
    els = [els zeros(node_num, 3)];
    % now: els = [ids  node1  node2  x1  y1  x2  y2  lengths  angles  E   A   k]
%     areas = zeros(node_num, 1); 
%     E = zeros(node_num, 1);
    for i=1:length(lines)
        line = lines(i); 
        if get_key(line) == "*solidsection"  % because removed all spaces 
            tokens = strsplit(line, ',');
            elset_name = strsplit(tokens(contains(tokens, "elset=")), '=');
            elset_name = char(elset_name(end)); 
            mat_name = strsplit(tokens(contains(tokens, "material=")), '=');
            mat_name = char(mat_name(end));
            
            el_ids = elset_map(elset_name); 
            indices = find_indices(el_ids, els(:,1));
            assert(isKey(elset_map, elset_name), 'elset in transform not defined');
            area = str2double(lines(i+1));
            E = mat(mat_name);
            
            els(indices, end-1) = area;
            els(indices, end-2) = E;         
        end
    end  
    k = els(:, end-2) .* els(:, end-1) ./ els(:,8);
    els(:,end) = k; 
%   els = [ids  node1  node2  x1  y1  x2  y2  length  angles  E   A   k]
end

function nodes = get_bcs(lines, nodes, nset_map)
    x = realmax;
    bcs = []; 
    for i=1:length(lines)
        line = lines(i);
        if get_key(line) == "*boundary"
            j = i + 1;
            while ~startsWith(lines(j), '*')
                line = str2double(strsplit(lines(j), ','));
                bcs = [bcs; line];
                j = j + 1;
            end
        end
    end
    bcs(:,3) = (bcs(:,3)>=2)*2 + (bcs(:,3)==1);  % make anything larger than 2 equal 2
    ind = find_indices(bcs(:,1), nodes(:,1));
    
    temp = x*ones(size(nodes,1), 2);
    mag = bcs(:,end);
    for i=1:length(ind)
        temp(ind(i), bcs(i,2)) = mag(i);
        temp(ind(i), bcs(i,3)) = mag(i);        
    end  
    
    nodes = [nodes temp];   
    % nodes = [ids   x   y   angle  Dp1 Dp2]
end

function nodes = get_cloads(lines, nodes, nset_map)
    x = realmax;
    cloads = [];
    for i=1:length(lines)
        line = lines(i);
        if get_key(line) == "*cload"
            j = i + 1;
            while ~startsWith(lines(j), '*')
                line = str2double(strsplit(lines(j), ','));
                cloads = [cloads; line];
                j = j + 1;
            end
        end
    end
    
    ind = find_indices(cloads(:,1), nodes(:,1));
    temp = x*ones(size(nodes,1), 2);
    mag = cloads(:,end);
    
    for i=1:length(ind)
        temp(ind(i), cloads(i,2)) = mag(i); 
    end  
    nodes = [nodes temp];   
    % nodes = [ids   x   y   angle  Dp1 Dp2 Qp1 Qp2]
end

function set = set_add(set, name, ids)
    % this works for both elset and nset
    if isKey(set, name)
        set(name) = unique([set(name) ids]);
    else
        set(name) = ids;
    end
end

function key = get_key(line)
    line = strsplit(line, ',');
    key = line(1);
end
