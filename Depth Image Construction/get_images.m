function images = get_images(path, im_height, im_width, im_no, plant_axis, file_id, im_type)
    folder_contents = dir(path);
    
    rotate = false;
    
    if strcmp(plant_axis, 'x')
        height_store = im_height;
        im_height = im_width;
        im_width = height_store;
        
        rotate = true;
    end
    
    if strcmp(im_type, 'depth')    
        images = zeros(im_height, im_width, im_no);
    else
        images = zeros(im_height, im_width, 3, im_no);
    end
    
    im_count = 0;
    
    for i = 1:numel(folder_contents)
        item = folder_contents(i);

        if ~item.isdir && contains(item.name, file_id)
            im_count = im_count + 1;            
            
            file_path = fullfile(path, item.name);
            
            im = imread(file_path);
            
            if rotate
               im = imrotate(im, 90); 
            end
            
            if strcmp(im_type, 'depth')    
                images(:, :, im_count) = im;
            else
                images(:, :, :, im_count) = im;
        end
    end
end