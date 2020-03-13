function tform_matrix = get_transformation_matrix(angle, axis)
    % Computes the affine transformation matrix that rotates a set of
    % points by a given angle around a given axis

    if strcmp(axis, 'x')
        tform_matrix = [1 0 0 0;
            0 cos(angle) sin(angle) 0;
            0 -sin(angle) cos(angle) 0;
            0 0 0 1];
    elseif strcmp(axis, 'y')
        tform_matrix = [cos(angle) 0 -sin(angle) 0;
            0 1 0 0;
            sin(angle) 0 cos(angle) 0;
            0 0 0 1];
    else
        tform_matrix = [cos(angle) sin(angle) 0 0;
            -sin(angle) cos(angle) 0 0;
            0 0 1 0;
            0 0 0 1];
    end
end