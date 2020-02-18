function paths = get_end_paths(directory, paths)
    folder_contents = dir(directory);
    
    end_path = true;
    
    for i = 1:numel(folder_contents)
        item = folder_contents(i);
        if item.isdir && ~strcmp(item.name, '.') && ~strcmp(item.name, '..')
            end_path = false;
            paths = get_end_paths(fullfile(directory, item.name), paths);
        end
    end
    
    if end_path
        paths{numel(paths) + 1} = directory;
    end
end