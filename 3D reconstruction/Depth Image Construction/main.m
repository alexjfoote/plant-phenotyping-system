close all

path = 'C:\Users\alexj\Documents\sorghum_data\4_1';

im_height = 424;
im_width = 512;
im_no = 12;

depth_ims = get_depth_ims(path, im_height, im_width, im_no);

is_first_plant = true;
is_first_scene = true;

pc_count = -1;

tic
for i = 1:im_no
    depth_im = uint16(depth_ims(:, :, i));
    
    segmented_im = segment_depth_im(depth_im);
                
    pc_count = pc_count + 1;
    fprintf('Constructing point cloud from depth image %d\n', pc_count + 1);
    pc_new = depthImage2PC(segmented_im);

    figure;
    pcshow(pc_new, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
    
    [plant_pc, pot_pc] = remove_pot(pc_new);
    
    figure;
    pcshow(plant_pc,  'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
    
    figure;
    pcshow(pot_pc,  'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
    break
    
%     if ~is_first_plant
%         fprintf('Registering point cloud %d\n', pc_count + 1);
%         if is_first_scene
%             [pc_scene, tform_total, aligned_pc, rmse] = registerPCs(0, pc_base, pc_new, 0, is_first_scene);
%         else
%             [pc_scene, tform_total, aligned_pc, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_total, is_first_scene);
%         end
%         is_first_scene = false;
%         
%         rmse
%         
% %         figure;
% %         pcshow(pc_scene);
%     end
%     
%     is_first_plant = false;
% 
%     pc_base = pc_new;
end
toc

% figure;
% pcshow(pc_scene);
% 
% denoised = pcdenoise(pc_scene);
% figure;
% pcshow(denoised);