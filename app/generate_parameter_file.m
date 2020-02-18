function generate_parameter_file(path, im_height, im_width, im_no, plant_axis, ...
    do_remove_plane, do_remove_pot, bounding_box, save_pc, save_measurements)

    parameters.im_height = im_height;
    parameters.im_width = im_width;
    parameters.im_no = im_no;
    parameters.plant_axis = plant_axis; 
    parameters.do_remove_plane = do_remove_plane;
    parameters.do_remove_pot = do_remove_pot;
    parameters.bounding_box = bounding_box;
    parameters.save_pc = save_pc;
    parameters.save_measurements = save_measurements;
    
    save(fullfile(path, 'parameters.mat'), '-struct', 'parameters');  
end