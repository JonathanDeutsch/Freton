% ses_1_r = ses_all(1,:);
% ind_0 = find(ses_1_r == 0);
% ses_all(:,ind_0) = [];

fret_res = 0.1;
fret_traces = f_tdp_raw;
counter = 0;
        [time_bins,~] = size(fret_traces);
        time_axis = 0:0.1:1;
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            fret_trace_t = nonzeros(fret_traces(j,:));
            [a,b] = hist(fret_trace_t,edges);
%             figure(1)
%             histogram(fret_trace_t,edges)
            a_h_t(counter,:) = a;   
        end 
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
            colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold';