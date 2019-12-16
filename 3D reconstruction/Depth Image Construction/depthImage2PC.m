function pc = depthImage2PC(depth_im)
    pixel_to_mm_scale_factor = 1.4089;
    base_distance = 500;

    im_dimensions = size(depth_im);

    height = im_dimensions(1);
    width = im_dimensions(2);

    points = zeros(height*width, 3);

    for i = 1:height
        for j = 1:width
            z = double(depth_im(i, j));
            
            normalised_z = z/base_distance;
                           
            x = (j - width/2) * pixel_to_mm_scale_factor * normalised_z;
            y = (i - height/2) * pixel_to_mm_scale_factor * normalised_z;
            
            points(((i - 1) * width) + j, :) = [x, y, z];
        end
    end
    
    pc = pointCloud(points);
    
%     pc = pcdenoise(pc);
end