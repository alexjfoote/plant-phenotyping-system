close all

save = false;

path = fullfile(erase(mfilename('fullpath'), 'main'), '\Example Data');

im_height = 424;
im_width = 512;
im_no = 11;

% Axis about which the plant is upright in the depth images (x or y)
plant_axis = 'y';

background_distance = 3000;

depth_ims = get_depth_ims(path, im_height, im_width, im_no, plant_axis);

is_first_plant = true;
is_first_scene = true;

pc_count = 0;

tic
for i = 1:im_no
    depth_im = uint16(depth_ims(:, :, i));
    
    plant_point = find_plant(depth_im, background_distance);
    
    segmented_im = segment_depth_im(depth_im, plant_point);
                
    pc_count = pc_count + 1;
    fprintf('Constructing point cloud from depth image %d\n', pc_count);
    pc = depthImage2PC(segmented_im);
    
    [plant_pc, pot_pc] = remove_pot(pc);

    pc_new = plant_pc;
    
    if ~is_first_plant
        fprintf('Registering point cloud %d\n', pc_count);
        if is_first_scene
            [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(0, pc_base, pc_new, 0, 0, is_first_scene);
        else
            [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_prev, tform_total, is_first_scene);
        end
    end
    
    is_first_plant = false;

    pc_base = pc_new;
end
toc

pc_scene = pcdownsample(pc_scene, 'gridAverage', 0.1);
disp('Removing noise')
pc_denoised = pcdenoise(pc_scene, 'NumNeighbors', 100, 'Threshold', 1.5);

figure;
pcshow(pc_denoised, 'VerticalAxis', 'Y', 'VerticalAxisDir', 'Down');

if save
    pc_shifted = shift_reference(pc_denoised.Location);
    
    figure;
    pcshow(pc_shifted);
    
    pc_filename = fullfile(path, 'pointCloud.ply');
    pcwrite(pc_shifted, pc_filename);
end