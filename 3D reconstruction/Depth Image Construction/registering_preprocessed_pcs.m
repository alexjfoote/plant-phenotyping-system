close all

path = 'C:\Users\alexj\OneDrive - University of Warwick\3rd Year Project\3D reconstruction\Depth Image Construction\Matlab Code\Pre-aligned Point Clouds';

folder_contents = dir(path);

is_first_plant = true;
is_first_scene = true;

pc_count = 0;
tic
for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if ~item.isdir
        file_path = fullfile(path, item.name);
        pc_new = pcread(file_path);
        
%         figure;
%         pcshow(pc_new);
%         break

        pc_count = pc_count + 1;
    else
        continue
    end
    
    base_exists = exist('pc_base', 'var');
    
    if ~is_first_plant
        if is_first_scene
            [pc_scene, tform_total, aligned_pc] = registerPCs(0, pc_base, pc_new, 0, is_first_scene);
        else
            [pc_scene, tform_total, aligned_pc] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene);
        end
        
        is_first_scene = false;
        
        figure;
        pcshow(pc_scene);
    else
        aligned_pc = pc_new;        
    end
    
%     filename = sprintf('pointCloudAligned%d.ply', pc_count);        
%     pcwrite(aligned_pc, filename);
    
    is_first_plant = false;
        
    pc_base = pc_new;       
end
toc