function pc = depthImage2PC(depth_im)
    % Converts a depth image to a point cloud

    im_dimensions = size(depth_im);

    height = im_dimensions(1);
    width = im_dimensions(2);

    points = zeros(height*width, 3);

    for i = 1:height
        for j = 1:width
            z = double(depth_im(i, j));
                           
            [x, y] = imagePoint2worldPoint(j, i, z, height, width);
            
            points(((i - 1) * width) + j, :) = [x, z, -y];
        end
    end
    
    pc = pointCloud(points);
    pc = normalise_position(pc);    
    pc = pcdownsample(pc, 'gridAverage', 1);
end