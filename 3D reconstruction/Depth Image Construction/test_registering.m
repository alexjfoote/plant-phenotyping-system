gridSize = 10;
    
fixed = pcdownsample(pc1, 'gridAverage', gridSize);
moving = pcdownsample(pc2, 'gridAverage', gridSize);

figure;
pcshow(fixed);

tform = pcregistericp(moving, fixed, 'Metric', 'pointToPlane', 'Extrapolate', true);
% tform = pcregistercpd(moving, fixed);

pc_aligned = pctransform(pc2, tform);

merge_size = 0.015;
pc_registered = pcmerge(pc1, pc_aligned, merge_size);

figure;
pcshow(pc_registered);