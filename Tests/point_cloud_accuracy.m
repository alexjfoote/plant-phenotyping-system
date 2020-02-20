function [rmse, pc_registered] = point_cloud_accuracy(pc_true, pc_test)
    grid_size = 1;    
    
    moving = pcdownsample(pc_test, 'gridAverage', grid_size);    
    fixed = pcdownsample(pc_true, 'gridAverage', grid_size);  
    
    [tform, ~, rmse] = pcregistericp(moving, fixed, 'Extrapolate', true, ...
        'MaxIterations', 30);
    
    if rmse > 15
        tform_flip = affine3d(get_transformation_matrix(pi, 'z'));
        moving = pctransform(moving, tform_flip);
        
        figure;
        pcshow(moving);
        
        [tform2, ~, rmse2] = pcregistericp(moving, fixed, 'Extrapolate', true, ...
            'MaxIterations', 30);
        
        if rmse2 < rmse
            tform = tform2;
        end
    end
    
    pc_aligned = pctransform(pc_test, tform);
%     pc_aligned = pc_test;
    
    pc_registered = pcmerge(pc_true, pc_aligned, grid_size);
end