function principal_pc = rotate_to_principal_axis(pc)
    max_width = 0;
    principal_angle = 0;
    
    interval = 5;
    angle = interval*pi/180;
    
    tform_matrix = get_transformation_matrix(angle, 'z');
    tform = affine3d(tform_matrix);
    
    rotated_pc = pc;
    
    for i = 0:interval:180
        pc_matrix = rotated_pc.Location;    
        X = pc_matrix(:, 1);
        
        width = max(X) - min(X);
        
        if width > max_width
            max_width = width;
            principal_angle = i*pi/180;
        end
        
        rotated_pc = pctransform(rotated_pc, tform);
    end
    
    tform_matrix = get_transformation_matrix(principal_angle, 'z');
    tform = affine3d(tform_matrix);
    principal_pc = pctransform(pc, tform);
end