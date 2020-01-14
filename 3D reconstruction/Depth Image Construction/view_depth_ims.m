close all;

path = 'C:\Users\alexj\Documents\sorghum_data\4_1_older';

im_height = 424;
im_width = 512;
im_no = 12;

depth_ims = get_depth_ims(path, im_height, im_width, im_no);

for i = 1:im_no
    depth_im = uint16(depth_ims(:, :, i));
    
    mode_z = find_plant(depth_im, 3000);
    
    segmented_im = segment_depth_im(depth_im, mode_z);
    
    figure;
    imshow(mat2gray(segmented_im));
    
%     break
    
%     filename = sprintf('initial_segmentation%d.jpg', i);    
%     save_path = fullfile(path, 'Initial Segmentations', filename);
%     imwrite(segmented_im, save_path, 'BitDepth', 16);
end