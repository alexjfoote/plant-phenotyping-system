function mode_z = find_plant(depth_im)
    width = size(depth_im, 2);    
    centre = width/2;
    
    centre_strip = depth_im(:, centre - 50:centre + 50);
    
    [z_counts, edges] = histcounts(centre_strip, 100);
    z_counts = z_counts(2:end);
    [~, mode_z_index] = max(z_counts);
    
    mode_z = edges(mode_z_index + 1);
end