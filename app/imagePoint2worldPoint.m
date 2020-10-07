function [world_x, world_y] = imagePoint2worldPoint(x, y, z, height, width)
    pixel_to_mm_scale_factor = 1.4089;
    focal_length = 1/pixel_to_mm_scale_factor;
    base_distance = 500;

    normalised_z = z/base_distance;
                           
    world_x = (x - width/2) * normalised_z / focal_length;
    world_y = (y - height/2) * normalised_z / focal_length;
end