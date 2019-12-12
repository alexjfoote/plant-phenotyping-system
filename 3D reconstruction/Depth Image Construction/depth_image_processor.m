% close all

path = 'C:\Users\alexj\Documents\sorghum_data\4_3';

folder_contents = dir(path);

is_first_plant = true;
is_first_scene = true;

pc_count = -1;
tic
for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if ~item.isdir && contains(item.name, 'DepthImage')
        file_path = fullfile(path, item.name);
                
        pc_count = pc_count + 1;
        fprintf('Constructing point cloud from depth image %d\n', pc_count + 1);
        pc_new = depthImage2PC(file_path);
        
%         figure;
%         pcshow(pc_new);
%         break
    else
        continue
    end
    
    if mod(pc_count, 1) == 0
        merge = true;
    else
        merge = false;
    end
    
    if ~is_first_plant
        fprintf('Registering point cloud %d\n', pc_count + 1);
        if is_first_scene
            [pc_scene, tform_total, aligned_pc, rmse, rmse2] = registerPCs(0, pc_base, pc_new, 0, is_first_scene, merge, first_pc);
        else
            [pc_scene, tform_total, aligned_pc, rmse, rmse2] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene, merge, first_pc);
        end
        is_first_scene = false;
        
        rmse
        rmse2;
        
%         figure;
%         pcshow(pc_scene);
    else
%         aligned_pc = pc_new;    
        first_pc = pc_new;
    end
    
%     filename = sprintf('pointCloudAligned%d.ply', pc_count);        
%     pcwrite(aligned_pc, filename);
    
    is_first_plant = false;

    pc_base = pc_new;
end
toc

figure;
pcshow(pc_scene);

denoised = pcdenoise(pc_scene);
figure;
pcshow(denoised);