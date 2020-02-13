close all

path = 'C:\Users\alexj\Documents\sorghum_data\plant_1\4_2\Depth Images';

folder_contents = dir(path);

pc_count = 1;

for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if ~item.isdir
        file_path = fullfile(path, item.name);
        pc_new = depthImage2PC(file_path);
        
        filename = sprintf('pointCloud%d.ply', pc_count);
        
%         pcwrite(pc_new, filename);
        
        pc_count = pc_count + 1;
    else
        continue
    end
end

figure;
pcshow(pc_new);

        