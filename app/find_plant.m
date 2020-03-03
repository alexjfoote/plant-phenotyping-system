function mode_z = find_plant(depth_im, background_distance)
    [height, width] = size(depth_im);    
    width_centre = width/2;
    height_centre = height/2;
    
    centre_strip = depth_im(height_centre - 100:height_centre + 100, ...
        width_centre - 100:width_centre + 100);
    
    centre_strip(centre_strip > background_distance) = 0;
    
    figure;
    imshow(mat2gray(centre_strip));
    
    [z_counts, edges] = histcounts(centre_strip, 100);
    z_counts = z_counts(2:end);
    [~, mode_z_index] = max(z_counts);
    
    mode_z = edges(mode_z_index + 1);
end