function [pc, measurements] = analyse_plant(path)
    load(fullfile(path, 'parameters.mat'));
    
    depth_ims = get_depth_ims(path, im_height, im_width, im_no, plant_axis);
    pc = construct_point_cloud(depth_ims, do_remove_plane, do_remove_pot, bounding_box);

    [height, convex_hull_volume, LAI, plant_aspect_ratio, ...
        bi_angular_convex_hull_area_ratio] = get_measurements(pc);

    measurements.height = height;
    measurements.plant_aspect_ratio = plant_aspect_ratio;
    measurements.bi_angular_convex_hull_area_ratio = bi_angular_convex_hull_area_ratio;
    measurements.convex_hull_volume = convex_hull_volume;
    measurements.LAI = LAI;

    if save_pc
        pc_filename = fullfile(path, 'pointCloud.ply');
        pcwrite(pc, pc_filename);
    end
    
    if save_measurements
        save(fullfile(path, 'pointCloudMeasurements.mat'), '-struct', 'measurements'); 
    end
end