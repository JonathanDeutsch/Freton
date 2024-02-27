function [sel_blch_trace] = single_trace_filter(don_spec_trace_t, don_bins, filt_f_back, mov_window, f_offset, don_f_ratio,sel_blch_trace_t)
% This function is an updated trace filter for pulling out good traces
% num bins is used to determine where in the 
    %% Set parameters for fitting
    %% Get the ratio values for the moving variance analyses   
        don_sel_t = don_spec_trace_t(f_offset:end);             
        % 1. putting donor data through digital filter (for smoothing)
        coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
        trace_filt = filtfilt(coeff, don_sel_t);     
        % 2. normalizing the donor data from the digital filter
        trace_filt_min = min(trace_filt);
        trace_filt_max = max(trace_filt);
        normdata = zeros(size(trace_filt,1),1);
        for m = 1 : size(trace_filt,1)
            normdata(m,1) = (trace_filt(m) - trace_filt_min) / (trace_filt_max - trace_filt_min);
        end        
        % 3. taking the moving mean of the normalized data
        normdata_mean = movmean(normdata,2*mov_window);        
        % 4. taking the moving variance of the moving mean of the
        % normalized data
        don_sel_var = movvar(normdata_mean,2*mov_window); 
        % setting the cutoff for data to be considered a peak (used in
        % findpeaks function)
        [N,edges] = histcounts(don_sel_var,10);
        cutoff = edges(end - don_bins);
        % plotting the peaks in variance
        % recording the height, location, and prominence of the peaks
        [pks_d, locs_d, ~, proms] = findpeaks(don_sel_var, 'MinPeakHeight', cutoff);
        % iterating through all the peaks found (which are kept in x-dim of locs_d)
        for k = size(locs_d,1) : -1 : 1
            % relying on the assumption that the pre-bleachpoint is always a fixed
            % number of points before the peak in variance
            prebleachpoint = locs_d(k,1) - filt_f_back;
            % if photobleaching occurs before the sixth point, then skip to
            % the next iteration (unlikely bleaching happens so quickly;
            % probably a fake spike)
            if (prebleachpoint < 6)
                continue;
            end

            % if the detected peak is too close to the end, don't select it
            if (locs_d(k,1) > size(don_sel_var,1) - 50)
                continue;
            end
            
            % selection criteria; trace will be selected if goodtrace == true
            goodtrace = false;
            sel_blch_trace = [];
            bleachpoint = locs_d(k,1);
            diff_don = diff(normdata_mean);
            sum_der_d = sum(diff_don((bleachpoint + 1 : (bleachpoint + ceil(mov_window/20))),1));
            
            % checking if the peaks are valid (i.e. tall enough or prominent enough)
            if (max(don_sel_var) > 0.005)
                don_sel_var_sq = don_sel_var.^2;                
                % finding the area under the selected peak
                peakarea = trapz(don_sel_var_sq((locs_d(k,1) - ceil(mov_window/2)) : min((locs_d(k,1) + ceil(mov_window/2)), size(don_sel_var_sq,1))));
                % finding the area under the remainder of the variance plot
                % (after the selected peak)
                %variancearea = trapz(don_sel_var_sq((locs_d(k,1) + 6) : min((locs_d(k,1) + .1*size(don_sel_var_sq,1)), size(don_sel_var_sq,1)))); 
                variancearea = trapz(don_sel_var_sq((locs_d(k,1) + 6) : min((locs_d(k,1) + mov_window), size(don_sel_var_sq,1)))); 
                
                if (sum_der_d < 0)
                    sum_der_d_big = sum(diff_don(((bleachpoint - ceil(mov_window/5)) : (bleachpoint + ceil(mov_window/5))),1));                    
                    % if either condition is true, then selected
                    % bleachpoint is good
                    if ((sum_der_d_big < 0) || variancearea < peakarea)
                        goodtrace = true; 
                        sel_blch_trace = sel_blch_trace_t;
                    end
                end
            % if there is only one peak and derivative is negative, then
            % select it
            elseif ((size(locs_d,1) == 1) && (sum_der_d < 0))
                goodtrace = true; 
                sel_blch_trace = sel_blch_trace_t;
            % if more than one peak, and the peaks' heights aren't less
            % than -0.5, then check prominences
            else
                proms_omit = proms;
                % omitting kth element because want to find max element of
                % proms other than proms(k)
                proms_omit(k) = [];
                if ((sum_der_d < 0) && (proms(k,1) > 2 * max(proms_omit)))
                    goodtrace = true;
                    sel_blch_trace = sel_blch_trace_t;
                end
            end           
        end
        
    end





