function vert_projection = get_vertical_projection(X, Y)
    round_X = int32(X);
    round_Y = int32(Y);
    
    norm_X = round_X - min(round_X) + 1;
    norm_Y = round_Y - min(round_Y) + 1;
    
    unique_coords = unique([norm_X, norm_Y], 'rows');
    unique_X = unique_coords(:, 1);
    unique_Y = unique_coords(:, 2);
    
    vert_projection = zeros(max(norm_Y), max(norm_X));
        
    directions = [0, 0; -1, 0; 1, 0; 0, -1; 0, 1; 1, 1; 1, -1; -1, 1; -1, -1]; 
    
    for i = 1:numel(unique_X)
        for j = 1:size(directions, 1)
            try
                vert_projection(unique_Y(i) + directions(j, 1), unique_X(i) + directions(j, 2)) = 1;
            catch
            end
        end
    end
    
    vert_projection = bwmorph(vert_projection, 'close');
    vert_projection = imfill(vert_projection, 'holes');
    
%     figure;
%     imshow(vert_projection);
end