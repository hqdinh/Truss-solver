function lamda = coor_transform(alpha)

    lamda = zeros(length(alpha), length(alpha));

    for i=1:length(alpha)
      j = (i-1)*2 + 1 ;  % just for a cleaner index
      temp = [ cosd(alpha(i))   sind(alpha(i))
               -sind(alpha(i))  cosd(alpha(i))];
      lamda(j:j+1, j:j+1) = temp;
    end
end
