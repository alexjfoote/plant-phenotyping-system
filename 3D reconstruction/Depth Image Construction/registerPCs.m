function [pc_registered, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_prev, tform_total, is_first_scene, rmse_cutoff)
    grid_size = 1;    
    
    moving = pcdownsample(pc_new, 'gridAverage', grid_size);    
    fixed = pcdownsample(pc_base, 'gridAverage', grid_size);  
    
    [tform, ~, rmse] = pcregistericp(moving, fixed, 'Extrapolate', true);
    
    if is_first_scene      
        if rmse < rmse_cutoff        
            tform_total = tform;
            tform_prev = tform;
            
            is_first_scene = false;

            pc_aligned = pctransform(moving, tform_total); 

            pc_registered = pcmerge(pc_base, pc_aligned, grid_size);         
        
        else
            tform_total = 0;
            tform_prev = 0;
            
            is_first_scene = true;

            pc_registered = 0;
        end
        
    else
        temp_tform_total = affine3d(tform_total.T * tform.T);
        pc_aligned = pctransform(moving, temp_tform_total);  
        
        moving = pcdownsample(pc_aligned, 'gridAverage', grid_size);  
        fixed = pcdownsample(pc_scene, 'gridAverage', grid_size); 

        [tform_tidy, ~, rmse_tidy] = pcregistericp(moving, fixed, ...
            'Extrapolate', true, 'MaxIterations', 40);
        
        if rmse_tidy < rmse_cutoff 
            tform_total = affine3d(temp_tform_total.T * tform_tidy.T); 
            tform_prev = tform;

            pc_registered = pctransform(pc_aligned, tform_tidy);
            pc_registered = pcmerge(pc_scene, pc_registered, grid_size);

        else
            tform_total = affine3d(tform_prev.T * tform_total.T);         
            pc_registered = pc_scene;
        end

        rmse = min(rmse, rmse_tidy);
    end
end