# Plant Phenotyping System

## Aim
The project aims to develop a plant phenotyping framework that constructs 3-dimensional
(3D) models of plants from images and extracts useful metrics from the models to enable
the monitoring of plant traits over time. Additionally, methods for segmentation of the 3D
plant models will be investigated.

## Process

1. Get depth images from 360° around a plant
![Multi-view Depth Images](https://github.com/alexjfoote/plant-phenotyping-system/blob/master/Demo%20images/depth_image_montage.jpg)

2. Remove background using distance threshold
![Example segmentation](https://github.com/alexjfoote/plant-phenotyping-system/blob/master/Demo%20images/initial_segmentation.jpg)

3. Construct point cloud
![Example point cloud](https://github.com/alexjfoote/plant-phenotyping-system/blob/master/Demo%20images/point_cloud.jpg)

4. Fit a plane to the top of the pot and remove all points below the plane to leave only the plant
![Point cloud without pot](https://github.com/alexjfoote/plant-phenotyping-system/blob/master/Demo%20images/pc_pot_removed.jpg)

5. Register all point clouds to the same frame
![Registered Point Cloud](https://github.com/alexjfoote/plant-phenotyping-system/blob/master/Demo%20images/registered_pc.jpg)
