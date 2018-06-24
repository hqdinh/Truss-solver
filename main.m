clc; close all; clear;
format shortE; x = realmax;
tic

% file extension assumed to be *.inp
inputfile = 'example4';
amp = 10;
[nodes, els] = truss_read(inputfile);
% at this point:
%     els = [ids  node1  node2  x1  y1  x2  y2  length  angles  E   A   k]
%     nodes = [ids   x   y   angle  Dp1 Dp2  Qp1 Qp2]
 
[D, Q, trusses] = truss_solve(nodes, els);

% Post processing
els_real = els;
els_amp = els;
displacements = D(trusses(:,3:end));
els_real(:,4:7) = els_real(:,4:7) + displacements;  % real displacements
els_amp(:,4:7) = els_amp(:,4:7) + amp*displacements;  % amplified displacements for plotting

L0 = els(:,8);
L = lengths_n_angles(els_real(:,4:7)); 
E = els(:, end-2);
epsilon = (L - L0) ./ L0;
sigma = epsilon .* E;
max_comp = min(sigma);
max_comp_el = els(find(sigma==max_comp),1);
max_tens = max(sigma);
max_tens_el = els(find(sigma==max_tens),1);
fprintf('Max compression stress : element number %i, magnitude = %.5e \n', max_comp_el, max_comp)
fprintf('Max tension stress     : element number %i, magnitude = %.5e \n', max_tens_el, max_tens)


truss_plot(nodes, els, els_real, els_amp, amp, sigma, 'Stress')