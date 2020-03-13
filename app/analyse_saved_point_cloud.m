function measurements = analyse_saved_point_cloud(path, save_measurements)
    % Extracts measurements from a saved point cloud

    pc = pcread(path);
    
    split_path = split(path, '\');
    folder_path = join(split_path(1:end-1), '\');
    full_file_name = split(split_path{end}, '.');
    file_name = full_file_name{1};

    [height, convex_hull_volume, PD_x, PD_y, PD_z, plant_aspect_ratio, ...
        bi_angular_convex_hull_area_ratio] = get_measurements(pc);

    measurements.height = height;
    measurements.plant_aspect_ratio = plant_aspect_ratio;
    measurements.bi_angular_convex_hull_area_ratio = bi_angular_convex_hull_area_ratio;
    measurements.convex_hull_volume = convex_hull_volume;
    measurements.PD_x = PD_x;
    measurements.PD_y = PD_y;
    measurements.PD_z = PD_z;
    
    if save_measurements
        save(fullfile(folder_path{1}, strcat(file_name, 'Measurements.mat')), '-struct', 'measurements'); 
    end
end