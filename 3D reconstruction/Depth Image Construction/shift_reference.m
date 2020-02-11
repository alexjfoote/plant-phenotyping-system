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
        disp('Flipping');
%         figure;
%         pcshow(pc);
        tform_flip = affine3d(get_transformation_matrix(pi, 'x'));
        pc = pctransform(pc, tform_flip);
%         figure;
%         pcshow(pc);
    end
        
    pc = rotate_to_principal_axis(pc);    
    
    pc = normalise_position(pc);
end