path = 'C:\Users\alexj\Documents\sorghum_data\4_1';

folder_contents = dir(path);

is_first_plant = true;
is_first_scene = true;

pc_count = -1;

for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if ~item.isdir && contains(item.name, 'segmentedMesh')
        file_path = fullfile(path, item.name);
         pc = pcread(file_path);
         
         figure;
         pcshow(pc);
    end
end