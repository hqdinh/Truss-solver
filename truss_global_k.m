function k_global = truss_global_k(trusses)
% all nodes have to be numbered sequentially from 1 to the number of nodes

% Sample input:
% trusses = [k1 90   1  2   3   4
%            k2 0    7  8   3   4
%            k2 0    1  2   5   6
%            k3 45   1  2   7   8
%            k2 90   5  6   7   8
%            k2 0    7  8  11  12
%            k2 0    5  6  11  12
%            k3 45   5  6   9  10];
    printt = 0;  % change this to true if you want to print all local [k]

    k = trusses(:,1);
    angle = trusses(:,2);
    nodes = int8(trusses(:,3:6));
    N_nodes = max(nodes(:));  % max value of node numbers = number of nodes
    k_global = zeros(N_nodes, N_nodes);

    for ii=1:length(k)  
        local = truss_local_k(k(ii), angle(ii));
        if printt
            fprintf('\nTruss %i, stiffness matrix ', ii);
            local
        end

        for jj=1:4
            for kk=1:4
                row = nodes(ii,jj);
                col = nodes(ii,kk);
                k_global(row, col) = k_global(row, col) + local(jj,kk);
            end
        end
    end
end