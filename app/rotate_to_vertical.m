function pc = rotate_to_vertical(pc_plant, pc_pot) 
    % Registers the extracted pot plane to a generated horizontal plane,
    % and applies the resultant transfrom to rotate the plant point cloud
    % to its vertical position

    num_points = 5000;
    width = 200;

    plane = zeros(num_points, 3);
    plane(:, 1) = randi(width, num_points, 1);
    plane(:, 2) = randi(width, num_points, 1) - width;
    
    pc_plane = pointCloud(plane);
    
    pc_pot = pcdenoise(pc_pot, 'NumNeighbors', 10, 'Threshold', 0.05);
    
    [~, ~, tform_total, ~, ~] = registerPCs(0, pc_plane, pc_pot, 0, 0, true, inf);

    [~, max_indices] = max(pc_plant.Location);
    [~, min_indices] = min(pc_plant.Location);
    
    max_index = max_indices(3);
    min_index = min_indices(3);
    
    pc = pctransform(pc_plant, tform_total); 
    
    if pc.Location(max_index, 3) < pc.Location(min_index, 3)
        switched = true;
    else
        switched = false;
    end
    
    if switched
        tform_flip = affine3d(get_transformation_matrix(pi, 'x'));
        pc = pctransform(pc, tform_flip);
    end
end