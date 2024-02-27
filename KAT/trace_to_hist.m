function [fret_calc_hist,tot_hist_obs] = trace_to_hist(don_spec_trace, accep_spec_trace, blch_fret, gamma)
%Calculates the histograms from the traces
fret_calc_hist = [];
[~, num_traces] = size(don_spec_trace);
for i = 1:num_traces
    index_sel = i;
    don_sel = don_spec_trace(:,index_sel);
    accep_sel = accep_spec_trace(:,index_sel);
    sel_blch_don = blch_fret(index_sel);
    sel_blch_accep = blch_fret(index_sel); 
    don_sel_blch = don_sel(1:sel_blch_don);
    accep_sel_blch = accep_sel(1:sel_blch_accep);       
    denom_fret = accep_sel_blch + (gamma.*don_sel_blch);
    fret_calc_trace = accep_sel_blch./denom_fret;  
    fret_calc_hist = vertcat(fret_calc_hist, fret_calc_trace);
    tot_hist_obs = numel(fret_calc_hist);
end

end

