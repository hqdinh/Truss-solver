% this calculates the local stiffness matrix of a truss of stiffness "k"
% oriented at "angle" degree from the global x axis
function k_local = truss_local_k(k, angle)

    c = cosd(angle);
    s = sind(angle);

    T = [ c -s 0 0;
          s c 0 0;
          0 0 c -s;
          0 0 s -c];
    unit = [1  0 -1  0
            0  0  0  0
            -1 0  1  0
            0  0  0  0];

    k_local = k * T * unit * T';

end