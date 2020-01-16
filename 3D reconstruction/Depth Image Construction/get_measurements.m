function [height, x_width, y_width, convex_hull_vol, LAI] = get_measurements(pc)
    pc_matrix = pc.Location;
    
    X = pc_matrix(:, 1);
    Y = pc_matrix(:, 2);
    Z = pc_matrix(:, 3);
    
    
    height = max(Z) - min(Z);
    x_width = max(X) - min(X);
    y_width = max(Y) - min(Y);
    
    [~, convex_hull_vol] = convhull(X, Y, Z);
    
    LAI = get_LAI(X, Y);
end 