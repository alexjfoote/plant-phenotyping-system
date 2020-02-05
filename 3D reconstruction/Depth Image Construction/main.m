close all

im_height = 424;
im_width = 512;
im_no = 11;

save = false;

% base_path = 'C:\Users\alexj\Documents\sorghum_data\15-08-10';
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

for i = 1:numel(folder_contents)
    item = folder_contents(i);
    
    if item.isdir && ~strcmp(item.name, '.') && ~strcmp(item.name, '..')
        count = count + 1;
        % path = fullfile(erase(mfilename('fullpath'), 'main'), '\Example Data');
        path = fullfile(base_path, item.name, '4_1');
%         path = fullfile(base_path, item.name);

        % Axis about which the plant is upright in the depth images (x or y)
        plant_axis = plant_axes(count);

        depth_ims = get_depth_ims(path, im_height, im_width, im_no, plant_axis);

        pc = construct_point_cloud(depth_ims);
        
        figure;
        pcshow(pc);

        [height, x_width, y_width, convex_hull_vol, LAI] = get_measurements(pc);
        
        heights(count) = height;
        x_widths(count) = x_width;
        y_widths(count) = y_width;
        convex_hull_vols(count) = convex_hull_vol;
        LAIs(count) = LAI;

        if save
            pc_filename = fullfile(path, 'pointCloud.ply');
            pcwrite(pc, pc_filename);
        end
    end
    
    if count == 3
        break
    end
end

figure;
plot(heights);
figure;
plot(x_widths);
figure;
plot(y_widths);
figure;
plot(convex_hull_vols);
figure;
plot(LAIs);