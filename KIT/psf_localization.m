function [new_centers] = psf_localization(centers_dt,image_d,max_iter)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
             [sizex,sizey,~] = size(image_d);
             half_index_snap = 3;   %   
             num_psf_spots_t = size(centers_dt);
             num_psf_spots = num_psf_spots_t(:,1);
             h = waitbar(0,'Fitting PSF');
             centers_fit = centers_dt;
             for i = 1:num_psf_spots
             curr_center = centers_fit(i,:);
             % Get the indicies for the snapshot of the donor particles 
             indeces_dy = curr_center(1)-half_index_snap:curr_center(1)+half_index_snap;
             indeces_dx = curr_center(2)-half_index_snap:curr_center(2)+half_index_snap;
             waitbar(i/num_psf_spots)
%% Get the donor image            
        % Trim the snap shot sizes           
            if indeces_dx(1) < 1 
               indeces_dx_t1 = find(indeces_dx == 1); 
               % get x shift
               diff_dx_m = indeces_dx_t1;
               % shift the center
               centers_fit(1) = centers_fit(1) + diff_dx_m;
            else
                indeces_dx_t1 = indeces_dx(1);
                diff_dx_m = 0;
            end            
            if indeces_dx(end) > sizex
                indeces_dx_t2 = find(indeces_dx == sizex);
                % get x shift
                diff_dx_p = indeces_dx(end) - indeces_dx(indeces_dx_t2(1));
                centers_fit(1) = centers_fit(1) + diff_dx_p;
            else
                indeces_dx_t2 = indeces_dx(end);
                diff_dx_p = 0;                
            end          
            
            if indeces_dy(1) < 1
                % get y shift
                indeces_dy_t1 = find(indeces_dy == 1);
                diff_dy_m = indeces_dy_t1;
                centers_fit(2) = centers_fit(2) + diff_dy_m;
            else
                indeces_dy_t1 = indeces_dy(1);
                diff_dy_m = 0;
            end            
            if indeces_dy(end) > sizey
                % get y shift
                indeces_dy_t2 = find(indeces_dy == sizey);
                diff_dy_p = indeces_dy(end) - indeces_dy(indeces_dy_t2(1));
                centers_fit(2) = centers_fit(2) + diff_dy_p;
            else
                indeces_dy_t2 = indeces_dy(end); 
                diff_dy_p = 0;
            end   
             index_mindx = indeces_dx_t1;
             index_maxdx = indeces_dx_t2;
             index_mindy = indeces_dy_t1;
             index_maxdy = indeces_dy_t2; 
             % get image
             pic_d = image_d(index_mindx : index_maxdx, index_mindy : index_maxdy); 
             Z = double(pic_d);
             %% Initiate Solver
            [X,Y] = meshgrid(1:7);
            xdata = zeros(size(X,1),size(Y,2),2);
            xdata(:,:,1) = X;
            xdata(:,:,2) = Y;
            options = optimoptions('lsqcurvefit','MaxIterations',max_iter,'Display','off');            
            lb = [];
            ub = [];
            % get maximum of position 4,4
            guess_max = double(pic_d(4,4));
            % send in initial guesses
            x0 = [guess_max,4,1,4,1]; %Inital guess parameters
            [x] = lsqcurvefit(@Gauss2D,x0,xdata,Z,lb, ub, options);
            % image (columns is x, rows is y);
            x_correc = round(4-x0(2));
            y_correc = round(4-x0(4));
            new_center_x = curr_center(1) + x_correc;
            new_center_y = curr_center(2) + y_correc;
            new_centers(i,:) = [new_center_x new_center_y];
             end
             close(h)
end

