function LAI = get_LAI(X, Y)
    round_X = int32(X);
    round_Y = int32(Y);
    
    norm_X = round_X - min(round_X) + 1;
    norm_Y = round_Y - min(round_Y) + 1;
    
    unique_coords = unique([norm_X, norm_Y], 'rows');
    unique_X = unique_coords(:, 1);
    unique_Y = unique_coords(:, 2);
    
    vert_projection = zeros(max(norm_Y), max(norm_X));
    tic
%     vert_projection(sub2ind(size(vert_projection), norm_Y, norm_X)) = 1;
        
    directions = [-1, 0; 1, 0; 0, -1; 0, 1; 1, 1; 1, -1; -1, 1;, -1, -1]; 
    
    for i = 1:numel(unique_X)
        i;
        for j = 1:size(directions, 1)
            try
                vert_projection(unique_Y(i) + directions(j, 1), unique_X(i) + directions(j, 2)) = 1;
            catch
            end
        end
    end
    
    processed = bwmorph(vert_projection, 'close');
    processed = imfill(processed, 'holes');
    
    figure;
    imshow(processed);
    
    dims = size(processed);
    
    LAI = nnz(processed)/(dims(1) * dims(2));
end