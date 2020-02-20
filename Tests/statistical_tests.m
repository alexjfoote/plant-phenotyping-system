function NRMSEs = statistical_tests(paths)
    count = 0;
    
    for i = 1:numel(paths)
        path = paths{i};
        test_measurements_path = fullfile(path, 'pointCloudMeasurements.mat');
        true_measurements_path = fullfile(path, 'segmentedMeshMeasurements.mat');

        if isfile(test_measurements_path) && isfile(true_measurements_path)
            count = count + 1;
                
            test_measurements = load(test_measurements_path);
            true_measurements = load(true_measurements_path);

            fields = fieldnames(test_measurements);
            
            if count == 1
                for j = 1:numel(fields)
                    field = fields{j};
                    all_test_measurements.(field) = [];
                    all_true_measurements.(field) = [];
                end
            end
            
            for j = 1:numel(fields)
                field = fields{j};
                
                test_measure = all_test_measurements.(field);
                test_measure(end + 1) = test_measurements.(field);
                all_test_measurements.(field) = test_measure;
                
                true_measure = all_true_measurements.(field);
                true_measure(end + 1) = true_measurements.(field);
                all_true_measurements.(field) = true_measure;
            end
        end
    end
    
    fields = fieldnames(test_measurements);
    
    for i = 1:numel(fields)
        field = fields{i};
        
        if count
            NRMSEs.(field) = (sqrt(mean((all_test_measurements.(field) ...
                - all_true_measurements.(field)).^2)))/mean(all_true_measurements.(field));
        else
            NRMSEs.(field) = -1;
        end
    end
end