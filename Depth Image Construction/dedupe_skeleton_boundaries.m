function boundaries = dedupe_skeleton_boundaries(boundaries)
    for i = 1:numel(boundaries)
        points = boundaries{i};
        height = size(points, 1);
        boundaries{i} = points(1:round(height/2), :);
    end
end