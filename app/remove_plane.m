function [pc_remain, plane_model] = remove_plane(pc, reference_axis, plant_side_point)
    max_distance = 50;
    
    if strcmp(reference_axis, 'x')        
        reference_vector = [1, 0, 0];
    elseif strcmp(reference_axis, 'y')        
        reference_vector = [0, 1, 0];
    elseif strcmp(reference_axis, 'z')   
        reference_vector = [0, 0, 1];
    end
    
    max_angle = 25;
    
    [plane_model, inlier_indices, outlier_indices] = pcfitplane(pc, ...
            max_distance, reference_vector, max_angle);
        
    pc_remain = select(pc, outlier_indices);
    pc_plane = select(pc, inlier_indices);
    
    z_coord = -plane_model.Parameters(4)/plane_model.Parameters(3);
    
    height = size(pc_remain.Location, 1);
    
    distances = zeros(height, 1);
    
    for i = 1:height
        distances(i) = (pc_remain.Location(i, :) - [0, 0, z_coord]) * plane_model.Normal';
    end
    
%     reference_distance = [0, 0, -z_coord] * plane_model.Normal';
    reference_distance = [0, 0, plant_side_point] * plane_model.Normal';
    
    D = distances < 0;
    
    if reference_distance < 0
        plant_indices = find(D);
    else
        plant_indices = find(~D);
    end
    
    pc_remain = select(pc_remain, plant_indices);
end