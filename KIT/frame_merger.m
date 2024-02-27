function varargout = frame_merger(varargin)
%% FRAME_MERGER MATLAB code for frame_merger.fig
%  Kobilka Lab frame merger allows for the orientation of the image panels
%  to be perfectly aligned for the generation os smFRET traces.
%      FRAME_MERGER, by itself, creates a new FRAME_MERGER or raises the existing
%      singleton*.%
%      H = FRAME_MERGER returns the handle to a new FRAME_MERGER or the handle to
%      the existing singleton*.%
%      FRAME_MERGER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRAME_MERGER.M with the given input arguments.%
%      FRAME_MERGER('Property','Value',...) creates a new FRAME_MERGER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before frame_merger_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to frame_merger_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help frame_merger

% Last Modified by GUIDE v2.5 15-Jun-2022 23:16:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @frame_merger_OpeningFcn, ...
                   'gui_OutputFcn',  @frame_merger_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end
if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

%% Initialisation parameters
% --- Executes just before frame_merger is made visible.
function frame_merger_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to frame_merger (see VARARGIN)

% Choose default command line output for frame_merger

global CAM
CAM = 2;
global CHAN
CHAN = 1;

global HOR
global VER
HOR = 0;
VER = 1;

handles.output = hObject;
cla(handles.axes1);
cla(handles.axes2);
cla(handles.axes5);
cla(handles.axes6);
cla(handles.axes7);
cla(handles.axes8);
cla(handles.axes9);
cla(handles.axes10);
cla(handles.axes11);
cla(handles.axes13);
cla(handles.axes14);
 set(handles.auto_save,'Value',1);
 set(handles.d_t_a_frames, 'String', num2str(2));
 sliderstep = [0.01, 0.01]; 
 set(handles.d_t_a_frames1, 'String', num2str(2));
 sliderstep2 = [0.01, 0.011]; 
 set(handles.don_pix_max, 'String', num2str(2.4));
 set(handles.accep_pix_max, 'String', num2str(2.4)); 
 set(handles.edit34, 'String', num2str(0.5));
 set(handles.edit33, 'String', num2str(0.5)); 
 set(handles.d_t_a_frames, 'String', num2str(5));
 set(handles.d_t_a_frames1, 'String', num2str(10));
 set(handles.trim_total_frames,'String',num2str(400));
 set(handles.eval_trim,'String',num2str(50));
 
 % Donor channel
 %threshold
 set(handles.don_sens, 'Min', 0);
 set(handles.don_sens, 'Max', 40000);
 set(handles.don_sens, 'Value', 1000);
 set(handles.don_sens_disp, 'String',num2str(1000));
 set(handles.don_sens,'SliderStep',  sliderstep);
%  % pixel overlap
%  set(handles.don_edge, 'Min', 0);
%  set(handles.don_edge, 'Max', 1.2);
%  set(handles.don_edge, 'Value', 1);
%  set(handles.don_edge, 'SliderStep', sliderstep2);
%  set(handles.don_edge_disp, 'String', num2str(1));
 
 % Acceptor channel
 set(handles.accep_sens, 'Min', 0);
 set(handles.accep_sens, 'Max', 40000);
 set(handles.accep_sens, 'Value', 800);
 set(handles.accep_sens_disp, 'String',num2str(800));
 set(handles.accep_sens,'SliderStep',  sliderstep);
%  %pixel overlap
%  set(handles.accep_edge, 'Min', 0);
%  set(handles.accep_edge, 'Max', 1.2);
%  set(handles.accep_edge, 'Value', 1);
%  set(handles.accep_edge, 'SliderStep', sliderstep2);
%  set(handles.accep_edge_disp, 'String', num2str(1));
 % set the multiplication factor
 set(handles.multi_don,'String',num2str(1));
 set(handles.multi_accep,'String',num2str(1));
% set(handles.popupmenu2,'Value',1);
 % Set Movie Preview
 set(handles.movie_fps,'String',num2str(1));
 set(handles.mov_num_frames,'String',num2str(1));
 global BackG 
BackG = 'Select Background (Pixel)';

global xperc
%set(handles.edit30, 'String', num2str(46));
xperc = 46;
global v_filt
%set(handles.checkbox2, 'Value', 1);
v_filt = 1;
set(handles.time_int, 'String', num2str(100)); 
global NUM
NUM = 100;
% Update handles structure
axes(handles.axes16);
cla
axes(handles.axes17);
cla
axes(handles.axes20);
cla
axes(handles.axes21);
cla
guidata(hObject, handles);

% UIWAIT makes frame_merger wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = frame_merger_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%% Load and reads images and updaes the various handles with the object data.
% --- Executes on button press in load_image.
function load_image_Callback(hObject, eventdata, handles)
% hObject    handle to load_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Determine the type of images
global image_d
global image_a
global image_d1
global image_a1          
global avg_frames
global CAM
global CHAN
global VER
global HOR
global donor
global acceptor
global AND_SOL
global img_source
global fname
global num_images
global file_name      
        auto_trim_frame = get(handles.auto_trim_mov, 'Value');
        auto_sum_frames = get(handles.auto_sum_frames,'Value'); 
        disp_trim_start = get(handles.disp_trim_start,'Value');
% Get the batch extract mode
        full__auto_t = get(handles.full_auto,'SelectedObject');
        full_auto_mode = get(full__auto_t,'String');
        switch full_auto_mode 
            case ('Batch Extract')
                batch_extraction = 1;
            case ('None')
                batch_extraction = 0;
            case('Auto Extract')
                batch_extraction = 0;
        end
reload_img = get(handles.radiobutton32,'Value');
img_source_t = get(handles.imgacq_group, 'SelectedObject');
img_source = get(img_source_t, 'String');
if reload_img == 0
    if batch_extraction == 0
        [fname, user_cancel] = imgetfile();
        [path_img,file_name] = fileparts(fname);        
    elseif batch_extraction == 1
        load('batch_file.mat','fname','path_img','file_name');
    end  
setappdata(handles.file_name, 'path_img', path_img);
setappdata(handles.file_name, 'fname',fname);
setappdata(handles.file_name, 'file_name',file_name);
elseif reload_img ==1
fname = getappdata(handles.file_name, 'fname');
path_img = getappdata(handles.file_name, 'path_img');
file_name = getappdata(handles.file_name, 'file_name');
end

%% Set the imaging speed from reading the name
b = {'1ms','3ms','5ms','8ms','10ms','11ms','12ms','15ms','20ms','25ms','30ms','35ms','40ms',...
    '45ms','50ms','60ms','75ms','100ms','200ms','250ms','500ms'};
preset = 0;
time_sample = contains(fname,b,'IgnoreCase',true);
if time_sample == 1
    if strfind(fname,'1ms')
        set(handles.time_int,'String',num2str(1));
        preset = 1;        
    elseif strfind(fname, '3ms')
        set(handles.time_int,'String',num2str(3));  
        preset = 1;
    elseif strfind(fname, '5ms')
        set(handles.time_int,'String',num2str(5));
        preset = 1;
    elseif strfind(fname, '8ms')
        set(handles.time_int,'String',num2str(8));
        preset = 1;
    elseif strfind(fname,'10ms')
        set(handles.time_int,'String',num2str(10));
        preset = 1;
    elseif strfind(fname,'11ms')
        set(handles.time_int,'String',num2str(11));
        preset = 1;
    elseif strfind(fname, '12ms')
        set(handles.time_int,'String',num2str(12));
        preset = 1;
    elseif strfind(fname,'15ms')
        set(handles.time_int,'String',num2str(15));
        preset = 1;
    elseif strfind(fname,'20ms')
        set(handles.time_int,'String',num2str(20));
        preset = 1;
    elseif strfind(fname,'25ms')
        set(handles.time_int,'String',num2str(25));
        preset = 2;
    elseif strfind(fname,'30ms')
        set(handles.time_int,'String',num2str(30));
        preset = 2;
    elseif strfind(fname,'35ms')
        set(handles.time_int,'String',num2str(35));
        preset = 2;
    elseif strfind(fname,'40ms')
        set(handles.time_int,'String',num2str(40));
    elseif strfind(fname,'45ms')
        set(handles.time_int,'String',num2str(45));
    elseif strfind(fname,'50ms')
        set(handles.time_int,'String',num2str(50));
    elseif strfind(fname,'60ms')
        set(handles.time_int,'String',num2str(60));
    elseif strfind(fname,'75ms')
        set(handles.time_int,'String',num2str(75));
    elseif strfind(fname,'100ms')
        set(handles.time_int,'String',num2str(100));
    elseif strfind(fname,'200ms')
        set(handles.time_int,'String',num2str(200));
    elseif strfind(fname,'250ms')
        set(handles.time_int,'String',num2str(250));
    elseif strfind(fname,'500ms')
        set(handles.time_int,'String',num2str(500));
    end    
end
if reload_img == 1
else
if preset == 1
    if batch_extraction == 1
        set(handles.eval_trim,'String',num2str(100));
    else
        set(handles.d_t_a_frames, 'String', num2str(30));
        set(handles.d_t_a_frames1, 'String', num2str(40));
        set(handles.eval_trim,'String',num2str(100));
    end
elseif preset == 2
    if batch_extraction == 1
        set(handles.eval_trim,'String',num2str(70));  
    else
        set(handles.d_t_a_frames, 'String', num2str(20));
        set(handles.d_t_a_frames1, 'String', num2str(30));
        set(handles.eval_trim,'String',num2str(70));
    end
end
end

addpath(path_img);
setappdata(handles.file_name, 'path_img', path_img);
info = imfinfo(fname);
img_dims_w = info.Width;
set(handles.img_width, 'String', num2str(img_dims_w));
img_dims_h = info.Height;
set(handles.img_hgt, 'String', num2str(img_dims_h));
num_images = numel(info);
setappdata(handles.file_name, 'num_images',num_images);
% set(handles.disp_read_images,'String','test');
avg_frames = str2double(get(handles.d_t_a_frames, 'String'));
avg_frames1 = str2double(get(handles.d_t_a_frames1, 'String'));

%% Do the movie trimming
% get trim switch handle
% calculate the start point
if auto_trim_frame == 1
    % get the number of evaluation frames
    num_eval_frames = str2num(get(handles.eval_trim,'String'));
    %set length
    max_frames = num_images -100;
    set(handles.trim_total_frames,'String',num2str(max_frames));
    % Calculate start frame
        for p = 1:num_eval_frames
            extrac_D = imread([file_name,'.tif'],p);
            sum_extrac_D(p) = sum(sum(extrac_D));        
        end
        d_trace_var = movvar(sum_extrac_D,5);
        [pks_d_t,~] = findpeaks(d_trace_var);
        sel_pks_d = max(pks_d_t)/2;
        [~, locs_d] = findpeaks(d_trace_var, 'MinPeakHeight', sel_pks_d);
        if disp_trim_start == 1
        figure(11)
        findpeaks(d_trace_var, 'MinPeakHeight', sel_pks_d);
        end
        locs_d = locs_d(1)+2;
        set(handles.trim_start_frame,'String', num2str(locs_d));
        set(handles.trim_end_frame,'String', num2str(locs_d + max_frames));
        start_frame = locs_d;
        stop_frame = locs_d + max_frames;        
end

switch img_source  
    case char('micromanager')
            if mod(num_images,2) ~= 0
            msgbox('Uneven donor acceptor frames')
            num_images = num_images -1;
            end
            
%             set(handles.disp_read_images, 'String', num2str(num_images));
            if (CAM == 1)
                set(handles.d_a_frame, 'String', num2str((num_images))); 
                donor = 1:num_images;
                acceptor = 1:num_images;                
            else
                set(handles.d_a_frame, 'String', num2str((num_images)/2));
                length_images = 1:num_images;
                donor = find(mod(length_images,2)~=0);
                acceptor = find(mod(length_images,2)==0);   
            end            
                     
    case char('Andor Solis')
           if auto_trim_frame == 1
               donor = start_frame:stop_frame;
               acceptor = start_frame:stop_frame;               
           else               
            donor = 1:num_images;
            acceptor = 1:num_images;            
            if (CAM == 1)
                set(handles.d_a_frame, 'String', num2str((num_images))); 
            else
                set(handles.d_a_frame, 'String', num2str((num_images)));
%                 set(handles.disp_read_images, 'String', num2str(num_images)*2);                
            end   
           end
end
set(handles.file_name, 'String', file_name);

%% perform image splitting and merging
%-------------------------------------------------------------------------------------------------------------------------%
%-------------------------------------------------------------------------------------------------------------------------%  
counter = 0;
if numel(donor)> avg_frames
    frame_plotter = avg_frames;
else
    frame_plotter = numel(donor);
end

if numel(acceptor)> avg_frames1
    frame_plotter1 = avg_frames1;
else
    frame_plotter1 = numel(acceptor);
end
global W
global H
global W_split
global H_split
W = img_dims_w; 
W_split = W/2;
H = img_dims_h;
H_split = H/2;

val_min_don = (get(handles.min_sub_don,'Value'));
val_min_accep = (get(handles.min_sub_accep,'Value'));
    
switch img_source
    case char('micromanager')        
        AND_SOL = 0;
        if CHAN == 1            
           if CAM == 2                
                            image_d = imread(fname, donor(1));
                            image_a = imread(fname, acceptor(1));
                                                       
                            for k = 2:frame_plotter  
                                D = imread(fname,donor(k));
                                if val_min_don == 1
                                sub_min_don = mean(min(D));
                                else
                                sub_min_don = uint16(0);
                                end 
                                image_d = image_d + (D - sub_min_don);
                            end
                            
                            for k = 2:frame_plotter1
                                A = imread(fname,acceptor(k));
                                if val_min_accep ==1
                                sub_min_accep =  mean(min(A));
                                else
                                sub_min_accep = uint16(0);                                
                                end
                                image_a = image_a + (A - sub_min_accep);
                            end
                
            elseif CAM == 1
                            image_d = imread(fname, 1);
                            image_a = ones(W,H);
                            for k = 2:frame_plotter   
                                D = imread(fname,k );
                                if val_min_don == 1
                                sub_min_don = mean(min(D));
                                else
                                sub_min_don = uint16(0);
                                end 
                                image_d = image_d + (D - sub_min_don);
                            end 
           end
        end
  
        if CHAN == 2
            if CAM == 1
                         dd =  imread(fname,1);
                         if HOR == 1
                              disp('horizontal')
                              set(handles.split_h, 'String', num2str(H_split));
                              set(handles.split_w, 'String', num2str(W));
                              image_d = dd(1:H_split,:);
                              image_a = dd((H_split+1):H,:);
                         elseif VER == 1
                             disp('vertical')
                              set(handles.split_h, 'String', num2str(H));
                              set(handles.split_w, 'String', num2str(W_split));
                              image_d = dd(:,1:W_split);
                              image_a = dd(:,(W_split+1):W);
                         end

                        for k = 2:frame_plotter   
                            D = imread(fname,k);
                            if HOR == 1
                              D1 = D(1:H_split,:);                              
                            elseif VER == 1
                              D1 = D(:,1:W_split);                              
                            end
                            image_d = image_d + D1 - mean(min(D1));                            
                        end
                        
                        for k = 2:frame_plotter1   
                            D = imread(fname,k);
                            if HOR == 1                              
                              D2 = D((H_split+1):H,:);
                            elseif VER == 1                              
                              D2 = D(:,(W_split+1):W);
                            end                            
                            image_a = image_a + D2 - mean(min(D2));
                        end                        
                        
            elseif CAM == 2                
                        image_dd1 = imread(fname, donor(1));
                        image_aa1 = imread(fname, acceptor(1));
                         if HOR == 1
                              image_d = image_dd1(1:H_split,:);
                              image_d1 = image_dd1((H_split+1):H,:);
                              image_a = image_aa1(1:H_split,:);
                              image_a1 = image_aa1((H_split+1):H,:);
                            elseif VER == 1
                              image_d = image_dd1(:,1:W_split);
                              image_d1 = image_dd1(:,(W_split+1):W);
                              image_a = image_aa1(:,1:W_split);
                              image_a1 = image_aa1(:,(W_split+1):W);
                         end
% NOTE THIS WILL NEED CORRECTION FOR FRAME PLOTTER AND FRAME PLOTTER1!!!
% Look above for the correction
                        for k = 2:frame_plotter   
                            image_dd1 = imread(fname, donor(k));
                            image_aa1 = imread(fname, acceptor(k));
                         if HOR == 1
                              image_dq = image_dd1(1:H_split,:);
                              image_d1q = image_dd1((H_split+1):H,:);
                              image_aq = image_aa1(1:H_split,:);
                              image_a1q = image_aa1((H_split+1):H,:);
                              image_d = image_d + image_dq - mean(min(image_dq));
                              image_d1 =  image_d1+  image_d1q - mean(min(image_d1q));
                              image_a = image_a +image_aq - mean(min(image_aq));
                              image_a1 = image_a1 + image_a1q - mean(min(image_a1q));

                            elseif VER == 1
                              image_dq = image_dd1(:,1:W_split);
                              image_d1q = image_dd1(:,(W_split+1):W);
                              image_aq = image_aa1(:,1:W_split);
                              image_a1q = image_aa1(:,(W_split+1):W);
                              image_d = image_d + image_dq - mean(min(image_dq));
                              image_d1 =  image_d1+  image_d1q - mean(min(image_d1q));
                              image_a = image_a +image_aq - mean(min(image_aq));
                              image_a1 = image_a1 + image_a1q - mean(min(image_a1q));
                         end
                        end
            end
        end
        

    case char('Andor Solis')
        AND_SOL = 1;
        image_d = imread([file_name,'.tif'], donor(1));        
        
        if CAM ==2
        image_a = imread([file_name,'b','.tif'], acceptor(1));
        else
        image_a = ones(size(image_d));
        end
        
        if CHAN == 1            
           if CAM == 2                
                            for k = 2:frame_plotter   
                                 D = imread([file_name,'.tif'],donor(k));
                                if val_min_don == 1
                                sub_min_don = mean(min(D));
                                else
                                sub_min_don = uint16(0);
                                end 
                                image_d = image_d + (D - sub_min_don);
                            end

                            for k = 2:frame_plotter1
                                A = imread([file_name,'b','.tif'],acceptor(k));
                                if val_min_accep ==1
                                sub_min_accep =  mean(min(A));
                                else
                                sub_min_accep = uint16(0);                                
                                end
                                image_a = image_a + (A - sub_min_accep);
                            end
                
            elseif CAM == 1
                            image_d = imread([file_name,'.tif'], donor(1));
                            image_a = ones(W,H);
                            for k = 2:frame_plotter   
                                D = imread([file_name,'.tif'], donor(k));
                                if val_min_don == 1
                                sub_min_don = mean(min(D));
                                else
                                sub_min_don = uint16(0);
                                end 
                                image_d = image_d + (D - sub_min_don);
                            end 
           end
        end
  
        if CHAN == 2
            if CAM == 1
                         dd =  imread([file_name,'.tif'], donor(1));
                         if HOR == 1
                              disp('horizontal')
                              set(handles.split_h, 'String', num2str(H_split));
                              set(handles.split_w, 'String', num2str(W));
                              image_d = dd(1:H_split,:);
                              image_a = dd((H_split+1):H,:);
                         elseif VER == 1
                             disp('vertical')
                             set(handles.split_h, 'String', num2str(H));
                             set(handles.split_w, 'String', num2str(W_split));
                              image_d = dd(:,1:W_split);
                              image_a = dd(:,(W_split+1):W);
                         end
                         
                        if auto_sum_frames == 1
                            image_d_p = edge(image_d,'Prewitt');
                            for k = 2:100  
                                D = imread([file_name,'.tif'], donor(k));
                                if HOR == 1
                              D1 = D(1:H_split,:);                              
                                elseif VER == 1
                              D1 = D(:,1:W_split);                             
                                end
                                D1_p = edge(D1,'Prewitt');
                                image_d_p = image_d_p + D1_p;
                            end
                            image_d = image_d_p.*100;    
                            max(max(image_d))
                        else
                            for k = 2:frame_plotter   
                                D = imread([file_name,'.tif'], donor(k));
                                if HOR == 1
                              D1 = D(1:H_split,:);                              
                                elseif VER == 1
                              D1 = D(:,1:W_split);                             
                                end
                                %image_d = image_d + D1 - mean(min(D1)); 
                                D1_min = mean(min(D1));
                                D1_t = D1-D1_min;
                                D1 = D1_t;                           
                                image_d = imadd(image_d, D1);                            
                            end 
                        end
                        if auto_sum_frames == 1
                            image_a_p = edge(image_a,'Prewitt');
                            for k = 2:100   
                                  D = imread([file_name,'.tif'], donor(k));
                                if HOR == 1                              
                              D2 = D((H_split+1):H,:);
                                elseif VER == 1                              
                              D2 = D(:,(W_split+1):W);
                                end   
                                D2_p = edge(D2,'Prewitt');
                                image_a_p = image_a_p + D2_p;
                            end
                            image_a = image_a_p.*100;
                            max(max(image_a))
                        else
                            for k = 2:frame_plotter1   
                                  D = imread([file_name,'.tif'], donor(k));
                                if HOR == 1                              
                              D2 = D((H_split+1):H,:);
                                elseif VER == 1                              
                              D2 = D(:,(W_split+1):W);
                                end                            
                            %image_a = image_a + D2 - mean(min(D2));
                           D2_min = mean(min(D2));
                           D2_t = D2-D2_min;
                           D2 = D2_t;
                           image_a = imadd(image_a, D2);
                            end
                        end
                        
            elseif CAM == 2                
                        image_dd1 = imread([file_name,'.tif'], donor(1));
                        image_aa1 = imread([file_name,'b','.tif'],acceptor(1));
                         if HOR == 1
                              image_d = image_dd1(1:H_split,:);
                              image_d1 = image_dd1((H_split+1):H,:);
                              image_a = image_aa1(1:H_split,:);
                              image_a1 = image_aa1((H_split+1):H,:);
                            elseif VER == 1
                              image_d = image_dd1(:,1:W_split);
                              image_d1 = image_dd1(:,(W_split+1):W);
                              image_a = image_aa1(:,1:W_split);
                              image_a1 = image_aa1(:,(W_split+1):W);
                         end

                        for k = 2:frame_plotter   
                            image_dd1 = imread([file_name,'.tif'], donor(k));
                            image_aa1 = imread([file_name,'b','.tif'], acceptor(k));
                         if HOR == 1
                              image_dq = image_dd1(1:H_split,:);
                              image_d1q = image_dd1((H_split+1):H,:);
                              image_aq = image_aa1(1:H_split,:);
                              image_a1q = image_aa1((H_split+1):H,:);
                              image_d = image_d + image_dq - mean(min(image_dq));
                              image_d1 =  image_d1+  image_d1q - mean(min(image_d1q));
                              image_a = image_a +image_aq - mean(min(image_aq));
                              image_a1 = image_a1 + image_a1q - mean(min(image_a1q));

                            elseif VER == 1
                              image_dq = image_dd1(:,1:W_split);
                              image_d1q = image_dd1(:,(W_split+1):W);
                              image_aq = image_aa1(:,1:W_split);
                              image_a1q = image_aa1(:,(W_split+1):W);
                              image_d = image_d + image_dq - mean(min(image_dq));
                              image_d1 =  image_d1+  image_d1q - mean(min(image_d1q));
                              image_a = image_a +image_aq - mean(min(image_aq));
                              image_a1 = image_a1 + image_a1q - mean(min(image_a1q));
                         end
                        end
            
            end
        end
