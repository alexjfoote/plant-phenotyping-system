function pc = depthImage2PC(file_path)
    pixel_to_mm_scale_factor = 1.4089;
    base_distance = 500;
    
    max_z = 1200;
    max_x = 300;
    min_x = -300;
    min_y = -250;
    max_y = 350;   
%     max_y = 650;    
    
    depth_im = imread(file_path);

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
            
            if z < max_z && x > min_x && x < max_x && y < max_y && y > min_y
                points(((i - 1) * width) + j, :) = [x, y, z];
            end
        end
    end
    
    pc = pointCloud(points);
    
    pc = pcdenoise(pc);
end