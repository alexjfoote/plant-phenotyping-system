function pc = construct_point_cloud(depth_ims)
    is_first_plant = true;
    is_first_scene = true;

    pc_count = 0;
    
    background_distance = 2000;
    rmse_cutoff = 15;

    for i = 1:size(depth_ims, 3)
        depth_im = uint16(depth_ims(:, :, i));

        plant_point = find_plant(depth_im, background_distance);

        segmented_im = segment_depth_im(depth_im, plant_point);

        pc_count = pc_count + 1;
        fprintf('Constructing point cloud from depth image %d\n', pc_count);
        pc = depthImage2PC(segmented_im);
        
%         figure;
%         pcshow(pc);

        [pc_no_floor, ~] = remove_floor(pc);
        
%         figure;
%         pcshow(pc_no_floor);

        [pc_plant, pc_pot_plane] = remove_pot(pc_no_floor);
        
%         figure;
%         pcshow(pc_plant);

        pc_new = pcdenoise(pc_plant, 'NumNeighbors', 25, 'Threshold', 0.01);
        
%         figure;
%         pcshow(pc_new);

        if ~is_first_plant
            fprintf('Registering point cloud %d\n', pc_count);
            if is_first_scene
                [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(0, pc_base, pc_new, 0, 0, is_first_scene, rmse_cutoff);
            else
                [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_prev, tform_total, is_first_scene, rmse_cutoff);
            end
            
            rmse
        end

        is_first_plant = false;

        pc_base = pc_new;
    end
    
    pc_scene = pcdownsample(pc_scene, 'gridAverage', 0.1);
    disp('Removing noise')
    pc_denoised = pcdenoise(pc_scene, 'NumNeighbors', 20, 'Threshold', 1);
    
    pc = shift_reference(pc_denoised.Location, pc_pot_plane);
end