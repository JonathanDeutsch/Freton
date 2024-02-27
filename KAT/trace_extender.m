function [don_spec_trace_new,don_tot_trace_new, accep_spec_trace_new,accep_tot_trace_new] = trace_extender(diff_length_t,num_traces,don_spec_trace,don_tot_trace, accep_spec_trace,accep_tot_trace)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
for k = 1:num_traces
    %get last 10 values for the various fields.
    % Spec (donor)
    don_spec_trace_pad_m1 = don_spec_trace(:,k);
    don_spec_trace_pad_m = don_spec_trace_pad_m1((end-100):end,:);
    don_spec_trace_pad_1 = mean(don_spec_trace_pad_m);
    don_spec_trace_pad = diff_length_t.*don_spec_trace_pad_1;
    don_spec_trace_new(:,k) = vertcat(don_spec_trace(:,k), don_spec_trace_pad);
    % Spec (acceptor)
    accep_spec_trace_pad_m1 = accep_spec_trace(:,k);
    accep_spec_trace_pad_m = accep_spec_trace_pad_m1((end-100):end,:);
    accep_spec_trace_pad_1 = mean(accep_spec_trace_pad_m);
    accep_spec_trace_pad = diff_length_t.*accep_spec_trace_pad_1;
    accep_spec_trace_new(:,k) = vertcat(accep_spec_trace(:,k), accep_spec_trace_pad);
    % Tot (donor)
    don_tot_trace_pad_m = don_tot_trace((end-100):end,k);
    don_tot_trace_pad_1 = mean(don_tot_trace_pad_m);
    don_tot_trace_pad = diff_length_t.*don_tot_trace_pad_1;
    don_tot_trace_new(:,k) = vertcat(don_tot_trace(:,k), don_tot_trace_pad);
    % Tot (acceptor)
    accep_tot_trace_pad_m = accep_tot_trace((end-100):end,k);
    accep_tot_trace_pad_1 = mean(accep_tot_trace_pad_m);    
    accep_tot_trace_pad = diff_length_t.*accep_tot_trace_pad_1;
    accep_tot_trace_new(:,k) = vertcat(accep_tot_trace(:,k), accep_tot_trace_pad);
%     % Bckg (donor)
%     don_bckg_trace_pad_m = don_bckg_trace((end-10):end,k);
%     don_bckg_trace_pad_1 = mean(don_bckg_trace_pad_m);
%     don_bckg_trace_pad = diff_length_t.*don_bckg_trace_pad_1;
%     don_bckg_trace = [don_bckg_trace(:,k), don_bckg_trace_pad];
%     % Bckg (acceptor)
%     accep_bckg_trace_pad_m = accep_bckg_trace((end-10):end,k);
%     accep_bckg_trace_pad_1 = mean(accep_bckg_trace_pad_m);
%     accep_bckg_trace_pad = diff_length_t.*accep_bckg_trace_pad_1;
%     accep_bckg_trace = [accep_bckg_trace(:,k), accep_bckg_trace_pad];
end
end