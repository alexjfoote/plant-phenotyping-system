function pc = shift_reference(pc_plant, pc_pot)        
    num_points = 5000;
    width = 200;

    plane = zeros(num_points, 3);
    plane(:, 1) = randi(width, num_points, 1);
    plane(:, 2) = randi(width, num_points, 1) - width;
    
    pc_plane = pointCloud(plane);
    
    pc_plane = pcdenoise(pc_plane);
    [pc_reg, ~, tform_total, ~, ~] = registerPCs(0, pc_plane, pc_pot, 0, 0, true, inf);
    
%     figure;
%     pcshow(pc_reg);
    
    pc = pctransform(pc_plant, tform_total); 
    
    pc = rotate_to_principal_axis(pc);
    
    xyz_shifted = pc.Location;
    
    for i = 1:3
        xyz_shifted(:, i) = xyz_shifted(:, i) - min(xyz_shifted(:, i));
    end
    
    pc = pointCloud(xyz_shifted);
end