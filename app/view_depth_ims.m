close all;

path = 'C:\Users\alexj\Documents\sorghum_data\15-08-20\4_1';

im_height = 424;
im_width = 512;
im_no = 12;

depth_ims = get_depth_ims(path, im_height, im_width, im_no, 'y');

for i = 1:im_no
    depth_im = uint16(depth_ims(:, :, i));
    
    max_value = double(max(depth_im, [], 'all'));
    
    figure;
    imagesc(depth_im);
    colorbar;
    
    mode_z = find_plant(depth_im, 2000);
    
    segmented_im = segment_depth_im(depth_im, 250, 1800); 
    
    figure;
    imagesc(segmented_im);
    colorbar;
    
    break
    
    pc = depthImage2PC(segmented_im);
    
    figure;
    pcshow(pc);

    pc = segment_point_cloud(pc, [500, 2000, 0, 2000]);

    figure;
    pcshow(pc);
    
    break
    
    figure;
    imshow(mat2gray(segmented_im));
    
%     pc = depthImage2PC(segmented_im);
    
%     max_distance = 40;    
%     reference_vector = [0, 0, 1];    
%     max_angle = 45;
%     confidence = 80;
%     
%     [model, inlier_indices, outlier_indices] = pcfitplane(pc, ...
%             max_distance, reference_vector, max_angle, 'Confidence', confidence);
    
%     [model, inlier_indices, outlier_indices] = pcfitplane(pc, ...
%             max_distance, 'Confidence', confidence);
    
%     pot_pc = select(pc, inlier_indices);
%     remain_pc = select(pc, outlier_indices);
%     
%     figure;
%     pcshow(remain_pc);
%     
%     [model, inlier_indices, outlier_indices] = pcfitplane(remain_pc, ...
%             25, reference_vector, max_angle, 'Confidence', confidence);
%         
%     remain_pc = select(remain_pc, outlier_indices);
    
%     figure;
%     pcshow(pc);
%     
%     figure;
%     pcshow(pot_pc);
    
%     figure;
%     pcshow(remain_pc);
%     
%     break
    
%     diff_im = imbinarize(segmented_im - segment_depth_im(uint16(depth_ims(:, :, i + 1)), mode_z));
%     
%     diff_im = bwmorph(diff_im, 'erode', 2);    
%     diff_im = medfilt2(diff_im, [3, 3]);
    
%     figure;
%     imshow(diff_im);
    
%     figure;
%     imshow(mat2gray(segmented_im));
%     
%     pc = depthImage2PC(segmented_im);
%     
%     figure;
%     pcshow(pc);
    
%     break
    
%     filename = sprintf('initial_segmentation%d.jpg', i);    
%     save_path = fullfile(path, 'Initial Segmentations', filename);
%     imwrite(segmented_im, save_path, 'BitDepth', 16);
end