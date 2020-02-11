function segmented_im = segment_depth_im(depth_im, plant_point, bounding_box)
    x_left = bounding_box(1);  
    x_right = bounding_box(2);
    y_top = bounding_box(3);
    y_bottom = bounding_box(4);
    
    z_width = 500;
    
    min_threshold = plant_point - z_width;
    max_threshold = plant_point + z_width;
    
%     distance_threshold_im = depth_im(1 + y_top:end - y_bottom, 1 + x_left:end - x_right);
    distance_threshold_im = depth_im;
    
    distance_threshold_im(distance_threshold_im > max_threshold | ...
        distance_threshold_im < min_threshold) = 0;
    
    segmented_im = distance_threshold_im;
    
%     bw_im = imbinarize(distance_threshold_im);
%     
%     bw_im = imfill(bw_im, 'holes');
%     
%     figure;
%     imshow(bw_im);
%     
%     column_counts = sum(bw_im);
%     
%     figure;
%     plot(column_counts);
end