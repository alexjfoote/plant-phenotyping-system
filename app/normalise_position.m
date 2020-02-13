function pc_normalised = normalise_position(pc)
    xyz_shifted = pc.Location;
    
    for i = 1:3
        xyz_shifted(:, i) = xyz_shifted(:, i) - min(xyz_shifted(:, i));
    end
    
    pc_normalised = pointCloud(xyz_shifted);
end