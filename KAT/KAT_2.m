function varargout = KAT_2(varargin)
% KAT_2 MATLAB code for KAT_2.fig
%      KAT_2, by itself, creates a new KAT_2 or raises the existing
%      singleton*.
%
%      H = KAT_2 returns the handle to a new KAT_2 or the handle to
%      the existing singleton
%
%      KAT_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_2.M with the given input arguments.
%
%      KAT_2('Property','Value',...) creates a new KAT_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KAT_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KAT_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Edit the above text to modify the response to help KAT_2

% Last Modified by GUIDE v2.5 24-Feb-2024 22:19:36



% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KAT_2_OpeningFcn, ...
                   'gui_OutputFcn',  @KAT_2_OutputFcn, ...
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


% --- Executes just before KAT_2 is made visible.
function KAT_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KAT_2 (see VARARGIN)
clear global
global INIT
INIT = 0;
global t
t = 0;
global butt_lim
butt_lim = 0;
global NAME_FILTER
NAME_FILTER = 'rlowess';
del_merged = exist('Traces_to_analyze.mat');
if del_merged == 2
    delete('Traces_to_analyze.mat')
end
%You can choose between these models
% 'moving'
% 'lowess'
% 'loess'
% 'sgolay'
% 'rlowess'
% 'rloess'
global Number
Number = 0;
global FIL
FIL = 0;
global num_heat 
num_heat = 1;
global don_sel
global accep_sel
global time_axis
set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
set(handles.axes8,'XTick',[]);
% set(handles.axes14,'XTick',[]);

% Choose default command line output for KAT_2
handles.output = hObject;
% sliderstep = ([1/1000, 1/1000]);
% set(handles.slider_don_intens, 'Min',1);
% set(handles.slider_don_intens, 'Max', 1001);

% set(handles.slider_don_intens, 'Value', 20);
% set(handles.slider_don_intens, 'SliderStep', sliderstep);
% set(handles.disp_don_hist, 'String',num2str(20));
% 
% set(handles.slider_accep_intens, 'Min',1);
% set(handles.slider_accep_intens, 'Max', 1001);
% set(handles.slider_accep_intens, 'Value', 20);
% set(handles.slider_accep_intens, 'SliderStep', sliderstep);
% set(handles.disp_accep_hist, 'String',num2str(20));

% set(handles.slider_tot_intens, 'Min',1);
% set(handles.slider_tot_intens, 'Max', 1001);
% set(handles.slider_tot_intens, 'Value', 20);
% set(handles.slider_tot_intens, 'SliderStep', sliderstep);
% set(handles.disp_tot_hist, 'String',num2str(20));

set(handles.gamma_corr_val, 'String', num2str(1));
% set(handles.lag_time, 'String', num2str(1));
% set(handles.edit9,'String',num2str(1))
% set(handles.edit10,'String',num2str(1))

% sliderstep = ([1/20000000, 1/20000000]);
% set(handles.slider6, 'Min',-10000000);
% set(handles.slider6, 'Max', 10000000);
% set(handles.slider6, 'SliderStep', sliderstep);
% set(handles.slider6, 'Value', 0);
global aaah_old
aaah_old = 0;
global N_STD1
global N_STD2
N_STD1 = 1;
N_STD2 = 1;

% Set the various default values for the analyses
set(handles.file_traces, 'String', num2str(1));
% filtering parameters for automated trace filtering
set(handles.don_trace_thresh,'String', num2str(500));
set(handles.accep_trace_thresh,'String',num2str(500));
set(handles.filt_win,'String', num2str(20));
set(handles.filt_f_back,'String',num2str(4));
set(handles.don_f_ratio,'String',num2str(0));
set(handles.accep_f_ratio,'String',num2str(0));
set(handles.don_snr1,'String',num2str(0.1));
set(handles.don_snr2,'String',num2str(0.1));
set(handles.acp_snr2,'String',num2str(0.1));
set(handles.acp_snr1,'String',num2str(0.1));
set(handles.tot_snr1,'String',num2str(2));
% set(handles.fret_res,'String', num2str(0.1));
set(handles.min_fret,'String', num2str(0));
setappdata(handles.subgrp_1,'temp_sublist1', []);
setappdata(handles.subgrp_2,'temp_sublist2', []);
setappdata(handles.subgrp_3,'temp_sublist3', []);
 
addpath([pwd '\KAT\STaSI_GUI'])
addpath([pwd '\STaSI_GUI'])

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KAT_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = KAT_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in load_traces.
function load_traces_Callback(hObject, eventdata, handles)
% hObject    handle to load_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global don_tot_hist
global accep_tot_hist
global fname
global file_frames
global don_tot_trace 
global don_bckg_trace 
global don_spec_trace 
global time_axis 
global AXR
AXR = time_axis;
global accep_tot_trace
global accep_bckg_trace
global accep_spec_trace
global Picture_d
global Picture_a
global don_sel
global accep_sel
global Mode1
global proc_trace_val

if ispc == 1
    seps = '\';
else
    seps = '/';
end

val_run_val_man = 0;
setappdata(handles.load_traces,'run_value_man',val_run_val_man);
proc_trace_val = get(handles.checkbox1,'Value');
load_folder_sel = get(handles.load_folder,'Value');
if load_folder_sel == 1
    file_frames = 2;
end

if file_frames > 1
  ALL_NAME =  cell(1,file_frames);
  if load_folder_sel == 1
      folder = uigetdir();
      fileList = dir(fullfile(folder, '*.mat'));
      num_files = length(fileList);
      path_trace= fileList(1).folder;
      addpath(path_trace)
      mg = msgbox('Compiling Folder of Traces');
      
      for k = 1:num_files
          file_name_t = fileList(k).name;
          path_img_t = fileList(k).folder;
          fname = [path_img_t,seps,file_name_t];
          [path_trace,file_name] = fileparts(fname);
          ALL_NAME{k} = file_name;
      end      
  else
    for i = 1:file_frames
     [fname, path_trace] = uigetfile();
     ALL_NAME{i} = fname;
    end
    mg = msgbox('Compiling Selected Traces');
  end

  set(handles.listbox6,'String',ALL_NAME);
  Traces_merger_together(ALL_NAME{:})
  fname = 'Traces_to_analyze.mat';
  [~,file_name] = fileparts(fname);
  addpath(path_trace);
  setappdata(handles.load_traces, 'path_trace', path_trace);
  load(file_name)
  setappdata(handles.load_traces, 'file_name', file_name);
  setappdata(handles.load_traces, 'Mode1', Mode1);
  close(mg)
else
    [fname, path_trace] = uigetfile(); 
    [~,file_name] = fileparts(fname);
    addpath(path_trace);
    set(handles.listbox6, 'String',file_name);
    setappdata(handles.load_traces, 'path_trace', path_trace);
    load(file_name)
    setappdata(handles.load_traces, 'file_name', file_name);
    setappdata(handles.load_traces, 'Mode1', Mode1);
end
set(handles.disp_folder,'String',path_trace);
[size1, size2] = size(don_spec_trace);
if exist('Mode1','var')
else
    Mode1 = 'other';
end

if strcmp(Mode1 , 'onecolor')
    accep_spec_trace = zeros(size1, size2);
end

types_traces_t = get(handles.type_traces, 'SelectedObject');
types_traces = get(types_traces_t, 'String');
switch types_traces
    case {'Specific'}
        trace_type = 1;
    case {'Total'}
        trace_type = 2;
    case {'All Total'}
        trace_type = 3;
end  
%calculate radii for 
radii_ext_t = size(centers_ext);
radii_ext = ones(radii_ext_t(1),1);
axes(handles.axes24)
viscircles(centers_ext, radii_ext);
y_lim_t = max(centers_ext(:,1));
hold off
if y_lim_t > 900
    y_lim = 1012;
elseif y_lim_t >450
    y_lim = 512;
elseif y_lim_t >200
    y_lim = 256;
elseif y_lim_t >40
    y_lim = 64;
elseif y_lim_t >20
    y_lim = 32;
end      
xlim([1 y_lim]);
ylim([1 y_lim]);
setappdata(handles.load_traces,'centers_ext', centers_ext);
setappdata(handles.load_traces,'radii_ext', radii_ext);
setappdata(handles.load_traces,'trace_type',trace_type);
% Sort the type of data present
list_data = who;
don_p = sum(strcmp('don_spec_trace',list_data));
accep_p = sum(strcmp('accep_spec_trace',list_data));
setappdata(handles.load_traces, 'time_axis', time_axis);
time_ints = time_axis(2)-time_axis(1);
set(handles.disp_time_int,'String',num2str(time_ints*1000));
% determine operating mode
% donor trace filtering only or FRET
if don_p + accep_p == 2
    set(handles.disp_oper, 'String', 'FRET Traces')
    oper_mode = 2;
    setappdata(handles.load_traces, 'oper_mode',oper_mode);
end
if strcmp(Mode1,'onecolor')
    set(handles.disp_oper, 'String', 'Donor Traces')
    oper_mode = 1;    
    setappdata(handles.load_traces, 'oper_mode', oper_mode);
end

%% Set time axis slider
% READ THE TIME AXIS FILE AND DETERMINE THE LENGTH and increment
if oper_mode == 2
    slider_time_max = max(time_axis);
    slider_increment = time_axis(2)-time_axis(1);
    slider_time_min = min(time_axis);
    sliderstep2 = ([slider_increment/slider_time_max, slider_increment/slider_time_max]);
end

