
function [lengths, angles] = lengths_n_angles(coors)
    % coors = [x1 y1 x2 y2]
    x1 = coors(:,1);
    y1 = coors(:,2);
    x2 = coors(:,3);
    y2 = coors(:,4);
    lengths = sqrt((x1 - x2).^2 + (y1 - y2).^2);     
    angles = atand((y1-y2)./(x1-x2));
    angels = (angles > 90) .* (angles - 180) + ...
             (angles <= -90) .* (angles + 180) + ...
             (angles <= 90) .* (angles > -90) .* angles;
end 