close all

% paths = {'C:\Users\alexj\Documents\sorghum_data\15-08-03\4_1', ...
%     'C:\Users\alexj\Documents\sorghum_data\15-08-03\4_3'};

% NRMSEs = statistical_tests(paths);

base_path = 'C:\Users\alexj\Documents\sorghum_data';

end_paths = get_end_paths(base_path, {});

% path = 'C:\Users\alexj\Documents\sorghum_data\15-08-03\9_1';

NRMSEs = statistical_tests(end_paths);

% folder_contents = dir(path);
% for j = 1:numel(folder_contents)
%     item = folder_contents(j);
%     
%     if ~item.isdir
%         if contains(item.name, 'segmentedMesh.ply')
%             file_path = fullfile(path, item.name);
%             pc_true = pcread(file_path);
%             
%             pc_true = shift_reference(pc_true, 0, false);
% 
%             figure;
%             pcshow(pc_true);
%         end
%         
%         if contains(item.name, 'pointCloud.ply')
%             file_path = fullfile(path, item.name);
%             pc_test = pcread(file_path);
% 
%             figure;
%             pcshow(pc_test);
%         end
%     end
% end
% [rmse, pc_registered] = point_cloud_accuracy(pc_true, pc_test);
% rmse
% 
% figure;
% pcshow(pc_registered);







