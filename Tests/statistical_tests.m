function [CVRMSEs, p, NRMSEs] = statistical_tests(paths)
    count = 0;
    error_count = 0;
    
    for i = 1:numel(paths)
        path = paths{i};
        test_measurements_path = fullfile(path, 'pointCloudMeasurements.mat');
        true_measurements_path = fullfile(path, 'segmentedMeshMeasurements.mat');

        if isfile(test_measurements_path) && isfile(true_measurements_path)
            outlier_found = false;
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
                
                if abs(test_measure(end) - true_measure(end))/true_measure(end) > 0.9 && ~outlier_found ...
                        && (strcmp(field, 'height') || strcmp(field, 'convex_hull_volume'))
                    outlier_found = 1;
                    
                    error_count = error_count + 1;
                    
                    if mod(error_count, 1) == 0
                        pc = pcread(fullfile(path, 'pointCloud.ply'));

                        figure;
                        pcshow(pc);
                        
                        path
                        field
                    end
                end
            end
        else
            error_count = error_count + 1;
        end
    end
    
    error_count
    
    lims = [1700, 4, 30, 6*(10^8), 1, 1, 1];
    fields = fieldnames(test_measurements);
    for i = 1:numel(fields)
        field = fields{i};
        lim = lims(i);
        
        test_mean = mean(all_test_measurements.(field));
        true_mean = mean(all_true_measurements.(field));
        
        test = all_test_measurements.(field);
        true = all_true_measurements.(field);
        
        if count
            CVRMSEs.(field) = (sqrt(mean((test - true).^2)))/true_mean;
        else
            CVRMSEs.(field) = -1;
        end
        
        if count
            NRMSEs.(field) = (sqrt(mean((test - true).^2)))/(max(true) - min(true));
        else
            NRMSEs.(field) = -1;
        end
        
%         figure;
%         plot(true, test, 'r*');
%         ylim([0, lim]);
%         xlim([0, lim]);
        
        p.(field) = corrcoef(true, test);
    end
end