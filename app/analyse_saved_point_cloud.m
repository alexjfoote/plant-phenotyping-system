function measurements = analyse_saved_point_cloud(path)
    pc = pcread(path);
    
    split_path = split(path, '\');
    full_file_name = split(split_path(end), '.');
    file_name = full_file_name(1);

    [height, x_width, y_width, convex_hull_vol, LAI] = get_measurements(pc, 0, true);

    measurements.height = height;
    measurements.x_width = x_width;
    measurements.y_width = y_width;
    measurements.convex_hull_vol = convex_hull_vol;
    measurements.LAI = LAI;
    
    if save_measurements
        save(fullfile(path, file_name + 'Measurements.mat'), '-struct', 'measurements'); 
    end
end