end


global stack_len
stack_len = numel(donor);

axes(handles.axes16);
cla
axes(handles.axes17);
cla
axes(handles.axes20);
cla
axes(handles.axes21);
cla
axes(handles.axes1);
cla
axes(handles.axes2);
cla

multi_don = str2double(get(handles.multi_don,'String'));
multi_accep = str2double(get(handles.multi_accep,'String'));
image_d = image_d.*multi_don;
image_a = image_a.*multi_accep;

%-------------------------------------------------------------------------%
%---------------plot the images-------------------------------------------%

if CHAN == 2 && CAM == 2 
axes(handles.axes16);
min_d = min(image_d(:));
max_d = max(image_d(:));
imshow(image_d,[min_d max_d*3]); 

axes(handles.axes17);
min_d = min(image_d1(:));
max_d = max(image_d1(:));
imshow(image_d1,[min_d max_d*3]); 

axes(handles.axes20);
min_a = min(image_a(:));
max_a = max(image_a(:));
imshow(image_a,[min_a max_a*3]); 

axes(handles.axes21);
min_a = min(image_a1(:));
max_a = max(image_a1(:));
imshow(image_a1,[min_a max_a*3]); 

% create fusion image
image_d_fuse = cat(2,image_d, image_d1);
image_a_fuse = cat(2,image_a, image_a1);
axes(handles.axes5);
raw_overlay = imfuse(image_d_fuse,image_a_fuse,'falsecolor' ,'ColorChannels',[2 1 0]);
imshow(raw_overlay)
end

if CHAN ~= 2 || CAM ~= 2
axes(handles.axes1);
min_d = min(image_d(:));

[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*20 >=65536
    max_d = 65536;
else
    max_d = max_d_t *40;
end
% max_d = max(image_d(:));
imshow(image_d,[min_d max_d]); 
axes(handles.axes2);
min_a = min(image_a(:));

[fig_a_c, fig_a_b] = imhist(image_a);
max_a_c = max(fig_a_c);
ind_maxa_c = find(fig_a_c == max_a_c);
max_a_t = ceil(fig_a_b(ind_maxa_c));
if max_a_t*20 >=65536
    max_a = 65536;
else
    max_a = max_a_t *40;
end
% max_a = max(image_a(:));
global maA
global miA

miA = min_a;
maA = max_a;
imshow(image_a,[min_a max_a]);

axes(handles.axes5);
raw_overlay = imfuse(image_d,image_a,'falsecolor','Scaling','joint','ColorChannels',[2 1 0]);
if auto_sum_frames == 1
    imshow(raw_overlay)
else
imshow(raw_overlay.*2,[min_d max_d])
end
setappdata(handles.d_t_a_frames,'image_d',image_d);
setappdata(handles.d_t_a_frames,'image_a',image_a);
set(handles.min_img_don,'String',num2str(min_d));
set(handles.max_img_don,'String',num2str(max_d));

set(handles.min_img_accp,'String',num2str(min_a));
set(handles.max_img_accp,'String',num2str(max_a));

don_lower_thresh = max_d/(frame_plotter*2);
accep_lower_thresh = max_a/frame_plotter1;

set(handles.don_thresh_picker,'String', num2str(don_lower_thresh));
set(handles.accep_thresh_picker,'String', num2str(accep_lower_thresh));
end

        full__auto_t = get(handles.full_auto,'SelectedObject');
        full_auto_mode = get(full__auto_t,'String');
        switch full_auto_mode 
            case ('Batch Extract')               
                image_register_Callback(handles.image_register, eventdata, handles)
        end
guidata(hObject, handles);
%% TO DO : enter call back for frame number
% write and save merged tif stack
function d_a_frame_Callback(hObject, eventdata, handles)
% hObject    handle to d_a_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_a_frame as text
%        str2double(get(hObject,'String')) returns contents of d_a_frame as a double

% --- Executes during object creation, after setting all properties.
function d_a_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_a_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function d_frame_Callback(hObject, eventdata, handles)
% hObject    handle to d_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_frame as text
%        str2double(get(hObject,'String')) returns contents of d_frame as a double

% --- Executes during object creation, after setting all properties.
function d_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function a_frame_Callback(hObject, eventdata, handles)
% hObject    handle to a_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a_frame as text
%        str2double(get(hObject,'String')) returns contents of a_frame as a double

% --- Executes during object creation, after setting all properties.
function a_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function m_frame_Callback(hObject, eventdata, handles)
% hObject    handle to m_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m_frame as text
%        str2double(get(hObject,'String')) returns contents of m_frame as a double

% --- Executes during object creation, after setting all properties.
function m_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
% function frame_slider_Callback(hObject, eventdata, handles)
% % hObject    handle to frame_slider (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'Value') returns position of slider
% %        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% 
% % Update handles structure
% % guidata(hObject, handles);
% frame_num = get(handles.frame_slider, 'Value');
% frame_num = ceil(frame_num);
% set(handles.d_frame, 'String', num2str(frame_num));
% set(handles.a_frame, 'String', num2str(frame_num));
% set(handles.m_frame, 'String', num2str(frame_num));
% guidata(hObject, handles);
% image_d = getappdata(handles.frame_slider,'image_d');
% image_a = getappdata(handles.frame_slider,'image_a');
% image_merge = getappdata(handles.frame_slider,'image_merge');
% axes(handles.axes1);
% min_d = min(image_d(:));
% max_d = max(image_d(:));
% imshow(image_d(:,:,frame_num),[min_d max_d]) 
% axes(handles.axes2);
% min_a = min(image_a(:));
% max_a = max(image_a(:));
% imshow(image_a(:,:,frame_num),[min_a max_a])
% axes(handles.axes3);
% min_m = min(min_d,min_a);
% max_m = max(max_d,max_a);
% imshow(image_merge(:,:,frame_num),[min_m max_m]);
% axes(handles.axes5);
% raw_overlay = imfuse(image_d(:,:,frame_num).*10,image_a(:,:,frame_num).*10,'falsecolor' ,'ColorChannels',[1 2 0]);
% imshow(raw_overlay)
% guidata(hObject, handles);
%
% % --- Executes during object creation, after setting all properties.
% function frame_slider_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to frame_slider (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: slider controls usually have a light gray background.
% if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor',[.9 .9 .9]);
% end

function file_name_Callback(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_name as text
%        str2double(get(hObject,'String')) returns contents of file_name as a double

% --- Executes during object creation, after setting all properties.
function file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in save_file.
function save_file_Callback(hObject, eventdata, handles)
% hObject    handle to save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Get Save type
global len_stack
        num_images = getappdata(handles.file_name, 'num_images'); 
        len_stack = getappdata(handles.save_name, 'len_stack');
        fname = getappdata(handles.save_name, 'file_name');
        length = 1:num_images;
        % Find and extract donor frames
        donor = find(mod(length,2)~=0);
        acceptor = find(mod(length,2)==0);
        h = waitbar(0, 'Processing Images for Registration');
        
            for k = 1:len_stack;
                D = imread(fname,donor(k));
                image_dw(:,:,k) = D;
                A = imread(fname,acceptor(k));
                image_aw(:,:,k) = A;
                waitbar(k/len_stack);
            end
        close (h) 
        register_save =get(handles.radio_register, 'String');
        save_name = getappdata(handles.save_name, 'save_name');
        path_img = getappdata(handles.file_name, 'path_img');
        save_path = [path_img, '/',save_name];

switch register_save
    case char('Register');
        tform = getappdata(handles.image_register,'tform');
        reg_file = getappdata(handles.image_register,'reg_coord');
        load(reg_file,'tform');   
        h = waitbar(0, 'Writing Registered Images');
        
        for i = 1:len_stack
            image_a_r = imwarp(image_aw(:,:,i),tform,'OutputView',imref2d(size(image_dw(:,:,i))));
%             image_merge_t = [image_dw(:,:,i) image_a_r];
%             image_merge_r(:,:,i) = image_merge_t;
            imwrite(image_merge_r(:,:,i), save_path, 'writemode', 'append');    
            waitbar(i/len_stack);
        end      
        close(h)
        msgbox('Registered Merged Image Saved');
                
    case char('No Register');
        
        h = waitbar(0, 'Writing Registered Images');
        counter2 = 0;
        for i = 1:len_stack
            image_merge_temp = [image_dw(:,:,i) image_aw(:,:,i)];
            counter2 = counter2 + 1;
            image_merge_n(:,:,i) = image_merge_temp;            
            imwrite(image_merge_n(:,:,i), save_path, 'writemode', 'append');
            waitbar(counter2/len_stack);
        end
        close(h)
        msgbox('UnRegistered Image Saved');
end
guidata(hObject, handles);


function save_name_Callback(hObject, eventdata, handles)
% hObject    handle to save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_name as text
%        str2double(get(hObject,'String')) returns contents of save_name as a double


% --- Executes during object creation, after setting all properties.
function save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in image_register.
function image_register_Callback(hObject, eventdata, handles)
% hObject    handle to image_register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_d
global image_a
global image_d1
global image_a1
global CAM
global CHAN
global VER
global HOR
        full__auto_t = get(handles.full_auto,'SelectedObject');
        full_auto_mode = get(full__auto_t,'String');
        switch full_auto_mode 
            case ('Batch Extract')
                type_reg_batch = getappdata(handles.batch_load,'reg_batch');
                if strcmpi(type_reg_batch,'Auto') == 1
                    batch_auto = 2;
                    f = msgbox('Computing the Registration','Registration');
                    [optimizer,metric] = imregconfig('monomodal');
                    optimizer.MaximumIterations = 600;
                    metric = registration.metric.MeanSquares;
                    [tform]= imregtform(image_a, image_d, 'rigid', optimizer, metric,'DisplayOptimization',disp_val);
                    movingRegisteredDefault = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));  
                    reg_file = tform;
                    register = 'Apply Registration'; 
                elseif strcmpi(type_reg_batch,'Apply') == 1
                    set(handles.radiobutton12,'Value',1);
                    batch_auto = 1;
                   register = 'Apply Registration'; 
                end                
                
            case ('Auto Extract')
                register_t = get(handles.registration_group, 'SelectedObject');
                register = get(register_t, 'String'); 
                
            case ('None')
                register_t = get(handles.registration_group, 'SelectedObject');
                register = get(register_t, 'String');                
        end

switch register
    case char('Automatic Registration')
        disp_conv = get(handles.disp_converg,'Value');
        if disp_conv == 1
            disp_val = true;
        elseif disp_conv == 0
            disp_val = false;
        end
        f = msgbox('Computing the Registration','Registration');
        [optimizer,metric] = imregconfig('monomodal');
        optimizer.MaximumIterations = 600;
        metric = registration.metric.MeanSquares;
        [tform]= imregtform(image_a, image_d, 'rigid', optimizer, metric,'DisplayOptimization',disp_val);
        movingRegisteredDefault = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));
        axes(handles.axes6);         
        reg_overlay = imfuse(image_d,movingRegisteredDefault,'falsecolor' ,'ColorChannels',[2 1 0]);
        imshow(reg_overlay)
        save('reg_coord.mat','tform');
        close(f)
         
    case char('Apply Registration')
         switch full_auto_mode 
            case ('Batch Extract')
                if batch_auto == 1
                    if ispc == 1
                        load('Variables\batch_cmd.mat','reg_file');
                    elseif ismac == 1
                        load('Variables/batch_cmd.mat','reg_file');
                    end 
                    load(reg_file,'tform');
                    
                end
                setappdata(handles.image_register,'reg_coord',reg_file); 
                
            case ('Auto Extract')
                reg_file = uigetfile('.mat', 'Select reg_coordin file');
                if ispc == 1
                save('Variables\batch_cmd.mat','reg_file');
                elseif ismac == 1
                save('Variables/batch_cmd.mat','reg_file');
                end
                
            case ('None')
                reg_file = uigetfile('.mat', 'Select reg_coordin file');  
                if ispc == 1
                save('Variables\batch_cmd.mat','reg_file');
                elseif ismac == 1
                save('Variables/batch_cmd.mat','reg_file');
                end
                setappdata(handles.image_register,'reg_coord',reg_file);         
                load(reg_file,'tform');
                        
         end
         
                movingRegisteredDefault = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));
                setappdata(handles.image_register,'image_a_reg',movingRegisteredDefault );
                axes(handles.axes6);
                reg_overlay = imfuse(image_d,movingRegisteredDefault,'falsecolor','Scaling','joint','ColorChannels',[2 1 0]);
                imshow(reg_overlay)
                setappdata(handles.image_register,'tform',tform);
        f = msgbox('Registration Applied');
        close(f)
       
    case char('No Registration')
        axes(handles.axes6);
        raw_overlay = imfuse(image_d,image_a,'falsecolor','Scaling','joint','ColorChannels',[2 1 0]);
        imshow(raw_overlay)
end

switch full_auto_mode 
    case ('Auto Extract')
      pushbutton22_Callback(handles.pushbutton22, eventdata, handles)
    case('Batch Extract')
      pushbutton22_Callback(handles.pushbutton22, eventdata, handles)
end

% --- Executes on button press in radio_register.
function radio_register_Callback(hObject, eventdata, handles)
% hObject    handle to radio_register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radio_register
if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles.radio_register, 'String', 'Register');
elseif (get(hObject,'Value') == get(hObject,'Min'))
	set(handles.radio_register, 'String', 'No Register');
end


function d_t_a_frames_Callback(hObject, eventdata, handles)
% hObject    handle to d_t_a_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_t_a_frames as text
%        str2double(get(hObject,'String')) returns contents of d_t_a_frames as a double

if (get(hObject,'Value') == get(hObject,'Max'))
	set(handles. d_t_a_frames, 'String', 'Value');
end


% --- Executes during object creation, after setting all properties.
function d_t_a_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_t_a_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double

% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in image_avg.
function image_avg_Callback(hObject, eventdata, handles)
% hObject    handle to image_avg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function img_hgt_Callback(hObject, eventdata, handles)
% hObject    handle to img_hgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of img_hgt as text
%        str2double(get(hObject,'String')) returns contents of img_hgt as a double

% --- Executes during object creation, after setting all properties.
function img_hgt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img_hgt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function img_width_Callback(hObject, eventdata, handles)
% hObject    handle to img_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of img_width as text
%        str2double(get(hObject,'String')) returns contents of img_width as a double


% --- Executes during object creation, after setting all properties.
function img_width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img_width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function don_mols_Callback(hObject, eventdata, handles)
% hObject    handle to don_mols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_mols as text
%        str2double(get(hObject,'String')) returns contents of don_mols as a double


% --- Executes during object creation, after setting all properties.
function don_mols_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_mols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_mols_Callback(hObject, eventdata, handles)
% hObject    handle to accep_mols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_mols as text
%        str2double(get(hObject,'String')) returns contents of accep_mols as a double


% --- Executes during object creation, after setting all properties.
function accep_mols_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_mols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stoich_Callback(hObject, eventdata, handles)
% hObject    handle to stoich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stoich as text
%        str2double(get(hObject,'String')) returns contents of stoich as a double


% --- Executes during object creation, after setting all properties.
function stoich_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stoich (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in find_donor.
function find_donor_Callback(hObject, eventdata, handles)
global centers_d
global radii_d
global image_d 
global cent_map_d
global num_d_o_range1
global num_d_o_range2 
global radii_dttt

% get iteration value
max_iter = str2num(get(handles.max_iter_psf,'String'));
min_image_d = min(min(image_d));
image_d_temp = image_d - min_image_d;
axes(handles.axes7);
min_d = min(image_d(:));
[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*10 >=65536
    max_d = 65536;
else
    max_d = max_d_t *10;
end
imshow(image_d,[min_d max_d]) 
% this is the threshold value
% Insert auto selection here
type_auto_thresh_t = get(handles.thresh_auto, 'SelectedObject');
type_auto_thresh = get(type_auto_thresh_t, 'String');
switch type_auto_thresh
    case ('Auto')
        th = str2num(get(handles.don_thresh_picker, 'String'));
        
    case ('Manual')
        th = get(handles.don_sens, 'Value');
end
% this is the optomiser ratio for the radii
don_edge = 1;
don_pix_min = str2double(get(handles.edit34, 'String'));
don_pix_max = str2double(get(handles.don_pix_max, 'String'));
% th = threshold
% os = offset
[centers_dttt, radii_dttt, cent_map_d] = centroid_finder (image_d, th,2,don_edge);
% Filter the particles to eliminate those with radii that are below or
% higher than the min/max pixel range
radii_dtti = find(radii_dttt>=don_pix_min & radii_dttt<=don_pix_max);
radii_dtt = radii_dttt(radii_dtti);
% number of particles outside of pixel range
num_d_o_range1 = length(radii_dttt) - length(radii_dtt);
centers_dtt = centers_dttt(radii_dtti,:);
localization_tt = get(handles.localization,'SelectedObject');
localization_t = get(localization_tt,'String');

%% Filter for overlap
[radii_di] = overlap_filter(centers_dtt, radii_dtt);
% New centers and radii filtered for rixel range and for overlap
centers_dt = centers_dtt(radii_di,:);
radii_d = round(radii_dtt(radii_di));
radii_l = size(radii_d);
radii_d = ones(radii_l).*2;
%%
switch localization_t
    case{'Standard'}  
        %% optomise sum of particles and pixelise the centers in x and y
        [centers_d] = extrac_optom(radii_d,centers_dt,image_d);
    case{'PSF'}
        centers_dt = round(centers_dt);
       [centers_d] = psf_localization(centers_dt,image_d,max_iter);
end
% number of pixels outside that overlap
num_d_o_range2 = length(radii_dtt)-length(radii_d);

setappdata(handles.find_donor, 'centers_d',centers_d);
setappdata(handles.find_donor, 'radii_d', radii_d); 
[don_mol,~] = size(radii_d);
set(handles.don_mols, 'String', num2str(don_mol));
setappdata(handles.find_donor, 'don_mol', don_mol);
viscircles(centers_d,radii_d,'Color','g','LineWidth',.01);

        full__auto_t = get(handles.full_auto,'SelectedObject');
        full_auto_mode = get(full__auto_t,'String');
        switch full_auto_mode 
            case ('Auto Extract')
                don_background_Callback(handles.don_background, eventdata, handles)
            case('Batch Extract')
                don_background_Callback(handles.don_background, eventdata, handles)
        end

% --- Executes on button press in find_acceptor.
function find_acceptor_Callback(hObject, eventdata, handles)
global centers_a
global radii_a
global maA
global miA
global image_a
global cent_map_a
global num_a_o_range1
global num_a_o_range2 
global radii_attt
auto_lock_ratio = get(handles.lock_ratio, 'Value');
auto_ratio_val = str2num(get(handles.set_ratio,'String'));
don_mol = getappdata(handles.find_donor, 'don_mol');
max_iter = str2num(get(handles.max_iter_psf,'String'));
min_image_a = min(min(image_a));
image_a_temp = image_a - min_image_a;
image_d = getappdata(handles.d_t_a_frames,'image_d');
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 
axes(handles.axes8);
image_a_r = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));
setappdata(handles.d_t_a_frames,'image_a_r', image_a_r);
imshow(image_a_r,[miA,maA]);
type_auto_thresh_t = get(handles.thresh_auto, 'SelectedObject');
type_auto_thresh = get(type_auto_thresh_t, 'String');
hold on 
switch type_auto_thresh
    case ('Auto')
        th = str2num(get(handles.accep_thresh_picker,'String'));
        
    case ('Manual')
        th = get(handles.accep_sens, 'Value');
