close all

path = 'C:\Users\alexj\Documents\sorghum_data\15-08-03\4_1';

RMSEs = statistical_tests(path);

% folder_contents = dir(path);
% tic
% for i = 1:numel(folder_contents)
%     item = folder_contents(i);
%     
%     if ~item.isdir
%         if contains(item.name, 'segmentedMesh')
%             file_path = fullfile(path, item.name);
%             pc_true = pcread(file_path);
%             
%             pc_true = normalise_position(pc_true);
% 
%             figure;
%             pcshow(pc_true);
%         end
%         
%         if contains(item.name, 'pointCloud')
%             file_path = fullfile(path, item.name);
%             pc_test = pcread(file_path);
% 
%             figure;
%             pcshow(pc_test);
%         end
%     end
% end
% toc
% tic
% [rmse, pc_registered] = point_cloud_accuracy(pc_true, pc_test);
% toc
% rmse
% 
% figure;
% pcshow(pc_registered);







