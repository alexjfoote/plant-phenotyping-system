function measurements_4D = get_4D_measurements(base_path, plant_id)
    measurements_4D = {};
    
    count = 0;
    
    folder_contents = dir(base_path);
    
    for i = 1:numel(folder_contents)
        item = folder_contents(i);
        
        if item.isdir && ~strcmp(item.name, '.') && ~strcmp(item.name, '..')
            count = count + 1;
            path = fullfile(base_path, item.name, plant_id, 'pointCloudMeasurements.mat');
            
            measurements = load(path);
            
            measurements_4D{count} = measurements;
        end
    end
end