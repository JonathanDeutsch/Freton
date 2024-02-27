function [filt_don, filt_tot,don_lifetime,don_cps,don_blchpoint] = autofilter_single(don_spec_trace, num_bins,mov_window, frames_back,f_offset,...
    plot_filt,time_ints,don_life_thresh,outlier_thresh)
% Implementation of automatic filter developed by K. Ollech and R.
% Shivnaraine
% NOTE: don_der not used anywhere in code, but will need to be for FRET
    %% Set parameters for fitting
    %% Get the ratio values for the moving variance analyses
    [~,num_traces] = size(don_spec_trace);
    %% Get the traces 
    totalnumplots = 4;      % keeping track of desired number of subplots
    filt_don = [];
    filt_tot = [];
    counter = 1;
    num_bins = 8;
    h1 = waitbar(0,'Filtering Single Color Traces');
    for i = 1 : num_traces
        waitbar((i/num_traces),h1,sprintf([num2str(i) ' / ' num2str(num_traces) ' One Color Traces']));
        don_sel = don_spec_trace(f_offset:end,i); 
        % 1. putting donor data through digital filter (for smoothing)
        coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
        trace_filt = filtfilt(coeff, don_sel);        
        % 2. normalizing the donor data from the digital filter
        trace_filt_min = min(trace_filt);
        trace_filt_max = max(trace_filt);
        normdata = zeros(size(trace_filt,1),1);
        for m = 1 : size(trace_filt,1)
            normdata(m,1) = (trace_filt(m) - trace_filt_min) / (trace_filt_max - trace_filt_min);
        end
        
        % 3. taking the moving mean of the normalized data
        normdata_mean = movmean(normdata,2*mov_window);
        if plot_filt == 1        
        figure(5);
        subplot(totalnumplots,1,1),plot(don_sel);
        hold on
        ylabel('Original Data');  
        ylim([-100,inf]);
        plot(trace_filt,'r')
        hold off
        subplot(totalnumplots,1,2),plot(trace_filt);
        ylabel('Digital Filter');
        ylim([-100,inf]);
        subplot(totalnumplots,1,3),plot(normdata_mean,'r');
        ylabel('Mean Norm Donor');
        ylim([0 +inf]);
        title(num2str(i));
        end
        
        % 4. taking the moving variance of the moving mean of the
        % normalized data
        don_sel_var = movvar(normdata_mean,2*mov_window);  
        
        % setting the cutoff for data to be considered a peak (used in
        % findpeaks function)
        [N,edges] = histcounts(don_sel_var,10);
        cutoff = edges(end - num_bins);

        % plotting the peaks in variance
%         subplot(totalnumplots,1,4);
%         findpeaks(don_sel_var, 'MinPeakHeight', cutoff);
%         ylabel('Variance');
        % recording the height, location, and prominence of the peaks
        [pks_d, locs_d, ~, proms] = findpeaks(don_sel_var, 'MinPeakHeight', cutoff);

        % iterating through all the peaks found (which are kept in x-dim of locs_d)
        for k = size(locs_d,1) : -1 : 1
            % relying on the assumption that the pre-bleachpoint is always a fixed
            % number of points before the peak in variance
            prebleachpoint = locs_d(k,1) - frames_back;
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
            bleachpoint = locs_d(k,1);
            diff_don = diff(normdata_mean);
            sum_der_d = sum(diff_don((bleachpoint + 1 : (bleachpoint + ceil(mov_window/20))),1));
            
            % checking if the peaks are valid (i.e. tall enough or prominent enough)
            if (max(don_sel_var) > 0.005)
                don_sel_var_sq = don_sel_var.^2;
                
                % finding the area under the selected peak
                peakarea = trapz(don_sel_var_sq(max(1,(locs_d(k,1) - ceil(mov_window/2))) : min((locs_d(k,1) + ceil(mov_window/2)), size(don_sel_var_sq,1))));

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
                    end
                end
            % if there is only one peak and derivative is negative, then
            % select it
            elseif ((size(locs_d,1) == 1) && (sum_der_d < 0))
                goodtrace = true;               
            % if more than one peak, and the peaks' heights aren't less
            % than -0.5, then check prominences
            else
                proms_omit = proms;
                % omitting kth element because want to find max element of
                % proms other than proms(k)
                proms_omit(k) = [];
                if ((sum_der_d < 0) && (proms(k,1) > 2 * max(proms_omit)))
                    goodtrace = true;
                end
            end            
            % plotting and saving successfully found traces
if (goodtrace == true)
    below_outlier = find(normdata <=-0.05);
    above_outlier = find (normdata >= 2.5);  
    total_outlier = numel(above_outlier) + numel(below_outlier);
    
    if total_outlier < outlier_thresh
    if bleachpoint*(time_ints/1000) >= don_life_thresh
    if plot_filt == 1
                subplot(totalnumplots,1,3),plot(normdata_mean,'g');
                ylabel('Mean Normalized');
                title(["Trace #: ", num2str(i), " Derivative: ", num2str(sum_der_d)]);
                subplot(totalnumplots,1,4);
                findpeaks(don_sel_var, 'MinPeakHeight', cutoff);
                ylabel('Variance');
                hold on;
                plot(bleachpoint, don_sel_var(bleachpoint), 'r*');
                hold off;
    end
            filt_don_t = (i);
            filt_don = vertcat(filt_don,filt_don_t);
            filt_tot_t = (i);
            filt_tot = vertcat(filt_tot,filt_tot_t); 
            % get the donor lifetime information
            don_lifetime(:,counter) = bleachpoint*(time_ints/1000);
            don_cps(:,counter) = sum(don_sel(1:bleachpoint))/(bleachpoint*(time_ints/1000));
            don_blchpoint(:,counter) = bleachpoint;
            counter = counter + 1;            
    end
    end
 break;
 end
        end
    end
close (h1)

end

