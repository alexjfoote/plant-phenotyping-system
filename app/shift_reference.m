function pc = shift_reference(pc_plant, pc_pot, do_vertical_rotate)   
    % Shifts a point cloud to the standardised position
    
    if do_vertical_rotate
        pc = rotate_to_vertical(pc_plant, pc_pot);
    else
        pc = pc_plant;
    end
    
    pc = rotate_to_principal_axis(pc);    
    
    pc = normalise_position(pc);
end