function [plant_pc, pot_pc] = remove_pot(pc)
    maxDistance = 30;
    
    roi = [-250, 250; 100, 400; -inf, inf];
    sampleIndices = findPointsInROI(pc, roi);
    
    [plane_model, inlierIndices, outlierIndices] = pcfitplane(pc, ...
            maxDistance, 'SampleIndices', sampleIndices);
        
    pot_plane = select(pc, inlierIndices);
    remain_pc = select(pc, outlierIndices);
    
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