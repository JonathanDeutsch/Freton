function [filt_don, filt_accep, filt_tot,don_lifetime,accep_lifetime,don_cps,accep_cps,don_blchpoint,accep_blchpoint,fret_blchpoint,blch_pt,snr_don_bckg,snr_don_var,snr_accep_bckg,snr_accep_var] = autofilter_twocolor...
    (don_spec_trace,accep_spec_trace,don_thresh,accep_thresh,mov_window,filt_f_back,f_offset,plot_filt,time_ints,don_life_thresh,accep_life_thresh,don_snr1,acp_snr1,don_snr2,acp_snr2,gamma)        
%% Notes between Robin and Rick 10-16-2020
%% Get the ratio values for the moving variance analyses
%     don_thresh = donor intensity cutoff
%     accep_thresh = acceptor intensity cutoff
% Set the variance cut off here for the determiniation of the bleachpoint
    frames_back = filt_f_back;
    [~,num_traces] = size(don_spec_trace);
    %% Get the traces 
    totalnumplots = 6;      % keeping track of desired number of subplots      
    counter = 0;
    filt_don = [];
    filt_tot = [];
    filt_accep = [];    
    h1 = waitbar(0,'Filtering Two Color Traces'); 
    counter2 =0;
    pks_d_h = [];
    don_norm_means = [];
    accep_norm_means = [];
    don_sel_var_orig = [];
    accep_sel_var_orig = [];
    
    for i =1: num_traces
        blch = 0;
        waitbar((i/num_traces),h1,sprintf([num2str(i),' / ' num2str(num_traces) ' Two Color Traces']));
        don_sel_t = don_spec_trace(1:end,i);
        don_sel = movmean(don_sel_t, 3);        
        accep_sel_t = accep_spec_trace(1:end,i);
        accep_sel = movmean(accep_sel_t,3);
        max_don_sel = mean(don_sel(1:10));
        max_accep_sel = mean(accep_sel(1:10)); 
        if (accep_thresh > max_accep_sel)||(don_thresh > max_don_sel)  
            continue            
        end   
        %normalized data
        max_don_sel = (mean(don_sel(1:10)));
        max_accep_sel = (mean(accep_sel(1:10)));
        norm_don_trace = don_sel./max_don_sel;
        norm_accep_trace = accep_sel./max_accep_sel;
        %putting means of first ten digits of each trace into a matrix.
        %Each mean represents a respective trace
        don_sel_var_orig = norm_don_trace;
        accep_sel_var_orig = norm_accep_trace;
        don_norm_means = horzcat(don_norm_means, mean(don_sel_var_orig(1:10)));
%         disp(don_norm_means);
%         disp('break ');
        
        %disp(mean(don_sel_var_orig));
        accep_norm_means = horzcat(mean(accep_sel_var_orig));
        
%%      % 4. taking the moving variance of the moving mean of the
        % normalized data
        don_sel_var = movvar(don_sel,mov_window);  
        accep_sel_var = movvar(accep_sel,mov_window);        
        [pks_d_t, ~] = findpeaks(don_sel_var);
        [pks_a_t, ~] = findpeaks(accep_sel_var); 
        sel_pks_d = max(pks_d_t)/10;
        sel_pks_a = max(pks_a_t)/2;       
        [pks_d_t2, locs_d] = findpeaks(don_sel_var, 'MinPeakHeight', sel_pks_d);
        [pks_a_t2, locs_a] = findpeaks(accep_sel_var, 'MinPeakHeight', sel_pks_a); 
         pks_d_h = vertcat(pks_d_h, pks_d_t2);
        
