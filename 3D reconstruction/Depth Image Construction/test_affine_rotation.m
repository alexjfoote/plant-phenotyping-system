close all;

figure;
pcshow(pc1);

A = [  0.8660254,  0.0000000,  0.5000000, 0;
   0.0000000,  1.0000000,  0.0000000, 0;
  -0.5000000,  0.0000000,  0.8660254, 0;
  0, 0, 0, 1];
 
tform = affine3d(A);

pc_rotated = pctransform(pc1, tform);

figure;
pcshow(pc_rotated);