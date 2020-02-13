close all

base_path = 'C:\Users\alexj\Documents\sorghum_data\15-08-03\9_3';

pc = pcread(fullfile(base_path, 'pointCloud.ply'));

% figure;
% pcshow(pc);

projection = get_projection(pc.Location(:, 1), pc.Location(:, 3));

skeleton = bwskel(projection, 'MinBranchLength', 50);
skeleton = bwmorph(skeleton, 'spur', 10);
skeleton = bwareafilt(skeleton, 1);

all_points = dedupe_skeleton_boundaries(bwboundaries(skeleton));
all_points = all_points{1};

base_point = all_points(1, :);

% base_point = [base_point(2), base_point(1)];

black = logical(zeros(550, 633));
black(all_points(:, 1), all_points(:, 2)) = 1;

figure;
imshow(black);

end_points = bwmorph(skeleton, 'endpoints');
leaf_tips = bwboundaries(end_points);
leaf_tips = leaf_tips(2:end);

leaf_tips = dedupe_skeleton_boundaries(leaf_tips);

branch_points = bwmorph(skeleton, 'branchpoints');
% figure;
% imshow(branch_points);
junctions = dedupe_skeleton_boundaries(bwboundaries(branch_points));

for i = 1:numel(junctions)
    junction = junctions{i};
    if size(junction, 1) > 1
        for j = 2:size(junction, 1)
            junctions{numel(junctions) + 1} = [];
            junctions(j+1:end) = junctions(j:end-1);
            junctions{j} = junction(j, :);
        end
        
        junctions{i} = junction(1, :);
    end
end

leaf_edges = {};
stem_edges = {};

new_edge = zeros(1, 2);

current_junction = base_point;

leaf_tip_pointer = 1;
junction_pointer = 1;
new_edge_pointer = 1;

for i = 1:size(all_points, 1)
    update = false;

    point = all_points(i, :);
    new_edge(new_edge_pointer, :) = point;

    leaf_tip = leaf_tips{leaf_tip_pointer};
    junction = junctions{junction_pointer};

    if point == leaf_tip
        leaf_edges{i} = new_edge;
        leaf_tip_pointer = leaf_tip_pointer + 1;
        update = true;
    elseif point == junction
        stem_edges{i} = new_edge;
        junction_pointer = junction_pointer + 1;
        update = true;
    end
    
    new_edge_pointer = new_edge_pointer + 1;

    if update
        if i+1 <= size(all_points, 1) && abs(all_points(i+1, 2) - current_junction(2)) > 1
            current_junction = junctions{junction_pointer - 1};
        end
        
        new_edge = zeros(1, 2);
        new_edge(1, :) = current_junction;
        new_edge_pointer = 2;
    end
end
            
figure;
imshow(projection);

figure;
imshow(skeleton);

% figure;
% for i = 1:numel(leaf_edges)
%     leaf_edge = leaf_edges{1};
%     plot(leaf_edge(:, 1), leaf_edge(:, 2));
%     hold on
% end