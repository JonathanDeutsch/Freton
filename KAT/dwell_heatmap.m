function [a_h_t time_axis, edges] = dwell_heatmap(ses_all, heat_lim,heat_end)
%plots the dwell time heat map and in the corresponding axis
ses_1_r = ses_all(1,:);
ind_0 = find(ses_1_r == 0);
ses_all(:,ind_0) = [];
fret_res = 0.1;
fret_traces = ses_all;
if heat_lim == 1
heat_end = round(heat_end);
fret_traces = fret_traces(1:heat_end,:);
end

counter = 0;
        [time_bins,~] = size(fret_traces);
        time_axis = 1:time_bins;
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            fret_trace_t = nonzeros(fret_traces(j,:));
            [a,b] = hist(fret_trace_t,edges);
            a_h_t(counter,:) = a;   
        end             
end

