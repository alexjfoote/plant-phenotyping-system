function pc = construct_point_cloud(depth_ims, do_remove_plane, do_remove_pot, bounding_box)
    is_first_plant = true;
    is_first_scene = true;

    pc_count = 0;
    
%     background_distance = 1800;
    background_cutoff = 1800;
    foreground_cutoff = 250;
    rmse_cutoff = 10;
    
    reference_vector = [0, 0, 1];

    for i = 1:size(depth_ims, 3)
        depth_im = uint16(depth_ims(:, :, i));
%         plant_point = find_plant(depth_im, background_distance);

        segmented_im = segment_depth_im(depth_im, foreground_cutoff, background_cutoff);
        
%         if i == 1
%             figure;
%             imshow(mat2gray(depth_im));
% 
%             figure;
%             imshow(mat2gray(segmented_im));
%         end

        pc_count = pc_count + 1;
        fprintf('Constructing point cloud from depth image %d\n', pc_count);
        pc = depthImage2PC(segmented_im);
        
        if i == 1
            first_pc = pcdownsample(pc, 'gridAverage', 1);
            first_pc = pcdenoise(first_pc, 'NumNeighbors', 25, 'Threshold', 0.01);
            figure;
            pcshow(first_pc);
        end

        pc = segment_point_cloud(pc, bounding_box);
        
        if i == 1
            bbox_pc = pcdownsample(pc, 'gridAverage', 1);
            bbox_pc = pcdenoise(bbox_pc, 'NumNeighbors', 25, 'Threshold', 0.01);
            figure;
            pcshow(bbox_pc);
        end
        
%         break
        if do_remove_plane && do_remove_pot
            [pc, plane_model] = remove_plane(pc, reference_vector, bounding_box(4));
            [pc, pc_pot_plane] = remove_pot(pc, plane_model.Normal, bounding_box(4));
        elseif do_remove_plane
            pc = remove_plane(pc, reference_vector, bounding_box(4));
        elseif do_remove_pot
            [pc, pc_pot_plane] = remove_pot(pc, reference_vector, bounding_box(4));
        end
        
%         figure;
%         pcshow(pc);
        
%         figure;
%         pcshow(pc_plant);

        pc = pcdownsample(pc, 'gridAverage', 1);
        pc_new = pcdenoise(pc, 'NumNeighbors', 25, 'Threshold', 0.01);
        
        if i == 1
            figure;
            pcshow(pc_new);
        end

        if ~is_first_plant
            fprintf('Registering point cloud %d\n', pc_count);
            if is_first_scene
                [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(0, pc_base, pc_new, 0, 0, is_first_scene, rmse_cutoff);
            else
                [pc_scene, tform_prev, tform_total, is_first_scene, rmse] = registerPCs(pc_scene, pc_base, pc_new, tform_prev, tform_total, is_first_scene, rmse_cutoff);
            end
            
            rmse
            
%             figure;
%             pcshow(pc_scene);
        end

        is_first_plant = false;

        pc_base = pc_new;
    end
    
    pc = pcdownsample(pc_scene, 'gridAverage', 0.1);
    
    figure;
    pcshow(pc);
    
%     disp('Removing noise')
    pc = pcdenoise(pc, 'NumNeighbors', 50, 'Threshold', 0.5);
    
    if do_remove_pot
        pc = shift_reference(pc, pc_pot_plane, true);
    else
        pc = shift_reference(pc, 0, false);
    end
end