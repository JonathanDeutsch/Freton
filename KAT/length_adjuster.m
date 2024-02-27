function [] = length_adjuster(ALL_NAME,proc_trace_val, Mode1)
number_arguments = length(ALL_NAME);

for i = 1:number_arguments
file = ALL_NAME(i);
file1 = [file{1}];
load(file1)
[lengthTraces_t, ~] = size(don_spec_trace);
lengthTraces(i)=lengthTraces_t;
end
max_length = max(lengthTraces, [], 'all');

%Merging all the vectors
for i = 1:number_arguments
file = ALL_NAME(i);
file1 = [file{1}];
load(file1)

[lengthTraces_tt, num_traces] = size(don_spec_trace);
diff_length = max_length - lengthTraces_tt;
diff_length_t = ones(diff_length,1);
if diff_length > 0
    for i = 1:num_traces
    %get last 10 values for the various fields.
    % Spec (donor)
    don_spec_trace_pad_1 = average(don_spec_trace([(end-10):end],i));
    don_spec_trace_pad = diff_length_t.*don_spec_trace_pad_1;
    don_spec_trace = [don_spec_trace(:,i), don_spec_trace_pad];
    % Spec (acceptor)
    accep_spec_trace_pad_1 = average(accep_spec_trace([(end-10):end],i));
    accep_spec_trace_pad = diff_length_t.*accep_spec_trace_pad_1;
    accep_spec_trace = [accep_spec_trace(:,i), accep_spec_trace_pad];
    % Tot (donor)
    don_tot_trace_pad_1 = average(don_tot_trace([(end-10):end],i));
    don_tot_trace_pad = diff_length_t.*don_tot_trace_pad_1;
    don_tot_trace = [don_tot_trace(:,i), don_tot_trace_pad];
    % Tot (acceptor)
    accep_tot_trace_pad_1 = average(accep_tot_trace([(end-10):end],i));    
    accep_tot_trace_pad = diff_length_t.*accep_tot_trace_pad_1;
    accep_tot_trace = [accep_tot_trace(:,i), accep_tot_trace_pad];
    % Bckg (donor)
    don_bckg_trace_pad_1 = average(don_bckg_trace([(end-10):end],i));
    don_bckg_trace_pad = diff_length_t.*don_bckg_trace_pad_1;
    don_bckg_trace = [don_bckg_trace(:,i), don_bckg_trace_pad];
    % Bckg (acceptor)
    accep_bckg_trace_pad_1 = average(accep_bckg_trace([(end-10):end],i));
    accep_bckg_trace_pad = diff_length_t.*accep_bckg_trace_pad_1;
    accep_bckg_trace = [accep_bckg_trace(:,i), accep_bckg_trace_pad];
    end
end

if strcmp(Mode1,'onecolor')
else
accep_bckg_trace_temp = [accep_bckg_trace_temp , accep_bckg_trace];
accep_spec_trace_temp = [accep_spec_trace_temp , accep_spec_trace];
accep_tot_trace_temp = [accep_tot_trace_temp , accep_tot_trace];
if proc_trace_val == 1
blch_accep_temp = [blch_accep_temp; blch_accep'];
blch_don_temp = [blch_don_temp; blch_don'];
blch_type_temp = [blch_type_temp; blch_type'];
blch_fret_temp = [blch_fret_temp; blch_fret'];
end
end
don_bckg_trace_temp = [don_bckg_trace_temp , don_bckg_trace];
don_spec_trace_temp = [don_spec_trace_temp , don_spec_trace];
don_tot_trace_temp = [don_tot_trace_temp , don_tot_trace];
Picture_d_temp     = [ Picture_d_temp ; Picture_d];
Picture_a_temp     = [ Picture_a_temp ; Picture_a];
centers_ext_temp = [centers_ext_temp ; centers_ext];
%time_axis_temp = [time_axis_temp ; time_axis];
end
end