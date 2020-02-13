function [rmse, pc_registered] = point_cloud_accuracy(pc_true, pc_test)
    grid_size = 10;    
    
    moving = pcdownsample(pc_test, 'gridAverage', grid_size);    
    fixed = pcdownsample(pc_true, 'gridAverage', grid_size);  
    
    [tform, ~, rmse] = pcregistericp(moving, fixed, 'Extrapolate', true);
    
    pc_aligned = pctransform(pc_test, tform);
%     pc_aligned = pc_test;
    
    pc_registered = pcmerge(pc_true, pc_aligned, 1);
end