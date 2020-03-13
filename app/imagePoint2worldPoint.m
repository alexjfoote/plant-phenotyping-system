function [world_x, world_y] = imagePoint2worldPoint(x, y, z, height, width)
    % Converts a point in a depth image to a point in 3D space based on the
    % focal length of the camera. Default focal length is calculated from
    % a scale factor that was "empirically determined to represent the
    % distance between two pixels at a depth of 500mm", determined by the
    % publishers of the original sorghum dataset. See
    % https://github.com/MulletLab/SorghumReconstructionAndPhenotyping for
    % more information
    
    pixel_to_mm_scale_factor = 1.4089;
    focal_length = 1/pixel_to_mm_scale_factor;
    base_distance = 500;

    normalised_z = z/base_distance;
                           
    world_x = (x - width/2) * normalised_z / focal_length;
    world_y = (y - height/2) * normalised_z / focal_length;
end