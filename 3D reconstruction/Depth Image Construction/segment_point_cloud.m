function pc_segmented = segment_point_cloud(pc, bounding_box)
    points = pc.Location;
    x = points(:, 1);
    y = points(:, 2);
    z = points(:, 3);
    
    segmented_indices = x > bounding_box(1) & x < bounding_box(2) & ...
        z > bounding_box(3) & z < bounding_box(4);

    seg_x = x(segmented_indices);
    seg_y = y(segmented_indices);
    seg_z = z(segmented_indices);

    pc_segmented = pointCloud([seg_x, seg_y, seg_z]);        
end