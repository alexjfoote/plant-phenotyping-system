function [pc, measurements] = analyse_plant(path)
    % Analyses a plant by constructing its point cloud and extracting
    % measurements
    
    load(fullfile(path, 'parameters.mat'));
    
    depth_ims = get_depth_ims(path, im_height, im_width, im_no, plant_axis);
    
    pc = construct_point_cloud(depth_ims, do_remove_plane, do_remove_pot, ...
        depth_thresholds, bounding_box);

    [height, convex_hull_volume, PD_x, PD_y, PD_z, plant_aspect_ratio, ...
        bi_angular_convex_hull_area_ratio] = get_measurements(pc);

    measurements.height = height;
    measurements.plant_aspect_ratio = plant_aspect_ratio;
    measurements.bi_angular_convex_hull_area_ratio = bi_angular_convex_hull_area_ratio;
    measurements.convex_hull_volume = convex_hull_volume;
    measurements.PD_x = PD_x;
    measurements.PD_y = PD_y;
    measurements.PD_z = PD_z;

    if save_pc
        pc_filename = fullfile(path, 'pointCloud.ply');
        pcwrite(pc, pc_filename);
    end
    
    if save_measurements
        save(fullfile(path, 'pointCloudMeasurements.mat'), '-struct', 'measurements'); 
    end
end