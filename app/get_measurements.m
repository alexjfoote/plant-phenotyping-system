function [height, convex_hull_volume, PD_x, PD_y, PD_z, plant_aspect_ratio, ...
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
    
    XZ_proj = get_projection(X, Z);
    YZ_proj = get_projection(Y, Z);
    XY_proj = get_projection(X, Y);
    
    PD_x = nnz(XZ_proj)/XZ_conv_hull_area;
    PD_y = nnz(YZ_proj)/YZ_conv_hull_area;
    PD_z = nnz(XY_proj)/XY_conv_hull_area;

%     PD_x = nnz(XZ_proj);
%     PD_y = nnz(YZ_proj);
%     PD_z = nnz(XY_proj);

%     PD_x = XZ_conv_hull_area;
%     PD_y = YZ_conv_hull_area;
%     PD_z = XY_conv_hull_area;
end 