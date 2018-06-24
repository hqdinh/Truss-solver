function [D, Q] = solveDQ(D, Q, K)
    % Input description:
    % - K: global stiffness matrix. 
    % - D: deflection vector, put realmax for unknowns
    % - Q: force vector, put realmax for unknowns
    % Input requirements:
    % - D, Q = 1D array of same length L
    % - K = 2D array of size (L, L)
    x = realmax;

    assert(length(D)==length(Q), 'D and Q must have equal length');
    d_index = zeros(1, length(D));
    q_index = zeros(1, length(Q));
    for ii=1:length(D)
        d = D(ii) == x;
        q = Q(ii) == x;
        d_index(ii) = q*ii;
        q_index(ii) = d*ii; 
        fail_msg = sprintf('You must prescribe either D(%i) OR Q(%i)', ii, ii);
        assert(xor(d,q), fail_msg);
    end
    d_index(d_index==0) = [];
    q_index(q_index==0) = [];
    index = [d_index q_index];

    K = reorder(K, index);

    dbar = D(d_index);
    qbar = Q(q_index);

    dl = length(d_index);
    K11 = K(1:dl, 1:dl);
    K12 = K(1:dl, dl+1:end);
    K21 = K(dl+1:end, 1:dl);
    K22 = K(dl+1:end, dl+1:end);

    d = inv(K22) * (qbar - K21 * dbar);
    q = K11 * dbar + K12 * d;

    d = [dbar; d];
    q = [q; qbar];

    for ii=1:length(D)
        D(index(ii)) = d(ii);
        Q(index(ii)) = q(ii);
    end

end
