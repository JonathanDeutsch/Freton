function PlotTraces(panel, time, donor, acceptor, label, classfied_label, nshow, key)
% Plots msFRET traces in with pages
%
% Args:
%   ax: The axis to show plots
%   X: The matrix containing SiMREPS traces data
%   score: The ML classification score for each trace
%   order: The order to show traces.
%   nshow: The number of traces per page.
%   key: The key pressed that controls page up, down and reset.


    persistent mshow;
    if isempty(mshow)
        mshow = 0;
    end
    if key == "reset"
        mshow = 0;
    elseif key == "uparrow"
        mshow = mshow - nshow;
    elseif key == "downarrow"
        mshow = mshow + nshow;
    elseif key == "leftarrow"
        mshow = mshow - nshow;
    elseif key == "rightarrow"
        mshow = mshow + nshow;
    end
        
    if mshow < 0
        mshow = 0;
        return;
    end
    
    if mshow >= size(donor, 1)
        mshow = size(donor, 1);
        return
    end
    
    n_traces = min(nshow, size(donor, 1) - mshow);
    for i = 1 : n_traces
        sub_ax = subplot(nshow, 1, i, 'Parent', panel);
        plot(sub_ax, time, donor(mshow+i, :), '-', 'Color', [0 0.4470 0.7410]);
        hold(sub_ax, 'on')
        plot(sub_ax, time, acceptor(mshow+i, :), 'r-');
        if ~isempty(label)
            annotate(sub_ax, time, donor(mshow+i, :), acceptor(mshow+i, :), label(mshow+i, :), [0.9290 0.6940 0.1250], 'manual');
        end
        if ~isempty(classfied_label)
            annotate(sub_ax, time, donor(mshow+i, :), acceptor(mshow+i, :), classfied_label(mshow+i, :), [0.4940 0.1840 0.5560], 'ML');
        end
        hold(sub_ax, 'off')
        if i < n_traces
            set(sub_ax,'xticklabel',[])  % Hides duplicated x ticks.
        end
    end
end

function annotate(ax, time, donor, acceptor, label, color, annotation_text)
    n_frame = numel(label);
    last_label = false;
    current_region = 0;
    region_map = containers.Map;
    for i = 1 : n_frame
        if label(i)
            if ~last_label
                current_region = current_region + 1;
            end
            key = num2str(current_region);
            if region_map.isKey(key)
                region_map(key) = [region_map(key); i];
            else
                region_map(key) = i;
            end
        end
        last_label = label(i);
    end
    if region_map.isempty
        return
    end
    for region_cell = region_map.values
        region = cell2mat(region_cell);
        max_donor = max(donor(region));
        min_donor = min(donor(region));
        max_acceptor = max(acceptor(region));
        min_acceptor = min(acceptor(region));
        start_frame = time(region(1));
        end_frame = time(region(end));
        y_min = min(min_acceptor, min_donor);
        y_max = max(max_acceptor, max_donor);
        pos = [start_frame, y_min, end_frame-start_frame, y_max - y_min];
        rectangle(ax, 'Position', pos, 'LineWidth', 3, 'EdgeColor', color)
        text(ax, 'Position', pos([3, 4]) / 1.25 + pos([1, 2]), 'String', annotation_text, 'FontWeight', 'bold', 'Color', color)
    end
end