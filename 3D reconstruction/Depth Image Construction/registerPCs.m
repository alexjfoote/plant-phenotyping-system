function [pc_registered, tform_total, pc_aligned, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene, merge)
    gridSize = 5;
    
    fixed = pcdownsample(pc_base, 'gridAverage', gridSize);
    moving = pcdownsample(pc_new, 'gridAverage', gridSize);
    
%     tform = pcregistericp(moving, fixed, 'Metric', 'pointToPlane', 'Extrapolate', true);
    [tform, rmse] = pcregistericp(moving, fixed, 'Extrapolate', true);
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
    pc_aligned = pctransform(moving, tform_total);
    
    merge_size = 0.015;
    
    if merge
        pc_registered = pcmerge(pc_scene, pc_aligned, merge_size);
    else
        pc_registered = pc_scene;
    end
end