%         num_peaks = size(pks_d_t2')
%         disp(num_peaks)
        %go through peaks of donor 
%         for j =1: num_peaks
%             %find the location of the peak in the array of the variances
%             index = find(don_sel_var == pks_d_t2(1,j))
%             %check to see if the variance immediately after the moving
%             %window is too much. If it is, we skip it
%             if(don_sel_var(1,index+frame+1)> max_accept_var)
%                 continue
%             end
%         end
    end 
    
   save('variance_histogram', 'pks_d_h')
   %disp(mean(don_norm_means));
   %filtering out everything that is not within one standard deviation of
   %the mean
   dnm_result = [];
   dnm = mean(don_norm_means);
   dnstd = std(don_norm_means);
   dnm_result = don_norm_means((don_norm_means < dnm+dnstd) & (don_norm_means >dnm-dnstd));
   disp(don_norm_means);
   disp("break")
   disp(dnstd);
   disp("break")
   disp(dnm_result);
   
   figure(9)Line 92    figure(9)

    histogram(dnm_result,10);
    
   figure(8)
    histogram(don_norm_means,10);
    
     figure(7)
        histogram(pks_d_h,1000)
    
%     h = histogram(pks_d_h)
        
    for i = 1 : num_traces          
        blch = 0;
        waitbar((i/num_traces),h1,sprintf([num2str(i),' / ' num2str(num_traces) ' Two Color Traces']));
        don_sel_t = don_spec_trace(1:end,i);
        don_sel = movmean(don_sel_t, 3);        
        accep_sel_t = accep_spec_trace(1:end,i);
        accep_sel = movmean(accep_sel_t,3);
        max_don_sel = mean(don_sel(1:10));
        max_accep_sel = mean(accep_sel(1:10)); 
        if (accep_thresh > max_accep_sel)||(don_thresh > max_don_sel)  
            continue            
        end                     
%%      % 4. taking the moving variance of the moving mean of the
        % normalized data
        don_sel_var = movvar(don_sel,mov_window);  
        accep_sel_var = movvar(accep_sel,mov_window);        
        [pks_d_t, ~] = findpeaks(don_sel_var);
        [pks_a_t, ~] = findpeaks(accep_sel_var);   
        sel_pks_d = max(pks_d_t)/10;
        sel_pks_a = max(pks_a_t)/2;       
        [pks_d, locs_d] = findpeaks(don_sel_var, 'MinPeakHeight', sel_pks_d);
        [pks_a, locs_a] = findpeaks(accep_sel_var, 'MinPeakHeight', sel_pks_a); 
            if plot_filt == 1
            figure(6);
            subplot(totalnumplots,1,1),plot(don_sel,'g');
            hold on
            ylabel('Donor Data');
            title(['Trace Number ', num2str(i), '   PRE-Selection',' don counts  ',num2str(max_don_sel),' accep counts  ',num2str(max_accep_sel)])
            ylim([-100,inf]);            
            hold off
            subplot(totalnumplots,1,3),plot(accep_sel,'r');
            hold on
            ylabel('Acceptor Data');         
            ylim([-100,inf]);            
            hold off
            hold on
            ylabel('Mean Norm Data');
            ylim([0 +inf]);
            title(num2str(i));
            hold off
            subplot(totalnumplots,1,2);
            findpeaks(don_sel_var, 'MinPeakHeight', sel_pks_d);
            ylabel('Variance');
            text(locs_d,pks_d,num2str(locs_d));
            subplot(totalnumplots,1,4)
            findpeaks(accep_sel_var,'MinPeakHeight',sel_pks_a)
            text(locs_a,pks_a,num2str(locs_a));
            pause()
            end                
        %% Using possible locations of the bleach points sort through        
        %% Start with picking the donor bleach
        % iterating through all the peaks found (which are kept in x-dim of locs_d)
        if size(locs_d,1) <= 0 || size(locs_a,1) <= 0
            continue            
        end
        
        [bleachpoint_don_t,bleachpoint_accep_t,blch_sel] = locs_sorter(locs_d,locs_a);        
        if blch_sel == 0
            if plot_filt == 1
            figure(6);
            subplot(totalnumplots,1,1),plot(don_sel,'g');
            hold on
            ylabel('Donor Data');
            title(['Trace Number ', num2str(i), '   Unselected',' don counts  ',num2str(max_don_sel),' accep counts  ',num2str(max_accep_sel)])
            ylim([-100,inf]);            
            hold off
            subplot(totalnumplots,1,3),plot(accep_sel,'r');
            hold on
            ylabel('Acceptor Data');         
            ylim([-100,inf]);            
            hold off
            hold on
            ylabel('Mean Norm Data');
            ylim([0 +inf]);
            title(num2str(i));
            hold off
            subplot(totalnumplots,1,2);
            findpeaks(don_sel_var, 'MinPeakHeight', sel_pks_d);
            ylabel('Variance');
            text(locs_d,pks_d,num2str(locs_d));
            subplot(totalnumplots,1,4)
            findpeaks(accep_sel_var,'MinPeakHeight',sel_pks_a)
            text(locs_a,pks_a,num2str(locs_a));
            pause()
            end        
            continue
        end
        bleachpoint_don = bleachpoint_don_t(1)-frames_back;
        bleachpoint_accep = bleachpoint_accep_t(1)-frames_back;      
        
        if bleachpoint_don<=4 || bleachpoint_accep <=4
            continue
        end
        %% Process the selected trace
        if blch_sel == 1
            diff_don = diff(don_sel);
            diff_accep = diff(accep_sel);
            % Take the sum of the derivative (2 frames back and 3 frames forward)
            sum_der_d = sum(diff_don((bleachpoint_don - 1 : (bleachpoint_don + 3)),1));
            sum_der_a = sum(diff_accep((bleachpoint_accep -1  : (bleachpoint_accep + 3)),1));
                
            % condition if they have both bleached (donor has bleached first)
            if sum_der_d <= 0 && sum_der_a <= 0
               blch = 1;
                if bleachpoint_don >= bleachpoint_accep
                    bleachpoint_fret = bleachpoint_accep;
                elseif bleachpoint_accep > bleachpoint_don
                    bleachpoint_fret = bleachpoint_don;
                 end                    
            % condition where the acceptor has bleached and donor has increased    
            elseif sum_der_d >=0 && sum_der_a <= 0
                blch = 2;
                bleachpoint_fret = bleachpoint_accep;
            else
                blch = 0;
                continue
            end             
            % Implement all the filtering criteria
%             bleachpoint_don
%             bleachpoint_accep
               don_time_t = ceil(bleachpoint_don*(time_ints/1000));
               don_time = don_time_t(1);
               accep_time_t = ceil(bleachpoint_accep*(time_ints/1000));
               accep_time = accep_time_t(1);               
            if  don_time> don_life_thresh && accep_time> accep_life_thresh   
                            don_blch = don_sel(1:bleachpoint_fret);
                            accep_blch = accep_sel(1:bleachpoint_fret);                        
                            %% calculate the SNRs here and filter the data
                            %snr1 = sig_qual = snr_var
                            %snr2 = sig_bckg       
                            don_emms_tt = (don_blch');
                            accep_emms_tt = (accep_blch');
                            don_emms_bckg_tt = don_sel(bleachpoint_fret+3:end);
                            accep_emms_bckg_tt = accep_sel(bleachpoint_fret+3:end);                            
                            snr_don_bckg_t = mean(don_emms_tt)/std(don_emms_bckg_tt);
                            snr_don_var_t = mean(don_emms_tt)/std(don_emms_tt);
                            snr_accep_bckg_t = mean(accep_emms_tt)/std(accep_emms_bckg_tt);
                            snr_accep_var_t = mean(accep_emms_tt)/std(accep_emms_tt);
                                
                            if snr_don_var_t >= don_snr1 && snr_accep_var_t >= acp_snr1
                                counter = counter + 1;
                                if blch == 1
                                    if snr_don_bckg_t >= don_snr2 
                                filt_don_t = (i);
                                filt_don = vertcat(filt_don,filt_don_t);
                                %line above is useful
                                    end
                                elseif blch == 2
                                    if snr_accep_bckg_t >= acp_snr2 
                                filt_accep_t = (i);
                                filt_accep = vertcat(filt_accep, filt_accep_t);
                                    end
                                end
                                filt_tot_t = (i);
                                filt_tot = vertcat(filt_tot,filt_tot_t);
                                % get the donor lifetime information
                                don_lifetime(:,counter) = bleachpoint_don*(time_ints/1000);
                                don_cps(:,counter) = sum(don_sel(1:bleachpoint_don))/(bleachpoint_don*(time_ints/1000));
                                don_blchpoint(:,i) = bleachpoint_don;
                                % get the acceptor lifetime information
                                accep_lifetime(:,counter) = bleachpoint_accep*(time_ints/1000);
                                accep_cps(:,counter) = sum(accep_sel(1:bleachpoint_accep))/(bleachpoint_accep*(time_ints/1000));
                                accep_blchpoint(:,i) = bleachpoint_accep;
                                fret_blchpoint(:,i) = bleachpoint_fret;
                                % store the bleachpoint information
                                blch_pt(:,i) = blch;
                                snr_don_bckg(:,counter) = snr_don_bckg_t;                            
                                snr_don_var(:,counter) = snr_don_var_t;
                                snr_accep_bckg(:,counter) = snr_accep_bckg_t;                            
                                snr_accep_var(:,counter) = snr_accep_var_t;                                
                                        if plot_filt == 1
                                            figure(6);
                                            subplot(totalnumplots,1,1),plot(don_sel,'g');
                                            hold on
                                            ylabel('Donor Data');
                                            title(['Trace Number ',num2str(i), '   Selected','  SNRv',num2str(snr_accep_var_t),'    SNRb',num2str(snr_accep_bckg_t)])
                                            ylim([-100,inf]);            
                                            hold off
                                            subplot(totalnumplots,1,3),plot(accep_sel,'r');
                                            hold on
                                            ylabel('Acceptor Data');
                                            ylim([-100,inf]);            
                                            hold off
                                            hold on
                                            ylabel('Mean Norm Data');
                                            ylim([0 +inf]);
                                            title(num2str(i));
                                            hold off
                                            subplot(totalnumplots,1,2);
                                            findpeaks(don_sel_var, 'MinPeakHeight', sel_pks_d);
                                            ylabel('Variance');
                                            text(locs_d,pks_d,num2str(locs_d));
                                            subplot(totalnumplots,1,4)
                                            findpeaks(accep_sel_var,'MinPeakHeight',sel_pks_a)
                                            text(locs_a,pks_a,num2str(locs_a));
                                            pause()
                                        end        
                                
                            end
            end            
        end             
    end % end of the number of traces function
    close(h1)
end % end of the function