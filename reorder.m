function k = reorder(matrix, order)
    dim = size(matrix);
    if dim(1) == 1 && dim(1) ~= dim(2) && dim(2) == length(order)
        k = matrix(order);
    elseif dim(1) == dim(2) && dim(1) == length(order)
        k = matrix(order, order);
    else
        k = 'Junk. Fix your input, fool!';
    end

end