% close all

path = 'C:\Users\alexj\Documents\sorghum_data\4_1';

im_height = 424;
im_width = 512;
im_no = 11;

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
    pc = depthImage2PC(segmented_im);
    
    [plant_pc, pot_pc] = remove_pot(pc);
    
%     if i == 1
%         figure;
%         title('Original point cloud');
%         pcshow(pc, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
% 
%         figure;
%         title('Plant point cloud');
%         pcshow(plant_pc,  'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
% 
%         figure;
%         title('Pot point cloud');
%         pcshow(pot_pc,  'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
%     end
%     
%     break
    
%     figure;
%     pcshow(plant_pc,  'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');
%     
%     break

    pc_new = plant_pc;
    
    if ~is_first_plant
        fprintf('Registering point cloud %d\n', pc_count + 1);
        if is_first_scene
            [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(0, pc_base, pc_new, 0, 0, is_first_scene);
        else
            [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_prev, tform_total, is_first_scene);
        end
        
        rmse
        
%         figure;
%         pcshow(pc_scene);
    end
    
    is_first_plant = false;

    pc_base = pc_new;
end
toc

% figure;
% pcshow(pc_scene);

pc_scene = pcdownsample(pc_scene, 'gridAverage', 0.1);
tic
denoised = pcdenoise(pc_scene, 'NumNeighbors', 100, 'Threshold', 5);
toc
figure;
pcshow(denoised);