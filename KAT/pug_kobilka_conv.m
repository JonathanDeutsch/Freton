function [  ] = pug_kobilka_conv( )
%This file will convert the puglisi traces to be analysed in KIT/KAT
%% Load the data and get traces indicies
[filename, pathname] = uigetfile();
addpath(pathname);
load (filename);
[~,ttraces] = size(ttotal);
num_tot_traces = (ttraces -1); 
num_traces = num_tot_traces/3;
tot_traces = ttotal(:,2:end);

%% parse the traces
time_axis = ttotal(:,1);
% Get the donor traces
counterd = 0;
for i = 1:3:num_tot_traces-2
    counterd = counterd + 1;
    don_traces(:,counterd) = tot_traces(:,i);
end
% get the acceptor traces
countera = 0;
for j = 2:3:num_tot_traces-1
    countera = countera + 1;
    accep_traces(:,countera) = tot_traces(:,j);
end
% get the fret traces
counterf = 0;
for k = 3:3:num_tot_traces
    counterf= counterf + 1;
    fret_traces (:,counterf) = tot_traces(:,k);
end
bckg = zeros(size(don_traces));
%% create fake pics
img_t = ones(20,20);
img = uint16(img_t);
for l= 1:num_traces
             Picture_d{l,1} = img;
             Picture_d{l,2} = [10,10];
             Picture_d{l,3} = 1.5;             
             Picture_a{l,1} = img;
             Picture_a{l,2} = [10,10];
             Picture_a{l,3} = 1.5;
end
%% Rewrite files to be read into KAT2
don_tot_trace = don_traces;
don_spec_trace = don_traces;
don_bckg_trace = bckg;
accep_tot_trace = accep_traces;
accep_spec_trace = accep_traces;
accep_bckg_trace = bckg;
Mode1 = 'Multicolor';
%% Call on a dialog box to save the variables
uisave({'time_axis','don_tot_trace','don_spec_trace','don_bckg_trace','accep_tot_trace','accep_spec_trace','accep_bckg_trace','Mode1','Picture_d','Picture_a'})
% size(don_traces)
% size(accep_traces)
% size(fret_traces)

