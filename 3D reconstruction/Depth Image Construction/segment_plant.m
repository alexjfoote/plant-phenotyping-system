close all

base_path = 'C:\Users\alexj\Documents\sorghum_data\15-08-03\9_3';

pc = pcread(fullfile(base_path, 'pointCloud.ply'));

% figure;
% pcshow(pc);

projection = get_projection(pc.Location(:, 1), pc.Location(:, 3));

% skeleton = bwskel(projection);
skeleton = bwskel(projection, 'MinBranchLength', 50);

% skeleton = bwmorph(projection, 'thin', inf);
skeleton = bwmorph(skeleton, 'spur', 10);


%% look at Bwboundaries


% figure;
% imshow(projection);

figure;
imshow(skeleton);