function [pc_registered, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_scene, pc_new, tform_prev, tform_total, is_first_scene, im_no)
    grid_size = 1;    
    rmse_cutoff = 20;
    
    moving = pcdownsample(pc_new, 'gridAverage', grid_size);
    
    if is_first_scene    
        moving_transform = moving;
    else
        moving_transform = pctransform(moving, tform_total); 
    end    
    
    fixed = pcdownsample(pc_scene, 'gridAverage', grid_size);    
    [tform, ~, rmse] = pcregistericp(moving_transform, fixed, ...
        'Extrapolate', true);
    
    if rmse < rmse_cutoff 
        pc_aligned = pctransform(moving_transform, tform);  
        pc_registered = pcmerge(pc_scene, pc_aligned, grid_size);
        
        tform_prev = tform;
    else
        pc_registered = pc_scene;
    end
    
    if is_first_scene && rmse < rmse_cutoff      
        tform_total = tform;
        is_first_scene = false;
    elseif is_first_scene
        tform_total = 0;
        is_first_scene = true;
    elseif rmse < rmse_cutoff
        tform_total = affine3d(tform.T * tform_total.T);  
    else
        tform_total = affine3d(tform_prev.T * tform_total.T); 
    end
end