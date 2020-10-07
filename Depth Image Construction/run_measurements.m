% close all

path = 'C:\Users\alexj\Documents\sorghum_data\15-08-03\4_1\pointCloud.ply';

pc = pcread(path);

% figure;
% pcshow(pc);

get_measurements(pc);