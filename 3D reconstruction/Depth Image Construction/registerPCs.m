function [pc_registered, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_first, pc_scene, pc_base, pc_new, tform_prev, tform_total, is_first_scene)
    grid_size = 1;    
    rmse_cutoff = 15;
    
    moving = pcdownsample(pc_new, 'gridAverage', grid_size);    
    fixed = pcdownsample(pc_base, 'gridAverage', grid_size);  
    
    [tform, ~, rmse] = pcregistericp(moving, fixed, 'Extrapolate', true);
    
    if is_first_scene && rmse < rmse_cutoff      
        tform_total = tform;
        tform_prev = tform;
        
        is_first_scene = false;
        
        pc_aligned = pctransform(moving, tform_total);  
        pc_registered = pcmerge(pc_base, pc_aligned, grid_size); 
        
    elseif is_first_scene
        tform_total = 0;
        is_first_scene = true;
        
        pc_registered = 0;
        
    elseif rmse < rmse_cutoff
        tform_total = affine3d(tform.T * tform_total.T);  
        tform_prev = tform;
        
        pc_aligned = pctransform(moving, tform_total);  
        
        moving = pcdownsample(pc_aligned, 'gridAverage', grid_size);    
%         fixed = pcdownsample(pc_first, 'gridAverage', gridSize); 
        fixed = pcdownsample(pc_scene, 'gridAverage', grid_size); 

        tform_tidy = pcregistericp(moving, fixed, 'Extrapolate', true);

        pc_registered = pctransform(pc_aligned, tform_tidy);
        pc_registered = pcmerge(pc_scene, pc_registered, grid_size);
        
%         tform_total = affine3d(tform_tidy.T * tform_total.T); 

    else
        tform_total = affine3d(tform_prev.T * tform_total.T);         
        pc_registered = pc_scene;
    end
end