end
accep_edge = 1;
accep_pix_min = str2double(get(handles.edit33, 'String'));
accep_pix_max = str2double(get(handles.accep_pix_max, 'String'));
%% Does the auto scanning
if auto_lock_ratio == 1
    f = msgbox('Auto computing ratio','Ratio');
    th_trials = 200;
    th_inc = 50;
    for k = 1:1000
        th = th_trials + th_inc*k;
        [centers_attt, radii_attt, cent_map_a] = centroid_finder(image_a_r, th,2, accep_edge);
        % Filter the particles to eliminate those with radii that are below or
        % higher than the min/max pixel range
        radii_atti = find(radii_attt>=accep_pix_min & radii_attt<=accep_pix_max);
        radii_att = radii_attt(radii_atti);
        % number of particles outside of pixel range
        num_a_o_range1 = length(radii_attt) - length(radii_att);
        centers_att = centers_attt(radii_atti,:);
        % Filter for overlap
        [radii_ai] = overlap_filter(centers_att, radii_att);
        % New centers and radii filtered for rixel range and for overlap
        centers_at = centers_att(radii_ai,:);
        radii_a = round(radii_att(radii_ai));
        radii_l = size(radii_a);
        radii_a = ones(radii_l).*2;
        [accep_mol,~] = size(radii_a);
        stoich = accep_mol/don_mol;
        if stoich > auto_ratio_val-0.02 && stoich < auto_ratio_val+0.02 
            localization_t = 'PSF';
            break  
        elseif stoich < auto_ratio_val
            localization_t = 'PSF';
            break 
        end
        
    end
else
        % Does the particle finding. 
        [centers_attt, radii_attt, cent_map_a] = centroid_finder(image_a_r, th,2, accep_edge);
        % Filter the particles to eliminate those with radii that are below or
        % higher than the min/max pixel range
        radii_atti = find(radii_attt>=accep_pix_min & radii_attt<=accep_pix_max);
        radii_att = radii_attt(radii_atti);
        % number of particles outside of pixel range
        num_a_o_range1 = length(radii_attt) - length(radii_att);
        centers_att = centers_attt(radii_atti,:);
        localization_tt = get(handles.localization,'SelectedObject');
        localization_t = get(localization_tt,'String');
        % Filter for overlap
        [radii_ai] = overlap_filter(centers_att, radii_att);
        % New centers and radii filtered for rixel range and for overlap
        centers_at = centers_att(radii_ai,:);
        radii_a = round(radii_att(radii_ai));
        radii_l = size(radii_a);
        radii_a = ones(radii_l).*2;
        [accep_mol,~] = size(radii_a);
        stoich = accep_mol/don_mol;
end

%% Optomised number of spots
switch localization_t
    case{'Standard'}  
        %% optomise sum of particles and pixelise the centers in x and y
        [centers_a] = extrac_optom(radii_a,centers_at,image_a_r);
    case{'PSF'}    
        centers_at = round(centers_at);
       [centers_a] = psf_localization(centers_at,image_a_r,max_iter);
end
axes(handles.axes8);
% number of pixels outside that overlap
num_a_o_range2 = length(radii_att)-length(radii_a);
set(handles.accep_mols, 'String', num2str(accep_mol));
viscircles(centers_a,radii_a,'Color','m','LineWidth',.5);
hold off
set(handles.stoich, 'String', stoich);
setappdata(handles.find_acceptor, 'centers_a', centers_a);
setappdata(handles.find_acceptor, 'radii_a', radii_a);        
        if auto_lock_ratio == 1
            close(f)
            accep_background_Callback(handles.accep_background, eventdata, handles)
            pop_fret_Callback(handles.pop_fret, eventdata, handles)            
        end
        
%         full__auto_t = get(handles.full_auto,'SelectedObject');
%         full_auto_mode = get(full__auto_t,'String');
%         switch full_auto_mode 
%             case ('Auto Extract')
%                 accep_background_Callback(handles.accep_background, eventdata, handles)
%             case('Batch Extract')
%                 accep_background_Callback(handles.accep_background, eventdata, handles)               
%         end

        
function fret_mols_Callback(hObject, eventdata, handles)
% hObject    handle to fret_mols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fret_mols as text
%        str2double(get(hObject,'String')) returns contents of fret_mols as a double

