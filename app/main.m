close all

im_height = 424;
im_width = 512;
im_no = 11;

save_pc = false;
save_measurements = false;

% base_path = 'C:\Users\alexj\Documents\sorghum_data\15-08-20';
base_path = 'C:\Users\alexj\Documents\sorghum_data';

folder_contents = dir(base_path);

count = 0;

heights = zeros(4, 1);
x_widths = zeros(4, 1);
y_widths = zeros(4, 1);
convex_hull_vols = zeros(4, 1);
LAIs = zeros(4, 1);

plant_axes = ['y', 'y', 'x', 'x'];
% plant_axes = ['x'];
% remove_plane_axes = {'z'};
bounding_boxes = [250, 1500, 0, 1500;
    400, 1700, 0, 1500;
    400, 1700, 0, 1500;
    500, 2000, 0, 1800];

fore_back_thresholds = [250, 1500;
    250, 1800;
    250, 1800;
    250, 1800];
    
% tic
for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if item.isdir && ~strcmp(item.name, '.') && ~strcmp(item.name, '..') && strcmp(item.name, '15-08-03') 
        count = count + 1;
        % path = fullfile(erase(mfilename('fullpath'), 'main'), '\Example Data');
        path = fullfile(base_path, item.name, '4_1');
%         path = fullfile(base_path, item.name);
%         path = fullfile(base_path, '4_1');

%         generate_parameter_file(path, im_height, im_width, im_no, plant_axes(count), ...
%             true, true, bounding_boxes(count, :), save_pc, save_measurements);

        [pc, measurements] = analyse_plant(path);
        
        figure;
        pcshow(pc);
    end
    
    if count == 1
        break
    end
end
% toc
% figure;
% plot(heights);
% figure;
% plot(x_widths);
% figure;
% plot(y_widths);
% figure;
% plot(convex_hull_vols);
% figure;
% plot(LAIs);