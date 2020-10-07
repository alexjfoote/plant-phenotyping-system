function [pc_remain, pc_plane] = remove_floor(pc)
    max_distance = 50;
    
    reference_vector = [0, 0, 1];
    
    max_angle = 45;
    
    [~, inlier_indices, outlier_indices] = pcfitplane(pc, ...
            max_distance, reference_vector, max_angle);
        
    pc_remain = select(pc, outlier_indices);
    pc_plane = select(pc, inlier_indices);
end