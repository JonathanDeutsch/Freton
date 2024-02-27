%% Read the spartan trace
data = [];
dataTypes = {'char','uint8','uint16','uint32','uint64', ...
                    'int8', 'int16', 'int32', 'int64', ...
             'single','double','logical','cell','struct'};  %zero-based
[f,p] = uigetfile( {'*.traces;*.rawtraces','Binary Traces Files (*.traces;*.rawtraces)'; ...
                        '*.txt','Old format traces files (*.txt)'; ...
                        '*.*','All Files (*.*)'}, 'Select a traces file');
if p==0, return; end
filename = [p f];
fid=fopen(filename,'r');
% Open the traces file
fid=fopen(filename,'r');
% 2) Read header information
z = fread( fid, 1, 'uint32' );  %identifies the new traces format.
% Check validity of header data.
magic     = fread( fid, [1,4], '*char' );  %format identifier ("magic")
version   = fread( fid, 1, '*uint16' );   %format version number
% assert( (z==0 && strcmp(magic,'TRCS')), 'loadTraces: invalid header' );
% assert( version>=3 && version<=4, 'Version not supported!' );
% Read the data dimensions and channel names.
dataType  = fread( fid, 1, '*uint8' );   % data class (9=single)
nChannels = fread( fid, 1, '*uint8' );
nTraces   = fread( fid, 1, 'uint32' );
traceLen  = fread( fid, 1, 'uint32' );
indexes = 1:nTraces;
szNames      = fread( fid, 1, 'uint32' );
channelNames = fread( fid, [1,szNames], '*char' );
channelNames = strsplit(channelNames,char(31), 'CollapseDelimiters',false);
indexes = indexes( indexes>=1 & indexes<=nTraces );
nTracesLoaded = numel(indexes);
if dataType==9
    star = '*';
else
    star = '';
    disp('Warning: converting non-float data to double!');
end
type = dataTypes{dataType+1};
data.time = fread( fid, [1,traceLen], type );  %time axis (s)
time_axis = data.time;
% get the time interval.
diff_time = time_axis(2)- time_axis(1);
if diff_time>=10
    time_axis = time_axis./1000;
end

for i=1:nChannels
    d = fread( fid, [nTraces,traceLen], [star type] );    
    data.(channelNames{i}) = d(indexes,:);   
end

%% Convert the spartan trace into KIT_KAT
% create fake pics
img_t = ones(20,20);
img = uint16(img_t);
for l= 1:nTraces
             Picture_d{l,1} = img;
             Picture_d{l,2} = [10,10];
             Picture_d{l,3} = 1.5;             
             Picture_a{l,1} = img;
             Picture_a{l,2} = [10,10];
             Picture_a{l,3} = 1.5;
end
centers_ext= ones(nTraces,2).*32;

for i = 1:nTraces
    don_tot_trace(:,i) = (data.donor(i,:)');
    accep_tot_trace(:,i) = (data.acceptor(i,:)');
    don_bckg_trace(:,i) = mean(don_tot_trace((end-100):end));
    accep_bckg_trace(:,i) = mean(accep_tot_trace((end-100):end));
end
don_spec_trace = don_tot_trace-don_bckg_trace;
accep_spec_trace = accep_tot_trace-accep_bckg_trace;
Mode1 = 'Multicolor';
uisave({'time_axis','centers_ext','don_tot_trace','don_spec_trace','don_bckg_trace','accep_tot_trace','accep_spec_trace',...
    'accep_bckg_trace','Mode1','Picture_d','Picture_a'})
%% get the metadata
% loadTraces(filename);