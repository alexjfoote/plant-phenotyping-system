function [height, convex_hull_volume, LAI, plant_aspect_ratio, ...
    bi_angular_convex_hull_area_ratio] = get_measurements(pc)

    pc = shift_reference(pc, 0, false);

    pc_matrix = double(pc.Location);
    
    X = pc_matrix(:, 1);
    Y = pc_matrix(:, 2);
    Z = pc_matrix(:, 3);    
    
    height = max(Z) - min(Z);
    
    [~, XZ_conv_hull_area] = convhull(X, Z);
    [~, YZ_conv_hull_area] = convhull(Y, Z);
    
    bi_angular_convex_hull_area_ratio = XZ_conv_hull_area/YZ_conv_hull_area;
    
    [~, XY_conv_hull_area] = convhull(X, Y);
    
    [~, min_enclosing_circle_radius] = minboundcircle(X, Y);
    
    plant_aspect_ratio = height/min_enclosing_circle_radius;
    
    [~, convex_hull_volume] = convhull(X, Y, Z);
    
    vert_projection = get_vertical_projection(X, Y);
    
    dims = size(vert_projection);
    
%     LAI = nnz(vert_projection)/(dims(1) * dims(2));
    LAI = nnz(vert_projection)/XY_conv_hull_area;
end 