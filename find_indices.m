
function indices = find_indices(selected_ids, all_ids) 
    % this function returns the indices of 
    all_ids = all_ids(:);
    selected_ids = selected_ids(:)';
    n = length(all_ids);
    indices = mod(find(all_ids == selected_ids) - 1, n) + 1;
end