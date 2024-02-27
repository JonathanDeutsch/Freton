function [a_h_t,fret_sel_all_hist] = heatmap_updater(don_spec_trace, accep_spec_trace,gamma,time_axis,blch_fret)
% Outputs the heatmap;
% outputs the histogram;
%% Generates a heatmap for the input traces
[~,num_traces] = size(don_spec_trace);
counter = 0;
fret_sel_all_hist = [];
fret_sel_indv_hist = [];
Index1 = time_axis(1);
Index2 = time_axis(end);
fret_res = 0.1;
edges = [0:fret_res:1];
h = waitbar(0,'Processing Overlay');
%% run for the number of traces
for i = 1:num_traces
    counter = counter+1;  
    waitbar(counter/num_traces)
    don_sel = don_spec_trace(:,i); 
    accep_sel = accep_spec_trace(:,i);   
    bleachpoint_fret = blch_fret(i);
    don_sel_blch = don_sel(1:bleachpoint_fret);
    accep_sel_blch = accep_sel(1:bleachpoint_fret);
    time_axis_blch = time_axis(1:bleachpoint_fret);
    denom_fret_blch = accep_sel_blch + (gamma.*don_sel_blch);
    fret_calc_trace_blch = (accep_sel_blch)./denom_fret_blch;  
    blch_diff = length(don_sel)-bleachpoint_fret;
    fret_diff = (zeros(blch_diff,1));
    fret_calc_trace_pad = vertcat(fret_calc_trace_blch,fret_diff);     
    fret_traces_heat(:,counter) = fret_calc_trace_pad;
%% histogram each trace
 counter_fret = 0;
        for j = 1:length(don_sel_blch)
            counter_fret = counter_fret + 1;
            denom_fret_hist = accep_sel_blch (j) + (gamma.*don_sel_blch(j));
            fret_calc_inc_indv = accep_sel_blch(j)./denom_fret_hist;
            fret_sel_indv_hist(:,counter_fret) = fret_calc_inc_indv;            
        end 
            fret_sel_all_hist = horzcat(fret_sel_all_hist,fret_sel_indv_hist);   
end
            [time_bins,~] = size(fret_traces_heat);
            counter_heat = 0;
        for j = 1:time_bins
            counter_heat = counter_heat + 1;
            edges = [0:fret_res:1];
            [a,b] = hist(fret_traces_heat(j,:),edges); 
            a_h_t(counter_heat,:) = a;             
        end    
% end of function
close(h)
end

