function RMSEs = statistical_tests(paths)
    for i = 1:numel(paths)
        path = paths{i};
        test_measurements_path = fullfile(path, 'pointCloudMeasurements.mat');
        true_measurements_path = fullfile(path, 'segmentedMeshMeasurements.mat');

        if isfile(test_measurements_path) && isfile(true_measurements_path)
            test_measurements = load(test_measurements_path);
            true_measurements = load(true_measurements_path);

            fields = fieldnames(test_measurements);

            for j = 1:numel(test_measurements)
                field = fields{j};
                all_test_measurements.field(end + 1) = test_measurements.field;
                all_true_measurements.field(end + 1) = true_measurements.field;
            end
        end
    end
    
    RMSEs.field = sqrt(mean((all_test_measurements.field - all_true_measurements.field).^2));
end