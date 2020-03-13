function pc_normalised = normalise_position(pc)
    % Shifts a point cloud such that the minimum values of x, y, z are 0
    
    xyz_shifted = pc.Location;
    
    for i = 1:3
        xyz_shifted(:, i) = xyz_shifted(:, i) - min(xyz_shifted(:, i));
    end
    
    pc_normalised = pointCloud(xyz_shifted);
end