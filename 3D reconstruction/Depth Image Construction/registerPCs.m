function [pc_registered, tform_total, pc_rigid_aligned, rmse, rmse2] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene, merge, first_pc)
    gridSize = 6;    
    rmse_cutoff = 18;
    
    moving = pcdownsample(pc_new, 'gridAverage', gridSize);
    
%     fixed = pcdenoise(fixed);
%     moving = pcdenoise(moving);
    
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
    
    pc_rigid_aligned = pctransform(moving_transform, tform);
    
%     if rmse < rmse_cutoff   
%         fixed_scene = pcdownsample(pc_scene, 'gridAverage', gridSize);
% %         first_pc = pcdownsample(first_pc, 'gridAverage', gridSize);
% 
%         [D, ~, rmse2] = pcregistercpd(pc_rigid_aligned, fixed_scene);
% %         [D, ~, rmse2] = pcregistercpd(pc_rigid_aligned, first_pc);
%         pc_aligned = pctransform(pc_rigid_aligned, D);
%     else
%         pc_registered = pc_scene;
%         rmse2 = 0;
%         return
%     end
    
    pc_aligned = pc_rigid_aligned;
    rmse2 = 0;
    
    merge_size = 5;
    
    if merge && rmse < rmse_cutoff
        pc_registered = pcmerge(pc_scene, pc_aligned, merge_size);
        
%         pc_registered = pcdenoise(pc_registered);
    else
        pc_registered = pc_scene;
    end
end