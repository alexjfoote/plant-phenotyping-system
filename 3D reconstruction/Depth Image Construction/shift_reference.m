function pc = shift_reference(pc_locations, pc_floor)
    xyz_shifted = pc_locations;
    
    xyz_shifted(:, 2) = xyz_shifted(:, 2) - min(xyz_shifted(:, 2));
    xyz_shifted(:, 3) = xyz_shifted(:, 3) - min(xyz_shifted(:, 3));

    pc_shifted = pointCloud(xyz_shifted);
    
    floor_shifted = pc_floor.Location;

    floor_shifted(:, 2) = floor_shifted(:, 2) - min(floor_shifted(:, 2));
    floor_shifted(:, 3) = floor_shifted(:, 3) - min(floor_shifted(:, 3));

    pc_floor_shifted = pointCloud(floor_shifted);
        
    num_points = 5000;
    width = 800;
    
    plane = zeros(num_points, 3);
    plane(:, 1) = randi(width/10, num_points, 1);
    plane(:, 2) = randi(2 * width, num_points, 1) - width;
    
    pc_plane = pointCloud(plane);
    
    figure;
    pcshow(pc_floor_shifted);
    
    [~, ~, tform_total, ~, ~] = registerPCs(0, pc_plane, pc_floor_shifted, 0, 0, true);
    tform_total
    pc = pctransform(pc_shifted, tform_total); 
end