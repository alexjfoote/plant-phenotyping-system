function [pc, measurements] = analyse_plant(path)
    load(fullfile(path, 'parameters.mat'));
    
    depth_ims = get_depth_ims(path, im_height, im_width, im_no, plant_axis);
    pc = construct_point_cloud(depth_ims, do_remove_plane, do_remove_pot, bounding_box);

    [height, x_width, y_width, convex_hull_vol, LAI] = get_measurements(pc, true);

    measurements.height = height;
    measurements.x_width = x_width;
    measurements.y_width = y_width;
    measurements.convex_hull_vol = convex_hull_vol;
    measurements.LAI = LAI;

    if save_pc
        pc_filename = fullfile(path, 'pointCloud.ply');
        pcwrite(pc, pc_filename);
    end
    
    if save_measurements
        save(fullfile(path, 'pointCloudMeasurements.mat'), '-struct', 'measurements'); 
    end
end