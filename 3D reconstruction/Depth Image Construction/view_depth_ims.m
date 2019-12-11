close all;

path = 'C:\Users\alexj\Documents\sorghum_data\plant_1\4_2\Depth Images';

folder_contents = dir(path);

for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if ~item.isdir
        file_path = fullfile(path, item.name);
        depth_im = imread(file_path);
        depth_im = mat2gray(depth_im);
        
        figure;
        imshow(depth_im);
    end
end