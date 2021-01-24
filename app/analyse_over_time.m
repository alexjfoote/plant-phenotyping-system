function [pcs, measurements_4D] = analyse_over_time(base_path, plant_id)
    % Calls analyse_plant and passes it the path for each time point for a
    % particular plant

    pcs = {};
    measurements_4D = {};
    
    count = 0;
    
    folder_contents = dir(base_path);
    
    for i = 1:numel(folder_contents)
        item = folder_contents(i);
        
        if item.isdir && ~strcmp(item.name, '.') && ~strcmp(item.name, '..')
            count = count + 1;
            path = fullfile(base_path, item.name, plant_id);
            
            [pc, measurements] = analyse_plant(path);
            
            pcs{count} = pc;
            measurements_4D{count} = measurements;
        end
    end
end