% --- Executes during object creation, after setting all properties.
function fret_mols_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fret_mols (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in find_fret.
function find_fret_Callback(hObject, eventdata, handles)
% hObject    handle to find_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global centers_a
% global radii_a
global image_d

axes(handles.axes9);
min_d = min(image_d(:));
[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*10 >=65536
    max_d = 65536;
else
    max_d = max_d_t *10;
end
imshow(image_d,[min_d max_d]) 
hold on

%% get the status of the radio call button for the FRET Overlay

fret_method = get(handles.overlay_fret_method, 'SelectedObject');
find_style = get(fret_method, 'String');
switch find_style
    case{'Run Matcher'}
        load('matched_fret.mat')
        num_fret_spots = length(radii_a_o);
        viscircles(centers_a_o,radii_a_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);
        
    case{'Accep over Don'}
        load('matched_fret1.mat');
        num_fret_spots = length(radii_a_o);
        viscircles(centers_a_o,radii_a_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);
        
    case{'All Particles'}
        load('matched_fret.mat');
        num_fret_spots = length(radii_d_o);
        viscircles(centers_d_o,radii_d_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);   
        
    case{'All Donor'}
        load('matched_fret1.mat');
        num_fret_spots = length(radii_d_o);
        viscircles(centers_d_o,radii_d_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);
end

extract_auto_t = get(handles.auto_overlay,'SelectedObject');
extract_auto = get(extract_auto_t,'String');
switch extract_auto
    case{'Auto'}
      extract_fret_Callback(handles.extract_fret, eventdata, handles)  
    case{'Manual'}        
end

% centers_a = getappdata(handles.find_acceptor, 'centers_a');
% [num_spots, ~] = size(centers_a); 

% radii_a = getappdata(handles.find_acceptor, 'radii_a');
 

% --- Executes on button press in extract_donor.
function extract_donor_Callback(hObject, eventdata, handles)
global donor
global fname
global image_d
global Picture_d
global v_filt
global file_name
global image_dt
global D
global BackG
global BGD_donor
global centers_d
global radii_d
% Initialise the donor extractor
vis_trace = get(handles.vis_trace,'Value');
auto_save = get(handles.auto_save,'Value');
time_int =str2double(get(handles.time_int, 'String'));
load('bckg_don1.mat','bckg_don1');
bckg_d = bckg_don1;
radii_de = radii_d;
[num_spots_d, ~] = size(centers_d); 
[sizex,sizey,num_frames] = size(image_dt);
time_axis = (1:num_frames)*(time_int/1000);
f = warndlg('Ensure the TIME INTERVAL is set correctly', 'A Warning Dialog');
waitfor(f);
tic
h1 = waitbar(0,'Pulling traces...');
%% Start pulling the traces
        for i = 1:num_spots_d
             waitbar(i/num_spots_d);
             half_index_snap = 3;
             centers_de = centers_d(i,:);
             indeces_dy = centers_de(1)-half_index_snap:centers_de(1)+half_index_snap;
             indeces_dx = centers_de(2)-half_index_snap:centers_de(2)+half_index_snap;             
             %% Get the donor image            
% Trim the snap shot sizes           
            if indeces_dx(1) < 1 
               indeces_dx_t1 = find(indeces_dx == 1); 
               % get x shift
               diff_dx_m = indeces_dx_t1;
               % shift the center
               centers_de(1) = centers_de(1) + diff_dx_m;
            else
                indeces_dx_t1 = indeces_dx(1);
                diff_dx_m = 0;
            end
            
            if indeces_dx(end) > sizex
                indeces_dx_t2 = find(indeces_dx == sizex);
                % get x shift
                diff_dx_p = indeces_dx(end) - indeces_dx(indeces_dx_t2(1));
                centers_de(1) = centers_de(1) + diff_dx_p;
            else
                indeces_dx_t2 = indeces_dx(end);
                diff_dx_p = 0;                
            end          
            
            if indeces_dy(1) < 1
                % get y shift
                indeces_dy_t1 = find(indeces_dy == 1);
                diff_dy_m = indeces_dy_t1;
                centers_de(2) = centers_de(2) + diff_dy_m;
            else
                indeces_dy_t1 = indeces_dy(1);
                diff_dy_m = 0;
            end
            
            if indeces_dy(end) > sizey
                % get y shift
                indeces_dy_t2 = find(indeces_dy == sizey);
                diff_dy_p = indeces_dy(end) - indeces_dy(indeces_dy_t2(1));
                centers_de(2) = centers_de(2) + diff_dy_p;
            else
                indeces_dy_t2 = indeces_dy(end); 
                diff_dy_p = 0;
            end            
             index_mindx = indeces_dx_t1;
             index_maxdx = indeces_dx_t2;
             index_mindy = indeces_dy_t1;
             index_maxdy = indeces_dy_t2;
             pic_d = image_d(index_mindx : index_maxdx, index_mindy : index_maxdy);               
             Picture_d{i,1} = pic_d;
             Picture_d{i,2} = [4,4];
             Picture_d{i,3} = radii_d(i);               
% Get the donot trace
 % Pull the traces for the spots          
% load the donor and background
            bckg_de = bckg_d(:,i);
            % get the pixel plus/minus
            rtd = round(radii_de(i));         
            % get the center
            ind_dfe = centers_d(i,:);
            % index on the donor x   
            ind_dfex = ind_dfe(:,2);
            ind_dfexp = ind_dfex + rtd;
            ind_dfexm = ind_dfex - rtd;
            ind_dfext = [ind_dfexm:ind_dfexp];
            % index on the donor y
            ind_dfey = ind_dfe(:,1);
            ind_dfeyp = ind_dfey + rtd;
            ind_dfeym = ind_dfey - rtd;
            ind_dfeyt = [ind_dfeym:ind_dfeyp];
            % compute donor traces            
                for j = 1:num_frames
                    image_d_t = image_dt(ind_dfext,ind_dfeyt,j);
                    image_d_t_sum(j) = sum(sum(image_d_t));                    
                end
                don_hist(:,i) = max(image_d_t_sum);
                image_d_t_spec = image_d_t_sum - bckg_de';
                don_tot_trace(:,i) = image_d_t_sum;
                don_bckg_trace(:,i) = bckg_de;
                don_spec_trace (:,i) = image_d_t_spec;  
                
                 if vis_trace == 1                     
                    if v_filt == 1
                        image_d_t_sum_s = smooth(double(image_d_t_sum),'lowess');
                        image_d_t_spec_s = smooth(double(image_d_t_spec),'lowess');
                        image_a_t_sum_s = smooth(double(image_a_t_sum),'lowess');
                        image_a_t_spec_s = smooth(double(image_a_t_spec),'lowess');
                        axes(handles.axes10);
                        axis_limits = max(image_d_t_sum_s) + 0.25* max(image_d_t_sum_s);
                        plot(time_axis, image_d_t_sum_s,'g', time_axis, bckg_de, 'b',time_axis,image_d_t_spec_s,'k');
                            if num_frames > 1
                                axis([0 max(time_axis) 0 axis_limits])
                            end                        
                    else
                    axes(handles.axes10);
                    axis_limits = max(image_d_t_sum) + 0.25* max(image_d_t_sum);
                    plot(time_axis, image_d_t_sum,'g', time_axis, bckg_de, 'b',time_axis,image_d_t_spec,'k');
                            if num_frames > 1
                                axis([1 num_frames 0 axis_limits])
                            end                    
                    end                     
                end
        end        
            close (h1) 
            axes(handles.axes13)
            hist(don_hist,num_spots_d/5);
            setappdata(handles.extract_donor, 'don_tot_trace',don_tot_trace);
            setappdata(handles.extract_donor, 'don_bckg_trace',don_bckg_trace);
            setappdata(handles.extract_donor, 'don_spec_trace',don_spec_trace);
            setappdata(handles.extract_donor, 'time_axis',time_axis);   
toc
            [~,save_name,~] = fileparts(fname);
            img_ta = ones(10,10);
            img_a = uint16(img_ta);
            for i = 1:num_spots_d
                Picture_a{i,1} = img_a;
                Picture_a{i,2} =  [4,4];
                Picture_a{i,3} = 1.5;
            end
            if auto_save == 1
                centers_ext = centers_d;
                Mode1 = 'onecolor';
                save([save_name,'donor','.mat'],'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'Picture_d','Picture_a','Mode1', 'centers_ext');
            end
           
            
            
% --- Executes on button press in extract_acceptor.
function extract_acceptor_Callback(hObject, eventdata, handles)
global centers_a
global radii_a
global image_d
global A
global A_t 
global image_at
global donor
msgbox ('Load the Movie as a Single Channel and Extract as Donor')

% hObject    handle to extract_acceptor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%stack_len = getappdata(handles.save_name, 'len_stack'); 
% stack_len = numel(donor);
% num_images = getappdata(handles.file_name, 'num_images'); 
% image_a_r = getappdata(handles.d_t_a_frames,'image_a_r');
% accep_spot_bckg = getappdata(handles.accep_background,'accep_spot_bckg');
% clear('handles.axes8');
% axes(handles.axes8);
% min_a = min(image_a_r(:));
% max_a = max(image_a_r(:));
% imshow(image_a_r,[min_a max_a]) 
% hold on
% centers_a = getappdata(handles.find_acceptor, 'centers_a');
% [num_spots_a, ~] = size(centers_a); 
% radii_a = getappdata(handles.find_acceptor, 'radii_a');
% time_int =str2double(get(handles.time_int, 'String'));    
% dims_x_a = get(handles.img_width, 'String');
% dims_y_a = get(handles.img_hgt, 'String');
% %stack_len = getappdata(handles.save_name, 'len_stack');  
% num_images = getappdata(handles.file_name, 'num_images');  
% global fname
% %fname = getappdata(handles.save_name, 'file_name');
% image_d = getappdata(handles.d_t_a_frames,'image_d');
% tform = getappdata(handles.image_register,'tform');
% reg_file = getappdata(handles.image_register,'reg_coord');
% load(reg_file,'tform'); 
% 
% %         length = 1:disp_read_images;
% %         % Find and extract acceptor frames and register the frames
% %         acceptor = find(mod(length,2)==0);
% %         h = waitbar(0, 'Processing Images for Acceptor Traces');
% %         counter = 0;
% %             for k = 1:stack_len
% %                 counter = counter + 1;     
% %                 A = imread(fname,acceptor(k));
% %                 A_t = imwarp(A,tform,'OutputView',imref2d(size(image_d)));
% %                 image_at(:,:,counter) = A_t-min(min(A));
% %                 waitbar(counter/stack_len);
% %             end
% %         close (h) 
%         
%          h1 = waitbar_new(0,'Please wait...');
%         
% 
%             
%         global BackG
%         global BGA_acceptor
%         
% %         acceptor_counter = 0;
%         for i = 1:num_spots_a
%             
%             waitbar_new(i/num_spots_a,h1);
%             
%              center_a = centers_a(i,:);
%              ref_1_a = center_a(:,1);
%              ref_2_a = center_a(:,2);
%              radius_a = radii_a(i)+0.3*radii_a(i);
%              NOP = 20;
%              THETA_a=linspace(0,2*pi,NOP);
%              RHO_a=ones(1,NOP)*radius_a;
%              [X_a,Y_a] = pol2cart(THETA_a,RHO_a);
%              X_a_spot=X_a+ref_1_a;
%              Y_a_spot=Y_a+ref_2_a;
%              
%              if strcmp(BackG,'Select Background (Pixel)')
%              X_a_bckg = accep_spot_bckg(:,1)+X_a;
%              Y_a_bckg = accep_spot_bckg(:,2)+Y_a;
%              axes(handles.axes8);
%              h=fill(X_a_spot,Y_a_spot,'r',X_a_bckg, Y_a_bckg, 'b');
%                
%              else
%                  axes(handles.axes8);
%                  h=fill(X_a_spot,Y_a_spot,'r');
%              end
%              acceptor_counter = acceptor_counter+1;  
%              image_a_t = uint16(image_at);
%              [roi_BW_a] = roipoly(image_a_r, X_a_spot,Y_a_spot);
%              
%              if strcmp(BackG,'Select Background (Pixel)')
%              [roi_bckg_a] = roipoly(image_a_r,X_a_bckg, Y_a_bckg);
%              end
% %              figure(1)
% %              imshow(roi_BW)
% %              pause
%              roi_selection_a = uint16(repmat(roi_BW_a,[1,1,stack_len])).*uint16(image_at);
%              
%              if strcmp(BackG,'Select Background (Pixel)')
%              roi_bckg_a = uint16(repmat(roi_bckg_a,[1,1,stack_len])).*image_at;
%              end
%              
%              intensity_defRoi_a = squeeze(sum(sum(roi_selection_a,1),2));
%              
%              if strcmp(BackG,'Select Background (Pixel)')
%                 intensity_defRoi_bckg_a = squeeze(sum(sum(roi_bckg_a,1),2));;
%              else
%                 intensity_defRoi_bckg_a = BGA_acceptor'; 
%              end
%              
%              %intensity_defRoi_bckg_a = squeeze(sum(sum(roi_bckg_a,1),2));
%              intensity_acceptor_specific = intensity_defRoi_a - intensity_defRoi_bckg_a;
%              time_axis = 1:stack_len;
%              
%              
%              if v_filt == 0
%                   axes(handles.axes11);
%              axis_limits = max(intensity_defRoi_a) + 0.25* max(intensity_defRoi_a);
%              plot(time_axis, intensity_defRoi_a,'r', time_axis, intensity_defRoi_bckg_a, 'b',time_axis,intensity_acceptor_specific,'k');
% 
%                 if stack_len > 1
%                     axis([1 stack_len 0 axis_limits])
%                 end
%                 
%         else
% 
%             intensity_defRoi_a1 = smooth(double(intensity_defRoi_a),'lowess');
%             intensity_defRoi_bckg_a1 = smooth(double(intensity_defRoi_bckg_a),'lowess');
%             intensity_acceptor_specific1 = smooth(double(intensity_acceptor_specific),'lowess');
% 
%              axes(handles.axes11);
%              axis_limits = max(intensity_defRoi_a1) + 0.25* max(intensity_defRoi_a1);
%              plot(time_axis, intensity_defRoi_a1,'r', time_axis, intensity_defRoi_bckg_a1, 'b',time_axis,intensity_acceptor_specific1,'k');
%                 if stack_len > 1
%                     axis([1 stack_len 0 axis_limits])
%                 end
%              end
%                 
%              accep_hist(:,i) = max(intensity_defRoi_a);
%              axes(handles.axes14)
%              hist(accep_hist,num_spots_a/5);  
%              
%              accep_tot_trace(:,i) = intensity_defRoi_a;
%              accep_bckg_trace(:,i) = intensity_defRoi_bckg_a;
%              accep_spec_trace (:,i) = intensity_acceptor_specific;            
%         end
%         close(h1)
%             setappdata(handles.extract_acceptor, 'accep_tot_trace',accep_tot_trace);
%             setappdata(handles.extract_acceptor, 'accep_bckg_trace',accep_bckg_trace);
%             setappdata(handles.extract_acceptor, 'accep_spec_trace',accep_spec_trace);
%             setappdata(handles.extract_acceptor, 'time_axis',time_axis);          
         
        
% --- Executes on button press in extract_fret.
function extract_fret_Callback(hObject, eventdata, handles)
% hObject    handle to extract_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Get general information
%% This code was rewritten for the new version 3.0
global donor
global fname
global image_d
global image_a
% global W_gab
global v_filt
global file_name
global image_dt
global D
global A
global A_t 
global image_at
global BackG
global BGD_donor
global BGA_acceptor
% get the centers and radii
% centers from the overlay optomiser
% global centers_d_o
% global radii_d_o 
% global centers_a_o 
% global radii_a_o 
% centers and radii from optomised spots
% global centers_d
% global radii_d
% global centers_a
% global radii_a

extract_auto_t = get(handles.auto_overlay,'SelectedObject');
extract_auto = get(extract_auto_t,'String');

switch extract_auto
    case {'Manual'}
f = warndlg('Ensure the TIME INTERVAL is set correctly', 'A Warning Dialog');
waitfor(f);
end
tic
% Get the type of FRET extraction
fret_method = get(handles.overlay_fret_method, 'SelectedObject');
find_style = get(fret_method, 'String');
switch find_style
    case{'Run Matcher'}
        load('matched_fret.mat')
        num_fret_spots = length(radii_a_o);
        viscircles(centers_a_o,radii_a_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);
        centers_de = centers_d_o;
        radii_de = radii_d_o;
        centers_ae = centers_a_o;
        radii_ae = radii_a_o;
        load('bckg_don1_o.mat','bckg_don1_o');
        load('bckg_accep1_o.mat','bckg_accep1_o'); 
        bckg_d = bckg_don1_o;
        bckg_a = bckg_accep1_o;        
    case{'Accep over Don'}
        load('matched_fret1.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
        num_fret_spots = length(radii_a_o);
        viscircles(centers_a_o,radii_a_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots); 
        centers_de = centers_d_o;
        radii_de = radii_d_o;
        centers_ae = centers_a_o;
        radii_ae = radii_a_o;
        load('bckg_don1.mat','bckg_don1');
        load('bckg_accep1.mat','bckg_accep1');  
        bckg_d = bckg_don1;
        bckg_a = bckg_accep1;
    case{'All Particles'}
        load('matched_fret1.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
        num_fret_spots = length(radii_d_o);
        viscircles(centers_d_o,radii_d_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots); 
        centers_de = centers_d_o;
        radii_de = radii_d_o;
        centers_ae = centers_a_o;
        radii_ae = radii_a_o;
        load('bckg_don1.mat','bckg_don1');
        load('bckg_accep1.mat','bckg_accep1');  
        bckg_d = bckg_don1;
        bckg_a = bckg_accep1;
        
end
time_int =str2double(get(handles.time_int, 'String'));   
%get the rotated image
image_a_r = getappdata(handles.d_t_a_frames,'image_a_r');
vis_trace = get(handles.vis_trace,'Value');
auto_save = get(handles.auto_save,'Value');

%% Initialise the extractor
        num_spots_f = num_fret_spots;
        fret_counter = 0;
        [sizex,sizey,num_frames] = size(image_dt);
        time_axis = (1:num_frames)*(time_int/1000);
        % h1 = waitbar_new(0,'Please wait...');
        h1 = waitbar(0,'Pulling traces...');
        % initalise the coefficient for extraction
        coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
        % Initialise the for loop and grab the spots         
        for i = 1:num_spots_f
             %waitbar_new(i/num_spots_f,h1);
             waitbar(i/num_spots_f);
             %calculate the boundaries             
             centers_dt = centers_de(i,:);
             half_index_snap = 3;   %              
            % Get the indicies for the snapshot of the donor particles 
             indeces_dy = centers_dt(1)-half_index_snap:centers_dt(1)+half_index_snap;
             indeces_dx = centers_dt(2)-half_index_snap:centers_dt(2)+half_index_snap;
%% Get the donor image            
% Trim the snap shot sizes           
            if indeces_dx(1) < 1 
               indeces_dx_t1 = find(indeces_dx == 1); 
               % get x shift
               diff_dx_m = indeces_dx_t1;
               % shift the center
               centers_dt(1) = centers_dt(1) + diff_dx_m;
            else
                indeces_dx_t1 = indeces_dx(1);
                diff_dx_m = 0;
            end
            
            if indeces_dx(end) > sizex
                indeces_dx_t2 = find(indeces_dx == sizex);
                % get x shift
                diff_dx_p = indeces_dx(end) - indeces_dx(indeces_dx_t2(1));
                centers_dt(1) = centers_dt(1) + diff_dx_p;
            else
                indeces_dx_t2 = indeces_dx(end);
                diff_dx_p = 0;                
            end          
            
            if indeces_dy(1) < 1
                % get y shift
                indeces_dy_t1 = find(indeces_dy == 1);
                diff_dy_m = indeces_dy_t1;
                centers_dt(2) = centers_dt(2) + diff_dy_m;
            else
                indeces_dy_t1 = indeces_dy(1);
                diff_dy_m = 0;
            end
            
            if indeces_dy(end) > sizey
                % get y shift
                indeces_dy_t2 = find(indeces_dy == sizey);
                diff_dy_p = indeces_dy(end) - indeces_dy(indeces_dy_t2(1));
                centers_dt(2) = centers_dt(2) + diff_dy_p;
            else
                indeces_dy_t2 = indeces_dy(end); 
                diff_dy_p = 0;
            end            

             index_mindx = indeces_dx_t1;
             index_maxdx = indeces_dx_t2;
             index_mindy = indeces_dy_t1;
             index_maxdy = indeces_dy_t2;
       
             % Take the snapshot of each particle 
             pic_d = image_d(index_mindx : index_maxdx, index_mindy : index_maxdy);             
             centers_at = centers_ae(i,:);
              % Get the indicies for the snapshot of the donor particles 
             indeces_ay = centers_at(1)-half_index_snap:centers_at(1)+half_index_snap;
             indeces_ax = centers_at(2)-half_index_snap:centers_at(2)+half_index_snap;
%% Get the acceptor image            
% Trim the snap shot sizes           
            if indeces_ax(1) < 1 
               indeces_ax_t1 = find(indeces_ax == 1); 
               % get x shift
               diff_ax_m = indeces_ax_t1;
               % shift the center
               centers_at(1) = centers_at(1) + diff_ax_m;
            else
                indeces_ax_t1 = indeces_ax(1);
                diff_ax_m = 0;
            end
            
            if indeces_ax(end) > sizex
                indeces_ax_t2 = find(indeces_ax == sizex);
                % get x shift
                diff_ax_p = indeces_ax(end) - indeces_ax(indeces_ax_t2(1));
                centers_at(1) = centers_at(1) + diff_ax_p;
            else
                indeces_ax_t2 = indeces_ax(end);
                diff_ax_p = 0;                
            end          
            
            if indeces_ay(1) < 1
                % get y shift
                indeces_ay_t1 = find(indeces_ay == 1);
                diff_ay_m = indeces_ay_t1;
                centers_at(2) = centers_at(2) + diff_ay_m;
            else
                indeces_ay_t1 = indeces_ay(1);
                diff_ay_m = 0;
            end
            
            if indeces_dy(end) > sizey
                % get y shift
                indeces_ay_t2 = find(indeces_ay == sizey);
                diff_ay_p = indeces_ay(end) - indeces_ay(indeces_ay_t2(1));
                centers_at(2) = centers_at(2) + diff_ay_p;
            else
                indeces_ay_t2 = indeces_ay(end); 
                diff_ay_p = 0;
            end  
             index_minax = indeces_ax_t1;
             index_maxax = indeces_ax_t2;
             index_minay = indeces_ay_t1;
             index_maxay = indeces_ay_t2;       
             % Take the snapshot of each particle              
             xcenter_pic = 4;
             ycenter_pic = 4;  
             % equalise the radii of spots
             if round(radii_de(i)) > round(radii_ae(i))
                 radii_de(i) = radii_ae(i);
             elseif round(radii_ae(i)) > round(radii_de(i))
                 radii_ae(i) = radii_de(i);
             end
             pic_a = image_a_r(index_minax : index_maxax, index_minay : index_maxay);
             Picture_d{i,1} = pic_d;
             Picture_d{i,2} = [4,4];
             Picture_d{i,3} = radii_de(i);             
             Picture_a{i,1} = pic_a;
             Picture_a{i,2} = [4,4];
             Picture_a{i,3} = radii_ae(i);               
            % Pull the traces for the spots          
            % process the spots 
            % load the donor and background
            bckg_de = bckg_d(:,i);
            bckg_ae = bckg_a(:,i);
            % get the pixel plus/minus
            rtd = round(radii_de(i));
            rta = round(radii_ae(i));            
            % get the center
            ind_dfe = centers_de(i,:);
            ind_afe = centers_ae(i,:);
            % index on the donor x   
            ind_dfex = ind_dfe(:,2);
            ind_dfexp = ind_dfex + rtd;
            ind_dfexm = ind_dfex - rtd;
            ind_dfext = [ind_dfexm:ind_dfexp];
            % index on the donor y
            ind_dfey = ind_dfe(:,1);
            ind_dfeyp = ind_dfey + rtd;
            ind_dfeym = ind_dfey - rtd;
            ind_dfeyt = [ind_dfeym:ind_dfeyp];
            % index on the acceptor x
            ind_afex = ind_afe(:,2);
            ind_afexp = ind_afex + rta;
            ind_afexm = ind_afex - rta;
            ind_afext = [ind_afexm:ind_afexp];
            % index on the acceptor y            
            ind_afey = ind_afe(:,1);
            ind_afeyp = ind_afey + rta;
            ind_afeym = ind_afey - rta;
            ind_afeyt = [ind_afeym:ind_afeyp]; 
            % compute donor traces            
                for j = 1:num_frames
                    image_d_t = image_dt(ind_dfext,ind_dfeyt,j);
                    image_d_t_sum(j) = sum(sum(image_d_t));                    
                end
                don_hist(:,i) = max(image_d_t_sum);
                image_d_t_spec = image_d_t_sum - bckg_de';
                image_d_t_sum_filt = filtfilt(coeff,image_d_t_sum);
                image_d_t_spec_filt = image_d_t_sum_filt - bckg_de';
                image_d_t_spec_filt2 = filtfilt(coeff,image_d_t_spec);
                don_tot_trace(:,i) = image_d_t_sum;                 
                don_bckg_trace(:,i) = bckg_de;
                don_spec_trace (:,i) = image_d_t_spec; 
                don_tot_trace_filt(:,i) = image_d_t_sum_filt;
                don_spec_trace_filt(:,i) =  image_d_t_spec_filt;
                don_spec_trace_filt2(:,i) = image_d_t_spec_filt2;                
                
            % compute acceptor traces
                for k = 1:num_frames
                    image_a_t = image_at(ind_afext,ind_afeyt,k);
                    image_a_t_sum(k) = sum(sum(image_a_t));
                end
                accep_hist(:,i) = max(image_a_t_sum);
                image_a_t_spec = image_a_t_sum - bckg_ae';
                image_a_t_sum_filt = filtfilt(coeff,image_a_t_sum);
                image_a_t_spec_filt = image_a_t_sum_filt - bckg_ae';
                image_a_t_spec_filt2 = filtfilt(coeff,image_a_t_spec);
                accep_tot_trace(:,i) = image_a_t_sum;                
                accep_bckg_trace(:,i) = bckg_ae;
                accep_spec_trace (:,i) = image_a_t_spec;  
                accep_tot_trace_filt(:,i) = image_a_t_sum_filt;
                accep_spec_trace_filt(:,i) =  image_a_t_spec_filt;
                accep_spec_trace_filt2(:,i) = image_a_t_spec_filt2;
                
%                 if vis_trace == 1
%                     
%                     if v_filt == 1
%                         image_d_t_sum_s = smooth(double(image_d_t_sum),'lowess');
%                         image_d_t_spec_s = smooth(double(image_d_t_spec),'lowess');
%                         image_a_t_sum_s = smooth(double(image_a_t_sum),'lowess');
%                         image_a_t_spec_s = smooth(double(image_a_t_spec),'lowess');
%                         axes(handles.axes10);
%                         axis_limits = max(image_d_t_sum_s) + 0.25* max(image_d_t_sum_s);
%                         plot(time_axis, image_d_t_sum_s,'g', time_axis, bckg_de, 'b',time_axis,image_d_t_spec_s,'k');
%                             if num_frames > 1
%                                 axis([0 max(time_axis) 0 axis_limits])
%                             end
%                         axes(handles.axes11);
%                         axis_limits = max(image_a_t_sum_s) + 0.25* max(image_a_t_sum_s);
%                         plot(time_axis, image_a_t_sum_s,'r', time_axis, bckg_ae, 'b',time_axis,image_a_t_spec_s,'k');
%                             if num_frames > 1
%                                 axis([0 max(time_axis) 0 axis_limits])
%                             end                   
%                     else
%                     axes(handles.axes10);
%                     axis_limits = max(image_d_t_sum) + 0.25* max(image_d_t_sum);
%                     plot(time_axis, image_d_t_sum,'g', time_axis, bckg_de, 'b',time_axis,image_d_t_spec,'k');
%                             if num_frames > 1
%                                 axis([1 num_frames 0 axis_limits])
%                             end
%                     axes(handles.axes11);
%                     axis_limits = max(image_a_t_sum) + 0.25* max(image_a_t_sum);
%                     plot(time_axis, image_a_t_sum,'r', time_axis, bckg_ae, 'b',time_axis,image_a_t_spec,'k');
%                             if num_frames > 1
%                                 axis([1 num_frames 0 axis_limits])
%                             end                   
%                     end                     
%                 end
        end    
             axes(handles.axes13)
             hist(don_hist,num_spots_f/5);
             axes(handles.axes14)
             hist(accep_hist,num_spots_f/5); 
        toc
            close (h1) 
                        
%% Save the data to be passed to the saver function
            setappdata(handles.extract_donor, 'don_tot_trace',don_tot_trace);
            setappdata(handles.extract_donor, 'don_bckg_trace',don_bckg_trace);
            setappdata(handles.extract_donor, 'don_spec_trace',don_spec_trace);
            setappdata(handles.extract_donor, 'time_axis',time_axis);    
            setappdata(handles.extract_donor,'Picture_d',Picture_d);
            setappdata(handles.extract_acceptor, 'accep_tot_trace',accep_tot_trace);
            setappdata(handles.extract_acceptor, 'accep_bckg_trace',accep_bckg_trace);
            setappdata(handles.extract_acceptor, 'accep_spec_trace',accep_spec_trace);
            setappdata(handles.extract_acceptor, 'time_axis',time_axis); 
            setappdata(handles.extract_acceptor,'Picture_a', Picture_a);
            [~,save_name,~] = fileparts(fname);
            
            if exist([save_name,'.mat'])>=1
                disp ([save_name,'.mat', 'exists'])                
            end
            
            if auto_save == 1
                Mode1 = 'Multicolor';  
                centers_ext = centers_de;
                save([save_name,'.mat'],'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace','Picture_d','Picture_a','Mode1',...
                 'don_tot_trace_filt', 'don_spec_trace_filt','don_spec_trace_filt2','accep_tot_trace_filt',...
                 'accep_spec_trace_filt','accep_spec_trace_filt2','centers_ext');
            end
    
% --- Executes on slider movement.
function don_sens_Callback(hObject, eventdata, handles)
% hObject    handle to don_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
don_sens_disp_val = (get(handles.don_sens, 'Value'));
set(handles.don_sens_disp, 'String',don_sens_disp_val);


% --- Executes during object creation, after setting all properties.
function don_sens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function accep_sens_Callback(hObject, eventdata, handles)
% hObject    handle to accep_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
accep_sens_disp_val = (get(handles.accep_sens, 'Value'));
set(handles.accep_sens_disp, 'String',accep_sens_disp_val);



% --- Executes during object creation, after setting all properties.
function accep_sens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function don_overlap_radii_Callback(hObject, eventdata, handles)
% hObject    handle to don_overlap_radii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_overlap_radii as text
%        str2double(get(hObject,'String')) returns contents of don_overlap_radii as a double


% --- Executes during object creation, after setting all properties.
function don_overlap_radii_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_overlap_radii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function accep_overlap_radii_Callback(hObject, eventdata, handles)
% hObject    handle to accep_overlap_radii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_overlap_radii as text
%        str2double(get(hObject,'String')) returns contents of accep_overlap_radii as a double


% --- Executes during object creation, after setting all properties.
function accep_overlap_radii_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_overlap_radii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function don_pix_max_Callback(hObject, eventdata, handles)
% hObject    handle to don_pix_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_pix_max as text
%        str2double(get(hObject,'String')) returns contents of don_pix_max as a double


% --- Executes during object creation, after setting all properties.
function don_pix_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_pix_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% function don_edge_Callback(hObject, eventdata, handles)
% % hObject    handle to don_edge (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of don_edge as text
% %        str2double(get(hObject,'String')) returns contents of don_edge as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function don_edge_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to don_edge (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end

function accep_pix_max_Callback(hObject, eventdata, handles)
% hObject    handle to accep_pix_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_pix_max as text
%        str2double(get(hObject,'String')) returns contents of accep_pix_max as a double


% --- Executes during object creation, after setting all properties.
function accep_pix_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_pix_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% function accep_edge_Callback(hObject, eventdata, handles)
% % hObject    handle to accep_edge (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of accep_edge as text
% %        str2double(get(hObject,'String')) returns contents of accep_edge as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function accep_edge_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to accep_edge (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes on slider movement.
function don_edge_Callback(hObject, eventdata, handles)
% hObject    handle to don_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% don_edge_disp_val = (get(handles.don_edge, 'Value'));
% set(handles.don_edge_disp, 'String',don_edge_disp_val);


% --- Executes during object creation, after setting all properties.
function don_edge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function accep_edge_Callback(hObject, eventdata, handles)
% hObject    handle to accep_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% accep_edge_disp_val = (get(handles.accep_edge, 'Value'));
% set(handles.accep_edge_disp, 'String',accep_edge_disp_val);


% --- Executes during object creation, after setting all properties.
function accep_edge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_edge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in don_overlap.
function don_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to don_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image_d = getappdata(handles.d_t_a_frames,'image_d');
image_d = image_d.*3;
axes(handles.axes7);
min_d = min(image_d(:));
max_d = max(image_d(:));
imshow(image_d,[min_d max_d]) 
don_sen = get(handles.don_sens, 'Value');
don_edge = 1;
don_pix_max = str2double(get(handles.don_pix_max, 'String'));

[centers_d, radii_d] = imfindcircles(image_d,[1 don_pix_max],'Method','TwoStage','ObjectPolarity','bright','Sensitivity',don_sen, 'Edge',don_edge);
tol_d =str2double(get(handles.don_overlap_radii, 'String'));
% option = 1 removes a circle
option = 3;
[centers_d_filt,radii_d_filt]=RemoveOverLap(centers_d,radii_d,tol_d,option);
centers_d = centers_d_filt;
radii_d = radii_d_filt;
[don_mol,~] = size(radii_d);
set(handles.don_mols, 'String', num2str(don_mol));
setappdata(handles.find_donor, 'don_mol', don_mol);
h = viscircles(centers_d,radii_d); 

% --- Executes on button press in accep_overlap.
function accep_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to accep_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image_a = getappdata(handles.d_t_a_frames,'image_a');
image_a = image_a.*3;
image_d = getappdata(handles.d_t_a_frames,'image_d');
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 
axes(handles.axes8);
image_a_r = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));
imshow(image_a_r) 
accep_sen = get(handles.accep_sens, 'Value');
accep_edge = 1;
accep_pix_max = str2double(get(handles.accep_pix_max, 'String'));
[centers_a, radii_a] = imfindcircles(image_a_r,[1 accep_pix_max],'Method','TwoStage','ObjectPolarity','bright','Sensitivity',accep_sen, 'Edge',accep_edge);
tol_a =str2double(get(handles.accep_overlap_radii, 'String'));
% option = 1 removes a circle
option = 3;
[centers_a_filt,radii_a_filt]=RemoveOverLap(centers_a,radii_a,tol_a,option);
centers_a = centers_a_filt;
radii_a = radii_a_filt;
[accep_mol,~] = size(radii_a);
set(handles.accep_mols, 'String', num2str(accep_mol));
h = viscircles(centers_a,radii_a); 
don_mol = getappdata(handles.find_donor, 'don_mol');
stoich = accep_mol/don_mol;
set(handles.stoich, 'String', stoich);
setappdata(handles.find_acceptor, 'centers_a', centers_a);
setappdata(handles.find_acceptor, 'radii_a', radii_a);



function don_sens_disp_Callback(hObject, eventdata, handles)
% hObject    handle to don_sens_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_sens_disp as text
%        str2double(get(hObject,'String')) returns contents of don_sens_disp as a double


% --- Executes during object creation, after setting all properties.
function don_sens_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_sens_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function don_edge_disp_Callback(hObject, eventdata, handles)
% hObject    handle to don_edge_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_edge_disp as text
%        str2double(get(hObject,'String')) returns contents of don_edge_disp as a double


% --- Executes during object creation, after setting all properties.
function don_edge_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_edge_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_sens_disp_Callback(hObject, eventdata, handles)
% hObject    handle to accep_sens_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_sens_disp as text
%        str2double(get(hObject,'String')) returns contents of accep_sens_disp as a double


% --- Executes during object creation, after setting all properties.
function accep_sens_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_sens_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_edge_disp_Callback(hObject, eventdata, handles)
% hObject    handle to accep_edge_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_edge_disp as text
%        str2double(get(hObject,'String')) returns contents of accep_edge_disp as a double


% --- Executes during object creation, after setting all properties.
function accep_edge_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_edge_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_interval_Callback(hObject, eventdata, handles)
% hObject    handle to time_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_interval as text
%        str2double(get(hObject,'String')) returns contents of time_interval as a double


% --- Executes during object creation, after setting all properties.
function time_interval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_interval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function time_int_Callback(hObject, eventdata, handles)
% hObject    handle to time_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_int as text
%        str2double(get(hObject,'String')) returns contents of time_int as a double
global NUM
NUM = get(hObject,'String');
NUM = str2num(NUM);


% --- Executes during object creation, after setting all properties.
function time_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in don_background.
function don_background_Callback(hObject, eventdata, handles)
% hObject    handle to don_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BackG
global image_d
global num_images
global fname
global xperc
global donor
global len_stack
global BGD_donor
global cent_map_d

radii_d = getappdata(handles.find_donor,'radii_d'); 
centers_d = getappdata(handles.find_donor,'centers_d');
type_auto_bckg_t = get(handles.auto_bckg, 'SelectedObject');
type_auto_bckg = get(type_auto_bckg_t, 'String');
abs_bckg_val = get(handles.abs_bckg,'Value');
channel = 'donor';

if ispc == 1
save('Variables\bckg.mat','cent_map_d','channel','radii_d','centers_d','type_auto_bckg','abs_bckg_val')
elseif ismac == 1
save('Variables/bckg.mat','cent_map_d','channel','radii_d','centers_d','type_auto_bckg','abs_bckg_val')
end
% change the background module
% run bckg_calc
run bckg_calc2

        full__auto_t = get(handles.full_auto,'SelectedObject');
        full_auto_mode = get(full__auto_t,'String');
        switch full_auto_mode 
            case ('Auto Extract')
                find_acceptor_Callback(handles.find_acceptor, eventdata, handles)
            case ('Batch Extract')
                find_acceptor_Callback(handles.find_acceptor, eventdata, handles)                
        end


% --- Executes on button press in accep_background.
function accep_background_Callback(hObject, eventdata, handles)
% hObject    handle to accep_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global BackG
global image_a
global num_images
global fname
global xperc
global acceptor
global BGA_acceptor
global cent_map_a


radii_a = getappdata(handles.find_acceptor, 'radii_a');
centers_a = getappdata(handles.find_acceptor,'centers_a');
type_auto_bckg_t = get(handles.auto_bckg, 'SelectedObject');
type_auto_bckg = get(type_auto_bckg_t, 'String');
abs_bckg_val = get(handles.abs_bckg,'Value');
channel = 'acceptor';

if ispc == 1
save('Variables\bckg.mat','cent_map_a','channel', 'radii_a','centers_a','type_auto_bckg','abs_bckg_val')
elseif ismac == 1
save('Variables/bckg.mat','cent_map_a','channel', 'radii_a','centers_a','type_auto_bckg','abs_bckg_val')
end


run bckg_calc2
%         full__auto_t = get(handles.full_auto,'SelectedObject');
%         full_auto_mode = get(full__auto_t,'String');
%         switch full_auto_mode 
%             case ('Auto Extract')
%                 pop_fret_Callback(handles.pop_fret, eventdata, handles)
%             case('Batch Extract')
%                 pop_fret_Callback(handles.pop_fret, eventdata, handles)
%         end



% --- Executes on button press in man_donor.
function man_donor_Callback(hObject, eventdata, handles)
% hObject    handle to man_donor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_d
global donor

global image_dt


center_f = ginput(1);
  
%stack_len = getappdata(handles.save_name, 'len_stack'); 
stack_len = numel(donor);

image_d = getappdata(handles.d_t_a_frames,'image_d');

%% Get background information

% clear('handles.axes9');
% axes(handles.axes9);
% min_d = min(image_d(:));
% max_d = max(image_d(:));
% imshow(image_d,[min_d max_d]) 
% hold on
%% get donor information
centers_d = getappdata(handles.find_donor, 'centers_d');
[num_spots_d, ~] = size(centers_d); 


don_spot_bckg = getappdata(handles.don_background,'don_spot_bckg');

      
ref_1_f = center_f(:,1);
ref_2_f = center_f(:,2);
radius_f = 1;
NOP = 20;
THETA=linspace(0,2*pi,NOP);
RHO_f=ones(1,NOP)*radius_f;
[X_f,Y_f] = pol2cart(THETA,RHO_f);
X_f_spot=X_f+ref_1_f;
Y_f_spot=Y_f+ref_2_f;     

X_d_bckg = don_spot_bckg(:,1)+X_f;
Y_d_bckg = don_spot_bckg(:,2)+Y_f;


image_d = uint16(image_d);
[roi_BW_d] = roipoly(image_d, X_f_spot,Y_f_spot);
[roi_bckg_d] = roipoly(image_d,X_d_bckg, Y_d_bckg);

             
roi_selection_d = uint16(repmat(roi_BW_d,[1,1,stack_len])).*uint16(image_dt);
roi_bckg_d = uint16(repmat(roi_bckg_d,[1,1,stack_len])).*uint16(image_dt);
intensity_defRoi_d = squeeze(sum(sum(roi_selection_d,1),2));
intensity_defRoi_bckg_d = squeeze(sum(sum(roi_bckg_d,1),2));
intensity_donor_specific = intensity_defRoi_d - intensity_defRoi_bckg_d;
              
time_axis = 1:stack_len;
axes(handles.axes10);
axis_limits = max(intensity_defRoi_d) + 0.25* max(intensity_defRoi_d);
plot(time_axis, intensity_defRoi_d,'g', time_axis, intensity_defRoi_bckg_d, 'b',time_axis,intensity_donor_specific,'k');
if stack_len > 1
    axis([1 stack_len 0 axis_limits])
end
            
                
don_hist(:,1) = max(intensity_defRoi_d);
axes(handles.axes13)
hist(don_hist,num_spots_d/5);      

  

% --- Executes on button press in man_accep.
function man_accep_Callback(hObject, eventdata, handles)
% hObject    handle to man_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_d
global donor
global image_dt
global fname
global D
global A
global A_t 
global image_at

time_int =str2double(get(handles.time_int, 'String'));   
%stack_len = getappdata(handles.save_name, 'len_stack'); 
stack_len = numel(donor);
num_images = getappdata(handles.file_name, 'num_images'); 
image_d = getappdata(handles.d_t_a_frames,'image_d');
image_a_r = getappdata(handles.d_t_a_frames,'image_a_r');
%% Get background information
don_spot_bckg = getappdata(handles.don_background,'don_spot_bckg');
accep_spot_bckg = getappdata(handles.accep_background,'accep_spot_bckg');
% clear('handles.axes9');
% axes(handles.axes9);
% min_d = min(image_d(:));
% max_d = max(image_d(:));
% imshow(image_d,[min_d max_d]) 
% hold on
%% get donor information
centers_d = getappdata(handles.find_donor, 'centers_d');
[num_spots_d, ~] = size(centers_d); 
radii_d = getappdata(handles.find_donor, 'radii_d');
time_int =str2double(get(handles.time_int, 'String'));    
dims_x_d = get(handles.img_width, 'String');
dims_y_d = get(handles.img_hgt, 'String');
%% get acceptor information
centers_a = getappdata(handles.find_acceptor, 'centers_a');
[num_spots_a, ~] = size(centers_a); 
radii_a = getappdata(handles.find_acceptor, 'radii_a'); 
dims_x_a = get(handles.img_width, 'String');
dims_y_a = get(handles.img_hgt, 'String'); 
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 
        length = 1:num_images;
        % Find and extract donor frames
        donor = find(mod(length,2)~=0);
        acceptor = find(mod(length,2)==0);

        


center_f = ginput(1);

 
 
             ref_1_f = center_f(:,1);
             ref_2_f = center_f(:,2);
             radius_f = 1;
             NOP = 20;
             THETA=linspace(0,2*pi,NOP);
             RHO_f=ones(1,NOP)*radius_f;
             [X_f,Y_f] = pol2cart(THETA,RHO_f);
             X_f_spot=X_f+ref_1_f;
             Y_f_spot=Y_f+ref_2_f;             

             X_a_bckg = accep_spot_bckg(:,1)+X_f;
             Y_a_bckg = accep_spot_bckg(:,2)+Y_f;
             axes(handles.axes9);
             %h=fill(X_f_spot,Y_f_spot,'g',X_d_bckg, Y_d_bckg, 'b', X_a_bckg, Y_d_bckg, 'm');                
             %fret_counter = fret_counter+1;  

             image_a_r = uint16(image_a_r);
             [roi_BW_a] = roipoly(image_a_r, X_f_spot,Y_f_spot);
             [roi_bckg_a] = roipoly(image_a_r,X_a_bckg, Y_a_bckg);
             
           
       
             roi_selection_a = uint16(repmat(roi_BW_a,[1,1,stack_len])).*uint16(image_at);
             roi_bckg_a = uint16(repmat(roi_bckg_a,[1,1,stack_len])).*uint16(image_at);
             
             intensity_defRoi_a = squeeze(sum(sum(roi_selection_a,1),2));
             intensity_defRoi_bckg_a = squeeze(sum(sum(roi_bckg_a,1),2));
             intensity_acceptor_specific = intensity_defRoi_a - intensity_defRoi_bckg_a;             
             time_axis = 1:stack_len;
             
             axes(handles.axes11);
             axis_limits = max(intensity_defRoi_a) + 0.25* max(intensity_defRoi_a);
             plot(time_axis, intensity_defRoi_a,'r', time_axis, intensity_defRoi_bckg_a, 'b',time_axis,intensity_acceptor_specific,'k');
                if stack_len > 1
                    axis([1 stack_len 0 axis_limits])
                end
   
 
             accep_hist(:,1) = max(intensity_defRoi_a);
             axes(handles.axes14)
             hist(accep_hist,num_spots_a/5);      
  

% --- Executes on button press in save_trace_donor.
function save_trace_donor_Callback(hObject, eventdata, handles)
% hObject    handle to save_trace_donor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Picture_d
Mode1 = 'onecolor';
            don_tot_trace = getappdata(handles.extract_donor, 'don_tot_trace');
            [~, num_traces_d] = size(don_tot_trace);
            don_bckg_trace = getappdata(handles.extract_donor, 'don_bckg_trace');
            don_spec_trace = getappdata(handles.extract_donor, 'don_spec_trace');
            time_axis = (getappdata(handles.extract_donor, 'time_axis'))';
            % create fake acceptor pics
            img_ta = ones(20,20);
            img_a = uint16(img_ta);
            for i = 1:num_traces_d
                Picture_a{i,1} = img_a;
                Picture_a{i,2} =  [10,10];
                Picture_a{i,3} = 1.5;
            end
            uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace','Picture_d','Picture_a','Mode1'});


% --- Executes on button press in save_trace_acceptor.
function save_trace_acceptor_Callback(hObject, eventdata, handles)
% hObject    handle to save_trace_acceptor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global NUM
global Picture_d
global Picture_a
Mode1 = 'onecolor'
        accep_tot_trace = getappdata(handles.extract_acceptor, 'accep_tot_trace',accep_tot_trace);
        accep_bckg_trace = getappdata(handles.extract_acceptor, 'accep_bckg_trace',accep_bckg_trace);
        accep_spec_trace = getappdata(handles.extract_acceptor, 'accep_spec_trace',accep_spec_trace)';
        time_axis = (getappdata(handles.extract_acceptor, 'time_axis',time_axis))'; 
        time_axis = (NUM/1000).*time_axis;
        uisave({'time_axis','accep_tot_trace','accep_bckg_trace','accep_spec_trace','Picture_d','Picture_a','Mode1'});

% --- Executes on button press in save_trace_fret.
function save_trace_fret_Callback(hObject, eventdata, handles)
% hObject    handle to save_trace_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Mode1 = 'Multicolor';
            don_tot_trace = getappdata(handles.extract_donor, 'don_tot_trace');
            don_bckg_trace = getappdata(handles.extract_donor, 'don_bckg_trace');
            don_spec_trace = getappdata(handles.extract_donor, 'don_spec_trace');
            time_axis = (getappdata(handles.extract_donor, 'time_axis'))';
            Picture_d = getappdata(handles.extract_donor,'Picture_d');
            accep_tot_trace = getappdata(handles.extract_acceptor, 'accep_tot_trace');
            accep_bckg_trace = getappdata(handles.extract_acceptor, 'accep_bckg_trace');
            accep_spec_trace = getappdata(handles.extract_acceptor, 'accep_spec_trace');
            Picture_a = getappdata(handles.extract_acceptor,'Picture_a');
            uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace','Picture_d','Picture_a','Mode1'});


% --- Executes on button press in imgsource_mm.
function imgsource_mm_Callback(hObject, eventdata, handles)
% hObject    handle to imgsource_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of imgsource_mm


% --- Executes on button press in imgsource_andor.
function imgsource_andor_Callback(hObject, eventdata, handles)
% hObject    handle to imgsource_andor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of imgsource_andor


% --- Executes on button press in reg_chan.
function reg_chan_Callback(hObject, eventdata, handles)
% hObject    handle to reg_chan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function split_h_Callback(hObject, eventdata, handles)
% hObject    handle to split_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of split_h as text
%        str2double(get(hObject,'String')) returns contents of split_h as a double


% --- Executes during object creation, after setting all properties.
function split_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to split_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function split_w_Callback(hObject, eventdata, handles)
% hObject    handle to split_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of split_w as text
%        str2double(get(hObject,'String')) returns contents of split_w as a double


% --- Executes during object creation, after setting all properties.
function split_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to split_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_alex_interleave_Callback(hObject, eventdata, handles)
% hObject    handle to num_alex_interleave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_alex_interleave as text
%        str2double(get(hObject,'String')) returns contents of num_alex_interleave as a double


% --- Executes during object creation, after setting all properties.
function num_alex_interleave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_alex_interleave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit33_Callback(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit33 as text
%        str2double(get(hObject,'String')) returns contents of edit33 as a double


% --- Executes during object creation, after setting all properties.
function edit33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit34_Callback(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit34 as text
%        str2double(get(hObject,'String')) returns contents of edit34 as a double


% --- Executes during object creation, after setting all properties.
function edit34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d_t_a_frames1_Callback(hObject, eventdata, handles)
% hObject    handle to d_t_a_frames1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_t_a_frames1 as text
%        str2double(get(hObject,'String')) returns contents of d_t_a_frames1 as a double
global frame1
frame1 = get(hObject,'String');
frame1 = str2num(frame1);




% --- Executes during object creation, after setting all properties.
function d_t_a_frames1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_t_a_frames1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in new.
function new_Callback(hObject, eventdata, handles)
% hObject    handle to new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
clear
clear global
clc
frame_merger


% --- Executes during object creation, after setting all properties.
function find_donor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to find_donor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12

% --- Executes on button press in radiobutton12.
function no_register_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on button press in radiobutton12.
function gen_register_Callback_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12

function [h, margin] = circle_hough(b, rrange, varargin)
%CIRCLE_HOUGH Hough transform for circles
%   [H, MARGIN] = CIRCLE_HOUGH(B, RADII) takes a binary 2-D image B and a
%   vector RADII giving the radii of circles to detect. It returns the 3-D
%   accumulator array H, and an integer MARGIN such that H(I,J,K) contains
%   the number of votes for the circle centred at B(I-MARGIN, J-MARGIN),
%   with radius RADII(K). Circles which pass through B but whose centres
%   are outside B receive votes.
%
%   [H, MARGIN] = CIRCLE_HOUGH(B, RADII, opt1, ...) allows options to be
%   set. Each option is a string, which if included has the following
%   effect:
%
%   'same' returns only the part of H corresponding to centre positions
%   within the image. In this case H(:,:,k) has the same dimensions as B,
%   and MARGIN is 0. This option should not be used if circles whose
%   centres are outside the image are to be detected.
%
%   'normalise' multiplies each slice of H, H(:,:,K), by 1/RADII(K). This
%   may be useful because larger circles get more votes, roughly in
%   proportion to their radius.
%
%   The spatial resolution of the accumulator is the same as the spatial
%   resolution of the original image. Smoothing the accumulator array
%   allows the effective resolution to be controlled, and this is probably
%   essential for sensitivity to circles of arbitrary radius if the spacing
%   between radii is greater than 1. If time or memory requirements are a
%   problem, a generalisation of this function to allow larger bins to be
%   used from the start would be worthwhile.
%
%   Each feature in B is allowed 1 vote for each circle. This function
%   could easily be generalised to allow weighted features.
%
%   See also CIRCLEPOINTS, CIRCLE_HOUGHPEAKS, CIRCLE_HOUGHDEMO

% Copyright David Young 2008, 2010

% argument checking
opts = {'same' 'normalise'};
narginchk(2, 2+length(opts));
validateattributes(rrange, {'double'}, {'real' 'positive' 'vector'});
if ~all(ismember(varargin, opts))
    error('Unrecognised option');
end

% get indices of non-zero features of b
[featR, featC] = find(b);

% set up accumulator array - with a margin to avoid need for bounds checking
[nr, nc] = size(b);
nradii = length(rrange);
margin = ceil(max(rrange));
nrh = nr + 2*margin;        % increase size of accumulator
nch = nc + 2*margin;
h = zeros(nrh*nch*nradii, 1, 'uint32');  % 1-D for now, uint32 a touch faster

% get templates for circles at all radii - these specify accumulator
% elements to increment relative to a given feature
tempR = []; tempC = []; tempRad = [];
for i = 1:nradii
    [tR, tC] = circlepoints(rrange(i));
    tempR = [tempR tR]; %#ok<*AGROW>
    tempC = [tempC tC];
    tempRad = [tempRad repmat(i, 1, length(tR))];
end

% Convert offsets into linear indices into h - this is similar to sub2ind.
% Take care to avoid negative elements in either of these so can use
% uint32, which speeds up processing by a factor of more than 3 (in version
% 7.5.0.342)!
tempInd = uint32( tempR+margin + nrh*(tempC+margin) + nrh*nch*(tempRad-1) );
featInd = uint32( featR' + nrh*(featC-1)' );

% Loop over features
for f = featInd
    % shift template to be centred on this feature
    incI = tempInd + f;
    % and update the accumulator
    h(incI) = h(incI) + 1;
end

% Reshape h, convert to double, and apply options
h = reshape(double(h), nrh, nch, nradii);

if ismember('same', varargin)
    h = h(1+margin:end-margin, 1+margin:end-margin, :);
    margin = 0;
end

if ismember('normalise', varargin)
    h = bsxfun(@rdivide, h, reshape(rrange, 1, 1, length(rrange)));
end

function peaks = circle_houghpeaks(h, radii, varargin)
%CIRCLE_HOUGHPEAKS finds peaks in the output of CIRCLE_HOUGH
%   PEAKS = CIRCLE_HOUGHPEAKS(H, RADII, MARGIN, OPTIONS) locates the
%   positions of peaks in the output of CIRCLE_HOUGH. The result PEAKS is a
%   3 x N array, where each column gives the position and radius of a
%   possible circle in the original array. The first row of PEAKS has the
%   x-coordinates, the second row has the y-coordinates, and the third row
%   has the radii.
%
%   H is the 3D accumulator array returned by CIRCLE_HOUGH.
%
%   RADII is the array of radii which was passed as an argument to
%   CIRCLE_HOUGH.
%
%   MARGIN is optional, and may be omitted if the 'same' option was used
%   with CIRCLE_HOUGH. Otherwise, it should be the second result returned
%   by CIRCLE_HOUGH.
%
%   OPTIONS is a comma-separated list of parameter/value pairs, with the
%   following effects:
%
%   'Smoothxy' causes each x-y layer of H to be smoothed before peak
%   detection using a 2D Gaussian kernel whose "sigma" parameter is given
%   by the value of this argument.
%
%   'Smoothr' causes each radius column of H to be smoothed before peak
%   detection using a 1D Gaussian kernel whose "sigma" parameter is given
%   by the value of this argument.
%
%       Note: Smoothing may be useful to locate peaks in noisy accumulator
%       arrays. However, it may also cause the performance to deteriorate
%       if H contains sharp peaks. It is most likely to be useful if
%       neighbourhood suppression (see below) is not used.
%
%       Both smoothing operations use reflecting boundary conditions to
%       compute values close to the boundaries.
%
%   'Threshold' sets the minimum number of votes (after any smoothing)
%   needed for a peak to be counted. The default is 0.5 * the maximum value
%   in H.
%
%   'Npeaks' sets the maximum number of peaks to be found. The highest
%   NPEAKS peaks are returned, unless the threshold causes fewer than
%   NPEAKS peaks to be available.
%
%   'Nhoodxy' must be followed by an odd integer, which sets a minimum
%   spatial separation between peaks. See below for a more precise
%   statement. The default is 1.
%
%   'Nhoodr' must be followed by an odd integer, which sets a minimum
%   separation in radius between peaks. See below for a more precise
%   statement. The default is 1.
%
%       When a peak has been found, no other peak with a position within an
%       NHOODXY x NHOODXY x NHOODR box centred on the first peak will be
%       detected. Peaks are found sequentially; for example, after the
%       highest peak has been found, the second will be found at the
%       largest value in H excepting the exclusion box found the first
%       peak. This is similar to the mechanism provided by the Toolbox
%       function HOUGHPEAKS.
%
%       If both the 'Nhoodxy' and 'Nhoodr' options are omitted, the effect
%       is not quite the same as setting each of them to 1. Instead of a
%       sequential algorithm with repeated passes over H, the Toolbox
%       function IMREGIONALMAX is used. This may produce slightly different
%       results, since an above-threshold point adjacent to a peak will
%       appear as an independent peak using the sequential suppression
%       algorithm, but will not be a local maximum. 
%
%   See also CIRCLE_HOUGH, CIRCLE_HOUGHDEMO

% check arguments
params = checkargs(h, radii, varargin{:});

% smooth the accumulator - xy
if params.smoothxy > 0
    [m, hsize] = gaussmask1d(params.smoothxy);
    % smooth each dimension separately, with reflection
    h = cat(1, h(hsize:-1:1,:,:), h, h(end:-1:end-hsize+1,:,:));
    h = convn(h, reshape(m, length(m), 1, 1), 'valid');
    
    h = cat(2, h(:,hsize:-1:1,:), h, h(:,end:-1:end-hsize+1,:));
    h = convn(h, reshape(m, 1, length(m), 1), 'valid');
end

% smooth the accumulator - r
if params.smoothr > 0
    [m, hsize] = gaussmask1d(params.smoothr);
    h = cat(3, h(:,:,hsize:-1:1), h, h(:,:,end:-1:end-hsize+1));
    h = convn(h, reshape(m, 1, 1, length(m)), 'valid');
end

% set threshold
if isempty(params.threshold)
    params.threshold = 0.5 * max(h(:));
end

if isempty(params.nhoodxy) && isempty(params.nhoodr)
    % First approach to peak finding: local maxima
    
    % find the maxima
    maxarr = imregionalmax(h);
    
    maxarr = maxarr & h >= params.threshold;
    
    % get array indices
    peakind = find(maxarr);
    [y, x, rind] = ind2sub(size(h), peakind);
    peaks = [x'; y'; radii(rind)];
    
    % get strongest peaks
    if ~isempty(params.npeaks) && params.npeaks < size(peaks,2)
        [~, ind] = sort(h(peakind), 'descend');
        ind = ind(1:params.npeaks);
        peaks = peaks(:, ind);
    end
    
else
    % Second approach: iterative global max with suppression
    if isempty(params.nhoodxy)
        params.nhoodxy = 1;
    elseif isempty(params.nhoodr)
        params.nhoodr = 1;
    end
    nhood2 = ([params.nhoodxy params.nhoodxy params.nhoodr]-1) / 2;
    
    if isempty(params.npeaks)
        maxpks = 0;
        peaks = zeros(3, round(numel(h)/100));  % preallocate
    else
        maxpks = params.npeaks;  
        peaks = zeros(3, maxpks);  % preallocate
    end
    
    np = 0;
    while true
        [r, c, k, v] = max3(h);
        % stop if peak height below threshold
        if v < params.threshold || v == 0
            break;
        end
        np = np + 1;
        peaks(:, np) = [c; r; radii(k)];
        % stop if done enough peaks
        if np == maxpks
            break;
        end
        % suppress this peak
        r0 = max([1 1 1], [r c k]-nhood2);
        r1 = min(size(h), [r c k]+nhood2);
        h(r0(1):r1(1), r0(2):r1(2), r0(3):r1(3)) = 0;
    end 
    peaks(:, np+1:end) = [];   % trim
end

% adjust for margin
if params.margin > 0
    peaks([1 2], :) = peaks([1 2], :) - params.margin;
end


function params = checkargs(h, radii, varargin)
% Argument checking
ip = inputParser;

% required
htest = @(h) validateattributes(h, {'double'}, {'real' 'nonnegative' 'nonsparse'});
ip.addRequired('h', htest);
rtest = @(radii) validateattributes(radii, {'double'}, {'real' 'positive' 'vector'});
ip.addRequired('radii', rtest);

% optional
mtest = @(n) validateattributes(n, {'double'}, {'real' 'nonnegative' 'integer' 'scalar'});
ip.addOptional('margin', 0, mtest); 

% parameter/value pairs
stest = @(s) validateattributes(s, {'double'}, {'real' 'nonnegative' 'scalar'});
ip.addParamValue('smoothxy', 0, stest);
ip.addParamValue('smoothr', 0, stest);
ip.addParamValue('threshold', [], stest);
nptest = @(n) validateattributes(n, {'double'}, {'real' 'positive' 'integer' 'scalar'});
ip.addParamValue('npeaks', [], nptest);
nhtest = @(n) validateattributes(n, {'double'}, {'odd' 'positive' 'scalar'});
ip.addParamValue('nhoodxy', [], nhtest);
ip.addParamValue('nhoodr', [], nhtest);
ip.parse(h, radii, varargin{:});
params = ip.Results;


function [m, hsize] = gaussmask1d(sigma)
% truncated 1D Gaussian mask
hsize = ceil(2.5*sigma);  % reasonable truncation
x = (-hsize:hsize) / (sqrt(2) * sigma);
m = exp(-x.^2);
m = m / sum(m);  % normalise


function [r, c, k, v] = max3(h)
% location and value of global maximum of a 3D array
[vr, r] = max(h);
[vc, c] = max(vr);
[v, k] = max(vc);
c = c(1, 1, k);
r = r(1, c, k);

function [x, y] = circlepoints(r)
%CIRCLEPOINTS  Returns integer points close to a circle
%   [X, Y] = CIRCLEPOINTS(R) where R is a scalar returns coordinates of
%   integer points close to a circle of radius R, such that none is
%   repeated and there are no gaps in the circle (under 8-connectivity).
%
%   If R is a row vector, a circle is generated for each element of R and
%   the points concatenated.

%   Copyright David Young 2010

x = [];
y = [];
for rad = r
    [xp, yp] = circlepoints1(rad);
    x = [x xp];
    y = [y yp];
end


    
function [x, y] = circlepoints1(r)    
% Get number of rows needed to cover 1/8 of the circle
l = round(r/sqrt(2));
if round(sqrt(r.^2 - l.^2)) < l   % if crosses diagonal
    l = l-1;
end
% generate coords for 1/8 of the circle, a dot on each row
x0 = 0:l;
y0 = round(sqrt(r.^2 - x0.^2));
% Check for overlap
if y0(end) == l
    l2 = l;
else
    l2 = l+1;
end
% assemble first quadrant
x = [x0 y0(l2:-1:2)]; 
y = [y0 x0(l2:-1:2)];
% add next quadrant
x0 = [x y];
y0 = [y -x];
% assemble full circle
x = [x0 -x0];
y = [y0 -y0];


function h = waitbar_new(X,varargin)
%  WAITBAR a modified version of MATLAB's waitbar function.
%__________________________________________________________________________
%     H = WAITBAR(X,'message') creates and displays a waitbar of fractional 
%           length X.  The handle to the waitbar figure is returned in H.
%           X should be between 0 and 1. 
%  
%     WAITBAR(X) will set the length of the bar in the most recently
%           created waitbar window to the fractional length X.
%  
%     WAITBAR(X,H) will set the length of the bar in waitbar H
%           to the fractional length X.
%  
%     WAITBAR(X,H,'message') will update the message text in
%           the waitbar figure, in addition to setting the fractional
%           length to X.
%  
%     WAITBAR is typically used inside a FOR loop that performs a
%           lengthy computation.  
%  
%     Example:
%         h = waitbar(0,'Please wait...');
%         for i=1:1000,
%             % computation here %
%             waitbar(i/1000,h)
%         end
%
% NOTES:
% - This progarm produced with heavy modification of Chad English's timebar
% function.  The update was designed to recieve input identically to
% MATLAB's waitbar function to allow for interchangability.
%
% - This program does not apply the property values that the traditional
% waitbar allows.
%
%__________________________________________________________________________

% 1 - GATHER THE INPUT
    if nargin == 1;
        h = findobj(allchild(0),'flat','Tag','waitbar');
        message = '';
    elseif isnumeric(X) & ishandle(varargin{1}) & nargin == 2;
        h = varargin{1}; message = '';
    elseif isnumeric(X) & ischar(varargin{1}) & nargin == 2;
        h = []; message = varargin{1}; 
    elseif isnumeric(X) & ishandle(varargin{1}) & nargin == 3;
        h = varargin{1}; message = varargin{2};
    else
        disp('Error defnining waitbar'); return;
    end

% 2 - BUILD/UPDATE THE MESSAGE BAR
    if  isempty(h) || ~ishandle(h(1)); h = buildwaitbar(X,message);       
    else updatewaitbar(h,X,message); end     

%--------------------------------------------------------------------------
% SUBFUNCTION: buildwaitbar
function h = buildwaitbar(X,message)
% BUILDWAITBAR constructs the figure containing the waitbar

 % 1 - SET WINDOW SIZE AND POSITION 
    % 1.1 - Gather screen information
        screensize = get(0,'screensize');  % User's screen size 
        screenwidth = screensize(3);       % User's screen width
        screenheight = screensize(4);      % User's screen height

    % 1.2 - Define the waitbar position
        winwidth = 300;           % Width of timebar window
        winheight = 85;           % Height of timebar window
        winpos = [0.5*(screenwidth-winwidth), ...
            0.5*(screenheight-winheight), winwidth, winheight];  % Position
                                                            
% 2 - OPEN FIGURE AND SET PROPERTIES  
    wincolor = 0.85*[1 1 1]; % Define window color
  
    % 2.1 - Define the main waitbar figure
    h = figure('menubar','none','numbertitle','off',...
        'name','0% Complete','position',winpos,'color',wincolor,...                                
        'tag','waitbar','IntegerHandle','off');                               

    % 2.2 - Define the message textbox
    userdata.text(1) = uicontrol(h,'style','text','hor','left',...     
        'pos',[10 winheight-30 winwidth-20 20], 'string',message,...                                            
        'backgroundcolor',wincolor,'tag','message');                                 

    % 2.3 - Build estimated remaining static text textbox
    est_text = 'Estimated time remaining: ';                
    userdata.text(2) = uicontrol(h,'style','text','string',est_text,...       
        'pos',[10 15 winwidth/2 20],'FontSize',7,...
        'backgroundcolor',wincolor,'HorizontalAlignment','right');                                

    % 2.4 - Build estimated time textbox
    userdata.remain = uicontrol(h,'style','text','string','',...
        'FontSize',7,'HorizontalAlignment','left',...   
        'pos',[winwidth/2+10 14.5 winwidth-25 20], ...                                  
        'backgroundcolor',wincolor);     
                                 
    % 2.5 - Build elapsed static text textbox
    est_text = 'Total elapsed time: ';                
    userdata.text(3) = uicontrol(h,'style','text','string',est_text,...       
        'pos',[10 3 winwidth/2 20],'FontSize',7,...
        'backgroundcolor',wincolor,'HorizontalAlignment','right');                                

    % 2.6 - Build elapsed time textbox
    userdata.elapse = uicontrol(h,'style','text','string','',...   
        'pos',[winwidth/2+10 3.5 winwidth-25 20],'FontSize',7, ...                                  
        'backgroundcolor',wincolor,'HorizontalAlignment','left');     
                                 
    % 2.7 - Build percent progress textbox
    userdata.percent = uicontrol(h,'style','text','hor','right',...     
        'pos',[winwidth-35 winheight-52 28 20],'string','',...                                       
        'backgroundcolor',wincolor);                                      
    
    % 2.8 - Build progress bar axis
    userdata.axes = axes('parent',h,'units','pixels','xlim',[0 1],...                                
        'pos',[10 winheight-45 winwidth-50 15],'box','on',...                                     
        'color',[1 1 1],'xtick',[],'ytick',[]);                             
    
% 3 - INITILIZE THE PROGESS BAR
    userdata.bar = ...
        patch([0 0 0 0 0],[0 1 1 0 0],'r');  % Initialize  bar to zero area
    userdata.time = clock;                   % Record the current time
    userdata.inc = clock;                    % Set incremental clock 
    set(h,'userdata',userdata)               % Store data in thefigure
    updatewaitbar(h,X,message);              % Updates waitbar if X~=0
  
%--------------------------------------------------------------------------
% SUBFUNCTION: updatewaitbar
function updatewaitbar(h,progress,message)
% UPDATEWAITBAR changes the status of the waitbar progress

% 1 - GATHER WAITBAR INFORMATION
    drawnow;                        % Needed for window to appear
    h = h(1);                       % Only allow newest waitbar to update                                                 
    userdata = get(h,'userdata');   % Get userdata from waitbar figure

    % Check object tag to see if it is a timebar
    if ~strcmp(get(h,'tag'), 'waitbar')                     
        error('Handle is not for a waitbar window')          
    end

    % Update the message
        if ~isempty(message);
            hh = guihandles(h);
            set(hh.message,'String',message);
        end

% 2 - UPDATE THE GUI (only update if more tha 1 sec has passed)
    if etime(clock,userdata.inc) > 1 || progress == 1

    % 2.1 - Compute the elapsed time and incremental time 
        elap = etime(clock,userdata.time);  % the total elapsed time
        userdata.inc = clock; set(h,'Userdata',userdata); % store current

    % 2.2 - Calculate the estimated time remaining
        sec_remain = elap*(1/progress-1);
        e_mes = datestr(elap/86400,'HH:MM:SS');
        r_mes = datestr(sec_remain/86400,'HH:MM:SS');

    % 2.3 - Produce error if progress is > 1
        if progress > 1; r_mes = 'Error, progress > 1'; end

    % 2.4 - Update information
        set(userdata.bar,'xdata',[0 0 progress progress 0]) % Update bar
        set(userdata.remain,'string',r_mes); % Update remaining time string   
        set(userdata.elapse,'string',e_mes); % Update elapsed time string                
        set(userdata.percent,'string',...                   
            strcat(num2str(floor(100*progress)),'%')); % Update progress %
        set(h,'Name',[num2str(floor(100*progress)),...
            '% Complete']); % Update figure name
       
    end


% --- Executes on button press in cam_2.
function cam_2_Callback(hObject, eventdata, handles)
% hObject    handle to cam_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cam_2
global CAM
CAM = 2;

% --- Executes on button press in cam_1.
function cam_1_Callback(hObject, eventdata, handles)
% hObject    handle to cam_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cam_1
global CAM
CAM = 1;


% --- Executes on button press in single_channel.
function single_channel_Callback(hObject, eventdata, handles)
% hObject    handle to single_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of single_channel
global CHAN
CHAN = 1;

% --- Executes on button press in dual_channel.
function dual_channel_Callback(hObject, eventdata, handles)
% hObject    handle to dual_channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dual_channel
global CHAN
CHAN = 2;


% --- Executes on button press in ver.
function ver_Callback(hObject, eventdata, handles)
% hObject    handle to ver (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ver
global VER
global HOR

VER = get(hObject,'Value');
%HOR = 0;

% --- Executes on button press in hor.
function hor_Callback(hObject, eventdata, handles)
% hObject    handle to hor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hor
global VER
global HOR

%VER = 0;
HOR = get(hObject,'Value');


% --- Executes during object creation, after setting all properties.
function image_register_CreateFcn(hObject, eventdata, handles)
% hObject    handle to image_register (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global image_d
global donor
global acceptor
global fname
global image_dt
global D
global A
%global stack_len
%global disp_read_images
global A_t 
global image_at
global CAM
global CHAN
global avg_frames
global img_source
global VER
global HOR
global H_split
global W_split
global H
global W
global file_name

%% Get the trimmed start and finish
auto_trim_frame = get(handles.auto_trim_mov, 'Value');
trim_start = str2num(get(handles.trim_start_frame,'String'))-1;
%% execute the trimming

stack_len = numel(donor);
if auto_trim_frame == 1
    stack_len = stack_len - 1;
end
num_images = getappdata(handles.file_name, 'num_images'); 
image_d = getappdata(handles.d_t_a_frames,'image_d');
ASASA = num_images;

if (CHAN ~=1)
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 
end

if ( CAM ~= 1)
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 
end

val_min_don = (get(handles.min_sub_don,'Value'));
val_min_accep = (get(handles.min_sub_accep,'Value'));

%% Read files in from either Micro or Andor for registration
h = waitbar(0, 'Compiling Images to Extract Traces');   
if CAM == 2
    if CHAN == 1
        switch img_source
            case char('micromanager')    
                for k = 1:stack_len
                D = imread(fname, donor(k));
                A = imread(fname, acceptor(k));
                    if val_min_don == 1
                       sub_min_don = mean(min(D));
                    else
                       sub_min_don = uint16(0);
                    end
                    if val_min_accep ==1
                       sub_min_accep =  mean(min(A));
                    else
                       sub_min_accep = uint16(0);                                
                    end
                image_dt(:,:,k) = D-sub_min_don; 
                A_t = imwarp(A,tform,'OutputView',imref2d(size(image_d)));
                image_at(:,:,k) = A_t-sub_min_accep;
                waitbar(k/stack_len);
                end                
            case char('Andor Solis')
                for k = 1:stack_len
                        if auto_trim_frame == 1
                        D = imread([file_name,'.tif'], (trim_start+k));  
                        A = imread([file_name,'b','.tif'], (trim_start+k)); 
                        else
                        D = imread([file_name,'.tif'], donor(k));  
                        A = imread([file_name,'b','.tif'], acceptor(k)); 
                        end                
                    if val_min_don == 1
                       sub_min_don = mean(min(D));
                    else
                       sub_min_don = uint16(0);
                    end
                     if val_min_accep ==1
                       sub_min_accep =  mean(min(A));
                    else
                       sub_min_accep = uint16(0);                                
                    end
                image_dt(:,:,k) = D-sub_min_don;
                A_t = imwarp(A,tform,'OutputView',imref2d(size(image_d)));
                %image_at(:,:,k) = A_t;
                image_at(:,:,k) = A_t-sub_min_accep;
                waitbar(k/stack_len);
                end
        end
    end
end

if CHAN == 2
    if CAM == 1
        for k = 1:stack_len
            if auto_trim_frame == 1
                dd = imread([file_name,'.tif'], (trim_start+k)); 
            else
                dd = imread([file_name,'.tif'], donor(k)); 
            end
                if HOR == 1
                D = dd(1:H_split,:);
                    if val_min_don == 1
                       sub_min_don = mean(min(D));
                    else
                       sub_min_don = uint16(0);
                    end                
                image_dt(:,:,k) = D - sub_min_don;
                A = dd((H_split+1):H,:);
                    if val_min_accep ==1
                       sub_min_accep =  mean(min(A));
                    else
                       sub_min_accep = uint16(0);                                
                    end                
                A_t = imwarp(A,tform,'OutputView',imref2d(size(image_d)));
                image_at(:,:,k) = A_t-sub_min_accep;                            
                waitbar(k/stack_len);
                 elseif VER == 1
                D = dd(:,1:W_split);
                    if val_min_don == 1
                       sub_min_don = mean(min(D));
                    else
                       sub_min_don = uint16(0);
                    end                
                image_dt(:,:,k) = D - sub_min_don;
                A = dd(:,(W_split+1):W);
                    if val_min_accep ==1
                       sub_min_accep =  mean(min(A));
                    else
                       sub_min_accep = uint16(0);                                
                    end                
                A_t = imwarp(A,tform,'OutputView',imref2d(size(image_d)));
                image_at(:,:,k) = A_t-sub_min_accep;
                waitbar(k/stack_len);
                end
        end
    end
end

if CAM == 1
    if CHAN == 1
        switch img_source
            case char('micromanager')    
                for k = 1:stack_len
                D = imread(fname, donor(k));
                    if val_min_don == 1
                       sub_min_don = mean(min(D));
                    else
                       sub_min_don = uint16(0);
                    end              
                image_dt(:,:,k) = D-sub_min_don;  
                waitbar(k/stack_len);
                end                
            case char('Andor Solis')
                for k = 1:stack_len  
                    if auto_trim_frame == 1
                        D = imread([file_name,'.tif'], (trim_start+k));  
                    else
                        D = imread([file_name,'.tif'], donor(k)); 
                    end                
                    if val_min_don == 1
                       sub_min_don = mean(min(D));
                    else
                       sub_min_don = uint16(0);
                    end    
                image_dt(:,:,k) = D-sub_min_don;
                waitbar(k/stack_len);
                end
        end
    end    
end
close(h) 
setappdata(handles.image_register,'image_dt',image_dt);
setappdata(handles.image_register,'image_at',image_at);

        full__auto_t = get(handles.full_auto,'SelectedObject');
        full_auto_mode = get(full__auto_t,'String');
        switch full_auto_mode 
            case ('Auto Extract')
                find_donor_Callback(handles.find_donor, eventdata, handles)
            case('Batch Extract')
                find_donor_Callback(handles.find_donor, eventdata, handles)
        end
   
% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = zoom;
%h.Motion = 'horizontal';
h.Enable = 'on';
% zoom in on the plot in the horizontal direction.
a7 = (handles.axes7);

linkaxes([a7],'x');

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a7 = (handles.axes7);

linkaxes([a7],'x');
zoom('out');
linkaxes([a7],'x');
zoom off
linkaxes([a7],'x');

% % --- Executes on button press in pushbutton25.
% function pushbutton25_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton25 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% h = zoom;
% %h.Motion = 'horizontal';
% h.Enable = 'on';
% % zoom in on the plot in the horizontal direction.
% a8 = (handles.axes8);
% 
% linkaxes([a8],'x');
% 
% % --- Executes on button press in pushbutton26.
% function pushbutton26_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton26 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% a8 = (handles.axes8);
% 
% linkaxes([a8],'x');
% zoom('out');
% linkaxes([a8],'x');
% zoom off
% linkaxes([a8],'x');


% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global donor

global image_d


global image_dt


global image_at

time_int =str2double(get(handles.time_int, 'String'));   
%stack_len = getappdata(handles.save_name, 'len_stack'); 
num_images = getappdata(handles.file_name, 'num_images'); 
stack_len = num_images;
num_images = getappdata(handles.file_name, 'num_images'); 
image_d = getappdata(handles.d_t_a_frames,'image_d');
image_a_r = getappdata(handles.d_t_a_frames,'image_a_r');
%% Get background information
don_spot_bckg = getappdata(handles.don_background,'don_spot_bckg');
accep_spot_bckg = getappdata(handles.accep_background,'accep_spot_bckg');
%clear('handles.axes9');
% axes(handles.axes9);
% min_d = min(image_d(:));
% max_d = max(image_d(:));
% imshow(image_d,[min_d max_d]) 
% hold on
%% get donor information
centers_d = getappdata(handles.find_donor, 'centers_d');
[num_spots_d, ~] = size(centers_d); 
radii_d = getappdata(handles.find_donor, 'radii_d');
time_int =str2double(get(handles.time_int, 'String'));    
dims_x_d = get(handles.img_width, 'String');
dims_y_d = get(handles.img_hgt, 'String');
%% get acceptor information
centers_a = getappdata(handles.find_acceptor, 'centers_a');
[num_spots_a, ~] = size(centers_a); 
radii_a = getappdata(handles.find_acceptor, 'radii_a'); 
dims_x_a = get(handles.img_width, 'String');
dims_y_a = get(handles.img_hgt, 'String'); 
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 
        length = 1:num_images;
        % Find and extract donor frames
        donor = find(mod(length,2)~=0);
        acceptor = find(mod(length,2)==0);

        
        num_spots_f = num_spots_a;
        fret_counter = 0;
        


center_f = ginput(1);        

 ref_1_f = center_f(:,1);
 ref_2_f = center_f(:,2);
 radius_f = 2;
 NOP = 20;
 THETA=linspace(0,2*pi,NOP);
 RHO_f=ones(1,NOP)*radius_f;
 [X_f,Y_f] = pol2cart(THETA,RHO_f);
 X_f_spot=X_f+ref_1_f;
 Y_f_spot=Y_f+ref_2_f;             
 X_d_bckg = don_spot_bckg(:,1)+X_f;
 Y_d_bckg = don_spot_bckg(:,2)+Y_f;
 X_a_bckg = accep_spot_bckg(:,1)+X_f;
 Y_a_bckg = accep_spot_bckg(:,2)+Y_f;
%  axes(handles.axes9);
%  h=fill(X_f_spot,Y_f_spot,'g',X_d_bckg, Y_d_bckg, 'b', X_a_bckg, Y_d_bckg, 'm');                
 fret_counter = fret_counter+1;  
 image_d = uint16(image_d);
 [roi_BW_d] = roipoly(image_d, X_f_spot,Y_f_spot);
 [roi_bckg_d] = roipoly(image_d,X_d_bckg, Y_d_bckg);
 image_a_r = uint16(image_a_r);
 [roi_BW_a] = roipoly(image_a_r, X_f_spot,Y_f_spot);
 [roi_bckg_a] = roipoly(image_a_r,X_a_bckg, Y_a_bckg);



 roi_selection_d = uint16(repmat(roi_BW_d,[1,1,stack_len])).*uint16(image_dt);
 roi_bckg_d = uint16(repmat(roi_bckg_d,[1,1,stack_len])).*uint16(image_dt);
 intensity_defRoi_d = squeeze(sum(sum(roi_selection_d,1),2));
 intensity_defRoi_bckg_d = squeeze(sum(sum(roi_bckg_d,1),2));
 intensity_donor_specific = intensity_defRoi_d - intensity_defRoi_bckg_d;
 roi_selection_a = uint16(repmat(roi_BW_a,[1,1,stack_len])).*uint16(image_at);
 roi_bckg_a = uint16(repmat(roi_bckg_a,[1,1,stack_len])).*uint16(image_at);





 intensity_defRoi_a = squeeze(sum(sum(roi_selection_a,1),2));
 intensity_defRoi_bckg_a = squeeze(sum(sum(roi_bckg_a,1),2));
 intensity_acceptor_specific = intensity_defRoi_a - intensity_defRoi_bckg_a;             
 time_axis = 1:stack_len;
 axes(handles.axes10);
 axis_limits = max(intensity_defRoi_d) + 0.25* max(intensity_defRoi_d);
 plot(time_axis, intensity_defRoi_d,'g', time_axis, intensity_defRoi_bckg_d, 'b',time_axis,intensity_donor_specific,'k');
    if stack_len > 1
        axis([1 stack_len 0 axis_limits])
    end
 axes(handles.axes11);
 axis_limits = max(intensity_defRoi_a) + 0.25* max(intensity_defRoi_a);
 plot(time_axis, intensity_defRoi_a,'r', time_axis, intensity_defRoi_bckg_a, 'b',time_axis,intensity_acceptor_specific,'k');
    if stack_len > 1
        axis([1 stack_len 0 axis_limits])
    end
 don_hist(:,1) = max(intensity_defRoi_d);
 axes(handles.axes13)
 hist(don_hist,num_spots_d/5);      

 accep_hist(:,1) = max(intensity_defRoi_a);
 axes(handles.axes14)
 hist(accep_hist,num_spots_a/5);      
   


global maA
global miA
% hObject    handle to find_acceptor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_a
%global imageAAA
%image_a = getappdata(handles.d_t_a_frames,'image_a');
min_image_a = min(min(image_a));
image_a_temp = image_a - min_image_a;
%image_a = image_a_temp.*10;

image_d = getappdata(handles.d_t_a_frames,'image_d');
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 

axes(handles.axes8);
image_a_r = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));
setappdata(handles.d_t_a_frames,'image_a_r', image_a_r);
% setappdata(handles.d_t_a_frames,'image_a', image_a);
% min_a = min(image_a_r(:));
% max_a = max(image_a_r(:));

imshow(image_a_r,[miA,maA]);
viscircles(center_f,radius_f,'Color','m','LineWidth',0.5);

axes(handles.axes7);
min_d = min(image_d(:));
max_d = max(image_d(:));
imshow(image_d,[min_d max_d]) 
viscircles(center_f,radius_f,'Color','m','LineWidth',0.5);
  


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
global BackG 
contents = cellstr(get(hObject,'String'));
BackG = contents{get(hObject,'Value')};


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double
global xperc
xperc = str2double(get(hObject,'String'));


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2
global v_filt
v_filt = get(hObject,'Value');


% --- Executes on button press in pop_out_donor.
function pop_out_donor_Callback(hObject, eventdata, handles)
% hObject    handle to pop_out_donor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Generate a popup of the donor identification figure
global centers_d
global radii_d
global image_d 
global cent_map_d
global num_d_o_range1
global num_d_o_range2 
global radii_dttt

% get iteration value
max_iter = str2num(get(handles.max_iter_psf,'String'));
min_image_d = min(min(image_d));
image_d_temp = image_d - min_image_d;

figure (2)
min_d = min(image_d(:));
% max_d = max(image_d(:));
[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*10 >=65536
    max_d = 65536;
else
    max_d = max_d_t *10;
end
imshow(image_d,[min_d max_d]) 
colormap(gray)
colorbar

%This is the threshold value
type_auto_thresh_t = get(handles.thresh_auto, 'SelectedObject');
type_auto_thresh = get(type_auto_thresh_t, 'String');
switch type_auto_thresh
    case ('Auto')
        th = str2num(get(handles.don_thresh_picker, 'String'));
        
    case ('Manual')
        th = get(handles.don_sens, 'Value');
end

don_edge = 1;

don_pix_min = str2double(get(handles.edit34, 'String'));
don_pix_max = str2double(get(handles.don_pix_max, 'String'));

im = image_d;
min_d = min(image_d(:));
max_d = max(image_d(:));

%offset = 2
[centers_dttt, radii_dttt, cent_map_d] = centroid_finder (image_d, th,2,don_edge);
% Filter the particles to eliminate those with radii that are below or
% higher than the min/max pixel range
radii_dtti = find(radii_dttt>=don_pix_min & radii_dttt<=don_pix_max);
radii_dtt = radii_dttt(radii_dtti);
% number of particles outside of pixel range
num_d_o_range1 = length(radii_dttt) - length(radii_dtt);

centers_dtt = centers_dttt(radii_dtti,:);
localization_tt = get(handles.localization,'SelectedObject');
localization_t = get(localization_tt,'String');

%% Filter for overlap
[radii_di] = overlap_filter(centers_dtt, radii_dtt);
% New centers and radii filtered for rixel range and for overlap
centers_dt = centers_dtt(radii_di,:);
radii_d = round(radii_dtt(radii_di));
radii_l = size(radii_d);
radii_d = ones(radii_l).*2;
switch localization_t
    case{'Standard'}  
        %% optomise sum of particles and pixelise the centers in x and y
        [centers_d] = extrac_optom(radii_d,centers_dt,image_d);
    case{'PSF'}            
        centers_dt = round(centers_dt);
       [centers_d] = psf_localization(centers_dt,image_d,max_iter);
end
% number of pixels outside that overlap
num_d_o_range2 = length(radii_dtt)-length(radii_d);
setappdata(handles.find_donor, 'centers_d',centers_d);
setappdata(handles.find_donor, 'radii_d', radii_d); 
[don_mol,~] = size(radii_d);
set(handles.don_mols, 'String', num2str(don_mol));
setappdata(handles.find_donor, 'don_mol', don_mol);
viscircles(centers_d,radii_d,'Color','g','LineWidth',.001);
% Set a title.
[num_donors,~] = size(radii_d);
title(['number of identified Donors = ' num2str(num_donors)]);


% --- Executes on button press in pop_out_acceptor.
function pop_out_acceptor_Callback(hObject, eventdata, handles)
% hObject    handle to pop_out_acceptor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Generates a pop up window for the acceptor window
global centers_a
global radii_a
global maA
global miA
global image_a
auto_lock_ratio = get(handles.lock_ratio, 'Value');
auto_ratio_val = str2num(get(handles.set_ratio,'String'));

don_mol = getappdata(handles.find_donor, 'don_mol');
max_iter = str2num(get(handles.max_iter_psf,'String'));
min_image_a = min(min(image_a));
image_a_temp = image_a - min_image_a;
image_d = getappdata(handles.d_t_a_frames,'image_d');
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 

figure (3)
image_a_r = imwarp(image_a,tform,'OutputView',imref2d(size(image_d)));
setappdata(handles.d_t_a_frames,'image_a_r', image_a_r);
imshow(image_a_r,[miA,maA]);
colormap(gray)
colorbar
hold on
type_auto_thresh_t = get(handles.thresh_auto, 'SelectedObject');
type_auto_thresh = get(type_auto_thresh_t, 'String');
switch type_auto_thresh
    case ('Auto')
        th = str2num(get(handles.accep_thresh_picker,'String'));
        
    case ('Manual')
        th = get(handles.accep_sens, 'Value');
end
accep_edge = 1;
accep_pix_min = str2double(get(handles.edit33, 'String'));
accep_pix_max = str2double(get(handles.accep_pix_max, 'String'));
%% Does the auto scanning
if auto_lock_ratio == 1
        f = msgbox('Auto computing ratio','Ratio');
    th_trials = 400;
    th_inc = 50;
    for k = 1:1000
        th = th_trials + th_inc*k;
        [centers_attt, radii_attt, cent_map_a] = centroid_finder(image_a_r, th,2, accep_edge);
        % Filter the particles to eliminate those with radii that are below or
        % higher than the min/max pixel range
        radii_atti = find(radii_attt>=accep_pix_min & radii_attt<=accep_pix_max);
        radii_att = radii_attt(radii_atti);
        % number of particles outside of pixel range
        num_a_o_range1 = length(radii_attt) - length(radii_att);
        centers_att = centers_attt(radii_atti,:);
        % Filter for overlap
        [radii_ai] = overlap_filter(centers_att, radii_att);
        % New centers and radii filtered for rixel range and for overlap
        centers_at = centers_att(radii_ai,:);
        radii_a = round(radii_att(radii_ai));
        radii_l = size(radii_a);
        radii_a = ones(radii_l).*2;
        [accep_mol,~] = size(radii_a);
        stoich = accep_mol/don_mol;
        if stoich > auto_ratio_val-0.02 && stoich < auto_ratio_val+0.02 
            h = waitbar(0,'Processing');
            disp('auto threshold reached')
            localization_t = 'PSF';
            close (h)
            break 
        elseif stoich < auto_ratio_val
            localization_t = 'PSF';
            break
        end
        
    end
else
        % Does the particle finding. 
        [centers_attt, radii_attt, cent_map_a] = centroid_finder(image_a_r, th,2, accep_edge);
        % Filter the particles to eliminate those with radii that are below or
        % higher than the min/max pixel range
        radii_atti = find(radii_attt>=accep_pix_min & radii_attt<=accep_pix_max);
        radii_att = radii_attt(radii_atti);
        % number of particles outside of pixel range
        num_a_o_range1 = length(radii_attt) - length(radii_att);
        centers_att = centers_attt(radii_atti,:);
        localization_tt = get(handles.localization,'SelectedObject');
        localization_t = get(localization_tt,'String');
        % Filter for overlap
        [radii_ai] = overlap_filter(centers_att, radii_att);
        % New centers and radii filtered for rixel range and for overlap
        centers_at = centers_att(radii_ai,:);
        radii_a = round(radii_att(radii_ai));
        radii_l = size(radii_a);
        radii_a = ones(radii_l).*2;
        [accep_mol,~] = size(radii_a);
        stoich = accep_mol/don_mol;
end
%% Filter for overlap
[radii_ai] = overlap_filter(centers_att, radii_att);
% New centers and radii filtered for rixel range and for overlap
centers_at = centers_att(radii_ai,:);
radii_a = round(radii_att(radii_ai));
radii_l = size(radii_a);
radii_a = ones(radii_l).*2;
localization_tt = get(handles.localization,'SelectedObject');
localization_t = get(localization_tt,'String');
switch localization_t
    case{'Standard'}  
        %% optomise sum of particles and pixelise the centers in x and y
        [centers_a] = extrac_optom(radii_a,centers_at,image_a_r);
    case{'PSF'}            
        centers_at = round(centers_at);
       [centers_a] = psf_localization(centers_at,image_a_r,max_iter);
end

figure (3)
% number of pixels outside that overlap
num_a_o_range2 = length(radii_att)-length(radii_a);
[accep_mol,~] = size(radii_a);
set(handles.accep_mols, 'String', num2str(accep_mol));
viscircles(centers_a,radii_a,'Color','r','LineWidth',.01);
hold off
don_mol = getappdata(handles.find_donor, 'don_mol');
stoich = accep_mol/don_mol;
set(handles.stoich, 'String', stoich);
setappdata(handles.find_acceptor, 'centers_a', centers_a);
setappdata(handles.find_acceptor, 'radii_a', radii_a);
[num_acceptors,~] = size(radii_a);
title(['Number of Identified Acceptors = ' num2str(num_acceptors)]);
        if auto_lock_ratio == 1
            close(f)
            accep_background_Callback(handles.accep_background, eventdata, handles)
            pop_fret_Callback(handles.pop_fret, eventdata, handles)            
        end

% --- Executes on button press in pop_fret.
function pop_fret_Callback(hObject, eventdata, handles)
% hObject    handle to pop_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image_d = getappdata(handles.d_t_a_frames,'image_d');
centers_d = getappdata(handles.find_donor, 'centers_d');
radii_d = getappdata(handles.find_donor, 'radii_d'); 
centers_a = getappdata(handles.find_acceptor, 'centers_a');
radii_a = getappdata(handles.find_acceptor, 'radii_a');
image_a_r = getappdata(handles.d_t_a_frames,'image_a_r');

extract_auto_t = get(handles.auto_overlay,'SelectedObject');
extract_auto = get(extract_auto_t,'String');

type_picker_t = get(handles.overlay_fret_method, 'SelectedObject');
type_picker = get(type_picker_t, 'String');

if ispc == 1
save('Variables\temp_fret_id','centers_a','radii_a','centers_d','radii_d','image_d','image_a_r','type_picker','extract_auto');
elseif ismac == 1
save('Variables/temp_fret_id','centers_a','radii_a','centers_d','radii_d','image_d','image_a_r','type_picker','extract_auto');
end

switch type_picker
    case('Run Matcher')
        % Run the FRET matcher
        fret_overlay
        switch extract_auto
            case{'Auto'}
            close ('fret_overlay')
        end
    case('All Particles')
        fret_overlay
        close ('fret_overlay')
    case('Accep over Don')
        % Take all the acceptor spots and overlay it on the donor positions
        % Run all particle picker, get background from fit and apply to all
        % donor particles
        load('bckg_don_avg.mat','bckg_don_avg');
        centers_a_o = centers_a;
        radii_a_o = radii_a;
        centers_d_o = centers_a;
        radii_d_o = radii_a;
        for i = 1:length(radii_a)
            bckg_don1(:,i) = bckg_don_avg;            
        end
        
        if ispc == 1
        save('Variables\matched_fret1.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
        save('Variables\bckg_don1.mat','bckg_don1'); 
        elseif ismac == 1
        save('Variables/matched_fret1.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
        save('Variables/bckg_don1.mat','bckg_don1'); 
        end
        

        
    case('All Donor')
        % Take all the particles including donor only and high fret
        % acceptor
        % Run all particle picker        
        centers_d_o = centers_d;
        radii_d_o = radii_d;
        centers_a_o = centers_d;
        radii_a_o = radii_d;
        load('bckg_accep_avg.mat','bckg_accep_avg');
        for i = 1:length(radii_d)
            bckg_accep1(:,i) = bckg_accep_avg;            
        end
        
        if ispc == 1
        save('Variables\matched_fret1.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
        save('Variables\bckg_accep1.mat','bckg_accep1');
        elseif ismac == 1
        save('Variables/matched_fret1.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
        save('Variables/bckg_accep1.mat','bckg_accep1');
        end
        
        
end

switch extract_auto
            case{'Auto'}
        find_fret_Callback(handles.find_fret, eventdata, handles)
end


% --- Executes on button press in co_local.
function co_local_Callback(hObject, eventdata, handles)
% hObject    handle to co_local (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of co_local


% --- Executes on button press in accep_ov_don.
function accep_ov_don_Callback(hObject, eventdata, handles)
% hObject    handle to accep_ov_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of accep_ov_don


% --- Executes on button press in pop_disp_FRET.
function pop_disp_FRET_Callback(hObject, eventdata, handles)
% hObject    handle to pop_disp_FRET (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% This is a display program of the picked particles
global centers_a
global radii_a
global image_d

figure(4);
min_d = min(image_d(:));
[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*2.5 >=65536
    max_d = 65536;
else
    max_d = max_d_t *2.5;
end
imshow(image_d,[min_d max_d]) 
hold on

%% get the statud of the radio call button for the FRET Overlay

fret_method = get(handles.overlay_fret_method, 'SelectedObject');
find_style = get(fret_method, 'String');
switch find_style
    case{'Run Matcher'}
        load('matched_fret.mat')
        num_fret_spots = length(radii_a_o);
        viscircles(centers_a_o,radii_a_o,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);
        
    case{'Accep over Don'}
        num_fret_spots = length(radii_a);
        viscircles(centers_a,radii_a,'Color','r','LineWidth',.01);
        set(handles.fret_mols, 'String', num_fret_spots);
        
end


% --- Executes on button press in rep_don.
function rep_don_Callback(hObject, eventdata, handles)
% hObject    handle to rep_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global num_d_o_range1
global num_d_o_range2 
global radii_dttt

msgbox({['Donors identified =', num2str(length(radii_dttt))],['Particles outside pixel range =' ,num2str(num_d_o_range1)],...
    ['Particles overlapping =', num2str(num_d_o_range2)]})


% --- Executes on button press in rep_accep.
function rep_accep_Callback(hObject, eventdata, handles)
% hObject    handle to rep_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global num_a_o_range1
global num_a_o_range2 
global radii_attt

msgbox({['Acceptors identified =', num2str(length(radii_attt))],['Particles outside pixel range =' ,num2str(num_a_o_range1)],...
    ['Particles overlapping =', num2str(num_a_o_range2)]})


% --- Executes on button press in vis_trace.
function vis_trace_Callback(hObject, eventdata, handles)
% hObject    handle to vis_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vis_trace


% --- Executes on button press in auto_save.
function auto_save_Callback(hObject, eventdata, handles)
% hObject    handle to auto_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_save



function multi_don_Callback(hObject, eventdata, handles)
% hObject    handle to multi_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multi_don as text
%        str2double(get(hObject,'String')) returns contents of multi_don as a double


% --- Executes during object creation, after setting all properties.
function multi_don_CreateFcn(hObject, eventdata, handles)
% hObject    handle to multi_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function multi_accep_Callback(hObject, eventdata, handles)
% hObject    handle to multi_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of multi_accep as text
%        str2double(get(hObject,'String')) returns contents of multi_accep as a double


% --- Executes during object creation, after setting all properties.
function multi_accep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to multi_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_kat.
function run_kat_Callback(hObject, eventdata, handles)
% hObject    handle to run_kat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run KAT_2


% --- Executes on button press in exp_donor_img.
function exp_donor_img_Callback(hObject, eventdata, handles)
% hObject    handle to exp_donor_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_d
global CAM
global CHAN
%get the minimum and maximum and scale them to be the same for both images
min_d = uint16(str2double(get(handles.min_img_don,'String')));
max_d = uint16(str2double(get(handles.max_img_don,'String')));
if CAM == 1 && CHAN == 1
fig = figure();
set(fig,'units','normalized','position', [0.1, 0.2, 0.3, 0.4])
% imshow(image_d,[min_exp, max_exp]);
imagesc(image_d, [min_d, max_d])
title('Donor')
colormap(gray)
cb = colorbar;
% cb.FontWeight = 'bold';
cb.FontSize = 12;
end



function min_img_don_Callback(hObject, eventdata, handles)
% hObject    handle to min_img_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_img_don as text
%        str2double(get(hObject,'String')) returns contents of min_img_don as a double


% --- Executes during object creation, after setting all properties.
function min_img_don_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_img_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_img_don_Callback(hObject, eventdata, handles)
% hObject    handle to max_img_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_img_don as text
%        str2double(get(hObject,'String')) returns contents of max_img_don as a double


% --- Executes during object creation, after setting all properties.
function max_img_don_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_img_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_don_accep_img.
function exp_don_accep_img_Callback(hObject, eventdata, handles)
% hObject    handle to exp_don_accep_img (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_d
global image_a
global CAM
global CHAN
min_d = uint16(str2double(get(handles.min_img_don,'String')));
max_d = uint16(str2double(get(handles.max_img_don,'String')));

min_a = uint16(str2double(get(handles.min_img_accp,'String')));
max_a = uint16(str2double(get(handles.max_img_accp,'String')));
if CAM == 2 || CHAN == 2    
fig = figure();
set(fig,'units','normalized','position', [0.1, 0.2, 0.7, 0.4])
ax1=subplot(1,2,1);
a1 = imagesc(image_d,[min_d, max_d]);
colormap(gray)
cbd = colorbar;
% cbd.FontWeight = 'bold';
cbd.FontSize = 12;
copyobj(allchild(a1),ax1);
title('Donor')

ax2=subplot(1,2,2);
a2 = imagesc(image_a,[min_a, max_a]);
colormap(gray)
colorbar
cba = colorbar;
% cba.FontWeight = 'bold';
cba.FontSize = 12;
copyobj(allchild(a2),ax2);
title('Acceptor')
end


function min_img_accp_Callback(hObject, eventdata, handles)
% hObject    handle to min_img_accp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_img_accp as text
%        str2double(get(hObject,'String')) returns contents of min_img_accp as a double


% --- Executes during object creation, after setting all properties.
function min_img_accp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_img_accp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_img_accp_Callback(hObject, eventdata, handles)
% hObject    handle to max_img_accp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_img_accp as text
%        str2double(get(hObject,'String')) returns contents of max_img_accp as a double


% --- Executes during object creation, after setting all properties.
function max_img_accp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_img_accp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in movie_preview.
function movie_preview_Callback(hObject, eventdata, handles)
% hObject    handle to movie_preview (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%msgbox('Movie Feature Not Available');
global image_dt
global image_at
movie_fps = str2double(get(handles.movie_fps,'String'));
mov_num_frame = str2double(get(handles.mov_num_frames,'String'));

mov_type_t = get(handles.uibuttongroup11, 'SelectedObject');
mov_type = get(mov_type_t, 'String');

mov_preview_t = get(handles.uibuttongroup12, 'SelectedObject');
mov_preview = get(mov_preview_t, 'String');
min_d = str2double(get(handles.min_img_don,'String'));
max_d = str2double(get(handles.max_img_don,'String'));
min_a = str2double(get(handles.min_img_accp,'String'));
max_a = str2double(get(handles.max_img_accp,'String'));
switch mov_type
    case {'Donor'}
        if strcmp (mov_preview,'Gen. Movie')
            if movie_fps == 1 || mov_num_frame ==1
               msgbox('FPS  or Frames must be greater than 1') 
               return
            end
        v = VideoWriter('Donor','Motion JPEG 2000');
        open(v)
        end 
        figure(3)
        for k = 1:mov_num_frame
        frame_layer = (image_dt(:,:,k));
        imagesc(frame_layer,[min_d, max_d]);
        colormap gray
        colorbar
        cbd = colorbar;
        cbd.FontWeight = 'bold';
        cbd.FontSize = 10;
        title (k)
        mov_d(k) = getframe(gca);
        end
        
        case {'Acceptor'}
        if strcmp (mov_preview,'Gen. Movie')
            if movie_fps == 1 || mov_num_frame ==1
               msgbox('FPS  or Frames must be greater than 1') 
               return
            end
        v = VideoWriter('Acceptor','Motion JPEG 2000');
        open(v)
        end 
        figure(3)
        for k = 1:mov_num_frame
        frame_layer = (image_at(:,:,k));
        imagesc(frame_layer,[min_a, max_a]);
        colormap gray
        cba = colorbar;
        cba.FontWeight = 'bold';
        cba.FontSize = 10;
        title (k)
        mov_a(k) = getframe(gca);
        end
end

if strcmp (mov_preview,'Gen. Movie')
    switch mov_type
        case {'Donor'}          
        writeVideo(v,mov_d)
        close (v)
        implay('Donor.mj2',movie_fps)
        case {'Acceptor'} 
        writeVideo(v,mov_a)
        close (v)
        implay('Acceptor.mj2',movie_fps)
    end
end



function movie_fps_Callback(hObject, eventdata, handles)
% hObject    handle to movie_fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of movie_fps as text
%        str2double(get(hObject,'String')) returns contents of movie_fps as a double


% --- Executes during object creation, after setting all properties.
function movie_fps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to movie_fps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in min_sub_don.
function min_sub_don_Callback(hObject, eventdata, handles)
% hObject    handle to min_sub_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of min_sub_don


% --- Executes on button press in min_sub_accep.
function min_sub_accep_Callback(hObject, eventdata, handles)
% hObject    handle to min_sub_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of min_sub_accep



function mov_num_frames_Callback(hObject, eventdata, handles)
% hObject    handle to mov_num_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mov_num_frames as text
%        str2double(get(hObject,'String')) returns contents of mov_num_frames as a double


% --- Executes during object creation, after setting all properties.
function mov_num_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mov_num_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in qik_guide.
function qik_guide_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','1) Choose Acquisition Software',...
         '2) Number of Channels, Number of Cameras','3) If Double Channel Choose Splitting Type','4) Click Load Image Stack and Select Image File'},...
        'KIT: Help');


% --- Executes on button press in qik_guide2.
function qik_guide2_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','1) Identify Particles and Get Backgrounds',...
         '2) Pixel Range (Sets Max and Min size of Circles) ','3) Click Identify (Don/Accep) to see Particle identification',...
         '4) Move Threshold Slider bar to get apprpriate identification','5) Optimiser Ratio tigthens the area around each particle','6) Pop Donor Allows for larger Image identification',...
         '7) Pop Report shows the results of the identification','8) Don/Accep Background brings up module for background subtraction',...
         '9) For Donor Click Extract Donor','10) For FRET go to FRET overlay'},...
        'KIT: Help');


% --- Executes on button press in qik_guide3.
function qik_guide3_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','Required Previous Steps',...
         '1) Process Images ','2) Identify Donor/Acceptor Backgrounds',...
         'Next Step','3) FRET Overlay to Match','4) Identify FRET to visualise Acceptor on Donor Image',...
         '5) Extract FRET to obtain Traces','8) Extraction can be visualised (but slows down extraction)',...
         '9) File is autosaved under filename of movie','10) File can be saved as a new name using Save FRET'},...
        'KIT: Help');


% --- Executes on button press in qik_guide4.
function qik_guide4_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','1) Min and Max Values determines the Scale on Images and Movies',...
         '2) Export Donor for One Channel, Export Donor an Acceptor for Two Channels',...
         '3) Movies: Choose Donor or Acceptor','4)Set number of frames to preview (do not exceed max number of images)','5) Preview only shows Images', ...
         '6) Gen. Movie set frames per second of playback'},...
        'KIT: Help');


% --- Executes on button press in radiobutton32.
function radiobutton32_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton32


% --- Executes on button press in image_writer.
function image_writer_Callback(hObject, eventdata, handles)
% hObject    handle to image_writer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fname
image_dw = getappdata(handles.image_register,'image_dt');
image_aw = getappdata(handles.image_register,'image_at');
[~,save_name,~] = fileparts(fname);
tform = getappdata(handles.image_register,'tform');
reg_file = getappdata(handles.image_register,'reg_coord');
load(reg_file,'tform'); 

global stack_len
[path_img,file_name] = fileparts(fname);
h = waitbar(0, 'Writing Registered Images');
type_writer_t = get(handles.uibuttongroup13, 'SelectedObject');
type_writer = get(type_writer_t, 'String');

switch type_writer
    case('Merged')
        save_name1 = [file_name '_reg_merg' '.tif'];
        save_path1 = [path_img, '/',save_name1];        
    case('Seperate')
        save_name1 = [file_name '_b_reg' '.tif'];  
        save_path1 = [path_img, '/',save_name1]; 
end

switch type_writer
    case('Merged')
        counter_write = 0;
        for i = 1:stack_len            
            image_merge_temp = uint16([image_dw(:,:,i) image_aw(:,:,i)]);            
            imwrite(image_merge_temp, save_path1, 'writemode', 'append');
            counter_write = counter_write + 1;
            waitbar(counter_write/stack_len);
        end
        close(h)
        msgbox('Registered Image Saved');
    case('Seperate')
            counter_write = 0;
        for i = 1:stack_len            
            counter_write = counter_write + 1; 
            image_aw_temp = uint16([image_aw(:,:,i)]);
            imwrite(image_aw_temp, save_path1, 'writemode', 'append');
            waitbar(counter_write/stack_len);
        end
        close(h)
        msgbox('Registered Image (b) Saved');

end



% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image_d = getappdata(handles.d_t_a_frames,'image_d');
image_a = getappdata(handles.d_t_a_frames,'image_a');
min_d = min(image_d(:));
[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*2.5 >=65536
    max_d = 65536;
else
    max_d = max_d_t *2.5;
end
figure(10)
raw_overlay = imfuse(image_d,image_a,'falsecolor','Scaling','joint','ColorChannels',[2 1 0]);
imshow(raw_overlay.*2,[min_d max_d])
title('Raw Image Overlay')




function don_thresh_picker_Callback(hObject, eventdata, handles)
% hObject    handle to don_thresh_picker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_thresh_picker as text
%        str2double(get(hObject,'String')) returns contents of don_thresh_picker as a double


% --- Executes during object creation, after setting all properties.
function don_thresh_picker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_thresh_picker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_thresh_picker_Callback(hObject, eventdata, handles)
% hObject    handle to accep_thresh_picker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_thresh_picker as text
%        str2double(get(hObject,'String')) returns contents of accep_thresh_picker as a double


% --- Executes during object creation, after setting all properties.
function accep_thresh_picker_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_thresh_picker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton47.
function pushbutton47_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image_d = getappdata(handles.d_t_a_frames,'image_d');
min_d = min(image_d(:));
[fig_d_c, fig_d_b] = imhist(image_d);
max_d_c = max(fig_d_c);
ind_max_c = find(fig_d_c == max_d_c);
max_d_t = ceil(fig_d_b(ind_max_c));
if max_d_t*2.5 >=65536
    max_d = 65536;
else
    max_d = max_d_t *2.5;
end
figure(11)
image_a_reg = getappdata(handles.image_register,'image_a_reg');
reg_overlay = imfuse(image_d,image_a_reg,'falsecolor','Scaling','joint','ColorChannels',[2 1 0]);
imshow(reg_overlay.*2,[min_d max_d])


% --- Executes on button press in batch_load.
function batch_load_Callback(hObject, eventdata, handles)
% hObject    handle to batch_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CAM
global CHAN
if ispc == 1
    seps = '\';
else
    seps = '/';
end
load('Variables\batch_parms.mat')
% Configure the GUI for batch processing
num_camera = str2num(batch_parameters{1});
if num_camera == 1
    set(handles.cam_1,'Value',1)
    CAM = 1;
else
    set(handles.cam_2,'Value',1)
    CAM = 2;
end

num_channels = str2num(batch_parameters{2});
if num_channels == 1
    set(handles.single_channel,'Value',1);
    CHAN = 1;
else 
    set(handles.dual_channel,'Value',1)
    CHAN = 2;
end
num_don_frame = str2num(batch_parameters{3});
set(handles.d_t_a_frames,'String',num2str(num_don_frame));
num_accep_frame = str2num(batch_parameters{4});
set(handles.d_t_a_frames1,'String', num2str(num_accep_frame));
type_reg_batch = batch_parameters{5};
setappdata(handles.batch_load,'reg_batch',type_reg_batch);
don_thresh = str2num(batch_parameters{6});
set(handles.don_thresh_picker,'String',num2str(don_thresh));
set(handles.don_sens, 'Value',don_thresh);
set(handles.don_sens_disp, 'String',num2str(don_thresh));
lock_ratio = str2num(batch_parameters{7});
set(handles.set_ratio,'String',num2str(lock_ratio));
set(handles.lock_ratio,'Value',1);
set(handles.radiobutton48,'Value',1);
set(handles.radiobutton38,'Value',1);
set(handles.radiobutton55,'Value',1);
set(handles.auto_trim_mov,'Value',1);
        folder = uigetdir();
        fileList = dir(fullfile(folder, '*.TIF'));
        path_img_t = fileList(1).folder; 
        fileList = natsortfiles(fileList);
        num_files = length(fileList); 
        counter_processing = 0; 
        if num_camera == 1
            disp(['Total Files = ','  ',num2str(num_files)])
             for     k = 1:1:num_files
                counter_processing = counter_processing +1;
                disp(['Processing File number  ', num2str(counter_processing)])
                file_name_t = fileList(k).name;
                fname = [path_img_t,seps,file_name_t];
                [path_img,file_name] = fileparts(fname);                
                if ispc == 1
                save('Variables\batch_file.mat','fname','path_img','file_name','type_reg_batch');
                elseif ismac == 1
                save('Variables/batch_file.mat','fname','path_img','file_name','type_reg_batch');    
                end
                load_image_Callback(handles.load_image, eventdata, handles)
            end

        elseif num_camera == 2
            disp(['Total Files = ','  ',num2str(num_files/2)])
             for     k = 1:2:num_files
                counter_processing = counter_processing +1;
                disp(['Processing File number  ', num2str(counter_processing)])
                file_name_t = fileList(k).name;
                fname = [path_img_t,seps,file_name_t];
                [path_img,file_name] = fileparts(fname);                
                if ispc == 1
                save('Variables\batch_file.mat','fname','path_img','file_name','type_reg_batch');
                elseif ismac == 1
                save('Variables/batch_file.mat','fname','path_img','file_name','type_reg_batch');    
                end
                load_image_Callback(handles.load_image, eventdata, handles)
             end
        end
 msgbox('Batch Extraction Completed')

% --- Executes on button press in qik_guide5.
function qik_guide5_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','Batch Load Function',...
         '1) Disable Reload',...
         '2) First pick a movie in the folder with Load Image ',...
         '3) Set the Full Auto Settings to (Batch Extract) ',...
         '4) Name the reg: reg_batch', ...
         '5) Set Thresh Don & Accep',...
         '6) Set BCKG to Auto',...
         '7) Set Auto Overlay to Auto',...
         '8) Choose Batch Extract'},...
        'KIT: Help');


% --- Executes on button press in auto_trim_mov.
function auto_trim_mov_Callback(hObject, eventdata, handles)
% hObject    handle to auto_trim_mov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_trim_mov



function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trim_start_frame_Callback(hObject, eventdata, handles)
% hObject    handle to trim_start_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trim_start_frame as text
%        str2double(get(hObject,'String')) returns contents of trim_start_frame as a double


% --- Executes during object creation, after setting all properties.
function trim_start_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trim_start_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trim_total_frames_Callback(hObject, eventdata, handles)
% hObject    handle to trim_total_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trim_total_frames as text
%        str2double(get(hObject,'String')) returns contents of trim_total_frames as a double


% --- Executes during object creation, after setting all properties.
function trim_total_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trim_total_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trim_end_frame_Callback(hObject, eventdata, handles)
% hObject    handle to trim_end_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trim_end_frame as text
%        str2double(get(hObject,'String')) returns contents of trim_end_frame as a double


% --- Executes during object creation, after setting all properties.
function trim_end_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trim_end_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in auto_sum_frames.
function auto_sum_frames_Callback(hObject, eventdata, handles)
% hObject    handle to auto_sum_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_sum_frames

    


% --- Executes on button press in auto_trim.
function auto_trim_Callback(hObject, eventdata, handles)
% hObject    handle to auto_trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_trim



function disp_trimmed_frames_Callback(hObject, eventdata, handles)
% hObject    handle to disp_trimmed_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_trimmed_frames as text
%        str2double(get(hObject,'String')) returns contents of disp_trimmed_frames as a double


% --- Executes during object creation, after setting all properties.
function disp_trimmed_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_trimmed_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function eval_trim_Callback(hObject, eventdata, handles)
% hObject    handle to eval_trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of eval_trim as text
%        str2double(get(hObject,'String')) returns contents of eval_trim as a double


% --- Executes during object creation, after setting all properties.
function eval_trim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eval_trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in disp_trim_start.
function disp_trim_start_Callback(hObject, eventdata, handles)
% hObject    handle to disp_trim_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disp_trim_start


% --- Executes on button press in set_batch.
function set_batch_Callback(hObject, eventdata, handles)
% hObject    handle to set_batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ispc == 1
    seps = '\';
else
    seps = '/';
end

type_batch = get(handles.popupmenu3,'Value');
% 1 = set parameters

switch type_batch
    case{1}
        batch_parameters = inputdlg({'#Cameras (1,2)', '#Channels (1,2)','#Donor Frames (1,100)','#Acceptor Frames (1,100)',...
            'Registration (Auto,Apply)','Donor Threshold (500-10000)','Lock Ratio (0.1-1)'},...
              'Set', [1 25; 1 25; 1 25; 1 25; 1 25; 1 25;1 25]);
    case{2}
        
end

if ispc == 1
save('Variables\batch_parms.mat','batch_parameters');
elseif ismac == 1
save('Variables/batch_parms.mat','batch_parameters');
end

get_reg_file = batch_parameters{5};
switch get_reg_file
    case{'Apply'}        
        get_reg_t = questdlg('Select Registration File', ...
                 'Reg File','Yes','No');
                switch get_reg_t
                 case{'Yes'}
                    reg_file = uigetfile('.mat', 'Select reg_coordin file');
                end
        if ispc == 1
           save('Variables\batch_cmd.mat','reg_file');
        elseif ismac == 1
           save('Variables/batch_cmd.mat','reg_file');
        end
end
msgbox('The Parameters for Batch Extraction is SAVED')


% --- Executes on button press in pushbutton51.
function pushbutton51_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function max_iter_psf_Callback(hObject, eventdata, handles)
% hObject    handle to max_iter_psf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_iter_psf as text
%        str2double(get(hObject,'String')) returns contents of max_iter_psf as a double


% --- Executes during object creation, after setting all properties.
function max_iter_psf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_iter_psf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in disp_converg.
function disp_converg_Callback(hObject, eventdata, handles)
% hObject    handle to disp_converg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disp_converg


% --- Executes on button press in abs_bckg.
function abs_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to abs_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of abs_bckg


% --- Executes during object creation, after setting all properties.
function extract_donor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to extract_donor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in lock_ratio.
function lock_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to lock_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lock_ratio



function set_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to set_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_ratio as text
%        str2double(get(hObject,'String')) returns contents of set_ratio as a double


% --- Executes during object creation, after setting all properties.
function set_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function batch_load_CreateFcn(hObject, eventdata, handles)
% hObject    handle to batch_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
