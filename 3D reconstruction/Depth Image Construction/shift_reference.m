function pc_shifted = shift_reference(pc_locations)
    xyz_shifted = pc_locations;
    
    z_copy = xyz_shifted(:, 3);
    
    xyz_shifted(:, 3) = -xyz_shifted(:, 2);
    xyz_shifted(:, 2) = -z_copy;
    xyz_shifted(:, 2) = xyz_shifted(:, 2) - min(xyz_shifted(:, 2));
    xyz_shifted(:, 3) = xyz_shifted(:, 3) - min(xyz_shifted(:, 3));

    pc_shifted = pointCloud(xyz_shifted);
end