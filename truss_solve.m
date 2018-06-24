function [D, Q, trusses] = truss_solve(nodes, els)
    x = realmax;

    Dp = nodes(:, 5:6)'; Dp = Dp(:);
    Qp = nodes(:, 7:8)'; Qp = Qp(:);

    for ii=1:length(Dp)
        if(Dp(ii) == x && Qp(ii) == x)
            Qp(ii) = 0;  % unspecified forces are assumed 0
        elseif(Dp(ii) ~= x && Qp(ii) ~= x)
            Qp(ii) = x;  % if both specified, force assume unknown
        end
    end 
    k = els(:,end);
    angles = els(:,9);
    dof1 = find_indices(els(:,2), nodes(:,1)) * 2 - 1;
    dof1 = [dof1, dof1+1];
    dof2 = find_indices(els(:,3), nodes(:,1)) * 2 - 1;
    dof2 = [dof2, dof2+1];
    trusses = [k angles dof1 dof2]; 

    K = truss_global_k(trusses);  % global stiffness matrix

    alpha = nodes(:, 4);
    lamda = coor_transform(alpha);  % coor transform matrix
    Kp = lamda*K*lamda';  % transformed global stiffness matrix
    [Dp, Qp] = solveDQ(Dp, Qp, Kp);  % calls solver
    D = lamda \ Dp;
    Q = lamda \ Qp;

end