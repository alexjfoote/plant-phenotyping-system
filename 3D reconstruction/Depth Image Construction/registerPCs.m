function [pc_registered, tform_total, pc_rigid_aligned, rmse, rmse2] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene, merge, first_pc)
    gridSize = 6;
    
    fixed = pcdownsample(pc_base, 'gridAverage', gridSize);
    moving = pcdownsample(pc_new, 'gridAverage', gridSize);
    
    fixed = pcdenoise(fixed);
    moving = pcdenoise(moving);
    
%     tform = pcregistericp(moving, fixed, 'Metric', 'pointToPlane', 'Extrapolate', true);
    [tform, ~, rmse] = pcregistericp(moving, fixed, 'Extrapolate', true);
%     tform = pcregistercpd(moving, fixed);
    
    if is_first_scene
        tform_total = tform;
%         pc_scene = pc_base;        
        pc_scene = fixed;
    else
        tform_total = affine3d(tform.T * tform_total.T);  
%         tform_total = tform_total + tform;
    end
    
%     pc_aligned = pctransform(pc_new, tform_total);
    pc_rigid_aligned = pctransform(moving, tform_total);
    
%     if rmse < 150   
% %         fixed_scene = pcdownsample(pc_scene, 'gridAverage', gridSize);
%         first_pc = pcdownsample(first_pc, 'gridAverage', gridSize);
% 
% %         [D, ~, rmse2] = pcregistercpd(pc_rigid_aligned, fixed_scene);
%         [D, ~, rmse2] = pcregistercpd(pc_rigid_aligned, first_pc);
%         pc_aligned = pctransform(pc_rigid_aligned, D);
%     else
%         pc_registered = pc_scene;
%         rmse2 = 0;
%         return
%     end
    
    
    pc_aligned = pc_rigid_aligned;
    rmse2 = 0;
    
    merge_size = 0.015;
%     merge_size = 0.1;
    
    if merge
        pc_registered = pcmerge(pc_scene, pc_aligned, merge_size);
        
%         pc_registered = pcdenoise(pc_registered);
    else
        pc_registered = pc_scene;
    end
end