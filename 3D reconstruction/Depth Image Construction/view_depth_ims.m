close all;

path = 'C:\Users\alexj\Documents\sorghum_data\15-08-03\4_1';

im_height = 424;
im_width = 512;
im_no = 12;

depth_ims = get_depth_ims(path, im_height, im_width, im_no, 'y');

for i = 1:im_no
    depth_im = uint16(depth_ims(:, :, i));
    
%     figure;
%     imshow(mat2gray(depth_im));
    
%     pc = depthImage2PC(depth_im);
%     
%     figure;
%     pcshow(pc);
    
%     break
    
    mode_z = find_plant(depth_im, 3000);
    
    segmented_im = segment_depth_im(depth_im, mode_z);
    
%     figure;
%     imshow(mat2gray(segmented_im));
    
    pc = depthImage2PC(segmented_im);
    
    figure;
    pcshow(pc);
    
    break
    
%     filename = sprintf('initial_segmentation%d.jpg', i);    
%     save_path = fullfile(path, 'Initial Segmentations', filename);
%     imwrite(segmented_im, save_path, 'BitDepth', 16);
end