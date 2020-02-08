function [plant_pc, pot_plane] = remove_pot(pc, floor_plane)
    max_distance = 30;    
%     reference_vector = [0, 0, 1];    
    reference_vector = floor_plane.Normal;  
    max_angle = 20;
    confidence = 60;
    
    [plane_model, inlier_indices, outlier_indices] = pcfitplane(pc, ...
            max_distance, reference_vector, max_angle, 'Confidence', confidence);
        
    pot_plane = select(pc, inlier_indices);
    remain_pc = select(pc, outlier_indices);
    
    z_coord = -plane_model.Parameters(4)/plane_model.Parameters(3);
    
    height = size(remain_pc.Location, 1);
    
    distances = zeros(height, 1);
    
    for i = 1:height
        distances(i) = (remain_pc.Location(i, :) - [0, 0, z_coord]) * plane_model.Normal';
    end
    
    reference_distance = [0, 0, -z_coord] * plane_model.Normal';
    
    D = distances < 0;
    
    if reference_distance < 0
        plant_indices = find(D);
        pot_indices = find(~D);
    else
        plant_indices = find(~D);
        pot_indices = find(D);
    end
    
    plant_pc = select(remain_pc, plant_indices);
    pot_pc = select(remain_pc, pot_indices);
    pot_pc = pcmerge(pot_pc, pot_plane, 1);
end