function depth_ims = get_depth_ims(path, im_height, im_width, im_no)
    folder_contents = dir(path);
    depth_ims = zeros(im_height, im_width, im_no);
    
    im_count = 0;
    
    for i = 1:numel(folder_contents)
        item = folder_contents(i);

        if ~item.isdir && contains(item.name, 'DepthImage')
            im_count = im_count + 1;            
            
            file_path = fullfile(path, item.name);
            
            depth_im = imread(file_path);
            depth_ims(:, :, im_count) = depth_im;
        end
    end
end