switch oper_mode
    case (1)
        [~, num_traces] = size(don_spec_trace);
        set(handles.raw_trace_total,'String', num2str(num_traces));
        num_list_trace = num2str ((1:num_traces)');
        set(handles.list_traces, 'String', num_list_trace);
        % Calculate histogram of intensities
        counter = 0;
        for i = 1:num_traces
            counter = counter + 1;
          %  don_tot_hist(:,counter) = max(don_spec_trace(i));
          if trace_type == 1
            don_tot_hist(:,counter) = mean(don_spec_trace(1:10,i));
          elseif trace_type >1
            don_tot_hist(:,counter) = mean(don_tot_trace(1:10,i));  
          end
        end
        setappdata(handles.load_traces, 'don_tot_hist', don_tot_hist);
%         axes(handles.axes2);
%         histogram(don_tot_hist, 20);
%         title('CPS Donor')
 
    case (2)
        [trace_length, num_traces] = size(don_spec_trace);
        set(handles.raw_trace_total,'String', num2str(num_traces));
        num_list_trace = num2str ((1:num_traces)');
        set(handles.list_traces, 'String', num_list_trace);
        % Calculate histogram of intensities
        bckg_index = trace_length:-1:trace_length-10;
        counter = 0;
        for i = 1:num_traces
            counter = counter + 1;
            if trace_type == 1
            don_tot_hist(:,counter) = mean(don_spec_trace(1:10,i));
            don_bckg_hist(:,counter) = don_spec_trace(bckg_index,i);
            
            elseif trace_type >1
            don_tot_hist(:,counter) = mean(don_tot_trace(1:10,i));  
            don_bckg_hist(:,counter) = don_tot_trace(bckg_index,i);
            end
            
            if strcmp(Mode1 , 'onecolor')
              accep_tot_hist(:,counter) = 0;
              if trace_type == 1
                tot_tot_hist(:,counter) = (mean(don_spec_trace(1:10,i)) );
              elseif trace_type > 1
                tot_tot_hist(:,counter) = (mean(don_tot_trace(1:10,i)) );  
              end
              
            else
                if trace_type ==1
                    accep_tot_hist(:,counter) = mean(accep_spec_trace(1:10,i));
                    accep_bckg_hist(:,counter) = accep_spec_trace(bckg_index,i);
                    tot_tot_hist(:,counter) = (mean(don_spec_trace(1:10,i)) + mean(accep_spec_trace(1:10,i)));
                elseif trace_type > 1
                    accep_tot_hist(:,counter) = mean(accep_tot_trace(1:10,i));
                    accep_bckg_hist(:,counter) = accep_tot_trace(bckg_index,i);
                    tot_tot_hist(:,counter) = (mean(don_tot_trace(1:10,i)) + mean(accep_tot_trace(1:10,i)));
                end
            end
        end
        setappdata(handles.load_traces, 'don_tot_hist', don_tot_hist);         
        setappdata(handles.load_traces, 'accep_tot_hist', accep_tot_hist);   
        setappdata(handles.load_traces, 'don_bckg_hist',don_bckg_hist);
        setappdata(handles.load_traces, 'accep_bckg_hist',accep_bckg_hist);
        %----------------------        
        setappdata(handles.load_traces, 'tot_tot_hist', tot_tot_hist); 
%         axes(handles.axes2);
%         h = histogram(don_tot_hist,'FaceColor','g');
%         axes(handles.axes22)
%         histogram(don_bckg_hist)
%         if ~ strcmp(Mode1 , 'onecolor')
%         axes(handles.axes4)
%         h = histogram(accep_tot_hist,'FaceColor','r');
%         axes(handles.axes23)
%         histogram(accep_bckg_hist)
%         end        
end   
% Create the heat maps
% fret_res = str2num(get(handles.fret_res,'String'));
if trace_type == 1
    max_intens_d = median(max(don_spec_trace));
if max_intens_d >= 1000    
    max_intens_d = roundn(max_intens_d,3)*1.5;
elseif max_intens_d >= 100    
    max_intens_d = roundn(max_intens_d,2)*1.5;
end
max_intens_a = median(max(accep_spec_trace));
if max_intens_a >=1000
    max_intens_a = roundn(max_intens_a,3)*1.5;
elseif max_intens_a >= 100
    max_intens_a = roundn(max_intens_a,2)*1.5;
end
min_intens_d = min(min(don_spec_trace));
min_intens_a = min(min(accep_spec_trace));
        if  min_intens_d < 0
            min_intens_d = 0;
        end
        if min_intens_a <0
           min_intens_a = 0;
        end
elseif trace_type > 1
max_intens_d = median(max(don_tot_trace));
if max_intens_d >= 1000    
    max_intens_d = roundn(max_intens_d,3)*1.5;
elseif max_intens_d >= 100    
    max_intens_d = roundn(max_intens_d,2);
end
max_intens_a = median(max(accep_tot_trace));
if max_intens_a >=1000
    max_intens_a = roundn(max_intens_a,3)*1.5;
elseif max_intens_a >= 100
    max_intens_a = roundn(max_intens_a,2);
end
min_intens_d = min(min(don_tot_trace));
min_intens_a = min(min(accep_tot_trace));
        if  min_intens_d < 0
            min_intens_d = 0;
        end
        if min_intens_a <0
           min_intens_a = 0;
        end
end
Index1 = 1;
Index2 = length(time_axis);
[time_bins,num_traces] = size(don_spec_trace);
counter_inten = 0;
if trace_type == 1
    don_heat_trace = don_spec_trace;
    accep_heat_trace = accep_spec_trace;
elseif trace_type > 1
    don_heat_trace = don_tot_trace;
    accep_heat_trace = accep_tot_trace;
end

for k = 1:time_bins
    counter_inten = counter_inten + 1;
    edges_intens_d = linspace(min_intens_d, max_intens_d, 10); 
    [c,d] = hist(don_heat_trace(k,:),edges_intens_d);
    c_h_t(counter_inten,:) = c;
    if oper_mode == 2
        edges_intens_a = linspace(min_intens_a, max_intens_a, 10);    
        [e,f] = hist(accep_heat_trace(k,:),edges_intens_a);    
        e_h_t(counter_inten,:) = e;
    end
end

[a1,~] = size((c_h_t)');
re_hist = c_h_t';
counter2 = 0;
        for i = 1:a1
            counter2 = counter2+1;
            bar_count(counter2,:) = sum(re_hist(i,:));
        end
mol_tot = sum(c_h_t(1,:));
% axes(handles.axes6)
% contourf(time_axis(Index1:Index2), edges_intens_d, c_h_t');
% xlabel('Time (s)')
% ylabel ('DONOR','FontWeight','bold','Color','g')
% title (['Total number of molecules = ',num2str(mol_tot)]);
if oper_mode == 2
% axes(handles.axes21)handles.overlay_type
% contourf(time_axis(Index1:Index2), edges_intens_a, e_h_t');handles.load_traces
% xlabel('Time (s)')
% ylabel ('ACCEP','FontWeight','bold','Color','r')
end
%% Set the various outputs
% set(handles.axes2,'fontsize',6);
% set(handles.axes4,'fontsize',6);
% set(handles.axes6,'fontsize',6);
set(handles.axes13,'fontsize',6);
setappdata(handles.load_traces, 'don_tot_trace', don_tot_trace);
setappdata(handles.load_traces, 'don_bckg_trace', don_bckg_trace);
setappdata(handles.load_traces, 'accep_tot_trace', accep_tot_trace);
setappdata(handles.load_traces, 'accep_bckg_trace', accep_bckg_trace);
setappdata(handles.load_traces, 'don_spec_trace', don_spec_trace);
setappdata(handles.load_traces, 'time_axis', time_axis);
setappdata(handles.load_traces, 'accep_spec_trace', accep_spec_trace);
setappdata(handles.load_traces, 'Picture_d', Picture_d);
setappdata(handles.load_traces, 'Picture_a', Picture_a);
setappdata(handles.load_traces, 'centers_ext', centers_ext);
setappdata(handles.filter_status,'filt_status',0);

if proc_trace_val == 1
    setappdata(handles.load_traces,'blch_don', blch_don);
    if strcmp(Mode1,'Multicolor')
    setappdata(handles.load_traces,'blch_accep', blch_accep);
    setappdata(handles.load_traces,'blch_fret', blch_fret);
    setappdata(handles.load_traces,'blch_type', blch_type);
    end
    sel_all_Callback(hObject, eventdata, handles)
    overlay_popmenu_Callback(hObject, eventdata, handles)
end

% --- Executes on selection change in list_traces.
function list_traces_Callback(hObject, eventdata, handles)
% hObject    handle to list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_traces contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_traces
global p_start
global p_end
global Picture_a
global Picture_d
global index_GGG
global time_axis 
global Mode1
global trace_type
img_disp_val = get(handles.radiobutton13,'Value');
types_traces_t = get(handles.type_traces, 'SelectedObject');
types_traces = get(types_traces_t, 'String');
switch types_traces
    case {'Specific'}
        trace_type = 1;
    case {'Total'}
        trace_type = 2;
    case {'All Total'}
        trace_type = 3;
end  
centers_ext = getappdata(handles.load_traces,'centers_ext');
radii_ext = getappdata(handles.load_traces,'radii_ext');
oper_mode = getappdata(handles.load_traces, 'oper_mode');
index = get(handles.list_traces,'Value');
set(handles.trace_num,'String',num2str(index));
set(handles.disp_status2,'String','Loaded');
if img_disp_val == 1
axes(handles.axes24)
cla
sel_center = centers_ext(index,:);
sel_radii = 4;
viscircles(centers_ext,radii_ext);
viscircles(sel_center, sel_radii, 'color', 'b');
hold off
end
axes(handles.axes19)
cla
% axes(handles.axes20)
cla
index_GGG = index;
if img_disp_val == 1
axes(handles.axes17);
imagesc(Picture_d{index,1});
hold on
viscircles(Picture_d{index,2},Picture_d{index,3},'Color','k','LineWidth',1);
axes(handles.axes18);
imagesc(Picture_a{index,1});
hold on
viscircles(Picture_a{index,2},Picture_a{index,3},'Color','k','LineWidth',1);
end
switch oper_mode
    %% One color plot mode
    case (1)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
% [~, num_traces] = size(don_tot_trace);
axes(handles.axes1);
if trace_type ==1
plot(time_axis, don_spec_trace(:,index),'g');
elseif trace_type == 2
plot(time_axis, don_tot_trace(:,index),'g');    
elseif trace_type == 3
plot(time_axis, don_tot_trace(:,index),'g', time_axis,don_bckg_trace(:,index),'k');    
end
ylabel('Donor')
ylim([0 +inf]);
if strcmp(Mode1 , 'onecolor')
axes(handles.axes8);
if trace_type == 1
    don_sel = don_spec_trace(:,index);  
elseif trace_type > 1
    don_sel = don_tot_trace(:,index);
end
plot(time_axis,don_sel./max(don_sel),'k');
% else
% plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
ylim([0 +inf]);
    %% Two color plot mode
    case (2)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
%-----------------------------
%-----------------------------
[size1, size2] = size(don_spec_trace);
if exist('Mode1','var')
else
    Mode1 = 'multicolor';
end
if strcmp(Mode1 , 'onecolor')
    accep_spec_trace = zeros(size1, size2);
end

if trace_type == 1
    don_sel = don_spec_trace(:,index); 
    accep_sel = accep_spec_trace(:,index);
elseif trace_type > 1
    don_sel = don_tot_trace(:,index);
    accep_sel = accep_tot_trace(:,index);
end
setappdata(handles.list_traces, 'accep_sel', accep_sel);
setappdata(handles.list_traces, 'don_sel',don_sel);
tot_sel = don_sel + accep_sel;
% [~, num_traces] = size(don_tot_trace);
axes(handles.axes1);
if trace_type<=2
    plot(time_axis, don_sel,'g');
elseif trace_type >2
    plot(time_axis, don_sel,'g', time_axis,don_bckg_trace(:,index),'k');
end
ylabel('Donor')
ylim([0 +inf]);
axes(handles.axes19)
plot(time_axis, tot_sel,'b')
axes(handles.axes7);
if trace_type <= 2
    plot(time_axis, accep_sel,'r');
elseif trace_type >2
    plot(time_axis, accep_sel,'r',time_axis,accep_bckg_trace(:,index),'k');
end
ylabel ('Acceptor')
ylim([0 +inf]);
max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;
axes(handles.axes8)
if strcmp(Mode1 , 'onecolor')
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
ylim([0 +inf]);
% pass to the FRET program donor trace, acceptor trace and gamma factor
gamma = str2num(get(handles.gamma_corr_val,'String'));
% [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;
%-----------------------------
axes(handles.axes9);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET')
ylim([0 1]);
gamma = str2num(get(handles.gamma_corr_val,'String'));
don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
time_axis = getappdata(handles.load_traces, 'time_axis');
counter_fret = 0;
for i = 1:length(don_sel)
    counter_fret = counter_fret + 1;
    denom_fret = accep_sel (i) + (gamma.*don_sel(i));
    fret_calc_inc = accep_sel(i)./denom_fret;
    fret_sel_hist(:,counter_fret) = fret_calc_inc;
end
axes(handles.axes13)
histogram(fret_sel_hist,linspace(0,1,20))
ylabel ('occurence');
xlabel ('FRET');

end
global butt_lim
if butt_lim == 1
set(handles.axes1,'XLim',[p_start,p_end]); 
set(handles.axes7,'XLim',[p_start,p_end]); 
set(handles.axes8,'XLim',[p_start,p_end]); 
% set(handles.axes14,'XLim',[p_start,p_end]); 
set(handles.axes9,'XLim',[p_start,p_end]); 
end

set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
if strcmp(Mode1 , 'onecolor')
    set(handles.axes8,'FontWeight','bold')
else
set(handles.axes8,'XTick',[]);
end
% set(handles.axes14,'XTick',[]);
set(handles.axes1,'fontsize',8);
set(handles.axes7,'fontsize',8);
set(handles.axes8,'fontsize',8);
% set(handles.axes14,'fontsize',6);
set(handles.axes9,'fontsize',8);
set(handles.axes13,'fontsize',6);
set(handles.axes9,'FontWeight','bold')
% no axes on the pics
set(handles.axes17,'XTick',[]);
set(handles.axes17,'YTick',[]);
set(handles.axes18,'XTick',[]);
set(handles.axes18,'YTick',[]);
global AXR
AXR = time_axis;
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function list_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider_don_intens_Callback(hObject, eventdata, handles)
% hObject    handle to slider_don_intens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% axes(handles.axes2);
% don_bins = (get(handles.slider_don_intens, 'Value'));
% set(handles.disp_don_hist, 'String',don_bins);
% don_tot_hist = getappdata(handles.load_traces, 'don_tot_hist');
% histogram(don_tot_hist, don_bins);

% --- Executes during object creation, after setting all properties.
function slider_don_intens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_don_intens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function disp_don_hist_Callback(hObject, eventdata, handles)
% hObject    handle to disp_don_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_don_hist as text
%     

% --- Executes during object creation, after setting all properties.
function disp_don_hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_don_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider_accep_intens_Callback(hObject, eventdata, handles)
% hObject    handle to slider_accep_intens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
if ~ strcmp(Mode1 , 'onecolor')
axes(handles.axes4);
accep_bins = (get(handles.slider_accep_intens, 'Value'));
set(handles.disp_accep_hist, 'String', accep_bins);
accep_tot_hist = getappdata(handles.load_traces, 'accep_tot_hist');
histogram(accep_tot_hist, accep_bins);
end

% --- Executes during object creation, after setting all properties.
function slider_accep_intens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_accep_intens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function disp_accep_hist_Callback(hObject, eventdata, handles)
% hObject    handle to disp_accep_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_accep_hist as text
%        str2double(get(hObject,'String')) returns contents of disp_accep_hist as a double

% --- Executes during object creation, after setting all properties.
function disp_accep_hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_accep_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider_tot_intens_Callback(hObject, eventdata, handles)
% hObject    handle to slider_tot_intens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% axes(handles.axes6)
% tot_bins = get(handles.slider_tot_intens, 'Value');
% set(handles.disp_tot_hist, 'String', tot_bins);
% tot_tot_hist = getappdata(handles.load_traces, 'tot_tot_hist');
% histogram(tot_tot_hist, tot_bins);   

% --- Executes during object creation, after setting all properties.
function slider_tot_intens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_tot_intens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function disp_tot_hist_Callback(hObject, eventdata, handles)
% hObject    handle to disp_tot_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_tot_hist as text
%        str2double(get(hObject,'String')) returns contents of disp_tot_hist as a double

% --- Executes during object creation, after setting all properties.
function disp_tot_hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_tot_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in list_filter.
function list_filter_Callback(hObject, eventdata, handles)
% hObject    handle to list_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_filter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_filter


global don_bins
global accep_bins
global don_tot_hist
global accep_tot_hist
global inde
global inde_stop

 
global don_spec_trace 

global accep_spec_trace
% Value 1 = donor bleaching
% Value 2 = Acceptor bleaching
% Value 3 = Donor+Acceptor bleaching
% Value 4 = Anti-correlated event
% Value 5 = Donor+Anti corr

popup = get(handles.list_filter,'Value');

n_donor1 = size(don_spec_trace,1);
n_accept1 = size(accep_spec_trace,1);
n_donor2 = size(don_spec_trace,2);
n_accept2 = size(accep_spec_trace,2);


if popup == 1
    inde = [];
    for j = 1:n_donor2
        
    max_don = max(don_spec_trace(:,j));
    for i = n_donor1:-1:1
    
        if don_spec_trace(i,j) > 0.01*max_don  
            if  i+1 < n_donor1 - 10
                inde = [inde; j];
                break
            else
                break
            end
        end

    end
    
    end
end

    
if popup == 2
    
    inde = [];
    inde_stop = [];
    for j = 1:n_accept2
    max_acc = max(accep_spec_trace(:,j));
    for i = n_accept1:-1:1  
        %change percentage goes below this line
        if accep_spec_trace(i,j) > 0.1*max_acc   
            if  i+1< n_accept1 - 10
                inde = [inde; j];
                inde_stop = [inde_stop; i];
                break
            else
                break
            end
        end
        
    end  
    end
end
    
if popup == 3
    
    inde1 = [];
    inde2 = [];
    for j = 1:n_donor2
    max_don = max(don_spec_trace(:,j));
    for i = n_donor1:-1:1  
        
        if don_spec_trace(i,j) > 0.01*max_don  
            if  i+1 < n_donor1 - 10
                inde = [inde; j];
                break
            else
                break
            end
        end
        
    end 
    end
    
    for j = 1:n_accept2
    max_acc = max(accep_spec_trace(:,j));
    for i = n_accept1:-1:1    
        
        if accep_spec_trace(i,j) > 0.01*max_acc   
            if  i+1< n_accept1 - 10
                inde = [inde; j];
                break
            else
                break
            end
        end
        
    end
    end
   inde = intersect(inde1,inde2);
end







[~, num_traces] = size(don_spec_trace);
set(handles.raw_trace_total,'String', num2str(num_traces));
num_list_trace = num2str ((1:num_traces)');
set(handles.list_traces, 'String', num_list_trace);



setappdata(handles.load_traces, 'don_tot_hist', don_tot_hist);
setappdata(handles.load_traces, 'accep_tot_hist', accep_tot_hist);
%----------------------

%setappdata(handles.load_traces, 'tot_tot_hist', tot_tot_hist);
don_bins = get(handles.slider_don_intens, 'Value');
accep_bins = get(handles.slider_accep_intens, 'Value');

global Complete_SET
global INIT
INIT = 1;


C = inde;

Complete_SET = C;
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';
num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
num_list_sel_trace = num2str((sel_trace_sub)');
set(handles.sel_list_traces, 'String', num_list_sel_trace);






% --- Executes during object creation, after setting all properties.
function list_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function raw_trace_total_Callback(hObject, eventdata, handles)
% hObject    handle to raw_trace_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of raw_trace_total as text
%        str2double(get(hObject,'String')) returns contents of raw_trace_total as a double

% --- Executes during object creation, after setting all properties.
function raw_trace_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to raw_trace_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function disp_oper_Callback(hObject, eventdata, handles)
% hObject    handle to disp_oper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_oper as text
%        str2double(get(hObject,'String')) returns contents of disp_oper as a double

% --- Executes during object creation, after setting all properties.
function disp_oper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_oper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function gamma_corr_val_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_corr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_corr_val as text
%        str2double(get(hObject,'String')) returns contents of gamma_corr_val as a double

% --- Executes during object creation, after setting all properties.
function gamma_corr_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_corr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in gamma_corr.
function gamma_corr_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_corr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kat_gamma;


% --- Executes on button press in heat_map_sel.
function heat_map_sel_Callback(hObject, eventdata, handles)
% hObject    handle to heat_map_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TR
global Mode1
% global don_tot_trace
% global don_sel_heat
	sel_trace_heat = getappdata(handles.load_traces,'sel_trace_sub');    
    file_name = getappdata(handles.load_traces, 'file_name');
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
    fret_res = str2num(get(handles.fret_res,'String'));
    load(file_name);
    counter_sel_heat = 0;   
    filtered_status = getappdata(handles.filter_status,'filt_status');
    % Initialise the 
    if filtered_status == 1
         fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
    end
    
 if strcmp(Mode1,'onecolor')    
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat(:,counter_sel_heat) = don_spec_trace(:,sel_trace_heat(i)); 
    end
 else
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat = don_spec_trace(:,sel_trace_heat(i));   
        accep_sel_heat = accep_spec_trace(:,sel_trace_heat(i));
        % [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
        denom_fret_heat = accep_sel_heat + (gamma.*don_sel_heat);
        if filtered_status == 1
            blch_cut = fret_blchpoint(i);
            blch_diff = length(don_sel_heat)-blch_cut;
            fret_trace_heat_ttt = accep_sel_heat./denom_fret_heat;
            fret_trace_heat_tt = fret_trace_heat_ttt(1:blch_cut);
            fret_diff = (zeros(blch_diff,1));
            fret_trace_heat_t = vertcat(fret_trace_heat_tt,fret_diff);            
        else 
            fret_trace_heat_t = accep_sel_heat./denom_fret_heat;
        end
        fret_trace_heat(:,counter_sel_heat) = fret_trace_heat_t;
        
        
    end
 end
     counter = 0;
 if strcmp(Mode1,'onecolor') 
    for i = 1: length(sel_trace_heat)
       counter = counter + 1;
       don_tot_trace_norm(:,i) = don_sel_heat(:,i)./max(don_sel_heat(:,i));
    end
 end
 [time_bins,num_traces] = size(don_sel_heat);
    
TR = 2;

    if strcmp(Mode1,'onecolor')
    gen_heat_map(don_tot_trace_norm, time_axis,fret_res)
    else
    gen_heat_map(fret_trace_heat, time_axis,fret_res)
    end



% --- Executes on button press in heat_map_all.
function heat_map_all_Callback(hObject, eventdata, handles)
% hObject    handle to heat_map_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TR
    file_name = getappdata(handles.load_traces, 'file_name');
    fret_res = str2num(get(handles.fret_res,'String'));
    load(file_name);
    [~, num_traces] = size(don_spec_trace);
    counter_all_heat = 0;    
    for i = 1:num_traces
        counter_all_heat = counter_all_heat +1;
        don_all_heat = don_spec_trace(:,(i));
        accep_all_heat = accep_spec_trace(:,(i));
		gamma = str2num(get(handles.gamma_corr_val,'String'));
		% [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
		denom_fret_allheat = accep_all_heat + (gamma.*don_all_heat);
		fret_all_heat(:,counter_all_heat) = accep_all_heat./denom_fret_allheat;
    end
    TR  = 1;
    gen_heat_map(fret_all_heat, time_axis,fret_res)



% --- Executes on selection change in sel_list_traces.
function sel_list_traces_Callback(hObject, eventdata, handles)
% hObject    handle to sel_list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns sel_list_traces contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_list_traces
global don_spec_trace
global accep_spec_trace
% global don_spec_trace_FILTERED
% global accep_spec_trace_FILTERED
global NAME_FILTER
global p_start
global p_end
global Picture_a
global Picture_d
% global fret_sel_hist
% global index_GGG
global Mode1
global butt_lim
% global SEL_INDEX
global Complete_SET
global proc_trace_val
global file_frames
run_value_man = 0;
don_blchpoint = getappdata(handles.load_traces,'blch_don');
accep_blchpoint = getappdata(handles.load_traces,'blch_accep');
blch_pt = getappdata(handles.load_traces,'blch_type');
snr_don_var = getappdata(handles.load_traces,'snr_don_var');
snr_accep_var = getappdata(handles.load_traces,'snr_accep_var');
centers_part = getappdata(handles.load_traces, 'centers_ext');
 %% Single Click action 
% get the mov_window, don_f_ratio and accep_f_ratio
mov_window = str2double(get(handles.filt_win,'String'));
don_f_ratio = 0.5;
accep_f_ratio = 0.5;
oper_mode = getappdata(handles.load_traces, 'oper_mode');
index_sel_t = get(handles.sel_list_traces,'Value');
SEL_INDEX = index_sel_t;
index_GGG = index_sel_t;
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel = sel_trace_sub(index_sel_t);
set(handles.trace_num,'String',num2str(index_sel));
set(handles.disp_status2,'String','Selected');
%% Process the single color first
switch oper_mode
    case (1)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
% [~, num_traces] = size(don_tot_trace);
axes(handles.axes1);
plot(time_axis, don_spec_trace(:,index_sel),'--g');
ylabel('Donor','FontWeight','bold')
ylim([0 +inf]);
grid on
axes(handles.axes17);
imagesc(Picture_d{index_sel,1});
hold on
viscircles(Picture_d{index_sel,2},Picture_d{index_sel,3},'Color','k','LineWidth',1);
axes(handles.axes18);
imagesc(Picture_a{index_sel,1});
hold on
viscircles(Picture_a{index_sel,2},Picture_a{index_sel,3},'Color','k','LineWidth',1);
if strcmp(Mode1 , 'onecolor')
axes(handles.axes8);
don_sel = don_spec_trace(:,index_sel);  
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
grid on
end
ylabel('Norm. Overlay')
ylim([0 +inf]);
%% Process the FRET/ two-color data
    case (2)
        img_disp_val = get(handles.radiobutton13,'Value');
        if proc_trace_val == 1 
           if file_frames >1
           load('Traces_to_analyze.mat');
           else
            file_name = getappdata(handles.load_traces, 'file_name');
            load(file_name);               
           end           
           blch_pt = blch_fret;
           don_blchpoint = blch_fret;
           accep_blchpoint= blch_fret;           
        else
            file_name = getappdata(handles.load_traces, 'file_name');
            load(file_name);
        end

don_sel = don_spec_trace(:,index_sel);
accep_sel = accep_spec_trace(:,index_sel);
setappdata(handles.list_traces, 'don_sel',don_sel);
setappdata(handles.list_traces, 'accep_sel', accep_sel);
setappdata(handles.list_traces, 'time_axis', time_axis);
center_sel = centers_part(index_sel,:);
% Run value man is the manual pick options
if run_value_man >=1
blch_pt = blch_pt';
disp_blch_type = blch_pt(index_sel_t);
else
blch_pt = blch_pt';
disp_blch_type = blch_pt(index_sel);
end

switch disp_blch_type
    case {1}
        set(handles.radiobutton11,'Value',1)
        set(handles.radiobutton12,'Value',0)
    case {2}
        set(handles.radiobutton11,'Value',0)
        set(handles.radiobutton12,'Value',1)
end
axes(handles.axes1);
if run_value_man >=1
sel_blch_don = don_blchpoint(index_sel_t);
sel_blch_accep = accep_blchpoint(index_sel_t);
else
   sel_blch_don = don_blchpoint(index_sel);
sel_blch_accep = accep_blchpoint(index_sel); 
end

don_sel_blch = movmean(don_sel(1:sel_blch_don),3);
accep_sel_blch = movmean(accep_sel(1:sel_blch_accep),3);
don_sel_blch_t = don_sel(1:sel_blch_don);
accep_sel_blch_t = accep_sel(1:sel_blch_accep);
if proc_trace_val == 1
else
%     if run_value_man >=1
%         don_snr = snr_don_var(index_sel_t);
%         set(handles.disp_snr1,'String',num2str(don_snr));
%         accep_snr = snr_accep_var(index_sel_t);
%         set(handles.disp_snr2,'String',num2str(accep_snr));
%     else
%     end
end
time_axis_blch_don = time_axis(1:sel_blch_don);
time_axis_blch_accep = time_axis(1:sel_blch_accep);
plot(time_axis, don_sel,'--k',time_axis_blch_don,don_sel_blch,'g');
ylabel('Donor','FontWeight','bold')
ylim([0 +inf]);
grid on

if img_disp_val == 1
axes(handles.axes17);
imagesc(Picture_d{index_sel,1});
hold on
viscircles(Picture_d{index_sel,2},Picture_d{index_sel,3},'Color','k','LineWidth',1);
hold off
axes(handles.axes18);
imagesc(Picture_a{index_sel,1});
hold on
viscircles(Picture_a{index_sel,2},Picture_a{index_sel,3},'Color','k','LineWidth',1);
hold off
end

axes(handles.axes7);
plot(time_axis, accep_sel,'--k',time_axis_blch_accep,accep_sel_blch,'r');
ylabel ('Acceptor','FontWeight','bold')
ylim([0 +inf]);
grid on
axes(handles.axes19)
gamma = str2num(get(handles.gamma_corr_val,'String'));
plot(time_axis, (don_sel.*gamma + accep_sel),'k')
ylabel('Total')
max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;
grid on
axes(handles.axes8)
if strcmp(Mode1 , 'onecolor')
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay','FontWeight','bold')
ylim([0 +inf]);
grid on
% pass to the FRET program donor trace, acceptor trace and gamma factor
if strcmp(Mode1 , 'Multicolor')
gamma = str2num(get(handles.gamma_corr_val,'String'));
% [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;
axes(handles.axes9);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET','FontWeight','bold')
xlabel('Time (s)')
ylim([0 1]);
yticks(0:0.2:1);
grid on
end
axes(handles.axes19);
grid on
setappdata(handles.list_traces, 'fret_trace',fret_calc_trace);
if strcmp(Mode1 , 'Multicolor')
gamma = str2num(get(handles.gamma_corr_val,'String'));
% fret_bins = get(handles.slider_fret_bins, 'Value');
% set(handles.disp_fret_slider_bins, 'String',fret_bins);
don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
time_axis = getappdata(handles.load_traces, 'time_axis');
% fret_index = find(time_axis == fret_bins);
don_sel_blch_t = don_sel(1:sel_blch_don);
accep_sel_blch_t = accep_sel(1:sel_blch_accep);
if numel(don_sel_blch_t) >= numel(accep_sel_blch_t)
    num_pts = numel(accep_sel_blch_t);
else
    num_pts = numel(don_sel_blch_t);
end
counter_fret = 0;
for m = 1:num_pts
    counter_fret = counter_fret + 1;
    denom_fret = accep_sel_blch_t(counter_fret) + (gamma.*don_sel_blch_t(counter_fret));
    fret_calc_inc = accep_sel_blch_t(counter_fret)./denom_fret;
    fret_sel_hist(:,counter_fret) = fret_calc_inc;
end

axes(handles.axes13)
histogram(fret_sel_hist,linspace(0,1,20))
ylabel ('occurence');
xlabel ('FRET');
title('FRET Distribution')
grid on

num_hist_obs = numel(fret_sel_hist);
set(handles.disp_indv_obs_his, 'String',num2str(num_hist_obs));

axes(handles.axes24)
cla
viscircles(center_sel,4,'Color','b');
hold off
end
end
%%  PLot the data
if butt_lim == 1
set(handles.axes1,'XLim',[p_start,p_end]); 
set(handles.axes7,'XLim',[p_start,p_end]); 
set(handles.axes8,'XLim',[p_start,p_end]); 
% set(handles.axes14,'XLim',[p_start,p_end]); 
set(handles.axes9,'XLim',[p_start,p_end]); 
set(handles.axes19,'XLim',[p_start,p_end]); 
end

set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
if strcmp(Mode1 , 'onecolor')
    set(handles.axes8,'FontWeight','bold')
else
set(handles.axes8,'XTick',[]);
end
set(handles.axes19,'XTick',[]);
% set(handles.axes20,'XTick',[]);
set(handles.axes19,'YTick',[]);
% set(handles.axes20,'YTick',[]);
% no axes on the pics
set(handles.axes17,'XTick',[]);
set(handles.axes17,'YTick',[]);
set(handles.axes18,'XTick',[]);
set(handles.axes18,'YTick',[]);

set(handles.axes1,'fontsize',8);
set(handles.axes7,'fontsize',8);
set(handles.axes8,'fontsize',8);
set(handles.axes9,'fontsize',8);
set(handles.axes9,'FontWeight','bold')
% set(handles.axes14,'fontsize',6);
set(handles.axes13,'fontsize',6);

% --- Executes during object creation, after setting all properties.
function sel_list_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
    
end

% --- Executes on button press in get_sel_trace.
function get_sel_trace_Callback(hObject, eventdata, handles)
% hObject    handle to get_sel_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global Complete_SET
% global don_spec_trace
% global accep_spec_trace
% time_axis = getappdata(handles.load_traces, 'time_axis');
% grp_traces_t = get(handles.uibuttongroup5, 'SelectedObject');
% grp_action = get(grp_traces_t, 'String');
% manual_activate = get(handles.man_activate,'Value');
% if manual_activate == 1
%     run_value_man = 1;
%     Mode1 = getappdata(handles.load_traces, 'Mode1');
%     index_sel_t = get(handles.sel_list_traces,'Value');
%     sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
%     index_sel = sel_trace_sub(index_sel_t);    
%     don_blchpoint = getappdata(handles.load_traces,'blch_don');
%     size(don_blchpoint)
%     accep_blchpoint = getappdata(handles.load_traces,'blch_accep');
%     fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
%     blch_pt = getappdata(handles.load_traces,'blch_type');
%     
%     
% %     snr_don_var = getappdata(handles.load_traces,'snr_don_var');
% %     snr_accep_var = getappdata(handles.load_traces,'snr_accep_var');
% %     snr_don_bckg = getappdata(handles.load_traces,'snr_don_bckg');
% %     snr_accep_bckg = getappdata(handles.load_traces,'snr_accep_bckg');  
% %     filt_tot = getappdata(handles.load_traces,'filt_tot');
% %     don_lifetime = getappdata(handles.load_traces,'don_lifetime');
% %     don_cps = getappdata(handles.load_traces,'don_cps');
% %     accep_lifetime = getappdata(handles.load_traces,'accep_lifetime');
% %     accep_cps = getappdata(handles.load_traces,'accep_cps');
% % Handle response
% 
% switch grp_action
%     case{'Modify'}
%             answer_blch = questdlg('Type of Bleaching?', ...
%             'Type of Bleach Event', ...
%             'Donor','Acceptor','Acceptor');
%     switch answer_blch
%         case 'Donor'
%         blch =1;
%         set(handles.radiobutton11,'Value',1)
%         set(handles.radiobutton12,'Value',0)
%         case 'Acceptor'
%         blch = 2;
%         set(handles.radiobutton11,'Value',0)
%         set(handles.radiobutton12,'Value',1)
%     end
%     % Get the Manual Bleach point
%         [xval,yval] = ginput(1);
%         ind_t = find(xval <=time_axis)
%         ind_sel = ind_t(1);
%         set(handles.man_lifetime,'String',num2str(xval));        
%         bleachpoint_fret = ind_sel;
%         if run_value_man == 1
%             don_blchpoint(:,index_sel) = bleachpoint_fret;
%             accep_blchpoint(:,index_sel) = bleachpoint_fret;
%             fret_blchpoint_t(:,index_sel) = bleachpoint_fret;
%             blch_pt(:,index_sel) = blch;
%         else
%             don_blchpoint(:,index_sel_t) = bleachpoint_fret;
%             accep_blchpoint(:,index_sel_t) = bleachpoint_fret;
%             fret_blchpoint_t(:,index_sel_t) = bleachpoint_fret;
%             blch_pt(:,index_sel_t) = blch;
%         end
%             
%     case {'Add(N/A)'}
%         msgbox('Feature Not Activated')
% end
% else
%     msgbox('Manual Picking Not Activated')
% end
% setappdata(handles.load_traces,'blch_don',don_blchpoint);
% setappdata(handles.load_traces,'blch_accep',accep_blchpoint);
% setappdata(handles.load_traces,'blch_fret',fret_blchpoint);
% setappdata(handles.load_traces,'blch_type',blch_pt); 
% sel_list_traces_Callback(hObject, eventdata, handles);

% --- Executes on button press in del_sel_trace.
function del_sel_trace_Callback(hObject, eventdata, handles)
% hObject    handle to del_sel_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SEL_INDEX = get(handles.sel_list_traces,'Value');
global Complete_SET
Complete_SET_old = Complete_SET;
run_value_man = getappdata(handles.load_traces,'run_value_man');
proc_trace_val = get(handles.checkbox1,'Value');

if run_value_man >=1 
    don_blchpoint = getappdata(handles.load_traces,'blch_don');
    accep_blchpoint = getappdata(handles.load_traces,'blch_accep');
    fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
    blch_pt = getappdata(handles.load_traces,'blch_type');
    don_lifetime = getappdata(handles.load_traces,'don_lifetime');
    don_cps = getappdata(handles.load_traces,'don_cps');
    accep_lifetime = getappdata(handles.load_traces,'accep_lifetime');
    accep_cps = getappdata(handles.load_traces,'accep_cps');
    snr_don_var = getappdata(handles.load_traces,'snr_don_var');
    snr_accep_var = getappdata(handles.load_traces,'snr_accep_var');
    snr_don_bckg = getappdata(handles.load_traces,'snr_don_bckg');
    snr_accep_bckg = getappdata(handles.load_traces,'snr_accep_bckg');   
end

if run_value_man >=1 
don_blchpoint(:,SEL_INDEX)= [];
accep_blchpoint(:,SEL_INDEX)= [];
fret_blchpoint(:,SEL_INDEX)= [];
blch_pt(:,SEL_INDEX)= [];
    don_lifetime(:,SEL_INDEX)= [];
    don_cps(:,SEL_INDEX)= [];
    accep_lifetime(:,SEL_INDEX)= [];
    accep_cps(:,SEL_INDEX)= [];
    snr_don_var(:,SEL_INDEX)= [];
    snr_accep_var(:,SEL_INDEX)= [];
    snr_don_bckg(:,SEL_INDEX)= [];
    snr_accep_bckg(:,SEL_INDEX)= [];
end

new_list = setdiff(Complete_SET_old,Complete_SET(SEL_INDEX));
new_list_size = size(new_list);
 if SEL_INDEX > new_list_size(:,1)
     SEL_INDEX_t = new_list_size(:,1);
 else
     SEL_INDEX_t = SEL_INDEX;
 end
 new_val = SEL_INDEX_t;
set(handles.sel_list_traces,'Value',new_val)
set(handles.sel_list_traces,'String',new_list)

Complete_SET(SEL_INDEX) = [];
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';

num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
[aa,~] =size(sel_trace_sub);
if aa == 1
    sel_trace_sub = sel_trace_sub';
end
num_list_sel_trace = num2str((sel_trace_sub));
%set(handles.sel_list_traces, 'String', num_list_sel_trace);
setappdata(handles.load_traces,'filt_tot',sel_trace_sub);

if run_value_man >=1 
    setappdata(handles.load_traces,'blch_don', don_blchpoint);
    setappdata(handles.load_traces,'blch_accep', accep_blchpoint);
    setappdata(handles.load_traces,'blch_fret', fret_blchpoint);
    setappdata(handles.load_traces,'blch_type', blch_pt);
    setappdata(handles.load_traces,'don_lifetime', don_lifetime);
    setappdata(handles.load_traces,'don_cps', don_cps);
    setappdata(handles.load_traces,'accep_lifetime',accep_lifetime);
    setappdata(handles.load_traces,'accep_cps', accep_cps);
    setappdata(handles.load_traces,'snr_don_var', snr_don_var);
    setappdata(handles.load_traces,'snr_accep_var', snr_accep_var);
    setappdata(handles.load_traces,'snr_don_bckg', snr_don_bckg);
    setappdata(handles.load_traces,'snr_accep_bckg', snr_accep_bckg);   
end



% --- Executes on button press in save_sel_traces.
function save_sel_traces_Callback(hObject, eventdata, handles)
% hObject    handle to save_sel_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FIL
global NAME_FILTER
%index_sel_t = get(handles.sel_list_traces,'Value');
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
Mode1 = getappdata(handles.load_traces, 'Mode1');
oper_mode = getappdata(handles.load_traces, 'oper_mode');
run_man = 0;
% global don_tot_trace 
% global don_bckg_trace 
% global don_spec_trace 
% global time_axis 
% global accep_tot_trace
% global accep_bckg_trace
% global accep_spec_trace
% global Picture_d
% global Picture_a

don_tot_trace = getappdata(handles.load_traces, 'don_tot_trace');
don_bckg_trace = getappdata(handles.load_traces, 'don_bckg_trace');
accep_tot_trace = getappdata(handles.load_traces, 'accep_tot_trace');
accep_bckg_trace = getappdata(handles.load_traces, 'accep_bckg_trace');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
Picture_d = getappdata(handles.load_traces, 'Picture_d');
Picture_a = getappdata(handles.load_traces, 'Picture_a');
centers_ext = getappdata(handles.load_traces, 'centers_ext');
a1 = [];
a2 = [];
a3 = [];
a5 = [];
a6 = [];
a7 = [];
a8 = [];
a9 = [];
if FIL == 0
a1 = don_tot_trace(:,sel_trace_sub);
a2 = don_bckg_trace(:,sel_trace_sub);
a3 = don_spec_trace(:,sel_trace_sub) ;
a10 = centers_ext(sel_trace_sub,:);
if oper_mode ==2
a5 = accep_tot_trace(:,sel_trace_sub);
a6 = accep_bckg_trace(:,sel_trace_sub);
a7 = accep_spec_trace(:,sel_trace_sub);
end

counter_Pics = 0;
for i = 1:length(sel_trace_sub)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub(i),3};
end
    
a8 = Picture_d_temp;
a9 = Picture_a_temp;

elseif FIL == 1    
for i = 1:length(sel_trace_sub)
a11 = smooth(don_tot_trace(:,sel_trace_sub(i)),NAME_FILTER);
a21 = smooth(don_bckg_trace(:,sel_trace_sub(i)),NAME_FILTER);
a31 = smooth(don_spec_trace(:,sel_trace_sub(i)),NAME_FILTER);
if oper_mode == 2
a51 = smooth(accep_tot_trace(:,sel_trace_sub(i)),NAME_FILTER);
a61 = smooth(accep_bckg_trace(:,sel_trace_sub(i)),NAME_FILTER);
a71 = smooth(accep_spec_trace(:,sel_trace_sub(i)),NAME_FILTER); 
end
counter_Pics = 0;
for i = 1:length(sel_trace_sub)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub(i),3};
end
a1 = [a1,a11];
a2 = [a2,a21];
a3 = [a3,a31];
if oper_mode == 2
a5 = [a5,a51];
a6 = [a6,a61];
a7 = [a7,a71];
end
a8 = [a8,Picture_d_temp];
a9 = [a9,Picture_a_temp];
end

end
don_tot_trace=a1; 
don_bckg_trace=a2;
don_spec_trace=a3;
if oper_mode == 2
accep_tot_trace=a5;
accep_bckg_trace= a6;
accep_spec_trace= a7;
end
Picture_d = a8;
Picture_a = a9;
centers_ext = a10;

if oper_mode ==1
    filtered_data = 1;
    blch_don = getappdata(handles.load_traces, 'don_blchpoint');
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                  'Picture_d','Picture_a','Mode1','filtered_data','blch_don','centers_ext'});
elseif oper_mode ==2
    filtered_data = 1;
    blch_don_t = getappdata(handles.load_traces,'blch_don');
    blch_accep_t = getappdata(handles.load_traces,'blch_accep');
    blch_fret_t = getappdata(handles.load_traces,'blch_fret');
    blch_type_t = getappdata(handles.load_traces,'blch_type');
    
    if run_man >= 1
        blch_don = blch_don_t;
        blch_accep = blch_accep_t;
        blch_fret = blch_fret_t;
        blch_type = blch_type_t;
    else
        blch_don = blch_don_t(:,sel_trace_sub);        
        blch_accep = blch_accep_t(:,sel_trace_sub);
        blch_fret = blch_fret_t(:,sel_trace_sub);
        blch_type = blch_type_t(:,sel_trace_sub);
    end
        
% Save statistics
trace_stats1 = get(handles.save_stats, 'Value');
if trace_stats1 == 1
    trace_list = sel_trace_sub';
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext','trace_list'});
else
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext'});
end
end


function num_sel_traces_Callback(hObject, eventdata, handles)
% hObject    handle to num_sel_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_sel_traces as text
%        str2double(get(hObject,'String')) returns contents of num_sel_traces as a double

% --- Executes during object creation, after setting all properties.
function num_sel_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_sel_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in overlay_popmenu.
function overlay_popmenu_Callback(hObject, eventdata, handles)
% hObject    handle to overlay_popmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns overlay_popmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from overlay_popmenu
global Number
global fname
global don_spec_trace;
global accep_spec_trace;

popup1 = get(handles.overlay_popmenu,'Value');
% 1 = All selected FRET
% 2 = Subgroup 1
% 3 = Subgroup 2
% 4 = Subgroup 3
 switch popup1
     case{1}
        sel_trace_heat = getappdata(handles.load_traces,'sel_trace_sub');
     case{2}
        sel_trace_heat = getappdata(handles.subgrp_1,'temp_sublist1');
     case{3}
        sel_trace_heat = getappdata(handles.subgrp_2,'temp_sublist2');  
     case{4}
         sel_trace_heat = getappdata(handles.subgrp_3,'temp_sublist3');
 end
 
 if numel(sel_trace_heat) > 1
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
%     fret_res = str2num(get(handles.fret_res,'String'));
    counter_sel_heat = 0;   
    fret_blchpoint_t = getappdata(handles.load_traces,'blch_fret');
    don_heat_trace = don_spec_trace(:,sel_trace_heat);   
    accep_heat_trace = accep_spec_trace(:,sel_trace_heat);
    fret_blchpoint = fret_blchpoint_t(:,sel_trace_heat);
[a_h_t2,~] = heatmap_updater(don_heat_trace, accep_heat_trace,gamma,time_axis,fret_blchpoint);
[fret_sel_all_hist2,tot_hist_obs] = trace_to_hist(don_heat_trace, accep_heat_trace, fret_blchpoint, gamma);
set(handles.disp_histobs_grp1,'String', num2str(tot_hist_obs));
% rvscolorMap = [zeros(256,1), linspace(0,1,256)', ones(256,1)];
% rvscolorMap(1:3,:) = ones(3,3);    
mol_tot = sum(a_h_t2(1,:));
axes(handles.axes10)
fret_res = 0.1;
edges = [0:fret_res:1];
[M,cf] = contourf(time_axis, edges, a_h_t2',25);
cf.LineStyle = 'none';
% colormap('hot')
prop.b2 = gca;
ylabel ('FRET Efficiency')
title (['Total number of molecules = ',num2str(mol_tot)]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');
prop.b2.FontWeight = 'bold';
axes(handles.axes28)
histogram(fret_sel_all_hist2, linspace(0,1,50),'LineWidth', 1.25)
title('FRET'); 
xticks([0:.2:1]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',9,'FontWeight','bold')

export_fret_vals = get(handles.exp_hist_vals_tem, 'Value');
if export_fret_vals == 1
counter_hist = 0;
for i = 1:length(fret_sel_all_hist2)
    if fret_sel_all_hist2(i) > -0.1 && fret_sel_all_hist2(i) < 1.1
       counter_hist = counter_hist + 1;
       file_sel_hist_t(:,counter_hist) = fret_sel_all_hist2(i);
    end
end
file_sel_hist = file_sel_hist_t;
uisave({'file_sel_hist'})
end



 end


% --- Executes during object creation, after setting all properties.
function overlay_popmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overlay_popmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
% global fname
% global don_spec_trace;
% global accep_spec_trace;
% global fret_hist_sel_out
% popup2 = get(handles.popupmenu2, 'Value');
% % 1 = No Display, 2 = Selected FRET
% if popup2 == 2    
%     sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');    
%     file_name = getappdata(handles.load_traces, 'file_name');
%     load(file_name);
%     counter_sel_trace = 0;
%     for i = 1:length(sel_trace_sub)
%         counter_sel_trace = counter_sel_trace +1;
%         don_sel_traces(:,counter_sel_trace) = don_spec_trace(:,sel_trace_sub(i));
%         accep_sel_traces(:,counter_sel_trace) = accep_spec_trace(:,sel_trace_sub(i));
%     end
%     
%     fret_bins = get(handles.slider_fret_bins, 'Value');
%     fret_index = find(time_axis == fret_bins);
%       if  isempty(fret_index)
%         fret_index = length(time_axis);
%     end
%     gamma = str2num(get(handles.gamma_corr_val,'String'));
%     [fret_hist_sel_out]=fret_hist(don_sel_traces,accep_sel_traces, gamma, fret_index);
%     
%     
%     fname(find(fname=='.',1,'last'):end) = [];
% %     axes(handles.axes11);
% %     histogram(fret_hist_sel_out,linspace(0,1,20))
% %   hist(fret_hist_sel_out,linspace(0,1,20))
%     ylabel ('occurence');
%     file = fret_hist_sel_out;
%     %save('testA.mat', 'file')
% 
% end
% set(handles.axes11,'fontsize',6);


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

% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
global don_spec_trace;
global accep_spec_trace;
popup3 = get(handles.popupmenu3,'Value');
% 1 = All selected FRET
% 2 = Subgroup 1
% 3 = Subgroup 2
% 4 = Subgroup 3
 switch popup3
     case{1}
        sel_trace_heat = getappdata(handles.subgrp_1,'temp_sublist1');
     case{2}
        sel_trace_heat = getappdata(handles.subgrp_2,'temp_sublist2');  
     case{3}
         sel_trace_heat = getappdata(handles.subgrp_3,'temp_sublist3');
 end
 
 if numel(sel_trace_heat) > 1
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
%     fret_res = str2num(get(handles.fret_res,'String'));
    counter_sel_heat = 0;   
    fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
    fret_blchpoint_t = getappdata(handles.load_traces,'blch_fret');
    don_heat_trace = don_spec_trace(:,sel_trace_heat);   
    accep_heat_trace = accep_spec_trace(:,sel_trace_heat);
    fret_blchpoint = fret_blchpoint_t(:,sel_trace_heat);
[a_h_t2,~] = heatmap_updater(don_heat_trace, accep_heat_trace,gamma,time_axis,fret_blchpoint);
[fret_sel_all_hist2,tot_hist_obs] = trace_to_hist(don_heat_trace, accep_heat_trace, fret_blchpoint, gamma);
set(handles.disp_histobs_grp2,'String', num2str(tot_hist_obs));
% rvscolorMap = [zeros(256,1), linspace(0,1,256)', ones(256,1)];
% rvscolorMap(1:3,:) = ones(3,3);    
mol_tot = sum(a_h_t2(1,:));
axes(handles.axes11)
fret_res = 0.1;
edges = [0:fret_res:1];
[M,cf] = contourf(time_axis, edges, a_h_t2',25);
cf.LineStyle = 'none';
% colormap('hot')
prop.b2 = gca;
ylabel ('FRET Efficiency')
title (['Total number of molecules = ',num2str(mol_tot)]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');
prop.b2.FontWeight = 'bold';
axes(handles.axes27)
histogram(fret_sel_all_hist2, linspace(0,1,50),'LineWidth', 1.25)
title('FRET'); 
xticks([0:.2:1]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',9,'FontWeight','bold')
 end




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

function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double
global p_end
p_end =  str2double(get(hObject,'String')); 

global p_start

% set(handles.axes14,'XTick',[]);
% set(handles.axes1,'fontsize',6);
% set(handles.axes7,'fontsize',6);
% set(handles.,'fontsize',6);
% set(handles.axes14,'fontsize',6);
% set(handles.axes9,'fontsize',6);

% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double
global p_start
p_start =  str2double(get(hObject,'String')); 



% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in link_traces_state_id.
function link_traces_state_id_Callback(hObject, eventdata, handles)
% hObject    handle to link_traces_state_id (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global don_spec_trace
global accep_spec_trace
global index_GGG
global SEL_INDEX
blch_point = getappdata(handles.load_traces,'blch_fret');
index_sel_t = get(handles.sel_list_traces,'Value');
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel = sel_trace_sub(index_sel_t);
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
num_traces = length(sel_trace_sub);
%% Preprocess the matrix
counter = 0;
for i = 1:num_traces
    counter = counter +1;
don_sel_t = don_spec_trace(:,sel_trace_sub(i));
don_blch = blch_point(:,i);
don_sel = don_sel_t(1:don_blch);
lens_traces(:, counter) = length(don_sel);
end
max_trace = max(lens_traces);

fret_all = [];
V_tosave = [];
for i = 1:num_traces
don_sel_t = don_spec_trace(:,sel_trace_sub(i));
don_blch = blch_point(:,i);
don_sel = don_sel_t(1:don_blch);
accep_sel_t = accep_spec_trace(:,sel_trace_sub(i));
accep_blch = blch_point(:,i);
accep_sel = accep_sel_t(1:accep_blch);
gamma = str2num(get(handles.gamma_corr_val,'String'));
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace_t = accep_sel./denom_fret;
fret_calc_trace = fret_calc_trace_t;
pad_trace_t = max_trace - length(fret_calc_trace_t);
if pad_trace_t >0
    pad_trace = (ones(pad_trace_t,1)*-1);
    fret_calc_trace_t = vertcat(fret_calc_trace_t,pad_trace);
    fret_calc_trace_t = standardizeMissing(fret_calc_trace_t,-1);
end
V_tosave = [V_tosave ; fret_calc_trace_t'];
fret_all = vertcat(fret_all, fret_calc_trace);
end

trace_time_out = time_axis;
trace_fret_out = V_tosave';

save('trace_to_link.mat','trace_time_out','trace_fret_out', 'fret_all');
trace_linker;



% --- Executes on button press in launch_stasi.
function launch_stasi_Callback(hObject, eventdata, handles)
% hObject    handle to launch_stasi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
StaSI;


% --- Executes on button press in launch_ebfret.
function launch_ebfret_Callback(hObject, eventdata, handles)
% hObject    handle to launch_ebfret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ebFRET;

% --- Executes on slider movement.
function slider_fret_bins_Callback(hObject, eventdata, handles)
% hObject    handle to slider_fret_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global p_end
global p_start
global butt_lim

% set(handles.slider_fret_bins, 'Min',1);
% set(handles.slider_fret_bins, 'Max',1001); 
% sliderstep = ([1/1000, 1/1000]);
% set(handles.slider_fret_bins, 'Value', 1000);
% set(handles.slider_fret_bins, 'SliderStep', sliderstep);
global t

if butt_lim == 1
t = t+1;
    if t == 1   
%     set(handles.slider_fret_bins, 'Min',1);
%     set(handles.slider_fret_bins, 'Max',round(p_end-p_start));
%     set(handles.slider_fret_bins, 'Value', ( (p_end-p_start)-1 )/2);
    % sliderstep = ([1/( (p_end-p_start)-1 ), 1/( (p_end-p_start)-1 )  ]);
    % set(handles.slider_don_intens, 'SliderStep', sliderstep);
    end

elseif butt_lim == 0 
% set(handles.slider_fret_bins, 'Min',1);
% set(handles.slider_fret_bins, 'Max',1001); 
%set(handles.slider_fret_bins, 'Value', 1000);
t = 0;
end




gamma = str2num(get(handles.gamma_corr_val,'String'));
fret_bins = get(handles.slider_fret_bins, 'Value');

don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
time_axis = getappdata(handles.load_traces, 'time_axis');
% fret_index = find(time_axis == fret_bins);
% fret_index = round(fret_index);

fret_index = get(hObject,'Value');
fret_index = round(fret_index);
set(handles.disp_fret_slider_bins, 'String',fret_index);


counter_fret = 0;
if butt_lim ==0
    for i = 1:fret_index:length(don_sel);
        counter_fret = counter_fret + 1;
        denom_fret = accep_sel (i) + (gamma.*don_sel(i));
        fret_calc_inc = accep_sel(i)./denom_fret;
        fret_sel_hist(:,counter_fret) = fret_calc_inc;
    end
elseif  butt_lim == 1
    for i = 1:fret_index:p_end-p_start;
        counter_fret = counter_fret + 1;
        denom_fret = accep_sel (i) + (gamma.*don_sel(i));
        fret_calc_inc = accep_sel(i)./denom_fret;
        fret_sel_hist(:,counter_fret) = fret_calc_inc;
    end     
end

axes(handles.axes13)
histogram(fret_sel_hist,linspace(0,1,20))
% hist(fret_sel_hist)
ylabel ('occurence');
% xlabel ('FRET');
set(handles.axes13,'fontsize',6);

global fname
global don_spec_trace;
global accep_spec_trace;
global fret_hist_sel_out
% popup2 = get(handles.popupmenu2, 'Value');
% % 1 = No Display, 2 = Selected FRET
% if popup2 == 2    
%     sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');    
%     file_name = getappdata(handles.load_traces, 'file_name');
%     load(file_name);
%     counter_sel_trace = 0;
%     for i = 1:length(sel_trace_sub)
%         counter_sel_trace = counter_sel_trace +1;
%         don_sel_traces(:,counter_sel_trace) = don_spec_trace(:,sel_trace_sub(i));
%         accep_sel_traces(:,counter_sel_trace) = accep_spec_trace(:,sel_trace_sub(i));
%     end
%     
%     fret_bins = get(handles.slider_fret_bins, 'Value');
%     fret_index = find(time_axis == fret_bins);
%     if  isempty(fret_index)
%         fret_index = length(time_axis);
%     end
%     gamma = str2num(get(handles.gamma_corr_val,'String'));
%     [fret_hist_sel_out]=fret_hist(don_sel_traces,accep_sel_traces, gamma, fret_index);
% 
%     
%     axes(handles.axes11);
%     histogram(fret_hist_sel_out,linspace(0,1,20))
% %   hist(fret_hist_sel_out,linspace(0,1,20))
%     ylabel ('occurence');
%     file = fret_hist_sel_out;
%     save('testA.mat', 'file')
% 
% end
% set(handles.axes11,'fontsize',6);


global Number
 global fret_hist_out

popup1 = get(handles.overlay_popmenu,'Value');
% 1 = No Display, 2 = All FRET
if popup1 == 2    
    file_name = getappdata(handles.load_traces, 'file_name');
    load(file_name);
    gamma = str2num(get(handles.gamma_corr_val,'String'));
    don_traces = don_spec_trace;
    accep_traces = accep_spec_trace;
    fret_bins = get(handles.slider_fret_bins, 'Value');
    fret_index = find(time_axis == fret_bins);
    if  isempty(fret_index)
        fret_index = length(time_axis);
    end
    [fret_hist_out]=fret_hist(don_traces,accep_traces, gamma, fret_index);

   
    
    axes(handles.axes10);
%     hist(fret_hist_out,20)
    histogram(fret_hist_out,linspace(0,1,20))
    ylabel ('occurence');
%     xlabel ('FRET');
    
end
set(handles.axes10,'fontsize',6);




% --- Executes during object creation, after setting all properties.
function slider_fret_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_fret_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function disp_fret_slider_bins_Callback(hObject, eventdata, handles)
% hObject    handle to disp_fret_slider_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_fret_slider_bins as text
%        str2double(get(hObject,'String')) returns contents of disp_fret_slider_bins as a double

% --- Executes during object creation, after setting all properties.

function disp_fret_slider_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_fret_slider_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cross_corr_val_Callback(hObject, eventdata, handles)
% hObject    handle to cross_corr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cross_corr_val as text
%        str2double(get(hObject,'String')) returns contents of cross_corr_val as a double


% --- Executes during object creation, after setting all properties.
function cross_corr_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cross_corr_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function lag_time_Callback(hObject, eventdata, handles)
% hObject    handle to lag_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lag_time as text
%        str2double(get(hObject,'String')) returns contents of lag_time as a double

% --- Executes during object creation, after setting all properties.
function lag_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lag_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in fit_all_fret_gaus.
function fit_all_fret_gaus_Callback(hObject, eventdata, handles)
% hObject    handle to fit_all_fret_gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
GUI_first_task;


% --- Executes on button press in fit_sel_gaus.
function fit_sel_gaus_Callback(hObject, eventdata, handles)
% hObject    handle to fit_sel_gaus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

GUI_first_task;


% --- Executes on button press in trans_density.
function trans_density_Callback(hObject, eventdata, handles)
% hObject    handle to trans_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% The first step is to process the transition matrix of vbFRET to generate
% the transition density plot
run kat_tdp




% --- Executes on button press in vb_traces.
function vb_traces_Callback(hObject, eventdata, handles)
% hObject    handle to vb_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global don_spec_trace
global accep_spec_trace
global index_GGG
global SEL_INDEX
global time_axis
gamma = str2num(get(handles.gamma_corr_val,'String'));
blch_fret = getappdata(handles.load_traces,'blch_fret');
index_sel_t = get(handles.sel_list_traces,'Value');
SEL_INDEX = index_sel_t;
index_GGG = index_sel_t;
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
global Mode1;
h1 = waitbar_new(0,'Please wait...');    
counterAAAA = 1;
    for i = sel_trace_sub
    waitbar_new(counterAAAA/size(sel_trace_sub,2),h1);    
    don_sel = don_spec_trace(:,i).*gamma;
    accep_sel = accep_spec_trace(:,i);
    bleachpoint_fret = blch_fret(:,i);
    don_sel_blch = don_sel(1:bleachpoint_fret);
    accep_sel_blch = accep_sel(1:bleachpoint_fret);
    denom_fret_blch = accep_sel_blch + (gamma.*don_sel_blch);
    fret_calc_trace_blch = accep_sel_blch./denom_fret_blch;  
    blch_diff = length(don_sel)-bleachpoint_fret;
    fret_diff = (zeros(blch_diff,1));
    accep_diff = (ones(blch_diff,1)).*0.001;
    fret_calc_trace = vertcat(fret_calc_trace_blch,fret_diff);    
    accep_sel = vertcat(accep_sel_blch,accep_diff);
%     gamma = str2num(get(handles.gamma_corr_val,'String'));
%     denom_fret = accep_sel + (gamma.*don_sel);
%     fret_calc_trace = accep_sel./denom_fret;    
    %% Implement non-zero check
        for j = 1:length(fret_calc_trace)
            if fret_calc_trace(j) < 0
            fret_calc_trace(j) = 1e-2;
            end
        end    
        for k = 1:length(don_sel)
            if don_sel(k) <0
            don_sel(k) = 0.1;
            end
        end    
        for k = 1:length(accep_sel)
            if accep_sel(k) < 0
            accep_sel(k) = 0.1;
            end            
        end    
        data{1,counterAAAA} = [don_sel_blch accep_sel_blch];
        FRET{1,counterAAAA} = fret_calc_trace;
        labels{1,counterAAAA}= num2str(counterAAAA); 
        counterAAAA = counterAAAA + 1;
    end
    close(h1)
    %uisave({'data','FRET','labels'});
    save('SELECTED_VBtraces.mat','data','FRET','labels');
   

% --- Executes on button press in save_fig_traces.
function save_fig_traces_Callback(hObject, eventdata, handles)
% hObject    handle to save_fig_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SEL_INDEX
fig = figure();
set(fig,'units','normalized','position', [0.1, 0.2, 0.8, 0.7])
ax1=subplot(5,1,1);
ax1(1).LineWidth = 1.25;
a1 = handles.axes1;
xlabel('Time')
ylabel('Donor')
grid on
ylim([0,inf]);
copyobj(allchild(a1),ax1);

ax2=subplot(5,1,2);
ax2(1).LineWidth = 1.25;
a2 = handles.axes7;
xlabel('Time')
ylabel('Acceptor')
grid on
ylim([0, inf]);
copyobj(allchild(a2),ax2);

ax3=subplot(5,1,3);
ax3(1).LineWidth = 1.25;
a3 = handles.axes19;
xlabel('Time')
ylabel('Total')
grid on
copyobj(allchild(a3),ax3);

ax4=subplot(5,1,4);
ax4(1).LineWidth = 1.25;
a4 = handles.axes8;
xlabel('Time')
ylabel('Norm. Overaly')
grid on
copyobj(allchild(a4),ax4);

ax5=subplot(5,1,5);
ax5(1).LineWidth = 1.25;
a5 = handles.axes9;
xlabel('Time')
ylabel('FRET')
grid on
ylim([0,1]);
yticks(0:0.2:1);
grid on
copyobj(allchild(a5),ax5);

sel_trace_exp = num2str(SEL_INDEX);

%saveas(fig,['trace','_',sel_trace_exp,'.tif']);



% --- Executes on button press in save_fig_hist.
function save_fig_hist_Callback(hObject, eventdata, handles)
% hObject    handle to save_fig_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Insert code here
% copy other figures of histograms


% --- Executes on button press in over_sub1.
function over_sub1_Callback(hObject, eventdata, handles)
% hObject    handle to over_sub1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global TR
global Mode1
% global don_tot_trace
% global don_sel_heat 
    sel_trace_heat = getappdata(handles.subgrp_1,'temp_sublist1');
    file_name = getappdata(handles.load_traces, 'file_name');
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
    fret_res = str2num(get(handles.fret_res,'String'));
    load(file_name);
    counter_sel_heat = 0;   
    filtered_status = getappdata(handles.filter_status,'filt_status');
    % Initialise the 
    if filtered_status == 1
         fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
    end
    
 if strcmp(Mode1,'onecolor')    
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat(:,counter_sel_heat) = don_spec_trace(:,sel_trace_heat(i)); 
    end
 else
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat = don_spec_trace(:,sel_trace_heat(i));   
        accep_sel_heat = accep_spec_trace(:,sel_trace_heat(i));
        % [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
        denom_fret_heat = accep_sel_heat + (gamma.*don_sel_heat);
        if filtered_status == 1
            blch_cut = fret_blchpoint(i);
            blch_diff = length(don_sel_heat)-blch_cut;
            fret_trace_heat_ttt = accep_sel_heat./denom_fret_heat;
            fret_trace_heat_tt = fret_trace_heat_ttt(1:blch_cut);
            fret_diff = (zeros(blch_diff,1));
            fret_trace_heat_t = vertcat(fret_trace_heat_tt,fret_diff);            
        else 
            fret_trace_heat_t = accep_sel_heat./denom_fret_heat;
        end
        fret_trace_heat(:,counter_sel_heat) = fret_trace_heat_t;
        
        
    end
 end
     counter = 0;
 if strcmp(Mode1,'onecolor') 
    for i = 1: length(sel_trace_heat)
       counter = counter + 1;
       don_tot_trace_norm(:,i) = don_sel_heat(:,i)./max(don_sel_heat(:,i));
    end
 end
 [time_bins,num_traces] = size(don_sel_heat);    
TR = 2;
    if strcmp(Mode1,'onecolor')
    gen_heat_map(don_tot_trace_norm, time_axis,fret_res)
    else
    gen_heat_map(fret_trace_heat, time_axis,fret_res)
    end



% --- Executes on button press in sel_filt_crit.
function sel_filt_crit_Callback(hObject, eventdata, handles)
% hObject    handle to sel_filt_crit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% get the value from the  filtering criteria and apply it to the master
% list to get a sub selection of traces
% case 1 = donor bleaching
% case 2 = acceptor bleaching
% case 3 = anti-correlated event
% case 4 = donor + Anti corr

switch_filter = get(handles.list_filter, 'Value');
switch switch_filter
    case(1)
%         disp('donor')
% insert code to read through all the donor traces to select the donor bleaching
% run function to get blch
% [] = get_blch_trace()


    case(2)
%         disp('acceptor')
% insert code to read through all the acceptor and select acceptor
% bleaching     
% run function to get blch
% [] = get_blch_trace()


    case(3)
%         disp('anti-correlated')
% identify all traces that have anti-correlated events]
% run function to get ant_corr_traces
% [] = get_ant_corr()
        
end


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in range1.
function range1_Callback(hObject, eventdata, handles)
% hObject    handle to range1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global don_tot_hist
global Index_T_1
global INIT

INIT = 1;

[x_range1,~] = ginput(2);
% Index_T_1 = []';

% Check code for obtaining the correct indicies
% x_range1(1)
% x_range1(2)
% don_tot_hist


Index_T_1 = find(don_tot_hist >= x_range1(1) & don_tot_hist <= x_range1(2));
% don_tot_hist(test_ind(1))
% 
% for i = 1: size(don_tot_hist,2)
%     if don_tot_hist(i) >= x_range1(1) && don_tot_hist(i) <= x_range1(2)
%       Index_T_1 = [Index_T_1, i]
%     end
% end
%set(handles.sel_list_traces, 'String', Index_T_1);

num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Index_T_1;

global Complete_SET
Complete_SET =sel_trace_sub';
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';
num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
num_list_sel_trace = num2str((sel_trace_sub)');
set(handles.sel_list_traces, 'String', num_list_sel_trace);




% --- Executes on button press in range2.
function range2_Callback(hObject, eventdata, handles)
% hObject    handle to range2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global accep_tot_hist
global Index_T_2
global Index_T_1
global Complete_SET

global INIT

INIT = 1;

[x_range2,~] = ginput(2);
% Index_T_2 = []';

% replaced old code above and below with find command
Index_T_2 = find(accep_tot_hist >= x_range2(1) & accep_tot_hist <= x_range2(2));


% for i = 1: size(accep_tot_hist,2)
%     if accep_tot_hist(i) >= x_range2(1) && accep_tot_hist(i) <= x_range2(2)
%       Index_T_2 = [Index_T_2, i];
%     end
% end

[C,ia,ib] = setxor(Index_T_1,Index_T_2);


INDEX_MORE = [];
for j = 1: size(ib,1)
    INDEX_MORE = [INDEX_MORE, Index_T_2(ib)];
end

Complete_set = [Index_T_1, C];
Complete_set = sort(Complete_set);

[b,m1,n1] = unique(Complete_set,'first');
[c1,d1] =sort(m1);
b = b(d1);

Complete_SET = b';
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';
num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
num_list_sel_trace = num2str((sel_trace_sub)');
set(handles.sel_list_traces, 'String', num_list_sel_trace);


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in new.
function new_Callback(hObject, eventdata, handles)
% hObject    handle to new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
clear
clear global
clc
KAT_2



function file_traces_Callback(hObject, eventdata, handles)
% hObject    handle to file_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of file_traces as text
%        str2double(get(hObject,'String')) returns contents of file_traces as a double
global file_frames
file_frames = get(hObject,'String');
file_frames = str2num(file_frames);

% --- Executes during object creation, after setting all properties.
function file_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function Traces_merger_together(varargin)
number_arguments = length(varargin);
global proc_trace_val;

for i = 1:number_arguments
file = varargin(i);
file1 = [file{1}];
load(file1)
[lengthTraces_t, ~] = size(don_spec_trace);
lengthTraces(i)=lengthTraces_t;
end
max_length = max(lengthTraces, [], 'all');

%Initialization
accep_bckg_trace_temp = [];
accep_spec_trace_temp = [];
accep_tot_trace_temp = [];
don_bckg_trace_temp = [];
don_spec_trace_temp = [];
don_tot_trace_temp = [];
time_axis_temp = [];
Trace_final_temp = [];
Picture_a_temp = {};
Picture_d_temp = {};
centers_ext_temp = [];
if proc_trace_val == 1
    blch_accep_temp = [];
    blch_don_temp = [];
    blch_type_temp = [];
    blch_fret_temp = [];    
end
if exist('Mode1')
else
    Mode1 = 'other';
end
%Merging all the vectors
for i = 1:number_arguments
file = varargin(i);
file1 = [file{1}];
load(file1)
[lengthTraces_tt, num_traces] = size(don_spec_trace);
diff_length = max_length - lengthTraces_tt;
diff_length_t = ones(diff_length,1);
if length(time_axis) == max_length
time_axis_temp =  time_axis;
end
if diff_length > 1
    [don_spec_trace_new,don_tot_trace_new, accep_spec_trace_new,accep_tot_trace_new] = trace_extender(diff_length_t,num_traces,don_spec_trace,don_tot_trace, accep_spec_trace,accep_tot_trace);
    don_spec_trace = don_spec_trace_new;
    don_tot_trace = don_tot_trace_new;
    accep_spec_trace = accep_spec_trace_new;
    accep_tot_trace = accep_tot_trace_new;
end

if strcmp(Mode1,'onecolor')
else
accep_bckg_trace_temp = [accep_bckg_trace_temp , accep_bckg_trace];
accep_spec_trace_temp = [accep_spec_trace_temp , accep_spec_trace];
accep_tot_trace_temp = [accep_tot_trace_temp , accep_tot_trace];
if proc_trace_val == 1
blch_accep_temp = [blch_accep_temp; blch_accep'];
blch_don_temp = [blch_don_temp; blch_don'];
size blch_type_temp
size blch_type
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
%time_axis_temp = [time_axis_temp ; time_axis];
%Trace_final_temp = Trace_final_temp;
don_bckg_trace = don_bckg_trace_temp ;
don_spec_trace = don_spec_trace_temp ;
don_tot_trace = don_tot_trace_temp ;
time_axis = time_axis_temp ;
Picture_d     =  Picture_d_temp ;
Picture_a   = Picture_a_temp;
centers_ext = centers_ext_temp;
if strcmp(Mode1,'onecolor')
    save('Traces_to_analyze.mat','time_axis','don_tot_trace','don_bckg_trace','don_spec_trace','Mode1','Picture_a','Picture_d');
else
accep_bckg_trace = accep_bckg_trace_temp ;
accep_spec_trace = accep_spec_trace_temp ;
accep_tot_trace = accep_tot_trace_temp ;
Picture_a     =  Picture_a_temp ;
if proc_trace_val ==1
blch_accep = blch_accep_temp';
blch_don = blch_don_temp';
blch_type = blch_type_temp';
blch_fret = blch_fret_temp';
end

if proc_trace_val == 1
save('Traces_to_analyze.mat','time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace','Mode1','Picture_a','Picture_d', 'centers_ext',...
                 'blch_accep','blch_don','blch_type','blch_fret');
else
    save('Traces_to_analyze.mat','time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace','Mode1','Picture_a','Picture_d', 'centers_ext');
    
end
end  
             
function [  ] = gen_heat_map(fret_traces, time_axis,fret_res)
global TR
global NAME_FILTER
global p_end
global p_start
global butt_lim 
global Mode1

if butt_lim == 1
    if p_start == 0
        p_start = time_axis(1);
    end
    Index1 = find(time_axis == p_start);
    Index2 = find(time_axis == p_end);
else
Index1 = 1;
Index2 = length(time_axis);
end
fret_traces = fret_traces(Index1:Index2,:);


[time_bins,num_traces] = size(fret_traces);
counter = 0;
for j = 1:time_bins
    counter = counter+ 1;
    edges = [0:fret_res:1];
   [a,b] = hist(fret_traces(j,:),edges);   
   a_h_t(counter,:) = a;  
end

[a1,~] = size((a_h_t)');

re_hist = a_h_t';
counter2 = 0;
        for i = 1:a1;
            counter2 = counter2+1;
            bar_count(counter2,:) = sum(re_hist(i,:));
        end
mol_tot = sum(a_h_t(1,:));

if TR == 1
    aaaa = 1;
    bbbb = 2;
elseif TR == 2
    aaaa = 3;
    bbbb = 4;
end

global FIL
if FIL == 1
TEMP = [];
for i = 1:size(a_h_t,2)
    TEMP = [TEMP, smooth(a_h_t(:,i),NAME_FILTER)];
end
a_h_t = TEMP;
end
% color map
rvscolorMap = [zeros(256,1), linspace(0,1,256)', ones(256,1)];
rvscolorMap(1:3,:) = ones(3,3);
% Red color map
% rvscolorMap = [ones(256,1), linspace(0,1,256)', zeros(256,1)];
% rvscolorMap(1:3,:) = ones(3,3);

fig1 = figure(bbbb);
set(fig1,'units','normalized','position', [0.1, 0.2, 0.8, 0.26])
subplot(1,4,[1 2 3])
[M,cf] = contourf(time_axis(Index1:Index2), edges, a_h_t',25);
cf.LineStyle = 'none';
prop.a2 = gca;
xlabel('Time (s)')
if strcmp(Mode1,'onecolor')
ylabel ('Norm Intensity')
else
ylabel ('FRET Efficiency')
end
title (['Total number of molecules = ',num2str(mol_tot)]);
prop.a2.FontWeight = 'bold';
colormap(rvscolorMap)

subplot(1,4,4)
barh(edges', bar_count, 'histc')
ylim1 = edges(1);
ylim2 = edges(end);
ylim([ylim1 ylim2]);
title('Histogram')
xlabel('Number of Events')


fig = figure(aaaa);
set(fig,'units','normalized','position', [0.1, 0.6, 0.8, 0.3])
[M, cf] = contourf(time_axis(Index1:Index2), edges, a_h_t',25);
cf.LineStyle = 'none';
prop.a2 = gca;
xlabel('Time (s)')

if strcmp(Mode1,'onecolor')
ylabel ('Norm Intensity')
else
ylabel ('FRET Efficiency')
end

title (['Total number of molecules = ',num2str(mol_tot)]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');
prop.a2.FontWeight = 'bold';
colormap(rvscolorMap)



% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = zoom;
h.Motion = 'horizontal';
h.Enable = 'on';
% zoom in on the plot in the horizontal direction.
a1 = (handles.axes1);
a7 = (handles.axes7);
a8 = (handles.axes8);
a9 = (handles.axes9);
a19 =(handles.axes19);
linkaxes([a1,a7,a8,a19,a9],'x');



% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1 = (handles.axes1);
a7 = (handles.axes7);
a8 = (handles.axes8);
a9 = (handles.axes9);
a19 =(handles.axes19);
linkaxes([a1,a7,a8,a19,a9],'x');
zoom('out');
linkaxes([a1,a7,a8,a19,a9],'x');
zoom off
linkaxes([a1,a7,a8,a19,a9],'x');



function [fret_hist_out] = fret_hist(don_traces, accep_traces, gamma, fret_index)
% This callback fuction will compute the basic FRET traces for display and
%analysis
% Traces are calculated here and sent to the GUI 
% FRET is computed as Ia/Ia + gamma*Id

% This reads through the collection of traces and gets them one by one
% then each trace is read though in segments to calculate the FRET

counter_fret = 0;
[~, num_trace_fret] = size(don_traces);
for j = 1:num_trace_fret
    don_sel = don_traces(:,j);
    accep_sel = accep_traces(:,j);
    
    for i = 1:fret_index:length(don_sel);
        counter_fret = counter_fret + 1;
        denom_fret = accep_sel (i) + (gamma.*don_sel(i));
        fret_calc_hist = accep_sel(i)./denom_fret;
        fret_hist_out(:,counter_fret) = fret_calc_hist;
    end
end

function [] = fret_setup(don_sel, accep_sel, gamma)
% This callback fuction will compute the basic FRET traces for display and
%analysis
% Traces are calculated here and sent to the GUI 
% FRET is computed as Ia/Ia + Id
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;


% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Complete_SET
global INIT
INIT = 1;

[x_range3,~] = ginput(4);
x_plot1 = x_range3(1:2);
x_plot2 = x_range3(3:4);

% replace code for loop code with find code

global don_tot_hist
% Index1 = []';

Index1 = find(don_tot_hist>= x_plot1(1) & don_tot_hist <= x_plot1(2));

% for i = 1: size(don_tot_hist,2)
%     if don_tot_hist(i) >= x_plot1(1) && don_tot_hist(i) <= x_plot1(2)
%       Index1 = [Index1, i];
%     end
% end
%set(handles.sel_list_traces, 'String', Index_T_1);

global accep_tot_hist
% Index2 = []';

Index2 = find(accep_tot_hist >= x_plot2(1) & accep_tot_hist <= x_plot2(2));
% for i = 1: size(accep_tot_hist,2)
%     if accep_tot_hist(i) >= x_plot2(1) && accep_tot_hist(i) <= x_plot2(2)
%       Index2 = [Index2, i];
%     end
% end

C = intersect(Index1,Index2);

Complete_SET = C';
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';
num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
num_list_sel_trace = num2str((sel_trace_sub)');
set(handles.sel_list_traces, 'String', num_list_sel_trace);


% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global NAME_FILTER
global Mode1
oper_mode = getappdata(handles.load_traces, 'oper_mode');
global SEL_INDEX
index_sel_t = get(handles.sel_list_traces,'Value');
SEL_INDEX = index_sel_t;

sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel = sel_trace_sub(index_sel_t);
switch oper_mode
    case (1)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
% [~, num_traces] = size(don_tot_trace);
don_spec_trace(:,index_sel) = smooth(don_spec_trace(:,index_sel),NAME_FILTER);

axes(handles.axes1);
plot(time_axis, don_spec_trace(:,index_sel),'g');
ylabel('Donor')
ylim([0 +inf]);

if strcmp(Mode1 , 'onecolor')
axes(handles.axes8);
don_sel = don_spec_trace(:,index_sel);  
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
ylim([0 +inf]);


    case (2)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
don_sel = don_spec_trace(:,index_sel);
accep_sel = accep_spec_trace(:,index_sel);
don_sel = smooth(double(don_sel),NAME_FILTER);
accep_sel = smooth(double(accep_sel),NAME_FILTER);

setappdata(handles.list_traces, 'don_sel',don_sel);
setappdata(handles.list_traces, 'accep_sel', accep_sel);
% [~, num_traces] = size(don_tot_trace);

axes(handles.axes1);
plot(time_axis, don_sel,'g');
ylabel('Donor')
ylim([0 +inf]);

axes(handles.axes7);
plot(time_axis, accep_sel,'r');
ylabel ('Acceptor')
% Normalise the traces to plot an donor and acceptor overlay
% normalise the donor and acceptor
max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;

axes(handles.axes8)
if strcmp(Mode1 , 'onecolor')
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
% pass to the FRET program donor trace, acceptor trace and gamma factor
gamma = str2num(get(handles.gamma_corr_val,'String'));
% [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;
axes(handles.axes9);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET')
ylim([0 1]);
% lag_time = str2double(get(handles.lag_time, 'String'));
% fret_corr = autocorr(fret_calc_trace,lag_time);
% fret_corr_val = fret_corr(1);
% set(handles.cross_corr_val, 'String', num2str(fret_corr_val));
% axes(handles.axes14)
% plot(fret_corr,'k');

% Calculate histogram on that selected trace
gamma = str2num(get(handles.gamma_corr_val,'String'));
fret_bins = get(handles.slider_fret_bins, 'Value');
set(handles.disp_fret_slider_bins, 'String',fret_bins);

don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
don_sel = smooth(don_sel,NAME_FILTER);

accep_sel = smooth(accep_sel,NAME_FILTER);
time_axis = getappdata(handles.load_traces, 'time_axis');
fret_index = find(time_axis == fret_bins);

counter_fret = 0;
for i = 1:fret_index:length(don_sel);
    counter_fret = counter_fret + 1;
    denom_fret = accep_sel (i) + (gamma.*don_sel(i));
    fret_calc_inc = accep_sel(i)./denom_fret;
    fret_sel_hist(:,counter_fret) = fret_calc_inc;
end
axes(handles.axes13)
 histogram(fret_sel_hist,linspace(0,1,20))
ylabel ('occurence');
xlabel ('FRET');
set(handles.axes13,'fontsize',6);
end

global butt_lim 
global p_start
global p_end

if butt_lim == 1
set(handles.axes1,'XLim',[p_start,p_end]); 
set(handles.axes7,'XLim',[p_start,p_end]); 
set(handles.axes8,'XLim',[p_start,p_end]); 
% set(handles.axes14,'XLim',[p_start,p_end]); 
set(handles.axes9,'XLim',[p_start,p_end]); 
end
set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
set(handles.axes8,'XTick',[]);
% set(handles.axes14,'XTick',[]);
set(handles.axes1,'fontsize',6);
set(handles.axes7,'fontsize',6);
set(handles.axes8,'fontsize',6);
% set(handles.axes14,'fontsize',6);
set(handles.axes9,'fontsize',6);




% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global don_spec_trace
global accep_spec_trace
global Complete_SET
global accep_spec_trace_FILTERED
global don_spec_trace_FILTERED
global FIL 
global Mode1
FIL = 1;
global NAME_FILTER

oper_mode = getappdata(handles.load_traces, 'oper_mode');
global SEL_INDEX
index_sel_t = get(handles.sel_list_traces,'Value');
SEL_INDEX = index_sel_t;

sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel = sel_trace_sub(index_sel_t);
switch oper_mode
    case (1)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
% [~, num_traces] = size(don_tot_trace);
don_spec_trace(:,index_sel) = smooth(don_spec_trace(:,index_sel),NAME_FILTER);

axes(handles.axes1);
plot(time_axis, don_spec_trace(:,index_sel),'g');
ylabel('Donor')
ylim([0 +inf]);

if strcmp(Mode1 , 'onecolor')
axes(handles.axes8);
don_sel = don_spec_trace(:,index_sel);  
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
ylim([0 +inf]);

    case (2)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
don_sel = don_spec_trace(:,index_sel);
accep_sel = accep_spec_trace(:,index_sel);
don_sel = smooth(double(don_sel),NAME_FILTER);
accep_sel = smooth(double(accep_sel),NAME_FILTER);

setappdata(handles.list_traces, 'don_sel',don_sel);
setappdata(handles.list_traces, 'accep_sel', accep_sel);
% [~, num_traces] = size(don_tot_trace);

axes(handles.axes1);
plot(time_axis, don_sel,'g');
ylabel('Donor')
ylim([0 +inf]);

axes(handles.axes7);
plot(time_axis, accep_sel,'r');
ylabel ('Acceptor')
% Normalise the traces to plot an donor and acceptor overlay
% normalise the donor and acceptor
max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;
axes(handles.axes8)
if strcmp(Mode1 , 'onecolor')
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
% pass to the FRET program donor trace, acceptor trace and gamma factor
gamma = str2num(get(handles.gamma_corr_val,'String'));
% [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;
axes(handles.axes9);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET')
ylim([0 1]);

% lag_time = str2double(get(handles.lag_time, 'String'));
% fret_corr = autocorr(fret_calc_trace,lag_time);
% fret_corr_val = fret_corr(1);
% set(handles.cross_corr_val, 'String', num2str(fret_corr_val));
% axes(handles.axes14)
% plot(fret_corr,'k');

% Calculate histogram on that selected trace
gamma = str2num(get(handles.gamma_corr_val,'String'));
fret_bins = get(handles.slider_fret_bins, 'Value');
set(handles.disp_fret_slider_bins, 'String',fret_bins);

don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
don_sel = smooth(don_sel,NAME_FILTER);

accep_sel = smooth(accep_sel,NAME_FILTER);
time_axis = getappdata(handles.load_traces, 'time_axis');
fret_index = find(time_axis == fret_bins);

counter_fret = 0;
for i = 1:fret_index:length(don_sel);
    counter_fret = counter_fret + 1;
    denom_fret = accep_sel (i) + (gamma.*don_sel(i));
    fret_calc_inc = accep_sel(i)./denom_fret;
    fret_sel_hist(:,counter_fret) = fret_calc_inc;
end
axes(handles.axes13)
 histogram(fret_sel_hist,linspace(0,1,20))
ylabel ('occurence');
xlabel ('FRET');
set(handles.axes13,'fontsize',6);
end
global butt_lim 
global p_start
global p_end

if butt_lim == 1
set(handles.axes1,'XLim',[p_start,p_end]); 
set(handles.axes7,'XLim',[p_start,p_end]); 
set(handles.axes8,'XLim',[p_start,p_end]); 
% set(handles.axes14,'XLim',[p_start,p_end]); 
set(handles.axes9,'XLim',[p_start,p_end]); 
end
set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
set(handles.axes8,'XTick',[]);
% set(handles.axes14,'XTick',[]);
set(handles.axes1,'fontsize',6);
set(handles.axes7,'fontsize',6);
set(handles.axes8,'fontsize',6);
% set(handles.axes14,'fontsize',6);
set(handles.axes9,'fontsize',6);


%plot(time_axis, don_spec_trace(:,index_sel),'g');

% don_spec_trace_FILTERED = smooth(don_spec_trace(:,Complete_SET),'lowess');
% accep_spec_trace_FILTERED = smooth(accep_spec_trace(:,Complete_SET),'lowess');
% don_spec_trace_FILTERED = smooth(don_spec_trace,'rlowess');
% accep_spec_trace_FILTERED = smooth(accep_spec_trace,'rlowess');



% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FIL
global Mode1
FIL = 0;

oper_mode = getappdata(handles.load_traces, 'oper_mode');
global SEL_INDEX
index_sel_t = get(handles.sel_list_traces,'Value');
SEL_INDEX = index_sel_t;

sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel = sel_trace_sub(index_sel_t);
switch oper_mode
    case (1)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
% [~, num_traces] = size(don_tot_trace);
axes(handles.axes1);
plot(time_axis, don_spec_trace(:,index_sel),'g');
ylabel('Donor')
ylim([0 +inf]);

if strcmp(Mode1 , 'onecolor')
axes(handles.axes8);
don_sel = don_spec_trace(:,index_sel);  
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
ylim([0 +inf]);

    case (2)
file_name = getappdata(handles.load_traces, 'file_name');
load(file_name);
don_sel = don_spec_trace(:,index_sel);
accep_sel = accep_spec_trace(:,index_sel);
setappdata(handles.list_traces, 'don_sel',don_sel);
setappdata(handles.list_traces, 'accep_sel', accep_sel);
% [~, num_traces] = size(don_tot_trace);
axes(handles.axes1);
plot(time_axis, don_sel,'g');
ylabel('Donor')
ylim([0 +inf]);

axes(handles.axes7);
plot(time_axis, accep_sel,'r');
ylabel ('Acceptor')
% Normalise the traces to plot an donor and acceptor overlay
% normalise the donor and acceptor
max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;
axes(handles.axes8)
if strcmp(Mode1 , 'onecolor')
plot(time_axis,don_sel./max(don_sel),'k');
else
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
end
ylabel('Norm. Overlay')
% pass to the FRET program donor trace, acceptor trace and gamma factor
gamma = str2num(get(handles.gamma_corr_val,'String'));
% [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;
axes(handles.axes9);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET')

% lag_time = str2double(get(handles.lag_time, 'String'));
% fret_corr = autocorr(fret_calc_trace,lag_time);
% fret_corr_val = fret_corr(1);
% set(handles.cross_corr_val, 'String', num2str(fret_corr_val));
% axes(handles.axes14)
% plot(fret_corr,'k');

% Calculate histogram on that selected trace
gamma = str2num(get(handles.gamma_corr_val,'String'));
fret_bins = get(handles.slider_fret_bins, 'Value');
set(handles.disp_fret_slider_bins, 'String',fret_bins);
don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
time_axis = getappdata(handles.load_traces, 'time_axis');
fret_index = find(time_axis == fret_bins);

counter_fret = 0;
for i = 1:fret_index:length(don_sel);
    counter_fret = counter_fret + 1;
    denom_fret = accep_sel (i) + (gamma.*don_sel(i));
    fret_calc_inc = accep_sel(i)./denom_fret;
    fret_sel_hist(:,counter_fret) = fret_calc_inc;
end
axes(handles.axes13)
 histogram(fret_sel_hist,linspace(0,1,20))
ylabel ('occurence');
xlabel ('FRET');
end
global butt_lim 
global p_start
global p_end

if butt_lim == 1
set(handles.axes1,'XLim',[p_start,p_end]); 
set(handles.axes7,'XLim',[p_start,p_end]); 
set(handles.axes8,'XLim',[p_start,p_end]); 
% set(handles.axes14,'XLim',[p_start,p_end]); 
set(handles.axes9,'XLim',[p_start,p_end]); 
end
set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
set(handles.axes8,'XTick',[]);
% set(handles.axes14,'XTick',[]);
set(handles.axes1,'fontsize',6);
set(handles.axes7,'fontsize',6);
set(handles.axes8,'fontsize',6);
% set(handles.axes14,'fontsize',6);


if butt_lim == 1
set(handles.axes1,'XLim',[p_start,p_end]); 
set(handles.axes7,'XLim',[p_start,p_end]); 
set(handles.axes8,'XLim',[p_start,p_end]); 
% set(handles.axes14,'XLim',[p_start,p_end]); 
set(handles.axes9,'XLim',[p_start,p_end]); 
end
set(handles.axes1,'XTick',[]);
set(handles.axes7,'XTick',[]);
set(handles.axes8,'XTick',[]);
% set(handles.axes14,'XTick',[]);
set(handles.axes1,'fontsize',6);
set(handles.axes7,'fontsize',6);
set(handles.axes8,'fontsize',6);
set(handles.axes9,'fontsize',6);
% set(handles.axes14,'fontsize',6);
set(handles.axes13,'fontsize',6);


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
global NAME_FILTER
contents = cellstr(get(hObject,'String'));
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
NAME_FILTER = contents{get(hObject,'Value')};

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rev_plot.
function rev_plot_Callback(hObject, eventdata, handles)
% hObject    handle to rev_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global butt_lim
butt_lim = 0;

% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbutton36 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% global N_STD1
% global N_STD2
% global don_bins
% global accep_bins
% global don_tot_hist
% global accep_tot_hist
% global Mode1
% global fname
% global file_frames
% global don_tot_trace 
% global don_bckg_trace 
% global don_spec_trace 
% global time_axis 
% global accep_tot_trace
% global accep_bckg_trace
% global accep_spec_trace
% global Complete_SET
% global INIT
% 
% 
% [~, num_traces] = size(don_spec_trace);
% set(handles.raw_trace_total,'String', num2str(num_traces));
% num_list_trace = num2str ((1:num_traces)');
% set(handles.list_traces, 'String', num_list_trace);
% % Calculate histogram of intensities
% counter = 0;
% for i = 1:num_traces
%     counter = counter + 1;
%     don_tot_hist(:,counter) = mean(don_spec_trace(i));
%     accep_tot_hist(:,counter) = mean(accep_spec_trace(i));
%     tot_tot_hist(:,counter) = (mean(don_spec_trace(i)) + mean(accep_spec_trace(i)));
% end
% 
% 
% setappdata(handles.load_traces, 'don_tot_hist', don_tot_hist);
% setappdata(handles.load_traces, 'accep_tot_hist', accep_tot_hist);
% %----------------------
% 
% setappdata(handles.load_traces, 'tot_tot_hist', tot_tot_hist);
% don_bins = get(handles.slider_don_intens, 'Value');
% accep_bins = get(handles.slider_accep_intens, 'Value');
% tot_bins = get(handles.slider_tot_intens, 'Value');
%          
% % [N1,~] = histcounts(don_tot_hist, don_bins);
% % [N2,~] = histcounts(accep_tot_hist, accep_bins);
% % 
% % [M1,sigmahat1] = normfit(N1);
% % [M2,sigmahat2] = normfit(N2);
% 
% [mu1, sigma1] = normfit(don_tot_hist, don_bins);
% [mu2, sigma2] = normfit(accep_tot_hist, accep_bins);
% 
% % axes(handles.axes2);
% % histogram(don_tot_hist, don_bins);
% % hold on
% % h = histfit(don_tot_hist,don_bins,'normal');
% % h(1).FaceColor = [0 0 1];
% % % vline = refline([inf sigmahat1*N_STD1]);
% % % vline.Color = 'g';
% % y1 =get(gca,'ylim');
% % plot([sigma1*N_STD1+mu1 sigma1*N_STD1+mu1],y1,'g--','LineWidth',1.5)
% % plot([-sigma1*N_STD1+mu1 -sigma1*N_STD1+mu1],y1,'g--','LineWidth',1.5)
% % hold off
% 
% if ~ strcmp(Mode1 , 'onecolor')
% axes(handles.axes4)
% histogram(accep_tot_hist, accep_bins);
% hold on
% h = histfit(accep_tot_hist, accep_bins,'normal');
% h(1).FaceColor = [0 0 1];
% y1 =get(gca,'ylim');
% plot([sigma2*N_STD2+mu2 sigma2*N_STD2+mu2],y1,'g--','LineWidth',1.5)
% plot([-sigma2*N_STD2+mu2 -sigma2*N_STD2+mu2],y1,'g--','LineWidth',1.5)
% hold off 
% end
% 
% % set(handles.axes2,'fontsize',6);
% % set(handles.axes4,'fontsize',6);
% 
% x_plot1 = [-sigma1*N_STD1+mu1, sigma1*N_STD1+mu1];
% x_plot2 = [-sigma2*N_STD2+mu2, sigma2*N_STD2+mu2];
% 
% INIT = 1;
% 
% % replace code with find 
% Index1 = find(don_tot_hist >= x_plot1(1) & don_tot_hist <= x_plot1(2));
% % Index1 = []';
% % 
% % for i = 1: size(don_tot_hist,2)
% %     if don_tot_hist(i) >= x_plot1(1) && don_tot_hist(i) <= x_plot1(2)
% %       Index1 = [Index1, i];
% %     end
% % end
% %set(handles.sel_list_traces, 'String', Index_T_1);
% 
% 
% Index2 = find(accep_tot_hist >= x_plot2(1) & accep_tot_hist <= x_plot2(2));
% % Index2 = []';
% % for i = 1: size(accep_tot_hist,2)
% %     if accep_tot_hist(i) >= x_plot2(1) && accep_tot_hist(i) <= x_plot2(2)
% %       Index2 = [Index2, i];
% %     end
% % end
% 
% C = intersect(Index1,Index2);
% 
% Complete_SET = C';
% set(handles.sel_list_traces, 'String', Complete_SET);
% num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
% sel_trace_sub = Complete_SET';
% num_sel_trace = nnz(sel_trace_sub);
% setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
% set(handles.num_sel_traces,'String',num2str(num_sel_trace));
% num_list_sel_trace = num2str((sel_trace_sub)');
% set(handles.sel_list_traces, 'String', num_list_sel_trace);


function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
global N_STD2
N_STD2 = str2double(get(hObject,'String'));

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



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double
global N_STD1
N_STD1 = str2double(get(hObject,'String'));

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global butt_lim
global index_GGG
global don_spec_trace
global accep_spec_trace
global aaah_old
global AXR
global time_axis

if butt_lim == 1
set(handles.axes8,'XLim',[p_start,p_end]); 
end

a = get(hObject,'Value');

don_sel = don_spec_trace(:,index_GGG);
accep_sel = accep_spec_trace(:,index_GGG);
setappdata(handles.list_traces, 'don_sel',don_sel);
setappdata(handles.list_traces, 'accep_sel', accep_sel);

max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;

dt = (time_axis(2) - time_axis(1));

if a-aaah_old >0 

        clear('handles.axes8');
        axes(handles.axes8)
        set(handles.axes8,'XTick',[]);
        set(handles.axes8,'fontsize',6);
        ylabel('Norm. Overlay')
        plot(time_axis,norm_don_trace,'g');
        hold on
        plot(AXR+dt, norm_accep_trace, 'r');
        xlim([time_axis(1) time_axis(end)])
        hold off
    AXR = AXR + dt;
    
      
    
elseif a-aaah_old < 0
    
        clear('handles.axes8');
        axes(handles.axes8)
        set(handles.axes8,'XTick',[]);
        set(handles.axes8,'fontsize',6);
        ylabel('Norm. Overlay')
        plot(time_axis,norm_don_trace,'g');
        hold on
        plot(AXR - dt , norm_accep_trace, 'r');
        xlim([time_axis(1) time_axis(end)])
        hold off
    AXR = AXR - dt;
    
end


aaah_old = a;

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in over_sub3.
function over_sub3_Callback(hObject, eventdata, handles)
% hObject    handle to over_sub3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global TR
global Mode1
    sel_trace_heat = getappdata(handles.subgrp_3,'temp_sublist3');
    file_name = getappdata(handles.load_traces, 'file_name');
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
    fret_res = str2num(get(handles.fret_res,'String'));
    load(file_name);
    counter_sel_heat = 0;   
    filtered_status = getappdata(handles.filter_status,'filt_status');
    % Initialise the 
    if filtered_status == 1
         fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
    end
    
 if strcmp(Mode1,'onecolor')    
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat(:,counter_sel_heat) = don_spec_trace(:,sel_trace_heat(i)); 
    end
 else
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat = don_spec_trace(:,sel_trace_heat(i));   
        accep_sel_heat = accep_spec_trace(:,sel_trace_heat(i));
        % [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
        denom_fret_heat = accep_sel_heat + (gamma.*don_sel_heat);
        if filtered_status == 1
            blch_cut = fret_blchpoint(i);
            blch_diff = length(don_sel_heat)-blch_cut;
            fret_trace_heat_ttt = accep_sel_heat./denom_fret_heat;
            fret_trace_heat_tt = fret_trace_heat_ttt(1:blch_cut);
            fret_diff = (zeros(blch_diff,1));
            fret_trace_heat_t = vertcat(fret_trace_heat_tt,fret_diff);            
        else 
            fret_trace_heat_t = accep_sel_heat./denom_fret_heat;
        end
        fret_trace_heat(:,counter_sel_heat) = fret_trace_heat_t;
        
        
    end
 end
     counter = 0;
 if strcmp(Mode1,'onecolor') 
    for i = 1: length(sel_trace_heat)
       counter = counter + 1;
       don_tot_trace_norm(:,i) = don_sel_heat(:,i)./max(don_sel_heat(:,i));
    end
 end
 [time_bins,num_traces] = size(don_sel_heat);
    
TR = 2;
    if strcmp(Mode1,'onecolor')
    gen_heat_map(don_tot_trace_norm, time_axis,fret_res)
    else
    gen_heat_map(fret_trace_heat, time_axis,fret_res)
    end


 
% --- Executes on button press in over_sub2.
function over_sub2_Callback(hObject, eventdata, handles)
% hObject    handle to over_sub2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global TR
global Mode1
% global don_tot_trace
% global don_sel_heat 
    sel_trace_heat = getappdata(handles.subgrp_2,'temp_sublist2');
    file_name = getappdata(handles.load_traces, 'file_name');
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
    fret_res = str2num(get(handles.fret_res,'String'));
    load(file_name);
    counter_sel_heat = 0;   
    filtered_status = getappdata(handles.filter_status,'filt_status');
    % Initialise the 
    if filtered_status == 1
         fret_blchpoint = getappdata(handles.load_traces,'blch_fret');
    end
    
 if strcmp(Mode1,'onecolor')    
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat(:,counter_sel_heat) = don_spec_trace(:,sel_trace_heat(i)); 
    end
 else
    for i = 1:length(sel_trace_heat)
        counter_sel_heat = counter_sel_heat +1;
        don_sel_heat = don_spec_trace(:,sel_trace_heat(i));   
        accep_sel_heat = accep_spec_trace(:,sel_trace_heat(i));
        % [fret_calc_trace] = fret_setup(don_sel, accep_sel, gamma);
        denom_fret_heat = accep_sel_heat + (gamma.*don_sel_heat);
        if filtered_status == 1
            blch_cut = fret_blchpoint(i);
            blch_diff = length(don_sel_heat)-blch_cut;
            fret_trace_heat_ttt = accep_sel_heat./denom_fret_heat;
            fret_trace_heat_tt = fret_trace_heat_ttt(1:blch_cut);
            fret_diff = (zeros(blch_diff,1));
            fret_trace_heat_t = vertcat(fret_trace_heat_tt,fret_diff);            
        else 
            fret_trace_heat_t = accep_sel_heat./denom_fret_heat;
        end
        fret_trace_heat(:,counter_sel_heat) = fret_trace_heat_t;
        
        
    end
 end
     counter = 0;
 if strcmp(Mode1,'onecolor') 
    for i = 1: length(sel_trace_heat)
       counter = counter + 1;
       don_tot_trace_norm(:,i) = don_sel_heat(:,i)./max(don_sel_heat(:,i));
    end
 end
 [time_bins,num_traces] = size(don_sel_heat);
    
TR = 2;
    if strcmp(Mode1,'onecolor')
    gen_heat_map(don_tot_trace_norm, time_axis,fret_res)
    else
    gen_heat_map(fret_trace_heat, time_axis,fret_res)
    end




function [  ] = gen_heat_map1(fret_traces, time_axis,n)
global TR
global NAME_FILTER
global p_end
global p_start
global butt_lim 
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

x_plot1 = [p_start, p_end];

if butt_lim  == 1
for i = 1: size(time_axis,2)
    if time_axis(i) >= x_plot1(1) 
      Index1 =  i;
      break
    end
end
for i = 1: size(time_axis,2)
    if  time_axis(i) > x_plot1(2)
      Index2 =  i-1;
      break
    end
end
else
Index1 = 1;
Index2 = length(time_axis);
end

fret_traces = fret_traces(Index1:Index2,:);


[time_bins,num_traces] = size(fret_traces);
counter = 0;
for j = 1:time_bins
    counter = counter+ 1;
    edges = [0:0.1:1];
   [a,b] = hist(fret_traces(j,:),edges);   
   a_h_t(counter,:) = a;  
end

[a1,~] = size((a_h_t)');

re_hist = a_h_t';
counter2 = 0;
        for i = 1:a1;
            counter2 = counter2+1;
            bar_count(counter2,:) = sum(re_hist(i,:));
        end
mol_tot = sum(a_h_t(1,:));

if TR == 1
    aaaa = 1;
    bbbb = 2;
elseif TR == 2
    aaaa = 3;
    bbbb = 4;
end

global FIL
if FIL == 1
TEMP = [];
for i = 1:size(a_h_t,2)
    TEMP = [TEMP, smooth(a_h_t(:,i),NAME_FILTER)];
end
a_h_t = TEMP;
end




%set(fig,'units','normalized','position', [0.0025, 0.2, 1, 0.7]);

contourf(time_axis(Index1:Index2), edges, a_h_t');
xlabel('Time (s)')
ylabel ('FRET Efficiency')
title (['Total number of molecules = ',num2str(mol_tot)]);
if n ==0
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');
end
% if  butt_lim == 1 
% set(a,'XLim',[p_start,p_end]); 
% end


% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global don_bins
global accep_bins
global don_tot_hist
global accep_tot_hist



 
global don_spec_trace 

global accep_spec_trace
% Value 1 = donor bleaching
% Value 2 = Acceptor bleaching
% Value 3 = Donor+Acceptor bleaching
% Value 4 = Anti-correlated event
% Value 5 = Donor+Anti corr


n_donor1 = size(don_spec_trace,1);
n_accept1 = size(accep_spec_trace,1);
n_donor2 = size(don_spec_trace,2);
n_accept2 = size(accep_spec_trace,2);


    inde = [];
    for j = 1:n_donor2
        
    max_don = max(don_spec_trace(:,j));
    for i = n_donor1:-1:1
    
        if don_spec_trace(i,j) <= 0.01*max_don  
            if  i< n_donor1 - 5
                inde = [inde; j];
                break
            end
        else
            break
        end

    end
    
    end

NUMMM1 = length(inde); 
    

    
    inde = [];
    for j = 1:n_accept2
    max_acc = max(accep_spec_trace(:,j));
    for i = n_accept1:-1:1  
        
        if accep_spec_trace(i,j) <= 0.01*max_acc  
            if  i< n_donor1 - 5
                inde = [inde; j];
                break
            end
        else
            break
        end
        
    end  
    end
NUMMM2 = length(inde); 
    

    
    inde1 = [];
    inde2 = [];
    for j = 1:n_donor2
    max_don = max(don_spec_trace(:,j));
    for i = n_donor1:-1:1  
        
        if don_spec_trace(i,j) <= 0.01*max_don  
            if  i< n_donor1 - 5
                inde1 = [inde1; j];
                break
            end
        else
            break
        end
        
    end 
    end
    
    for j = 1:n_accept2
    max_acc = max(accep_spec_trace(:,j));
    for i = n_accept1:-1:1    
        
        if accep_spec_trace(i,j) <= 0.01*max_acc  
            if  i< n_donor1 - 5
                inde2 = [inde2; j];
                break
            end
        else
            break
        end
        
    end
    end
   inde = intersect(inde1,inde2);
NUMMM3 = length(inde);

set(handles.text34, 'String', NUMMM1)
set(handles.text43, 'String', NUMMM2)
set(handles.text44, 'String', NUMMM3)



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

% --- Executes on button press in EB_Traces.
function EB_Traces_Callback(hObject, eventdata, handles)
% hObject    handle to EB_Traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global don_spec_trace
% global accep_spec_trace
% global index_GGG
% global SEL_INDEX
% global time_axis

exp_fret_plot_Callback(hObject, eventdata, handles)

% index_sel_t = get(handles.sel_list_traces,'Value');
% SEL_INDEX = index_sel_t;
% index_GGG = index_sel_t;
% sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
% file_name = getappdata(handles.load_traces, 'file_name');
% load(file_name);
% global Mode1
% if strcmp(Mode1 , 'onecolor')
% h1 = waitbar_new(0,'Please wait...');    
% counterAAAA = 1;
% vector = [];
% %Vectori = zeros(size(sel_trace_sub,2),length(don_spec_trace(:,1)))';
% for i = sel_trace_sub
%     waitbar_new(counterAAAA/size(sel_trace_sub,2),h1);
%     don_sel = don_spec_trace(:,i);  
%     index = time_axis;    
%     max_don_sel = (mean(don_sel(1:10)));
%     norm_don_trace = don_sel./max_don_sel;
%     values = zeros(length(time_axis),3);
%     %values(:,1) = don_sel;
%     %values(:,3) = norm_don_trace;
%     values(:,3) = abs(don_sel./(max(don_sel)));
%     data(1,counterAAAA).index = index;
%     data(1,counterAAAA).values = values;
%     data(1,counterAAAA).id = file_name;
%     counterAAAA = counterAAAA + 1;
% end
% columns = {'-','-','donor'};
% id = file_name;
% type = file_name;
% close (h1)
% save('Complete_set_ebtraces.mat','data','columns','id','type');
% %=================================================================================
% %=================================================================================
% else
%     %% two color export
%     % find out from JD about gamma the donor
% h1 = waitbar_new(0,'Please wait...');    
% counterAAAA = 1;
% vector = [];
% %Vectori = zeros(size(sel_trace_sub,2),length(don_spec_trace(:,1)))';
% for i = sel_trace_sub
%     waitbar_new(counterAAAA/size(sel_trace_sub,2),h1); 
%     don_sel = don_spec_trace(:,i);
%     accep_sel = accep_spec_trace(:,i);
%     gamma = str2num(get(handles.gamma_corr_val,'String'));
%     denom_fret = accep_sel + (gamma.*don_sel);
%     fret_calc_trace = accep_sel./denom_fret;
%     %% Implement non-zero check
%     for j = 1:length(fret_calc_trace)
%         if fret_calc_trace(j) < 0
%             fret_calc_trace(j) = 1e-2;
%         end
%     end    
%     for k = 1:length(don_sel)
%         if don_sel(k) <0
%             don_sel(k) = 0.1;
%         end
%     end    
%     for k = 1:length(accep_sel)
%         if accep_sel(k) < 0
%             accep_sel(k) = 0.1;
%         end            
%     end
% %%
% process_blch = get(handles.use_blch_pts, 'Value');
% blch_don_t = getappdata(handles.load_traces,'blch_don');
% blch_accep_t = getappdata(handles.load_traces,'blch_accep');
% blch_fret_t = getappdata(handles.load_traces,'blch_fret');
% %% process the trace data
%         blch_fret = blch_fret_t(:,sel_trace_sub);
%         blch_pt = blch_fret(:,i);
%         blch_diff = length(don_sel)-blch_pt;
%         blch_diff = (zeros(blch_diff,1));
% %%    for j = 1: length(don_sel)
%         vector = [vector ; [counterAAAA, don_sel(j), accep_sel(j)]];
% end    
% process_blch = get(handles.use_blch_pts, 'Value');
%     if process_blch == 1
%         don_sel_t = don_sel(1:blch_pt,:);
%         accep_sel_t = accep_sel(1:blch_pt,:);
%         don_sel_t = vertcat(don_sel_t,blch_diff);
%         accep_sel_t = vertcat(accep_sel_t,blch_diff);
%         don_sel = don_sel_t;
%         accep_sel = accep_sel_t;
%     end
%     index = time_axis';    
%     values = zeros(length(time_axis),3);
%     values(:,1) = don_sel.*gamma;
%     values(:,2) = accep_sel;
%     values(:,3) = fret_calc_trace;    
%     data(1,counterAAAA).index = index;
%     data(1,counterAAAA).values = values;
%     data(1,counterAAAA).id = file_name;
%     counterAAAA = counterAAAA + 1;
% columns = {'donor','acceptor','fret'};
% id = file_name;
% type = file_name;
% close (h1)
% save ebtraces_export.dat vector -ascii 
% save('Selected_traces_EBtraces.mat','data','columns','id','type');
% end


% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global Number
global fret_hist_out
% global fname
% global don_spec_trace
% global accep_spec_trace
%     file_name = getappdata(handles.load_traces, 'file_name');
%     load(file_name);
%     gamma = str2num(get(handles.gamma_corr_val,'String'));
%     don_traces = don_spec_trace;
%     accep_traces = accep_spec_trace;
%     fret_bins = get(handles.slider_fret_bins, 'Value');
%     fret_index = find(time_axis == fret_bins);
%     [fret_hist_out]=fret_hist(don_traces,accep_traces, gamma, fret_index);
%     
%  [fret_hist_out]=fret_hist(don_traces,accep_traces, gamma, fret_index);
% 
%     
%     fname(find(fname=='.',1,'last'):end) = [];
% 
%     a = [fname '_All'];
%     b = '.mat';
%     name=[a b];
  file = fret_hist_out;
  uisave({'file'}); 
  
%     fname(find(fname=='.',1,'last'):end) = [];
%     a = [fname '_All'];
%     b = '.mat';
%     name=[a b];
    


% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global fname
global fret_hist_sel_out
 
%     sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');    
%     file_name = getappdata(handles.load_traces, 'file_name');
%     load(file_name);
%     counter_sel_trace = 0;
%     for i = 1:length(sel_trace_sub)
%         counter_sel_trace = counter_sel_trace +1;
%         don_sel_traces(:,counter_sel_trace) = don_spec_trace(:,sel_trace_sub(i));
%         accep_sel_traces(:,counter_sel_trace) = accep_spec_trace(:,sel_trace_sub(i));
%     end
%     
%     fret_bins = get(handles.slider_fret_bins, 'Value');
%     fret_index = find(time_axis == fret_bins);
%     gamma = str2num(get(handles.gamma_corr_val,'String'));
%     [fret_hist_sel_out]=fret_hist(don_sel_traces,accep_sel_traces, gamma, fret_index);
%     
%     
   file_exp = fret_hist_sel_out;
   [~,b_ind] = size(file_exp)
   for i = 1:b_ind
       if file_exp(i) < 0
           file_exp(i) = -1;
       end
       if file_exp(i)> 1
           file_exp(i) = -1;
       end
   end
   file_exp = file_exp(file_exp~=-1);
   [~,b_ind] = size(file_exp)
   file = file_exp;
   uisave({'file'}); 


% --- Executes on button press in save111.
function save111_Callback(hObject, eventdata, handles)
% hObject    handle to save111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global time_axis
global don_spec_trace
global accep_spec_trace
global inde
global inde_stop
DON_Bleach = don_spec_trace(:,inde);
ACC_Bleach = accep_spec_trace(:,inde);

pre_DON = zeros(length(inde),1);
after_DON = zeros(length(inde),1);
pre_ACC = zeros(length(inde),1);
after_ACC = zeros(length(inde),1);

for i = 1:length(inde)
    
    after_DON(i) = mean(DON_Bleach(inde_stop(i)+2:inde_stop(i)+7,i));
    pre_DON(i) = mean(DON_Bleach(inde_stop(i)-7:inde_stop(i)-2,i));
    
    after_ACC(i) = mean(ACC_Bleach(inde_stop(i)+2:inde_stop(i)+7,i));
    pre_ACC(i) = mean(ACC_Bleach(inde_stop(i)-7:inde_stop(i)-2,i));

end

uisave({'time_axis','DON_Bleach','ACC_Bleach','pre_DON','after_DON','pre_ACC','after_ACC'}); 


% --- Executes on button press in launch_vbfret.
function launch_vbfret_Callback(hObject, eventdata, handles)
% hObject    handle to launch_vbfret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ispc == 1
    seps = '\';
else
    seps = '/';
end
addpath([pwd,seps,'KAT',seps,'vbFRET'])
vbFRET


% --- Executes on button press in anal_hist.
function anal_hist_Callback(hObject, eventdata, handles)
% hObject    handle to anal_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% insert the code here for the analysis of the histograms
run kat_histos


% --- Executes during object creation, after setting all properties.
function anal_hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anal_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function don_trace_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to don_trace_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_trace_thresh as text
%        str2double(get(hObject,'String')) returns contents of don_trace_thresh as a double


% --- Executes during object creation, after setting all properties.
function don_trace_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_trace_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_trace_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to accep_trace_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_trace_thresh as text
%        str2double(get(hObject,'String')) returns contents of accep_trace_thresh as a double


% --- Executes during object creation, after setting all properties.
function accep_trace_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_trace_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in auto_filter_trace.
function auto_filter_trace_Callback(hObject, eventdata, handles)
% hObject    handle to auto_filter_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA) 
global don_spec_trace 
global accep_spec_trace
global Complete_SET
global Mode1
global time_axis
% get the filtering values
% SNR1 = sig quality
% SNR2 = sig over bckg
% don snr1 & accep snr1
if ispc == 1
    seps = '\';
else
    seps = '/';
end
addpath([pwd,seps,'KAT'])
% don snr2 & accep snr2
don_thresh = str2double(get(handles.don_trace_thresh,'String'));
accep_thresh = str2double(get(handles.accep_trace_thresh,'String'));
mov_window = str2double(get(handles.filt_win,'String'));
filt_f_back = str2double(get(handles.filt_f_back,'String'));
don_f_ratio = str2double(get(handles.don_f_ratio,'String'));
accep_f_ratio = str2double(get(handles.accep_f_ratio,'String'));
don_snr1 = str2double(get(handles.don_snr1,'String'));
acp_snr1 = str2double(get(handles.acp_snr1,'String'));
don_snr2 = str2double(get(handles.don_snr2,'String'));
acp_snr2 = str2double(get(handles.acp_snr2,'String'));
tot_snr1 = str2double(get(handles.tot_snr1,'String'));
min_fret = str2double(get(handles.min_fret,'String'));
plot_filt = get(handles.disp_filter,'Value');
don_life_thresh = str2double(get(handles.don_f_ratio,'String'));
accep_life_thresh = str2double(get(handles.accep_f_ratio,'String'));
% get the number of traces
%size(1 = number of time points)
% size(2 = number of traces)
f_offset = filt_f_back - 1;
time_ints = str2num(get(handles.disp_time_int,'String'));
num_filts = size(don_spec_trace,2);
gamma = str2num(get(handles.gamma_corr_val,'String'));
%% perform filtration
if strcmp(Mode1, 'Multicolor')
    [filt_don, filt_accep, filt_tot,don_lifetime,accep_lifetime,don_cps,accep_cps,don_blchpoint,accep_blchpoint,fret_blchpoint,blch_pt,...
        snr_don_bckg,snr_don_var,snr_accep_bckg,snr_accep_var,snr_tot_var] = autofilter_twocolor...
        (don_spec_trace,accep_spec_trace,don_thresh,accep_thresh,mov_window,filt_f_back,f_offset,plot_filt,time_ints,don_life_thresh,accep_life_thresh,...
        don_snr1,acp_snr1,don_snr2,acp_snr2,gamma,tot_snr1); 
    setappdata(handles.load_traces,'blch_don',don_blchpoint);
    setappdata(handles.load_traces,'blch_accep',accep_blchpoint);
    setappdata(handles.load_traces,'blch_fret',fret_blchpoint);
    setappdata(handles.load_traces,'blch_type',blch_pt);
    setappdata(handles.load_traces,'snr_don_var',snr_don_var);
    setappdata(handles.load_traces,'snr_accep_var',snr_accep_var);

    % get the non selected traces
    [~,all_traces_t] = size(don_spec_trace);
    all_traces = 1:all_traces_t;
    non_sel_traces = setdiff(all_traces, filt_tot)';
    setappdata(handles.nonsel_list_traces,'non_sel_traces',non_sel_traces);
    set(handles.nonsel_list_traces,'String',non_sel_traces);
    set(handles.num_nonsel,'String',num2str(size(non_sel_traces,1)));
end

if strcmp(Mode1, 'onecolor')
    [filt_don, filt_tot,don_lifetime,don_cps,don_blchpoint] = autofilter_single(don_spec_trace,don_thresh,mov_window,filt_f_back,f_offset,...
        plot_filt,time_ints,don_life_thresh,don_snr1);
    setappdata(handles.load_traces, 'don_blchpoint',don_blchpoint);
    save('single_color.mat','don_lifetime','don_cps','don_blchpoint')
    axes(handles.axes10)  
%     histogram(don_lifetime,10);
%     axes(handles.axes11)
    histogram(don_cps,10);
end  
% Value 1 = total traces
% Value 2 = donor bleached
% Value 3 = acceptor bleached
% Value 4 = total number of bleached traces
% Value 5 = percentage of traces
if strcmp(Mode1, 'onecolor')
tot_blch_traces = length(filt_don);    
elseif strcmp(Mode1, 'Multicolor')
tot_blch_traces = length(filt_tot);    
gamma_traces = filt_accep;
set(handles.listbox5,'String',gamma_traces);
gamma_trace_sel = gamma_traces';
setappdata(handles.load_traces,'gamma_trace_sel',gamma_trace_sel);
set(handles.disp_gamma_trace,'String', num2str(numel(gamma_traces)));
end
perc_filt = (tot_blch_traces/num_filts)*100;
set(handles.text34, 'String', num2str(num_filts))
set(handles.text43, 'String', num2str(length(filt_don)));
set(handles.text45, 'String', num2str(tot_blch_traces));
set(handles.text46, 'String', num2str(perc_filt))

if strcmp(Mode1, 'Multicolor')
set(handles.text44, 'String', num2str(length(filt_accep)));
end

Complete_SET = filt_tot;
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';
num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
num_list_sel_trace = num2str((sel_trace_sub)');
set(handles.sel_list_traces, 'String', num_list_sel_trace);
set(handles.filter_status,'String','Filtered');
setappdata(handles.filter_status,'filt_status',1);
%% Compute the SNR for the filtered trace
%% Compute the new overlays based on the selected traces
% Create the heat maps
% fret_res = str2num(get(handles.fret_res,'String'));
don_heat_trace = don_spec_trace(:,filt_tot);
accep_heat_trace = accep_spec_trace(:,filt_tot);
max_intens_d = median(max(don_heat_trace));
if max_intens_d >= 1000
    max_intens_d = roundn(max_intens_d,3)*1.5;
elseif max_intens_d >=100
  max_intens_d = roundn(max_intens_d,2);
end
max_intens_a = median(max(accep_heat_trace));
if max_intens_a >=1000
    max_intens_a = roundn(max_intens_a,3)*1.5;
elseif max_intens_a >= 100
    max_intens_a = roundn(max_intens_a,2);
end
min_intens_d = min(min(don_heat_trace));
min_intens_a = min(min(accep_heat_trace));
        if  min_intens_d < 0
            min_intens_d = 0;
        end
        if min_intens_a <0
           min_intens_a = 0;
        end
Index1 = 1;
Index2 = length(time_axis);
[time_bins,~] = size(don_heat_trace);
counter_inten = 0;
for k = 1:time_bins
    counter_inten = counter_inten + 1;
    edges_intens_d = linspace(min_intens_d, max_intens_d, 10);
    edges_intens_a = linspace(min_intens_a, max_intens_a, 10);
    [c,d] = hist(don_heat_trace(k,:),edges_intens_d);
    [e,f] = hist(accep_heat_trace(k,:),edges_intens_a);
    c_h_t(counter_inten,:) = c;
    e_h_t(counter_inten,:) = e;
end
[a1,~] = size((c_h_t)');
re_hist = c_h_t';
counter2 = 0;
        for i = 1:a1
            counter2 = counter2+1;
            bar_count(counter2,:) = sum(re_hist(i,:));
        end
mol_tot = sum(c_h_t(1,:));
% axes(handles.axes6)
% contourf(time_axis(Index1:Index2), edges_intens_d, c_h_t');
% xlabel('Time (s)')
% ylabel ('F_DONOR','FontWeight','bold','Color','g')
% title (['Total number of molecules = ',num2str(mol_tot)]);
% if strcmp(Mode1, 'Multicolor')
% axes(handles.axes21)
% contourf(time_axis(Index1:Index2), edges_intens_a, e_h_t');
% xlabel('Time (s)')
% ylabel ('F_ACCEP','FontWeight','bold','Color','r')
% end
if strcmp(Mode1, 'Multicolor')
[a_h_t2,~] = heatmap_updater(don_heat_trace, accep_heat_trace,gamma,time_axis,fret_blchpoint); 
mol_tot = sum(a_h_t2(1,:));
axes(handles.axes10)
fret_res = 0.1;
edges = [0:fret_res:1];
[M,cf] = contourf(time_axis, edges, a_h_t2',25);
cf.LineStyle = 'none';
% colormap('hot')
prop.b2 = gca;
ylabel ('FRET Efficiency')
title (['Total number of molecules = ',num2str(mol_tot)]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');
prop.b2.FontWeight = 'bold';
overlay_popmenu_Callback(hObject, eventdata, handles)
end
% run_value_man = 1;
% setappdata(handles.load_traces,'run_value_man', run_value_man);

% [~,tot_hist_obs] = trace_to_hist(don_heat_trace, accep_heat_trace, fret_blchpoint, gamma);
% set(handles.disp_tot_datapts,'String', num2str(tot_hist_obs));
% axes(handles.axes28)
% histogram(fret_sel_all_hist2, linspace(0,1,50))
% title('FRET');
% xticks([0:.2:1]);
% a = get(gca,'XTickLabel');  
% set(gca,'XTickLabel',a,'fontsize',9,'FontWeight','bold')



function filt_win_Callback(hObject, eventdata, handles)
% hObject    handle to filt_win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filt_win as text
%        str2double(get(hObject,'String')) returns contents of filt_win as a double


% --- Executes during object creation, after setting all properties.
function filt_win_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filt_win (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filt_f_back_Callback(hObject, eventdata, handles)
% hObject    handle to filt_f_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filt_f_back as text
%        str2double(get(hObject,'String')) returns contents of filt_f_back as a double


% --- Executes during object creation, after setting all properties.
function filt_f_back_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filt_f_back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function don_f_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to don_f_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_f_ratio as text
%        str2double(get(hObject,'String')) returns contents of don_f_ratio as a double


% --- Executes during object creation, after setting all properties.
function don_f_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_f_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_f_ratio_Callback(hObject, eventdata, handles)
% hObject    handle to accep_f_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_f_ratio as text
%        str2double(get(hObject,'String')) returns contents of accep_f_ratio as a double


% --- Executes during object creation, after setting all properties.
function accep_f_ratio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_f_ratio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function don_snr1_Callback(hObject, eventdata, handles)
% hObject    handle to don_snr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_snr1 as text
%        str2double(get(hObject,'String')) returns contents of don_snr1 as a double


% --- Executes during object creation, after setting all properties.
function don_snr1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_snr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% function don_int_thresh_Callback(hObject, eventdata, handles)
% % hObject    handle to don_snr2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of don_snr2 as text
% %        str2double(get(hObject,'String')) returns contents of don_snr2 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function don_int_thresh_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to don_snr2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end



function acp_snr1_Callback(hObject, eventdata, handles)
% hObject    handle to acp_snr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acp_snr1 as text
%        str2double(get(hObject,'String')) returns contents of acp_snr1 as a double


% --- Executes during object creation, after setting all properties.
function acp_snr1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acp_snr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_plot.
function start_plot_Callback(hObject, eventdata, handles)
% hObject    handle to start_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global p_start
% global p_end
% global butt_lim 
% butt_lim = 1;
% min_time_t = str2double(get(handles.disp_time_int,'String'));
% min_time = min_time_t/1000;
% if p_start < min_time
%    p_start = min_time;
%    set(handles.edit12,'String',num2str(min_time));
% end
% %set(handles.axes1,'XLimMode','auto'); %This is the default
% set(handles.axes1,'XLim',[p_start,p_end]); 
% set(handles.axes7,'XLim',[p_start,p_end]); 
% set(handles.axes8,'XLim',[p_start,p_end]); 
% % set(handles.axes14,'XLim',[p_start,p_end]); 
% set(handles.axes9,'XLim',[p_start,p_end]); 
% set(handles.axes1,'XTick',[]);
% set(handles.axes7,'XTick',[]);
% set(handles.axes8,'XTick',[]);
% set(handles.axes19,'XLim',[p_start p_end]);
% % set(handles.axes20,'XLim',[p_start p_end]);


% --- Executes during object creation, after setting all properties.
function type_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in sel_all.
function sel_all_Callback(hObject, eventdata, handles)
% hObject    handle to sel_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Complete_SET
global don_spec_trace
[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((1:num_traces)');
Complete_SET = (1:num_traces)';
set(handles.sel_list_traces, 'String', Complete_SET);
num_sel_trace = str2num(get(handles.num_sel_traces,'String'));
sel_trace_sub = Complete_SET';
num_sel_trace = nnz(sel_trace_sub);
setappdata(handles.load_traces,'sel_trace_sub',sel_trace_sub)
set(handles.num_sel_traces,'String',num2str(num_sel_trace));
num_list_sel_trace = num2str((sel_trace_sub)');
set(handles.sel_list_traces, 'String', num_list_sel_trace);
run_value_man = 0;
setappdata(handles.load_traces,'run_value_man', run_value_man);


% --- Executes on button press in refresh_overlay.
function refresh_overlay_Callback(hObject, eventdata, handles)
% hObject    handle to refresh_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in disp_filter.
function disp_filter_Callback(hObject, eventdata, handles)
% hObject    handle to disp_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of disp_filter



function disp_time_int_Callback(hObject, eventdata, handles)
% hObject    handle to disp_time_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_time_int as text
%        str2double(get(hObject,'String')) returns contents of disp_time_int as a double


% --- Executes during object creation, after setting all properties.
function disp_time_int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_time_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in anal_single.
function anal_single_Callback(hObject, eventdata, handles)
% hObject    handle to anal_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_histos_single



function fret_res_Callback(hObject, eventdata, handles)
% hObject    handle to fret_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fret_res as text
%        str2double(get(hObject,'String')) returns contents of fret_res as a double


% --- Executes during object creation, after setting all properties.
function fret_res_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fret_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in del_gamma_trace.
function del_gamma_trace_Callback(hObject, eventdata, handles)
% hObject    handle to del_gamma_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in qik_guide1.
function qik_guide1_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','These parameters are for Automatic Filtering',...
         '1) For each trace 10 bins are created of the Variance ','2) Don/Accep bins: # of bins forward (8/10) to consider',...
         '3) Higher bins are more stringent','4) Mov.Window = Moving window for averaging',...
         '5) Frame Back: Frames back from identified bleachpoint that collection starts ','6) Lifetime(s): Don/Accep minimum lifetimes that are selected',...
         '7) Thresh(old): Don/FRET-number of values from start to bleach point that can be outside of the range','8) Run Automatic Filter'},...
        'KAT2: Help');


% --- Executes on button press in qik_guide2.
function qik_guide2_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','After Trace Filtering the Traces are futher analysed based on single-color/Dyes or FRET',...
         '1) Histograms-Single: analyses single-color traces and generates Heat Maps and Trace Analysis','2) Histograms-FRET: analyses FRET traces and performs advanced filtering'
         },'KAT2: Help');



function acp_snr2_Callback(hObject, eventdata, handles)
% hObject    handle to acp_snr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of acp_snr2 as text
%        str2double(get(hObject,'String')) returns contents of acp_snr2 as a double


% --- Executes during object creation, after setting all properties.
function acp_snr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to acp_snr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reload_file.
function reload_file_Callback(hObject, eventdata, handles)
% hObject    handle to reload_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reload_file



function don_snr2_Callback(hObject, eventdata, handles)
% hObject    handle to don_snr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_snr2 as text
%        str2double(get(hObject,'String')) returns contents of don_snr2 as a double


% --- Executes during object creation, after setting all properties.
function don_snr2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_snr2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% function acceps_int_thresh_Callback(hObject, eventdata, handles)
% % hObject    handle to acp_snr2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% % Hints: get(hObject,'String') returns contents of acp_snr2 as text
% %        str2double(get(hObject,'String')) returns contents of acp_snr2 as a double
% 
% 
% % --- Executes during object creation, after setting all properties.
% function acceps_int_thresh_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to acp_snr2 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


% --- Executes on button press in proc_trace.
function proc_trace_Callback(hObject, eventdata, handles)
% hObject    handle to proc_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of proc_trace


% --- Executes on button press in disp_tot_bckg.
function disp_tot_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to disp_tot_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton7.
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton7



function disp_gamma_trace_Callback(hObject, eventdata, handles)
% hObject    handle to disp_gamma_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_gamma_trace as text
%        str2double(get(hObject,'String')) returns contents of disp_gamma_trace as a double


% --- Executes during object creation, after setting all properties.
function disp_gamma_trace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_gamma_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in man_selection.
function man_selection_Callback(hObject, eventdata, handles)
% hObject    handle to man_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function man_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to man_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of man_lifetime as text
%        str2double(get(hObject,'String')) returns contents of man_lifetime as a double


% --- Executes during object creation, after setting all properties.
function man_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to man_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function get_sel_trace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_sel_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton11


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton12


% --- Executes on button press in exp_vals.
function exp_vals_Callback(hObject, eventdata, handles)
% hObject    handle to exp_vals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_sel_t = get(handles.sel_list_traces,'Value');
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel = sel_trace_sub(index_sel_t);
don_sel = getappdata(handles.list_traces, 'don_sel');
accep_sel = getappdata(handles.list_traces, 'accep_sel');
time_axis = getappdata(handles.list_traces, 'time_axis');
fret_trace = getappdata(handles.list_traces, 'fret_trace');
exp_name = num2str(index_sel);
save(['exp_',exp_name],'time_axis','don_sel','accep_sel','fret_trace')


% --- Executes on button press in radiobutton13.
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton13


% --- Executes on selection change in listbox6.
function listbox6_Callback(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox6


% --- Executes during object creation, after setting all properties.
function listbox6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in subgrp_1.
function subgrp_1_Callback(hObject, eventdata, handles)
% hObject    handle to subgrp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_sublist1 = getappdata(handles.subgrp_1,'temp_sublist1');
index_sel_1_t = get(handles.sel_list_traces,'Value');
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel_1 = sel_trace_sub(index_sel_1_t);
if length(temp_sublist1)>=1
    temp_sublist1 = vertcat(temp_sublist1,index_sel_1);
else
    temp_sublist1 = index_sel_1;
end
temp_sublist1 = sort(temp_sublist1);
set(handles.sel_list_sub1,'String',num2str(temp_sublist1));
setappdata(handles.subgrp_1,'temp_sublist1', temp_sublist1);
num_sub1 = length(temp_sublist1);
set(handles.disp_num_sub1,'String',num2str(num_sub1));

% --- Executes on selection change in sel_list_sub1.
function sel_list_sub1_Callback(hObject, eventdata, handles)
% hObject    handle to sel_list_sub1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sel_list_sub1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_list_sub1
index_sel_grp1 = get(handles.sel_list_sub1,'Value');
sel_trace_sub1 = getappdata(handles.subgrp_1,'temp_sublist1');
curr_trace1 = sel_trace_sub1(index_sel_grp1);
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
ind_main_list = find(sel_trace_sub == curr_trace1);
handles.sel_list_traces.Value = ind_main_list; 
sel_list_traces_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function sel_list_sub1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_list_sub1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_subgrp_1.
function save_subgrp_1_Callback(hObject, eventdata, handles)
% hObject    handle to save_subgrp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FIL
global NAME_FILTER
%index_sel_t = get(handles.sel_list_traces,'Value');
sel_trace_sub1 = getappdata(handles.subgrp_1,'temp_sublist1');
Mode1 = getappdata(handles.load_traces, 'Mode1');
oper_mode = getappdata(handles.load_traces, 'oper_mode');
run_man = 0;
don_tot_trace = getappdata(handles.load_traces, 'don_tot_trace');
don_bckg_trace = getappdata(handles.load_traces, 'don_bckg_trace');
accep_tot_trace = getappdata(handles.load_traces, 'accep_tot_trace');
accep_bckg_trace = getappdata(handles.load_traces, 'accep_bckg_trace');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
Picture_d = getappdata(handles.load_traces, 'Picture_d');
Picture_a = getappdata(handles.load_traces, 'Picture_a');
centers_ext = getappdata(handles.load_traces, 'centers_ext');
a1 = [];
a2 = [];
a3 = [];
a5 = [];
a6 = [];
a7 = [];
a8 = [];
a9 = [];
if FIL == 0
a1 = don_tot_trace(:,sel_trace_sub1);
a2 = don_bckg_trace(:,sel_trace_sub1);
a3 = don_spec_trace(:,sel_trace_sub1) ;
a10 = centers_ext(sel_trace_sub1,:);
if oper_mode ==2
a5 = accep_tot_trace(:,sel_trace_sub1);
a6 = accep_bckg_trace(:,sel_trace_sub1);
a7 = accep_spec_trace(:,sel_trace_sub1);
end

counter_Pics = 0;
for i = 1:length(sel_trace_sub1)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub1(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub1(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub1(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub1(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub1(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub1(i),3};
end    
a8 = Picture_d_temp;
a9 = Picture_a_temp;
elseif FIL == 1    
for i = 1:length(sel_trace_sub1)
a11 = smooth(don_tot_trace(:,sel_trace_sub1(i)),NAME_FILTER);
a21 = smooth(don_bckg_trace(:,sel_trace_sub1(i)),NAME_FILTER);
a31 = smooth(don_spec_trace(:,sel_trace_sub1(i)),NAME_FILTER);
if oper_mode == 2
a51 = smooth(accep_tot_trace(:,sel_trace_sub1(i)),NAME_FILTER);
a61 = smooth(accep_bckg_trace(:,sel_trace_sub1(i)),NAME_FILTER);
a71 = smooth(accep_spec_trace(:,sel_trace_sub1(i)),NAME_FILTER); 
end
counter_Pics = 0;
for i = 1:length(sel_trace_sub1)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub1(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub1(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub1(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub1(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub1(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub1(i),3};
end
a1 = [a1,a11];
a2 = [a2,a21];
a3 = [a3,a31];
if oper_mode == 2
a5 = [a5,a51];
a6 = [a6,a61];
a7 = [a7,a71];
end
a8 = [a8,Picture_d_temp];
a9 = [a9,Picture_a_temp];
end

end
don_tot_trace=a1; 
don_bckg_trace=a2;
don_spec_trace=a3;
if oper_mode == 2
accep_tot_trace=a5;
accep_bckg_trace= a6;
accep_spec_trace= a7;
end
Picture_d = a8;
Picture_a = a9;
centers_ext = a10;

if oper_mode ==1
    filtered_data = 1;
    blch_single = getappdata(handles.load_traces, 'don_blchpoint');
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                  'Picture_d','Picture_a','Mode1','filtered_data','blch_single','centers_ext'});
elseif oper_mode ==2
    filtered_data = 1;
    blch_don_t = getappdata(handles.load_traces,'blch_don');
    blch_accep_t = getappdata(handles.load_traces,'blch_accep');
    blch_fret_t = getappdata(handles.load_traces,'blch_fret');
    blch_type_t = getappdata(handles.load_traces,'blch_type');      
     if run_man >= 1
        blch_don = blch_don_t;
        blch_accep = blch_accep_t;
        blch_fret = blch_fret_t;
        blch_type = blch_type_t;
    else
        blch_don = blch_don_t(:,sel_trace_sub1);
        blch_accep = blch_accep_t(:,sel_trace_sub1);
        blch_fret = blch_fret_t(:,sel_trace_sub1);
        blch_type = blch_type_t(:,sel_trace_sub1);
     end   

% Save statistics
trace_stats1 = get(handles.save_stats, 'Value');
if trace_stats1 == 1
    sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
    trace_list = sel_trace_sub';
    trace_list1 = sel_trace_sub1;
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext','trace_list','trace_list1'});
else
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext'});
end

end



% --- Executes on button press in subgrp_2.
function subgrp_2_Callback(hObject, eventdata, handles)
% hObject    handle to subgrp_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_sublist2 = getappdata(handles.subgrp_2,'temp_sublist2');
index_sel_2_t = get(handles.sel_list_traces,'Value');
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel_2 = sel_trace_sub(index_sel_2_t);
if length(temp_sublist2)>=1
    temp_sublist2 = vertcat(temp_sublist2,index_sel_2);
else
    temp_sublist2 = index_sel_2;
end
temp_sublist2 = sort(temp_sublist2);
set(handles.sel_list_sub2,'String',num2str(temp_sublist2));
setappdata(handles.subgrp_2,'temp_sublist2', temp_sublist2);
num_sub2 = length(temp_sublist2);
set(handles.disp_num_sub2,'String',num2str(num_sub2));


% --- Executes on selection change in sel_list_sub2.
function sel_list_sub2_Callback(hObject, eventdata, handles)
% hObject    handle to sel_list_sub2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sel_list_sub2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_list_sub2
index_sel_grp2 = get(handles.sel_list_sub2,'Value');
sel_trace_sub2 = getappdata(handles.subgrp_2,'temp_sublist2');
curr_trace1 = sel_trace_sub2(index_sel_grp2);
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
ind_main_list = find(sel_trace_sub == curr_trace1);
handles.sel_list_traces.Value = ind_main_list; 
sel_list_traces_Callback(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function sel_list_sub2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_list_sub2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_subgrp_2.
function save_subgrp_2_Callback(hObject, eventdata, handles)
% hObject    handle to save_subgrp_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FIL
global NAME_FILTER
%index_sel_t = get(handles.sel_list_traces,'Value');
sel_trace_sub2 = getappdata(handles.subgrp_2,'temp_sublist2');
Mode1 = getappdata(handles.load_traces, 'Mode1');
oper_mode = getappdata(handles.load_traces, 'oper_mode');
run_man = 0;
don_tot_trace = getappdata(handles.load_traces, 'don_tot_trace');
don_bckg_trace = getappdata(handles.load_traces, 'don_bckg_trace');
accep_tot_trace = getappdata(handles.load_traces, 'accep_tot_trace');
accep_bckg_trace = getappdata(handles.load_traces, 'accep_bckg_trace');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
Picture_d = getappdata(handles.load_traces, 'Picture_d');
Picture_a = getappdata(handles.load_traces, 'Picture_a');
centers_ext = getappdata(handles.load_traces, 'centers_ext');

a1 = [];
a2 = [];
a3 = [];

a5 = [];
a6 = [];
a7 = [];
a8 = [];
a9 = [];

if FIL == 0
a1 = don_tot_trace(:,sel_trace_sub2);
a2 = don_bckg_trace(:,sel_trace_sub2);
a3 = don_spec_trace(:,sel_trace_sub2) ;
a10 = centers_ext(sel_trace_sub2,:);
if oper_mode ==2
a5 = accep_tot_trace(:,sel_trace_sub2);
a6 = accep_bckg_trace(:,sel_trace_sub2);
a7 = accep_spec_trace(:,sel_trace_sub2);
end

counter_Pics = 0;
for i = 1:length(sel_trace_sub2)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub2(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub2(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub2(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub2(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub2(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub2(i),3};
end    
a8 = Picture_d_temp;
a9 = Picture_a_temp;
elseif FIL == 1    
for i = 1:length(sel_trace_sub2)
a11 = smooth(don_tot_trace(:,sel_trace_sub2(i)),NAME_FILTER);
a21 = smooth(don_bckg_trace(:,sel_trace_sub2(i)),NAME_FILTER);
a31 = smooth(don_spec_trace(:,sel_trace_sub2(i)),NAME_FILTER);
if oper_mode == 2
a51 = smooth(accep_tot_trace(:,sel_trace_sub2(i)),NAME_FILTER);
a61 = smooth(accep_bckg_trace(:,sel_trace_sub2(i)),NAME_FILTER);
a71 = smooth(accep_spec_trace(:,sel_trace_sub2(i)),NAME_FILTER); 
end
counter_Pics = 0;
for i = 1:length(sel_trace_sub2)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub2(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub2(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub2(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub2(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub2(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub2(i),3};
end
a1 = [a1,a11];
a2 = [a2,a21];
a3 = [a3,a31];
if oper_mode == 2
a5 = [a5,a51];
a6 = [a6,a61];
a7 = [a7,a71];
end
a8 = [a8,Picture_d_temp];
a9 = [a9,Picture_a_temp];
end

end
don_tot_trace=a1; 
don_bckg_trace=a2;
don_spec_trace=a3;
if oper_mode == 2
accep_tot_trace=a5;
accep_bckg_trace= a6;
accep_spec_trace= a7;
end
Picture_d = a8;
Picture_a = a9;
centers_ext = a10;

if oper_mode ==1
    filtered_data = 1;
    blch_single = getappdata(handles.load_traces, 'don_blchpoint');
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                  'Picture_d','Picture_a','Mode1','filtered_data','blch_single','centers_ext'});
elseif oper_mode ==2
    filtered_data = 1;
    blch_don_t = getappdata(handles.load_traces,'blch_don');
    blch_accep_t = getappdata(handles.load_traces,'blch_accep');
    blch_fret_t = getappdata(handles.load_traces,'blch_fret');
    blch_type_t = getappdata(handles.load_traces,'blch_type');
    
    if run_man >= 1
        blch_don = blch_don_t;
        blch_accep = blch_accep_t;
        blch_fret = blch_fret_t;
        blch_type = blch_type_t;
    else
        blch_don = blch_don_t(:,sel_trace_sub2);
        blch_accep = blch_accep_t(:,sel_trace_sub2);
        blch_fret = blch_fret_t(:,sel_trace_sub2);
        blch_type = blch_type_t(:,sel_trace_sub2);
    end
    
% Save statistics
trace_stats1 = get(handles.save_stats, 'Value');
if trace_stats1 == 1
    sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
    trace_list = sel_trace_sub';
    trace_list2 = sel_trace_sub2;
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext','trace_list','trace_list2'});
else
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext'});
end
end



% --- Executes on button press in load_folder.
function load_folder_Callback(hObject, eventdata, handles)
% hObject    handle to load_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of load_folder


% --- Executes on button press in radiobutton15.
function radiobutton15_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton15


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in subgrp_3.
function subgrp_3_Callback(hObject, eventdata, handles)
% hObject    handle to subgrp_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_sublist3 = getappdata(handles.subgrp_3,'temp_sublist3');
index_sel_3_t = get(handles.sel_list_traces,'Value');
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
index_sel_3 = sel_trace_sub(index_sel_3_t);
if length(temp_sublist3)>=1
    temp_sublist3 = vertcat(temp_sublist3,index_sel_3);
else
    temp_sublist3 = index_sel_3;
end
temp_sublist3 = sort(temp_sublist3);
set(handles.sel_list_sub3,'String',num2str(temp_sublist3));
setappdata(handles.subgrp_3,'temp_sublist3', temp_sublist3);
num_sub3 = length(temp_sublist3);
set(handles.disp_num_sub3,'String',num2str(num_sub3));


% --- Executes on selection change in sel_list_sub3.
function sel_list_sub3_Callback(hObject, eventdata, handles)
% hObject    handle to sel_list_sub3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sel_list_sub3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_list_sub3
index_sel_grp3 = get(handles.sel_list_sub3,'Value');
sel_trace_sub3 = getappdata(handles.subgrp_3,'temp_sublist3');
curr_trace1 = sel_trace_sub3(index_sel_grp3);
sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
ind_main_list = find(sel_trace_sub == curr_trace1);
handles.sel_list_traces.Value = ind_main_list; 
sel_list_traces_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function sel_list_sub3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_list_sub3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_subgrp_3.
function save_subgrp_3_Callback(hObject, eventdata, handles)
% hObject    handle to save_subgrp_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FIL
global NAME_FILTER
%index_sel_t = get(handles.sel_list_traces,'Value');
sel_trace_sub3 = getappdata(handles.subgrp_3,'temp_sublist3');
Mode1 = getappdata(handles.load_traces, 'Mode1');
oper_mode = getappdata(handles.load_traces, 'oper_mode');
run_man = 0;
don_tot_trace = getappdata(handles.load_traces, 'don_tot_trace');
don_bckg_trace = getappdata(handles.load_traces, 'don_bckg_trace');
accep_tot_trace = getappdata(handles.load_traces, 'accep_tot_trace');
accep_bckg_trace = getappdata(handles.load_traces, 'accep_bckg_trace');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
Picture_d = getappdata(handles.load_traces, 'Picture_d');
Picture_a = getappdata(handles.load_traces, 'Picture_a');
centers_ext = getappdata(handles.load_traces, 'centers_ext');
a1 = [];
a2 = [];
a3 = [];
a5 = [];
a6 = [];
a7 = [];
a8 = [];
a9 = [];
if FIL == 0
a1 = don_tot_trace(:,sel_trace_sub3);
a2 = don_bckg_trace(:,sel_trace_sub3);
a3 = don_spec_trace(:,sel_trace_sub3) ;
a10 = centers_ext(sel_trace_sub3,:);
if oper_mode ==2
a5 = accep_tot_trace(:,sel_trace_sub3);
a6 = accep_bckg_trace(:,sel_trace_sub3);
a7 = accep_spec_trace(:,sel_trace_sub3);
end

counter_Pics = 0;
for i = 1:length(sel_trace_sub3)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub3(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub3(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub3(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub3(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub3(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub3(i),3};
end
    
a8 = Picture_d_temp;
a9 = Picture_a_temp;

elseif FIL == 1    
for i = 1:length(sel_trace_sub3)
a11 = smooth(don_tot_trace(:,sel_trace_sub3(i)),NAME_FILTER);
a21 = smooth(don_bckg_trace(:,sel_trace_sub3(i)),NAME_FILTER);
a31 = smooth(don_spec_trace(:,sel_trace_sub3(i)),NAME_FILTER);
if oper_mode == 2
a51 = smooth(accep_tot_trace(:,sel_trace_sub3(i)),NAME_FILTER);
a61 = smooth(accep_bckg_trace(:,sel_trace_sub3(i)),NAME_FILTER);
a71 = smooth(accep_spec_trace(:,sel_trace_sub3(i)),NAME_FILTER); 
end
counter_Pics = 0;
for i = 1:length(sel_trace_sub3)
    counter_Pics = counter_Pics + 1; 
    Picture_d_temp{counter_Pics,1}= Picture_d{sel_trace_sub3(i),1};
    Picture_d_temp{counter_Pics,2}= Picture_d{sel_trace_sub3(i),2};
    Picture_d_temp{counter_Pics,3}= Picture_d{sel_trace_sub3(i),3};
    Picture_a_temp{counter_Pics,1}= Picture_a{sel_trace_sub3(i),1};
    Picture_a_temp{counter_Pics,2}= Picture_a{sel_trace_sub3(i),2};
    Picture_a_temp{counter_Pics,3}= Picture_a{sel_trace_sub3(i),3};
end
a1 = [a1,a11];
a2 = [a2,a21];
a3 = [a3,a31];
if oper_mode == 2
a5 = [a5,a51];
a6 = [a6,a61];
a7 = [a7,a71];
end
a8 = [a8,Picture_d_temp];
a9 = [a9,Picture_a_temp];
end

end
don_tot_trace=a1; 
don_bckg_trace=a2;
don_spec_trace=a3;
if oper_mode == 2
accep_tot_trace=a5;
accep_bckg_trace= a6;
accep_spec_trace= a7;
end
Picture_d = a8;
Picture_a = a9;
centers_ext = a10;

if oper_mode ==1
    filtered_data = 1;
    blch_single = getappdata(handles.load_traces, 'don_blchpoint');
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                  'Picture_d','Picture_a','Mode1','filtered_data','blch_single','centers_ext'});
elseif oper_mode ==2
    filtered_data = 1;
    blch_don_t = getappdata(handles.load_traces,'blch_don');
    blch_accep_t = getappdata(handles.load_traces,'blch_accep');
    blch_fret_t = getappdata(handles.load_traces,'blch_fret');
    blch_type_t = getappdata(handles.load_traces,'blch_type');
    
    if run_man >= 1
        blch_don = blch_don_t;
        blch_accep = blch_accep_t;
        blch_fret = blch_fret_t;
        blch_type = blch_type_t;
    else
        blch_don = blch_don_t(:,sel_trace_sub3);
        blch_accep = blch_accep_t(:,sel_trace_sub3);
        blch_fret = blch_fret_t(:,sel_trace_sub3);
        blch_type = blch_type_t(:,sel_trace_sub3);
    end
    
% Save statistics
trace_stats1 = get(handles.save_stats, 'Value');
if trace_stats1 == 1
    sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
    trace_list = sel_trace_sub';
    trace_list3 = sel_trace_sub3;
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext','trace_list','trace_list3'});
else
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
'blch_accep','blch_fret','blch_type','centers_ext'});
end
end


function disp_folder_Callback(hObject, eventdata, handles)
% hObject    handle to disp_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_folder as text
%        str2double(get(hObject,'String')) returns contents of disp_folder as a double


% --- Executes during object creation, after setting all properties.
function disp_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in presort_trace.
function presort_trace_Callback(hObject, eventdata, handles)
% hObject    handle to presort_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in nonsel_list_traces.
function nonsel_list_traces_Callback(hObject, eventdata, handles)
% hObject    handle to nonsel_list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns nonsel_list_traces contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nonsel_list_traces
global don_spec_trace
global accep_spec_trace
global proc_trace_val
global file_frames
        if proc_trace_val == 1 
           if file_frames >1
           load('Traces_to_analyze.mat');
           else
            file_name = getappdata(handles.load_traces, 'file_name');
            load(file_name);               
           end           
           blch_pt = blch_fret;
           don_blchpoint = blch_fret;
           accep_blchpoint= blch_fret;           
        else
            file_name = getappdata(handles.load_traces, 'file_name');
            load(file_name);
        end
index_sel_t = get(handles.nonsel_list_traces,'Value');
non_sel_traces = getappdata(handles.nonsel_list_traces,'non_sel_traces');
index_sel = non_sel_traces(index_sel_t,:);
set(handles.trace_num,'String',num2str(index_sel));
set(handles.disp_status2,'String','NON_Selected');
don_sel = don_spec_trace(:,index_sel);
accep_sel = accep_spec_trace(:,index_sel);
axes(handles.axes1)
plot(time_axis, don_sel,'g');
axes(handles.axes7)
plot(time_axis, accep_sel,'r');

max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;
axes(handles.axes8)
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
axes(handles.axes9)
cla
% 


% --- Executes during object creation, after setting all properties.
function nonsel_list_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nonsel_list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reset_filter.
function reset_filter_Callback(hObject, eventdata, handles)
% hObject    handle to reset_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of reset_filter


% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function subgrp_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subgrp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in exp_fret_plot.
function exp_fret_plot_Callback(hObject, eventdata, handles)
% hObject    handle to exp_fret_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gamma = str2num(get(handles.gamma_corr_val,'String'));
type_export = get(handles.sel_exp_type,'Value');
% 1 = EBFRET/FRET PLOT
% 2 = VBFRET
% 3 = Mash
 switch type_export
     case{1}
        exp_type = 1;
        process_blch = get(handles.use_blch_pts, 'Value');
     case{2}
        exp_type = 2;
        process_blch = 1;
     case{3}
        exp_type = 3; 
 end
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
file_name = getappdata(handles.load_traces, 'file_name');
grp_traces_t = get(handles.uibuttongroup3, 'SelectedObject');
grp_traces = get(grp_traces_t, 'String');
%% determine if to use the bleach points
process_blch = get(handles.use_blch_pts, 'Value');
blch_don_t = getappdata(handles.load_traces,'blch_don');
blch_accep_t = getappdata(handles.load_traces,'blch_accep');
blch_fret_t = getappdata(handles.load_traces,'blch_fret');
%% process the trace data
switch grp_traces
    case {'Selected'}
        sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
        grp ='Selected';        
        blch_don = blch_don_t(:,sel_trace_sub);        
        blch_accep = blch_accep_t(:,sel_trace_sub);
        blch_fret = blch_fret_t(:,sel_trace_sub);
    case {'Grp 1'}
        sel_trace_sub = (getappdata(handles.subgrp_1,'temp_sublist1')');        
        grp = 'grp1';
        blch_don = blch_don_t(:,sel_trace_sub1);
        blch_accep = blch_accep_t(:,sel_trace_sub1);
        blch_fret = blch_fret_t(:,sel_trace_sub1);
    case {'Grp 2'}
        sel_trace_sub = (getappdata(handles.subgrp_2,'temp_sublist2')'); 
        grp = 'grp2';
         blch_don = blch_don_t(:,sel_trace_sub2);
         blch_accep = blch_accep_t(:,sel_trace_sub2);
         blch_fret = blch_fret_t(:,sel_trace_sub2);
end
gamma = str2num(get(handles.gamma_corr_val,'String'));  
vector = [];
h1 = msgbox('Writing Traces for Export');
counterAAAA = 1;
size(blch_fret)
for i = sel_trace_sub 
    don_sel = don_spec_trace(:,i).*gamma;
    accep_sel = accep_spec_trace(:,i);  
    blch_pt = blch_fret(:,i)+3;
    blch_diff = length(don_sel)-blch_pt;
    blch_diff_rand = rand(blch_diff,1);
    blch_diff_d = (ones(blch_diff,1))+ blch_diff_rand;
    blch_diff_a = (ones(blch_diff,1).*0.05) + blch_diff_rand;
    %% Pad the matrix
    for k = 1:length(don_sel)
        if don_sel(k) <0
            don_sel(k) = 0.1;
        end
    end    
    for k = 1:length(accep_sel)
        if accep_sel(k) < 0
            accep_sel(k) = 0.1;
        end            
    end
    
    if process_blch == 1
        don_sel_t = don_sel(1:blch_pt,:);
        accep_sel_t = accep_sel(1:blch_pt,:);
        don_sel_t = vertcat(don_sel_t,blch_diff_d);
        accep_sel_t = vertcat(accep_sel_t,blch_diff_a);
        don_sel = don_sel_t;
        accep_sel = accep_sel_t; 
    end
    
    if exp_type == 1
    values(:,1) = don_sel;
    values(:,2) = accep_sel;
    vector = horzcat(vector, values); 
    
    elseif exp_type == 2
        denom_fret_blch = accep_sel + (gamma.*don_sel);
        fret_calc_trace_blch = accep_sel./denom_fret_blch;  
        blch_diff = length(don_sel)-blch_pt;
        fret_diff = (zeros(blch_diff,1));
        accep_diff = (ones(blch_diff,1)).*0.001;
        fret_calc_trace = vertcat(fret_calc_trace_blch,fret_diff); 
        % write data
        data{1,counterAAAA} = [don_sel accep_sel];
        FRET{1,counterAAAA} = fret_calc_trace;
        labels{1,counterAAAA}= num2str(counterAAAA); 
        counterAAAA = counterAAAA + 1;        
    end
end

if exp_type == 1
    dlmwrite([file_name,' EBFRET_fretpl_',grp_traces,'.dat'],vector,'delimiter',",")
    close (h1)
    msgbox([file_name,' EBFRET_fretpl_',grp_traces,'.dat'],"Exported DAT file")
elseif exp_type == 2
    close (h1)
    save([file_name, ' VBtraces_',grp_traces,'.mat'],'data','FRET','labels'); 
    msgbox([file_name, ' VBtraces_',grp_traces,'.mat'],"Exported MAT file")
end

% --- Executes on button press in man_activate.
function man_activate_Callback(hObject, eventdata, handles)
% hObject    handle to man_activate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of man_activate


% --- Executes on button press in tune_autofilter.
function tune_autofilter_Callback(hObject, eventdata, handles)
% hObject    handle to tune_autofilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reset_filter = get(handles.reset_filter,'Value');
if reset_filter == 0
tune_parameters = inputdlg({'Donor_variance Division,Default = 2','Acceptor_variance Division, Default = 2',...
    'Total_variance Division,Default = 2','Range of Peak matching, Default = 6'},'Tune parameters',[1 50; 1 50; 1 50; 1 50; 1 50]);
    don_var_div = str2num(tune_parameters{1});
    accep_var_div = str2num(tune_parameters{2});
    tot_var_div = str2num(tune_parameters{3});
    range_peaks = str2num(tune_parameters{4});
elseif reset_filter == 1
    don_var_div = 2;
    accep_var_div = 2;
    tot_var_div = 2;
    range_peaks = 6;
end
save('filt_parms.mat','don_var_div','accep_var_div','tot_var_div','range_peaks')

function num_nonsel_Callback(hObject, eventdata, handles)
% hObject    handle to num_nonsel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_nonsel as text
%        str2double(get(hObject,'String')) returns contents of num_nonsel as a double


% --- Executes during object creation, after setting all properties.
function num_nonsel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_nonsel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in del_sub1.
function del_sub1_Callback(hObject, eventdata, handles)
% hObject    handle to del_sub1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_sublist1 = getappdata(handles.subgrp_1,'temp_sublist1');
index_sel_1_t = get(handles.sel_list_sub1,'Value');
temp_sublist1(index_sel_1_t) = [];
temp_sublist1 = sort(temp_sublist1);
set(handles.sel_list_sub1,'String',num2str(temp_sublist1));
setappdata(handles.subgrp_1,'temp_sublist1', temp_sublist1);
num_sub1 = length(temp_sublist1);
set(handles.disp_num_sub1,'String',num2str(num_sub1));


% --- Executes on button press in del_sub2.
function del_sub2_Callback(hObject, eventdata, handles)
% hObject    handle to del_sub2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_sublist2 = getappdata(handles.subgrp_2,'temp_sublist2');
index_sel_2_t = get(handles.sel_list_sub2,'Value');
temp_sublist2(index_sel_2_t) = [];
temp_sublist2 = sort(temp_sublist2);
set(handles.sel_list_sub2,'String',num2str(temp_sublist2));
setappdata(handles.subgrp_2,'temp_sublist2', temp_sublist2);
num_sub2 = length(temp_sublist2);
set(handles.disp_num_sub2,'String',num2str(num_sub2));


% --- Executes on button press in del_sub3.
function del_sub3_Callback(hObject, eventdata, handles)
% hObject    handle to del_sub3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
temp_sublist3 = getappdata(handles.subgrp_3,'temp_sublist3');
index_sel_3_t = get(handles.sel_list_sub3,'Value');
temp_sublist3(index_sel_3_t)=[];
temp_sublist3 = sort(temp_sublist3);
set(handles.sel_list_sub3,'String',num2str(temp_sublist3));
setappdata(handles.subgrp_3,'temp_sublist3', temp_sublist3);
num_sub3 = length(temp_sublist3);
set(handles.disp_num_sub3,'String',num2str(num_sub3));



function min_fret_Callback(hObject, eventdata, handles)
% hObject    handle to min_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_fret as text
%        str2double(get(hObject,'String')) returns contents of min_fret as a double


% --- Executes during object creation, after setting all properties.
function min_fret_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tot_snr1_Callback(hObject, eventdata, handles)
% hObject    handle to tot_snr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tot_snr1 as text
%        str2double(get(hObject,'String')) returns contents of tot_snr1 as a double


% --- Executes during object creation, after setting all properties.
function tot_snr1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tot_snr1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pos_ebfret.
function pos_ebfret_Callback(hObject, eventdata, handles)
% hObject    handle to pos_ebfret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_dwell


% --- Executes on button press in use_blch_pts.
function use_blch_pts_Callback(hObject, eventdata, handles)
% hObject    handle to use_blch_pts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of use_blch_pts


% --- Executes on button press in exp_mash.
function exp_mash_Callback(hObject, eventdata, handles)
% hObject    handle to exp_mash (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ispc == 1
    seps = '\';
else
    seps = '/';
end
addpath([pwd,seps,'KAT',seps,'mashfret'])
MASH


% --- Executes on button press in mash_traces.
function mash_traces_Callback(hObject, eventdata, handles)
% hObject    handle to mash_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
time_axis = getappdata(handles.load_traces, 'time_axis');
time_axis = time_axis';
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
file_name = getappdata(handles.load_traces, 'file_name');
grp_traces_t = get(handles.uibuttongroup3, 'SelectedObject');
grp_traces = get(grp_traces_t, 'String');
%% determine if to use the bleach points
process_blch = get(handles.use_blch_pts, 'Value');
blch_don_t = getappdata(handles.load_traces,'blch_don');
blch_accep_t = getappdata(handles.load_traces,'blch_accep');
blch_fret_t = getappdata(handles.load_traces,'blch_fret');
%% process the trace data
switch grp_traces
    case {'Selected'}
        sel_trace_sub = getappdata(handles.load_traces,'sel_trace_sub');
        grp ='Selected';        
        blch_don = blch_don_t(:,sel_trace_sub);        
        blch_accep = blch_accep_t(:,sel_trace_sub);
        blch_fret = blch_fret_t(:,sel_trace_sub);
    case {'Grp 1'}
        sel_trace_sub = (getappdata(handles.subgrp_1,'temp_sublist1')');        
        grp = 'grp1';
        blch_don = blch_don_t(:,sel_trace_sub1);
        blch_accep = blch_accep_t(:,sel_trace_sub1);
        blch_fret = blch_fret_t(:,sel_trace_sub1);
    case {'Grp 2'}
        sel_trace_sub = (getappdata(handles.subgrp_2,'temp_sublist2')'); 
        grp = 'grp2';
         blch_don = blch_don_t(:,sel_trace_sub2);
         blch_accep = blch_accep_t(:,sel_trace_sub2);
         blch_fret = blch_fret_t(:,sel_trace_sub2);
end
gamma = str2num(get(handles.gamma_corr_val,'String')); 
h1 = waitbar_new(0,'Please wait...');    
counterAAAA = 1;
vector = [];
for i = sel_trace_sub
    waitbar_new(counterAAAA/size(sel_trace_sub,2),h1);      
    don_sel = don_spec_trace(:,i).*gamma;
    accep_sel = accep_spec_trace(:,i);  
    blch_pt = blch_fret(:,i);
    blch_diff = length(don_sel)-blch_pt;
    blch_diff_d = (ones(blch_diff,1).*1);
    blch_diff_a = (ones(blch_diff,1).*0.05);
    %% Pad the matrix
    for k = 1:length(don_sel)
        if don_sel(k) <0
            don_sel(k) = 0.1;
        end
    end    
    for k = 1:length(accep_sel)
        if accep_sel(k) < 0
            accep_sel(k) = 0.1;
        end            
    end
    process_blch = get(handles.use_blch_pts, 'Value');
    if process_blch == 1
        don_sel_t = don_sel(1:blch_pt,:);
        accep_sel_t = accep_sel(1:blch_pt,:);
        don_sel_t = vertcat(don_sel_t,blch_diff_d);
        accep_sel_t = vertcat(accep_sel_t,blch_diff_a);
        don_sel = don_sel_t;
        accep_sel = accep_sel_t;
    end
    values(:,1) = don_sel;
    values(:,2) = accep_sel;
    vector = horzcat(vector, values);    
    counterAAAA = counterAAAA + 1;
end
    final_vector = [time_axis vector];
dlmwrite([file_name,' mash ',grp_traces,'.dat'],final_vector,'delimiter',",")
close (h1)


% --- Executes on button press in eval_n.
function eval_n_Callback(hObject, eventdata, handles)
% hObject    handle to eval_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Number
global fname
global don_spec_trace;
global accep_spec_trace;
num_splits = str2num(get(handles.splits_eval_n,'String'));
popup1 = get(handles.overlay_popmenu,'Value');
% 1 = All selected FRET
% 2 = Subgroup 1
% 3 = Subgroup 2
% 4 = Subgroup 3
 switch popup1
     case{1}
        sel_trace_heat = getappdata(handles.load_traces,'sel_trace_sub');
     case{2}
        sel_trace_heat = getappdata(handles.subgrp_1,'temp_sublist1');
     case{3}
        sel_trace_heat = getappdata(handles.subgrp_2,'temp_sublist2');  
     case{4}
         sel_trace_heat = getappdata(handles.subgrp_3,'temp_sublist3');
 end
 
if num_splits == 2
    if rem(sel_trace_heat,2) >0
        sel_trace_heat = sel_trace_heat -1;
    end        
elseif num_splits == 3
    if rem(sel_trace_heat,3) == 2
        sel_trace_heat = sel_trace_heat -2;
    elseif rem(sel_trace_heat,3) == 1
        sel_trace_heat = sel_trace_heat -1;
    end    
end
  
 % randomise and split the array
data_rnd = sel_trace_heat;
rand_pos = randperm(length(data_rnd)); 
% new array with original data randomly distributed 
for k = 1:length(data_rnd)
    data_randomly_placed(k) = data_rnd(rand_pos(k));
end
data_randomly_placed = data_randomly_placed';
% Split the data
data_len = length(sel_trace_heat);
    if num_splits == 2
        data_mid = (data_len/2);
        data_new(:,1) = data_randomly_placed(1:data_mid);
        data_new(:,2) = data_randomly_placed(data_mid+1:end);
    end
    
    if num_splits == 3        
        data_split = (data_len/3);
        data_new(:,1) = data_randomly_placed(1:data_split);
        data_new(:,2) = data_randomly_placed((data_split+1):(data_split*2));
        data_new(:,3) = data_randomly_placed((data_split*2)+1:end);        
    end

for i = 1:num_splits   
    sel_trace_heat = data_new(:,i);
    time_axis = getappdata(handles.load_traces, 'time_axis');
    gamma = str2num(get(handles.gamma_corr_val,'String'));
%     fret_res = str2num(get(handles.fret_res,'String'));
    fret_blchpoint_t = getappdata(handles.load_traces,'blch_fret');
    don_heat_trace = don_spec_trace(:,sel_trace_heat);   
    accep_heat_trace = accep_spec_trace(:,sel_trace_heat);
    fret_blchpoint = fret_blchpoint_t(:,sel_trace_heat);
    [fret_sel_all_hist2,tot_hist_obs] = trace_to_hist(don_heat_trace, accep_heat_trace, fret_blchpoint, gamma); 
figure(3)
hold on
ksdensity(fret_sel_all_hist2, linspace(0,1,50));
title('FRET'); 
xticks([0:.1:1]);
a = get(gca,'XTickLabel');  
set(gca,'XTickLabel',a,'fontsize',9,'FontWeight','bold')
end
 

function splits_eval_n_Callback(hObject, eventdata, handles)
% hObject    handle to splits_eval_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of splits_eval_n as text
%        str2double(get(hObject,'String')) returns contents of splits_eval_n as a double


% --- Executes during object creation, after setting all properties.
function splits_eval_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to splits_eval_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in conv_smd.
function conv_smd_Callback(hObject, eventdata, handles)
% hObject    handle to conv_smd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




function disp_indv_obs_his_Callback(hObject, eventdata, handles)
% hObject    handle to disp_indv_obs_his (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_indv_obs_his as text
%        str2double(get(hObject,'String')) returns contents of disp_indv_obs_his as a double


% --- Executes during object creation, after setting all properties.
function disp_indv_obs_his_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_indv_obs_his (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_histobs_grp1_Callback(hObject, eventdata, handles)
% hObject    handle to disp_histobs_grp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_histobs_grp1 as text
%        str2double(get(hObject,'String')) returns contents of disp_histobs_grp1 as a double


% --- Executes during object creation, after setting all properties.
function disp_histobs_grp1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_histobs_grp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_histobs_grp2_Callback(hObject, eventdata, handles)
% hObject    handle to disp_histobs_grp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_histobs_grp2 as text
%        str2double(get(hObject,'String')) returns contents of disp_histobs_grp2 as a double


% --- Executes during object creation, after setting all properties.
function disp_histobs_grp2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_histobs_grp2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_tot_datapts_Callback(hObject, eventdata, handles)
% hObject    handle to disp_tot_datapts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_tot_datapts as text
%        str2double(get(hObject,'String')) returns contents of disp_tot_datapts as a double


% --- Executes during object creation, after setting all properties.
function disp_tot_datapts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_tot_datapts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sel_next.
function sel_next_Callback(hObject, eventdata, handles)
% hObject    handle to sel_next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
subgrp_1_Callback(hObject, eventdata, handles);
index_sel_1_t = get(handles.sel_list_traces,'Value');
handles.sel_list_traces.Value = index_sel_1_t + 1; 
sel_list_traces_Callback(hObject, eventdata, handles)


% --- Executes on button press in next_trace.
function next_trace_Callback(hObject, eventdata, handles)
% hObject    handle to next_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_sel_1_t = get(handles.sel_list_traces,'Value');
handles.sel_list_traces.Value = index_sel_1_t + 1; 
sel_list_traces_Callback(hObject, eventdata, handles)


% --- Executes on selection change in sel_exp_type.
function sel_exp_type_Callback(hObject, eventdata, handles)
% hObject    handle to sel_exp_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sel_exp_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sel_exp_type


% --- Executes during object creation, after setting all properties.
function sel_exp_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sel_exp_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
subgrp_1_Callback(hObject, eventdata, handles);
subgrp_2_Callback(hObject, eventdata, handles);
index_sel_1_t = get(handles.sel_list_traces,'Value');
handles.sel_list_traces.Value = index_sel_1_t + 1; 
sel_list_traces_Callback(hObject, eventdata, handles)


% --- Executes on key press with focus on next_trace and none of its controls.
function next_trace_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to next_trace (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 and none of its controls.
function figure1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% keyPressed = eventdata.Key;
% if strcmpi(keyPressed,'l')
%     uicontrol(handles.next_trace)
%     next_trace_Callback(hObject, eventdata, handles);
%     run figure1
% end
% 
% if strcmpi(keyPressed,'d')
%     uicontrol(handles.sel_next)
%     sel_next_Callback(hObject, eventdata, handles);
% end
% 
% if strcmpi(keyPressed,'s')
%     uicontrol(handles.pushbutton78)
%     pushbutton78_Callback(hObject, eventdata, handles);
% end


% --- Executes on key press with focus on sel_list_traces and none of its controls.
function sel_list_traces_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to sel_list_traces (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

keyPressed = eventdata.Key;
if strcmpi(keyPressed,'1')
    uicontrol(handles.sel_list_traces)
    subgrp_1_Callback(hObject, eventdata, handles)
    sel_list_traces_Callback(hObject, eventdata, handles)
end


% --- Executes on button press in launch_mod_blch.
function launch_mod_blch_Callback(hObject, eventdata, handles)
% hObject    handle to launch_mod_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kat_blch_mod


% --- Executes on button press in save_stats.
function save_stats_Callback(hObject, eventdata, handles)
% hObject    handle to save_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save_stats


% --- Executes on button press in launch_ML.
function launch_ML_Callback(hObject, eventdata, handles)
% hObject    handle to launch_ML (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run KK_ML


% --- Executes on button press in hist_vals.
function hist_vals_Callback(hObject, eventdata, handles)
% hObject    handle to hist_vals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in gmm_gaussian.
function gmm_gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to gmm_gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_GMM


% --- Executes on selection change in stringency_sel.
function stringency_sel_Callback(hObject, eventdata, handles)
% hObject    handle to stringency_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns stringency_sel contents as cell array
%        contents{get(hObject,'Value')} returns selected item from stringency_sel
type_stringent = get(handles.stringency_sel,'Value');
% 2 = Least Stringent
% 3 = Medium Stringent
% 4 = High Stringent
% 5 = Custom
 switch type_stringent
     case{2}
         % Low

     case{3}
         % medium
      don_snr1 = (set(handles.don_snr1,'String','2'));

     case{4}
         % high
        
 end



don_thresh = str2double(get(handles.don_trace_thresh,'String'));
accep_thresh = str2double(get(handles.accep_trace_thresh,'String'));
mov_window = str2double(get(handles.filt_win,'String'));
filt_f_back = str2double(get(handles.filt_f_back,'String'));
don_f_ratio = str2double(get(handles.don_f_ratio,'String'));
accep_f_ratio = str2double(get(handles.accep_f_ratio,'String'));
don_snr1 = str2double(get(handles.don_snr1,'String'));
acp_snr1 = str2double(get(handles.acp_snr1,'String'));
don_snr2 = str2double(get(handles.don_snr2,'String'));
acp_snr2 = str2double(get(handles.acp_snr2,'String'));
tot_snr1 = str2double(get(handles.tot_snr1,'String'));
min_fret = str2double(get(handles.min_fret,'String'));






% --- Executes during object creation, after setting all properties.
function stringency_sel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stringency_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_least_Callback(hObject, eventdata, handles)
% hObject    handle to num_least (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_least as text
%        str2double(get(hObject,'String')) returns contents of num_least as a double


% --- Executes during object creation, after setting all properties.
function num_least_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_least (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit38_Callback(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit38 as text
%        str2double(get(hObject,'String')) returns contents of edit38 as a double


% --- Executes during object creation, after setting all properties.
function edit38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_hist_vals_tem.
function exp_hist_vals_tem_Callback(hObject, eventdata, handles)
% hObject    handle to exp_hist_vals_tem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of exp_hist_vals_tem


% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','Select the Export Histogram Button',...
         '1) Select the group of values that you would like to export the values for'...
          '2) Save file and then process in GMM Gaussian'
         },'KAT2: Help');


% --- Executes on button press in trace_converter.
function trace_converter_Callback(hObject, eventdata, handles)
% hObject    handle to trace_converter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

run trace_conv.m
