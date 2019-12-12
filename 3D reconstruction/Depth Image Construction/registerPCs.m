function [pc_registered, tform_total, pc_aligned, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene)
    gridSize = 6;    
    rmse_cutoff = 18;
    
    moving = pcdownsample(pc_new, 'gridAverage', gridSize);
    
    if is_first_scene    
        pc_scene = pc_base;
        moving_transform = moving;
    else
        moving_transform = pctransform(moving, tform_total); 
    end    
    
    fixed = pcdownsample(pc_scene, 'gridAverage', gridSize);
    
    [tform, ~, rmse] = pcregistericp(moving_transform, fixed, 'Extrapolate', true);
    
    if is_first_scene      
        tform_total = tform;
    else
        tform_total = affine3d(tform.T * tform_total.T);  
    end
    
    pc_aligned = pctransform(moving_transform, tform);
    
    merge_size = 5;
    
    if merge && rmse < rmse_cutoff
        pc_registered = pcmerge(pc_scene, pc_aligned, merge_size);
    else
        pc_registered = pc_scene;
    end
end