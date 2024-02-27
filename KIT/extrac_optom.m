function [center_opt] = extrac_optom(radii_inten,centers_inten,image_inten)
% This is an extraction optomiser that will shift the centers value to
% pixel values so that the particles are intensity centered for summing.
% the output from this function are the new centers
        for i = 1:length(radii_inten)
            % get the pixel plus/minus
            rtd = round(radii_inten(i))-1;
            % get the centers
            % get the min centers            
            ind_min = floor(centers_inten(i,:));
            x1 = ind_min(2);
            y1 = ind_min(1);
            % get the max centers
            ind_max = ceil(centers_inten(i,:));
            x2 = ind_max(2);
            y2 = ind_max(1);
            % get the rounded centers
            ind_round = round(centers_inten(i,:));
            x1r = ind_round(2);
            y1r = ind_round(1);
            % get the indicies for x1
            ind_x1p = x1 + rtd;
            ind_x1m = x1 - rtd;
            ind_x1t = [ind_x1m:ind_x1p];
            % get the indicies for x2
            ind_x2p = x2 + rtd;
            ind_x2m = x2 - rtd;
            ind_x2t = [ind_x2m:ind_x2p];              
            % get the indicies for y1
            ind_y1p = y1 + rtd;
            ind_y1m = y1 - rtd;
            ind_y1t = [ind_y1m:ind_y1p];
            % get the indicies for y2
            ind_y2p = y2 + rtd;
            ind_y2m = y2 - rtd;
            ind_y2t = [ind_y2m:ind_y2p];
            % get the indicies for x round
            ind_x1rp = x1r + rtd;
            ind_x1rm = x1r - rtd;
            ind_x1rt = [ind_x1rm:ind_x1rp];            
            % get the indicies for the y round
            ind_y1rp = y1r + rtd;
            ind_y1rm = y1r - rtd;
            ind_y1rt = [ind_y1rm:ind_y1rp];
            % compute sums of the identified spot              
            x1y1 = image_inten(ind_x1t,ind_y1t);
            sum_x1y1 = sum(sum(x1y1));    
            
            x1y2 = image_inten(ind_x1t,ind_y2t);
            sum_x1y2 = sum(sum(x1y2));  
            
            x2y1 = image_inten(ind_x2t,ind_y1t);
            sum_x2y1 = sum(sum(x2y1));  
            
            x2y2 = image_inten(ind_x2t,ind_y2t);
            sum_x2y2 = sum(sum(x2y2));  
            
            xryr = image_inten(ind_x1rt,ind_y1rt);
            sum_xryr = sum(sum(xryr));
            % put together for filtering
            sums_opt = [sum_x1y1 sum_x1y2 sum_x2y1 sum_x2y2 sum_xryr];
            % find the max option
            max_opt = max(sums_opt);
            opt_best = find(sums_opt == max_opt,1);
            
            switch opt_best
                case{1}
                    %x1y1
                    center_opt(i,:) = [y1 x1];
                case{2}
                    %x1y2
                    center_opt(i,:) = [y2 x2];
                case{3}
                    %x2y1
                    center_opt(i,:) = [y1 x2];
                case{4}
                    %x2y2
                    center_opt(i,:) = [y2 x2];
                case{5}
                    %xryr
                    center_opt(i,:) = [y1r x1r];
            end
        end    
end






