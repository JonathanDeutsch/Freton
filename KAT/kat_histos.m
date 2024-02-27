function varargout = kat_histos(varargin)
% KAT_HISTOS MATLAB code for kat_histos.fig
%      KAT_HISTOS, by itself, creates a new KAT_HISTOS or raises the existing
%      singleton*.
%
%      H = KAT_HISTOS returns the handle to a new KAT_HISTOS or the handle to
%      the existing singleton*.
%
%      KAT_HISTOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_HISTOS.M with the given input arguments.
%
%      KAT_HISTOS('Property','Value',...) creates a new KAT_HISTOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_histos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
% %      stop.  All inputs are passed to kat_histos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_histos

% Last Modified by GUIDE v2.5 17-May-2022 16:56:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_histos_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_histos_OutputFcn, ...
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


% --- Executes just before kat_histos is made visible.
function kat_histos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_histos (see VARARGIN)

% Choose default command line output for kat_histos
handles.output = hObject;
set(handles.gamma_hist_val, 'String', num2str(1));
set(handles.beta_hist_val,'String',num2str(0));
set(handles.num_files, 'String', num2str(1));
set(handles.hist_bins,'String',num2str(10));
set(handles.don_auto_val,'String',num2str(0));
set(handles.frame_back,'String',num2str(0));
set(handles.overlay_res,'String',num2str(0.1));
set(handles.heatmap_fac,'String',num2str(25));
set(handles.bins_fret_all,'String',num2str(50));
set(handles.pass_filt,'String',num2str(10));
set(handles.val_sigma13,'String',num2str(2));
set(handles.val_sigma23,'String',num2str(2));
set(handles.val_sigma33,'String',num2str(2));
set(handles.val_sigma43,'String',num2str(2));
set(handles.val_don_bckg,'String',num2str(0));
set(handles.val_don_var,'String',num2str(0));
set(handles.val_accep_bckg,'String',num2str(0));
set(handles.val_accep_var,'String',num2str(0));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_histos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_histos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
global index
global Complete_SET
index = get(handles.listbox1,'Value');
index1 = Complete_SET(index);
set(handles.disp_trace_num, 'String',num2str(index1));
global time_axis
global don_sel
global accep_sel

fret_life_thresh = str2num(get(handles.don_auto_val,'String'));
frame_back = str2num(get(handles.frame_back,'String'));
gamma = str2num(get(handles.gamma_hist_val,'String'));
beta = str2num(get(handles.beta_hist_val,'String'));
hist_bins = str2num(get(handles.hist_bins,'String'));
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_don = getappdata(handles.load_traces, 'blch_don') - frame_back;
blch_accep = getappdata(handles.load_traces,'blch_accep') - frame_back;
blch_fret = getappdata(handles.load_traces,'blch_fret') - frame_back;
time_ints = getappdata(handles.load_traces,'time_ints');

counter = 0;
counter_don = 0;
counter_accep = 0;
fret_sel_all_hist = [];

don_sel = don_spec_trace(:,index1);  
accep_sel = accep_spec_trace(:,index1);

% coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
trace_filt_don = movmean(don_sel,3);  
trace_filt_accep = movmean(accep_sel,3);

% 2. normalizing the donor data from the digital filter
trace_filt_min_don = min(trace_filt_don);
trace_filt_max_don = max(trace_filt_don);
normdata_don = zeros(size(trace_filt_don,1),1);
        for m = 1 : size(trace_filt_don,1)
            normdata_don(m,1) = (trace_filt_don(m) - trace_filt_min_don) / (trace_filt_max_don - trace_filt_min_don);
        end        
% normalizing the acceptor data from the digital filter
trace_filt_min_accep = min(trace_filt_accep);
trace_filt_max_accep = max(trace_filt_accep);
        for n = 1 : size(trace_filt_accep,1)
            normdata_accep(n,1) = (trace_filt_accep(n) - trace_filt_min_accep) / (trace_filt_max_accep - trace_filt_min_accep);
        end  

denom_fret = (accep_sel - beta.*don_sel)+ (gamma.*don_sel);
denom_fret_filt = (trace_filt_accep - beta.*trace_filt_don) + (gamma.*trace_filt_don);
fret_calc_trace = (accep_sel - beta.*don_sel)./denom_fret;    
fret_calc_filt = (trace_filt_accep - beta.*trace_filt_don) ./denom_fret_filt;
bleachpoint_don = blch_don(index1);
bleachpoint_accep = blch_accep(index1);
bleachpoint_fret = blch_fret(index1);      

don_sel_blch = don_sel(1:bleachpoint_fret);
accep_sel_blch = accep_sel(1:bleachpoint_fret);

trace_filt_don_blch = trace_filt_don(1:bleachpoint_fret);
trace_filt_accep_blch = trace_filt_accep(1:bleachpoint_fret);

time_axis_blch = time_axis(1:bleachpoint_fret);
denom_fret_blch = (accep_sel_blch - beta.*don_sel_blch) + (gamma.*don_sel_blch);
fret_calc_trace_blch = (accep_sel_blch - beta.*don_sel_blch)./denom_fret_blch;

%% Histogram each trace
        counter_fret = 0;
        for j = 1:length(don_sel_blch)
            counter_fret = counter_fret + 1;
            denom_fret_hist = (accep_sel_blch (j) -beta.*don_sel_blch(j))+ (gamma.*don_sel_blch(j));
            fret_calc_inc_indv = (accep_sel_blch(j)- beta.*don_sel_blch(j))./denom_fret_hist;
            fret_sel_indv_hist(:,counter_fret) = fret_calc_inc_indv;
        end   
        counter_fret_filt = 0;
        for k = 1:length(trace_filt_don_blch)
            counter_fret_filt = counter_fret_filt+1;
            denom_fret_hist_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k))+ (gamma.*trace_filt_don_blch(k));
            fret_calc_inc_indv_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k))./denom_fret_hist_filt;
            fret_sel_indv_hist_filt(:,counter_fret_filt) = fret_calc_inc_indv_filt;
        end
        
don_emms_tt = (don_sel_blch');
accep_emms_tt = (accep_sel_blch');
don_emms_bckg_tt = don_sel(bleachpoint_fret+3:end);
accep_emms_bckg_tt = accep_sel(bleachpoint_fret+3:end);                            
snr_don_bckg_t = mean(don_emms_tt)/std(don_emms_bckg_tt);
snr_don_var_t = mean(don_emms_tt)/std(don_emms_tt);
snr_accep_bckg_t = mean(accep_emms_tt)/std(accep_emms_bckg_tt);
snr_accep_var_t = mean(accep_emms_tt)/std(accep_emms_tt);
set(handles.disp_snr_d_bckg,'String',num2str(snr_don_bckg_t));
set(handles.disp_snr_d_var,'String',num2str(snr_don_var_t));
set(handles.disp_snr_a_bckg,'String',num2str(snr_accep_bckg_t));
set(handles.disp_snr_a_var,'String',num2str(snr_accep_var_t));
        
set(handles.disp_trace_num, 'String',num2str(index1));
axes(handles.axes8)
histogram(fret_sel_indv_hist,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Raw)');
axes(handles.axes13)
histogram(fret_sel_indv_hist_filt,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Smooth)');
% plot the traces
axes(handles.axes1)
plot(time_axis, don_sel,'k',time_axis_blch,don_sel_blch,'g',time_axis,trace_filt_don,'--k')
ylabel ('Donor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
axes(handles.axes3)
plot(time_axis,accep_sel,'k',time_axis_blch,accep_sel_blch,'r',time_axis,trace_filt_accep,'--k')
ylabel ('Acceptor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
axes(handles.axes2)
plot(time_axis,normdata_don,'k',time_axis,normdata_accep,'k',time_axis_blch,normdata_don(1:bleachpoint_fret),'g', time_axis_blch,normdata_accep(1:bleachpoint_fret),'r');
axes(handles.axes10)
plot(time_axis,fret_calc_trace,'k',time_axis_blch,fret_calc_trace_blch,'b',time_axis,fret_calc_filt,'--k',time_axis_blch,fret_calc_filt(1:bleachpoint_fret),'m');
ylim([-0.05 1.2])     

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_trace_num_Callback(hObject, eventdata, handles)
% hObject    handle to disp_trace_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_trace_num as text
%        str2double(get(hObject,'String')) returns contents of disp_trace_num as a double


% --- Executes during object creation, after setting all properties.
function disp_trace_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_trace_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_man.
function run_man_Callback(hObject, eventdata, handles)
% hObject    handle to run_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in load_traces.
function load_traces_Callback(hObject, eventdata, handles)
% hObject    handle to load_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% hObject    handle to load_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global time_axis
% global DON_Bleach 
% global ACC_Bleach
 global Complete_SET
% global num_list_trace
% global pre_DON
% global after_DON
% global pre_ACC
% global after_ACC
 global num_files
 global fname
  num_files = str2double(get(handles.num_files,'String'));
 
if num_files > 1
     ALL_NAME =  cell(1,num_files);
  for i = 1:num_files
     [fname, path_trace] = uigetfile();
     ALL_NAME{i} = fname;
  end
   
  Traces_merger_together1(ALL_NAME{:})
  fname = 'Traces_to_analyze.mat';
  [~,file_name] = fileparts(fname);
  addpath(path_trace);
  setappdata(handles.load_traces, 'path_trace', path_trace);
  load(file_name)
  setappdata(handles.load_traces, 'file_name', file_name);
  set(handles.disp_name,'String',file_name);
  
[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((1:num_traces)');
Complete_SET = 1:num_traces;
set(handles.listbox1, 'String', num_list_trace);
set(handles.edit7, 'String', num2str(num_traces));

else
[fname, ~] = uigetfile(); 
[path_trace,file_name] = fileparts(fname);
addpath(path_trace);
load(file_name)
set(handles.disp_name,'String',file_name);
setappdata(handles.load_traces, 'file_name', file_name);
if filtered_data == 1
    set(handles.edit19,'String','Filtered KAT2 data')
end

    
[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((1:num_traces)');
Complete_SET = 1:num_traces;
set(handles.listbox1, 'String', num_list_trace);
set(handles.edit7, 'String', num2str(num_traces));
end

setappdata(handles.load_traces, 'don_tot_trace', don_tot_trace);
setappdata(handles.load_traces, 'don_bckg_trace', don_bckg_trace);
setappdata(handles.load_traces, 'accep_tot_trace', accep_tot_trace);
setappdata(handles.load_traces, 'accep_bckg_trace', accep_bckg_trace);
setappdata(handles.load_traces, 'don_spec_trace', don_spec_trace);
setappdata(handles.load_traces, 'time_axis', time_axis);
setappdata(handles.load_traces, 'accep_spec_trace', accep_spec_trace);
setappdata(handles.load_traces, 'blch_don', blch_don);
setappdata(handles.load_traces, 'blch_accep',blch_accep);
setappdata(handles.load_traces, 'blch_fret',blch_fret);
setappdata(handles.load_traces, 'blch_type',blch_type);
time_ints = time_axis(2)-time_axis(1);
setappdata(handles.load_traces,'time_ints',time_ints);
set(handles.disp_timeres,'String',num2str(time_ints*1000));
set(handles.start_overlay,'String',num2str(time_ints));
set(handles.end_overlay,'String',num2str(max(time_axis)));
set(handles.ax_lim,'String',num2str(max(time_axis)));

function disp_name_Callback(hObject, eventdata, handles)
% hObject    handle to disp_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_name as text
%        str2double(get(hObject,'String')) returns contents of disp_name as a double


% --- Executes during object creation, after setting all properties.
function disp_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%--- Executes on button press in save_new_set.
function save_new_set_Callback(hObject, eventdata, handles)
% hObject    handle to save_new_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function don_auto_val_Callback(hObject, eventdata, handles)
% hObject    handle to don_auto_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_auto_val as text
%        str2double(get(hObject,'String')) returns contents of don_auto_val as a double


% --- Executes during object creation, after setting all properties.
function don_auto_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_auto_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function start_overlay_Callback(hObject, eventdata, handles)
% hObject    handle to start_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_overlay as text
%        str2double(get(hObject,'String')) returns contents of start_overlay as a double


% --- Executes during object creation, after setting all properties.
function start_overlay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frame_back_Callback(hObject, eventdata, handles)
% hObject    handle to frame_back1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frame_back1 as text
%        str2double(get(hObject,'String')) returns contents of frame_back1 as a double


% --- Executes during object creation, after setting all properties.
function frame_back_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frame_back1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
global Complete_SET
process_list = getappdata(handles.listbox2,'process_list');
index_l2 = get(handles.listbox2,'Value');
indexl2t = process_list(index_l2);
global time_axis


fret_life_thresh = str2num(get(handles.don_auto_val,'String'));
frame_back = str2num(get(handles.frame_back,'String'));
gamma = str2num(get(handles.gamma_hist_val,'String'));
beta = str2num(get(handles.beta_hist_val,'String'));
hist_bins = str2num(get(handles.hist_bins,'String'));
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_don = getappdata(handles.load_traces, 'blch_don') - frame_back;
blch_accep = getappdata(handles.load_traces,'blch_accep') - frame_back;
blch_fret = getappdata(handles.load_traces,'blch_fret') - frame_back;
time_ints = getappdata(handles.load_traces,'time_ints');

counter = 0;
counter_don = 0;
counter_accep = 0;
fret_sel_all_hist = [];

don_sel = don_spec_trace(:,indexl2t);  
accep_sel = accep_spec_trace(:,indexl2t);

% coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
trace_filt_don = movmean(don_sel,3);  
trace_filt_accep = movmean(accep_sel,3);

% 2. normalizing the donor data from the digital filter
trace_filt_min_don = min(trace_filt_don);
trace_filt_max_don = max(trace_filt_don);
normdata_don = zeros(size(trace_filt_don,1),1);
        for m = 1 : size(trace_filt_don,1)
            normdata_don(m,1) = (trace_filt_don(m) - trace_filt_min_don) / (trace_filt_max_don - trace_filt_min_don);
        end        
% normalizing the acceptor data from the digital filter
trace_filt_min_accep = min(trace_filt_accep);
trace_filt_max_accep = max(trace_filt_accep);
        for n = 1 : size(trace_filt_accep,1)
            normdata_accep(n,1) = (trace_filt_accep(n) - trace_filt_min_accep) / (trace_filt_max_accep - trace_filt_min_accep);
        end  

denom_fret = (accep_sel -beta.*don_sel)+ (gamma.*don_sel);
denom_fret_filt = (trace_filt_accep -beta.*trace_filt_don)+ (gamma.*trace_filt_don);
fret_calc_trace = (accep_sel-beta.*don_sel)./denom_fret;    
fret_calc_filt = (trace_filt_accep -beta.*trace_filt_don)./denom_fret_filt;
bleachpoint_don = blch_don(indexl2t);
bleachpoint_accep = blch_accep(indexl2t);
bleachpoint_fret = blch_fret(indexl2t);      

don_sel_blch = don_sel(1:bleachpoint_fret);
accep_sel_blch = accep_sel(1:bleachpoint_fret);

trace_filt_don_blch = trace_filt_don(1:bleachpoint_fret);
trace_filt_accep_blch = trace_filt_accep(1:bleachpoint_fret);

time_axis_blch = time_axis(1:bleachpoint_fret);
denom_fret_blch = (accep_sel_blch - beta.*don_sel_blch)+ (gamma.*don_sel_blch);
fret_calc_trace_blch = (accep_sel_blch - beta.*don_sel_blch)./denom_fret_blch;

%% Histogram each trace
        counter_fret = 0;
        for j = 1:length(don_sel_blch)
            counter_fret = counter_fret + 1;
            denom_fret_hist = (accep_sel_blch (j) - beta.*don_sel_blch(j))+ (gamma.*don_sel_blch(j));
            fret_calc_inc_indv = (accep_sel_blch(j) - beta.*don_sel_blch(j))./denom_fret_hist;
            fret_sel_indv_hist(:,counter_fret) = fret_calc_inc_indv;
        end   
        counter_fret_filt = 0;
        for k = 1:length(trace_filt_don_blch)
            counter_fret_filt = counter_fret_filt+1;
            denom_fret_hist_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k))+ (gamma.*trace_filt_don_blch(k));
            fret_calc_inc_indv_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k))./denom_fret_hist_filt;
            fret_sel_indv_hist_filt(:,counter_fret_filt) = fret_calc_inc_indv_filt;
        end
        
set(handles.disp_trace_num, 'String',num2str(indexl2t));
axes(handles.axes8)
histogram(fret_sel_indv_hist,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Raw)');
axes(handles.axes13)
histogram(fret_sel_indv_hist_filt,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Smooth)');
% plot the traces
axes(handles.axes1)
plot(time_axis, don_sel,'k',time_axis_blch,don_sel_blch,'g',time_axis,trace_filt_don,'--k')
ylabel ('Donor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
grid on
axes(handles.axes3)
plot(time_axis,accep_sel,'k',time_axis_blch,accep_sel_blch,'r',time_axis,trace_filt_accep,'--k')
ylabel ('Acceptor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
grid on
axes(handles.axes22)
plot(time_axis, ((don_sel.*gamma)+accep_sel),'b','LineWidth',1)
ylabel ('Total')
grid on
axes(handles.axes2)
plot(time_axis,normdata_don,'k',time_axis,normdata_accep,'k',time_axis_blch,normdata_don(1:bleachpoint_fret),'g', time_axis_blch,normdata_accep(1:bleachpoint_fret),'r');
ylabel('Norm')
grid on
axes(handles.axes10)
plot(time_axis,fret_calc_trace,'k',time_axis_blch,fret_calc_trace_blch,'b',time_axis,fret_calc_filt,'--k',time_axis_blch,fret_calc_filt(1:bleachpoint_fret),'m');
ylim([-0.05 1.2]) 
ylabel ('FRET')
yticks(0:0.2:1);
grid on
%%
don_emms_tt = (don_sel_blch');
accep_emms_tt = (accep_sel_blch');
don_emms_bckg_tt = don_sel(bleachpoint_fret+3:end);
accep_emms_bckg_tt = accep_sel(bleachpoint_fret+3:end);                            
snr_don_bckg_t = mean(don_emms_tt)/std(don_emms_bckg_tt);
snr_don_var_t = mean(don_emms_tt)/std(don_emms_tt);
snr_accep_bckg_t = mean(accep_emms_tt)/std(accep_emms_bckg_tt);
snr_accep_var_t = mean(accep_emms_tt)/std(accep_emms_tt);
set(handles.disp_snr_d_bckg,'String',num2str(snr_don_bckg_t));
set(handles.disp_snr_d_var,'String',num2str(snr_don_var_t));
set(handles.disp_snr_a_bckg,'String',num2str(snr_accep_bckg_t));
set(handles.disp_snr_a_var,'String',num2str(snr_accep_var_t));

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Traces_merger_together1(varargin)
number_arguments = length(varargin);
%% Update names to reflect the names of the traces

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
    blch_accep_temp = [];
    blch_don_temp = [];
    blch_type_temp = [];
    blch_fret_temp = []; 
if exist('Mode1')
else
    Mode1 = 'other';
end
%Merging all the vectors
for i = 1:number_arguments
file = varargin(i);
file1 = [file{1}];
load(file1)
accep_bckg_trace_temp = [accep_bckg_trace_temp , accep_bckg_trace];
accep_spec_trace_temp = [accep_spec_trace_temp , accep_spec_trace];
accep_tot_trace_temp = [accep_tot_trace_temp , accep_tot_trace];
blch_accep_temp = [blch_accep_temp; blch_accep'];
blch_don_temp = [blch_don_temp; blch_don'];
blch_type_temp = [blch_type_temp; blch_type'];
blch_fret_temp = [blch_fret_temp; blch_fret'];
don_bckg_trace_temp = [don_bckg_trace_temp , don_bckg_trace];
don_spec_trace_temp = [don_spec_trace_temp , don_spec_trace];
don_tot_trace_temp = [don_tot_trace_temp , don_tot_trace];
Picture_d_temp     = [ Picture_d_temp ; Picture_d];
Picture_a_temp     = [ Picture_a_temp ; Picture_a];
centers_ext_temp = [centers_ext_temp ; centers_ext];
%time_axis_temp = [time_axis_temp ; time_axis];
end
time_axis_temp =  time_axis;
%time_axis_temp = [time_axis_temp ; time_axis];
%Trace_final_temp = Trace_final_temp;
don_bckg_trace = don_bckg_trace_temp ;
don_spec_trace = don_spec_trace_temp ;
don_tot_trace = don_tot_trace_temp ;
time_axis = time_axis_temp ;
Picture_d     =  Picture_d_temp ;
Picture_a   = Picture_a_temp;
centers_ext = centers_ext_temp;
accep_bckg_trace = accep_bckg_trace_temp ;
accep_spec_trace = accep_spec_trace_temp ;
accep_tot_trace = accep_tot_trace_temp ;
Picture_a     =  Picture_a_temp ;
blch_accep = blch_accep_temp';
blch_don = blch_don_temp';
blch_type = blch_type_temp';
blch_fret = blch_fret_temp';
save('Traces_to_analyze.mat','time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace','Mode1','Picture_a','Picture_d', 'centers_ext',...
                 'blch_accep','blch_don','blch_type','blch_fret');



% --- Executes on slider movement.
function slider_fret_bins_Callback(hObject, eventdata, handles)
% hObject    handle to slider_fret_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider_fret_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_fret_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fit_gmm_gaussian.
function fit_gmm_gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to fit_gmm_gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_GMM


% --- Executes on button press in plot_overlay2.
function plot_overlay2_Callback(hObject, eventdata, handles)
% 

% --- Executes on button press in export_trace.
function export_trace_Callback(hObject, eventdata, handles)
% hObject    handle to export_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
snr_don_bckg = get(handles.disp_snr_d_bckg,'String');
snr_don_var = get(handles.disp_snr_d_var,'String');
snr_accep_bckg = get(handles.disp_snr_a_bckg,'String');
snr_accep_var = get(handles.disp_snr_a_var,'String');
ax_limit = str2num(get(handles.ax_lim,'String'));

fig1 = figure(8);
set(fig1,'units','normalized','position', [0.1, 0.2, 0.8, 0.5])
ax1=subplot(5,1,1);
ax1(1).LineWidth = 1.5;
a1 = handles.axes1;
ylabel('Donor')
grid on
ylim([0,inf]);
xlim([0, ax_limit])
copyobj(allchild(a1),ax1);
title(['Donor Bckg  ',snr_don_bckg,'  Var  ',snr_don_var,'        Accep Bckg  ',snr_accep_bckg,'  Var  ',snr_accep_var]);

ax2=subplot(5,1,2);
ax2(1).LineWidth = 1.5;
a2 = handles.axes3;
ylabel('Acceptor')
grid on
ylim([0,inf]);
xlim([0, ax_limit])
copyobj(allchild(a2),ax2);

ax3=subplot(5,1,3);
ax3(1).LineWidth = 1.5;
a3 = handles.axes22;
ylabel('Total')
grid on
ylim([0,inf]);
xlim([0, ax_limit])
copyobj(allchild(a3),ax3);

ax4=subplot(5,1,4);
ax4(1).LineWidth = 1.5;
a4 = handles.axes2;
ylabel('Norm.')
grid on
ylim([-0.05,1.15]);
xlim([0, ax_limit])
copyobj(allchild(a4),ax4);

ax5=subplot(5,1,5);
ax5(1).LineWidth = 1.5;
a5 = handles.axes10;
ylabel('FRET')
grid on
ylim([-0.05,1.1]);
xlim([0, ax_limit])
yticks(0:0.2:1);
grid on
copyobj(allchild(a5),ax5);

% --- Executes on button press in process_traces.
function process_traces_Callback(hObject, eventdata, handles)
% hObject    handle to process_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Complete_SET
vis_process = get(handles.vis_process,'Value');
stringent_filter = get(handles.stringent_filt,'Value');
fret_life_thresh = str2num(get(handles.don_auto_val,'String'));
frame_back = str2num(get(handles.frame_back,'String'));
gamma = str2num(get(handles.gamma_hist_val,'String'));
beta = str2num(get(handles.beta_hist_val,'String'));
hist_bins = str2num(get(handles.hist_bins,'String'));
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_don = getappdata(handles.load_traces, 'blch_don') - frame_back;
blch_accep = getappdata(handles.load_traces,'blch_accep') - frame_back;
blch_fret = getappdata(handles.load_traces,'blch_fret') - frame_back;
blch_type = getappdata(handles.load_traces,'blch_type');
time_ints = getappdata(handles.load_traces,'time_ints');
get_interval_hist = get(handles.hist_new_int,'Value');
interval_time = str2double(get(handles.end_overlay,'String'));
index_hist = find(time_axis == interval_time);
sigma_filt1 = get(handles.get_sigma1,'Value');
sigma_filt2 = get(handles.get_sigma2,'Value');
sigma_filt3 = get(handles.get_sigma3,'Value');
sigma_filt4 = get(handles.get_sigma4,'Value');
don_bckg_thresh = str2double(get(handles.val_don_bckg,'String'));
don_var_thresh = str2double(get(handles.val_don_var,'String'));
accep_bckg_thresh = str2double(get(handles.val_accep_bckg,'String'));
accep_var_thresh = str2double(get(handles.val_accep_var,'String'));
sigma_switch = 0;
if sigma_filt1 ==1
    sig1_cent = str2double(get(handles.val_sigma11,'String'));
    sig1_range = str2double(get(handles.val_sigma12,'String'));
    sig1_tol = str2double(get(handles.val_sigma13,'String'));
    if sig1_cent + sig1_range > 1 || sig1_cent - sig1_range <0
        msgbox('Filter 1 Off-Range: Capped between 0 &1');
    end      
    sigma_switch = 1;
end
if sigma_filt2 ==1
    sig2_cent = str2double(get(handles.val_sigma21,'String'));
    sig2_range = str2double(get(handles.val_sigma22,'String'));
    sig2_tol = str2double(get(handles.val_sigma23,'String'));
    if sig2_cent + sig2_range > 1 || sig2_cent - sig2_range <0
        msgbox('Filter 2 Off-Range: Capped between 0 &1');
    end    
    sigma_switch = 2;
end
if sigma_filt3 ==1
    sig3_cent = str2double(get(handles.val_sigma31,'String'));
    sig3_range = str2double(get(handles.val_sigma32,'String'));
    sig3_tol = str2double(get(handles.val_sigma33,'String'));
    if sig3_cent + sig3_range > 1 || sig3_cent - sig3_range <0
        msgbox('Filter 3 Off-Range: Capped between 0 &1');
    end    
    sigma_switch = 3;
end
if sigma_filt4 ==1
    sig4_cent = str2double(get(handles.val_sigma41,'String'));
    sig4_range = str2double(get(handles.val_sigma42,'String'));
    sig4_tol = str2double(get(handles.val_sigma43,'String'));
    if sig4_cent + sig4_range > 1 || sig4_cent - sig4_range <0
        msgbox('Filter 4 Off-Range: Capped between 0 &1');
    end    
    sigma_switch = 4;
end
[~,num_traces] = size(don_spec_trace);
counter = 0;
counter_don = 0;
counter_accep = 0;
fret_sel_all_hist = [];
fret_sel_all_hist_filt = [];
fret_int_indv_all = [];
fret_int_filt_indv_all = []; 
sel_trace = [];
blch_don_index = [];
blch_accep_index = [];

h = waitbar(0,'Processing Traces');
for i = 1:num_traces
    waitbar(i/num_traces,h,'Processing Traces')
    if blch_fret(i) < 1
        continue
    end
    don_sel = don_spec_trace(:,i); 
    accep_sel = accep_spec_trace(:,i);
    denom_fret = (accep_sel - beta.*don_sel) + (gamma.*don_sel);
    fret_calc_trace = (accep_sel - beta.*don_sel)./denom_fret; 
    bleachpoint_don = blch_don(i);
    bleachpoint_accep = blch_accep(i);
    bleachpoint_fret = blch_fret(i);
    
    if (bleachpoint_fret * time_ints) < fret_life_thresh
        continue
    end  

don_sel_blch = don_sel(1:bleachpoint_fret);
accep_sel_blch = accep_sel(1:bleachpoint_fret);
time_axis_blch = time_axis(1:bleachpoint_fret);
denom_fret_blch = (accep_sel_blch - beta.*don_sel_blch) + (gamma.*don_sel_blch);
fret_calc_trace_blch = (accep_sel_blch - beta.*don_sel_blch)./denom_fret_blch;  

%% Pad the matrix
blch_diff = length(don_sel)-bleachpoint_fret;
fret_diff = (zeros(blch_diff,1));
fret_calc_trace_pad = vertcat(fret_calc_trace_blch,fret_diff);   

trace_filt_don = movmean(don_sel,3);
trace_filt_accep = movmean(accep_sel,3);
denom_fret_filt = (trace_filt_accep - beta.*trace_filt_don) + (gamma.*trace_filt_don);
fret_calc_filt = (trace_filt_accep - beta.*trace_filt_don)./denom_fret_filt; 

above_outlier = find (fret_calc_trace_blch >= 1.05);  
below_outlier = find (fret_calc_trace_blch <=-0.01);
total_outlier = numel(above_outlier) + numel(below_outlier);

if stringent_filter == 1
    if total_outlier >=1
        continue
    end
end
outlier_thresh = str2double(get(handles.pass_filt,'String'));
if total_outlier > outlier_thresh
    continue
end

trace_filt_don_blch = trace_filt_don(1:bleachpoint_fret);
trace_filt_accep_blch = trace_filt_accep(1:bleachpoint_fret);
denom_fret_filt_blch = (trace_filt_accep_blch - beta.*trace_filt_don_blch) + (gamma.*trace_filt_don_blch);  
fret_calc_filt_blch = (trace_filt_accep_blch - beta.*trace_filt_don_blch)./denom_fret_filt_blch; 
fret_calc_filt_pad = vertcat(fret_calc_filt_blch,fret_diff);
% Sigma Filters
% enter the range values here

%% Use the filt with a selected variable to select and exclude
% set the filter in the ordered arrangement 4,3,2,1
skip1 = 0;
skip2 = 0;
skip3 = 0;
skip4 = 0;

if sigma_filt1 == 1
    max_filt_range1 = sig1_cent + sig1_range;
    min_filt_range1 = sig1_cent - sig1_range;
    thresh_filt1 = find(fret_calc_filt_blch<min_filt_range1 | fret_calc_filt_blch>max_filt_range1);    
    if length(fret_calc_filt_blch) > sig1_tol
        if max(fret_calc_filt_blch) > max_filt_range1 || min(fret_calc_filt_blch) < min_filt_range1
            if numel(thresh_filt1) > sig1_tol
                skip1 = 1;
            end
        end      
    end
end

if sigma_filt2 == 1
    max_filt_range2 = sig2_cent + sig2_range;
    min_filt_range2 = sig2_cent - sig2_range;
    thresh_filt2 = find(fret_calc_filt_blch<min_filt_range2 | fret_calc_filt_blch>max_filt_range2);    
    if length(fret_calc_filt_blch) > sig2_tol
        if max(fret_calc_filt_blch) > max_filt_range2 || min(fret_calc_filt_blch) < min_filt_range2
            if numel(thresh_filt2) > sig2_tol
                skip2 = 1;
            end
        end      
    end
end

if sigma_filt3 == 1
    max_filt_range3 = sig3_cent + sig3_range;
    min_filt_range3 = sig3_cent - sig3_range;
    thresh_filt3 = find(fret_calc_filt_blch<min_filt_range3 | fret_calc_filt_blch>max_filt_range3);    
    if length(fret_calc_filt_blch) > sig3_tol
        if max(fret_calc_filt_blch) > max_filt_range3 || min(fret_calc_filt_blch) < min_filt_range3
            if numel(thresh_filt3) > sig3_tol
                skip3 = 1;
            end
        end      
    end
end

if sigma_filt4 == 1
    max_filt_range4 = sig4_cent + sig4_range;
    min_filt_range4 = sig4_cent - sig4_range;
    thresh_filt4 = find(fret_calc_filt_blch<min_filt_range4 | fret_calc_filt_blch>max_filt_range4);    
    if length(fret_calc_filt_blch) > sig4_tol
        if max(fret_calc_filt_blch) > max_filt_range4 || min(fret_calc_filt_blch) < min_filt_range4
            if numel(thresh_filt4) > sig4_tol
                skip4 = 1;
            end
        end      
    end
end

switch sigma_switch
    case {1}
        if skip1 == 1
            continue
        end
    case {2}
        if skip1 && skip2 ==1
            continue
        end        
    case {3}
        if skip1 && skip2 && skip3 == 1
            continue
        end        
    case {4}  
        if skip1 && skip2 && skip3 && skip4 == 1
            continue
        end        
end

 if get_interval_hist == 1    
     if bleachpoint_fret >= index_hist
         don_sel_int = don_sel(1:index_hist);
         accep_sel_int = accep_sel(1:index_hist);
         trace_filt_don_int = trace_filt_don(1:index_hist);
         trace_filt_accep_int = trace_filt_accep(1:index_hist);
     else
         don_sel_int = don_sel(1:bleachpoint_fret);
         accep_sel_int = accep_sel(1:bleachpoint_fret);
         trace_filt_don_int = trace_filt_don(1:bleachpoint_fret);
         trace_filt_accep_int = trace_filt_accep(1:bleachpoint_fret);
     end
     
 end    
 
don_emms_tt = (don_sel_blch');
accep_emms_tt = (accep_sel_blch');
don_emms_bckg_tt = don_sel(bleachpoint_fret+3:end);
accep_emms_bckg_tt = accep_sel(bleachpoint_fret+3:end);                            
snr_don_bckg_t = mean(don_emms_tt)/std(don_emms_bckg_tt);
snr_don_var_t = mean(don_emms_tt)/std(don_emms_tt);
snr_accep_bckg_t = mean(accep_emms_tt)/std(accep_emms_bckg_tt);
snr_accep_var_t = mean(accep_emms_tt)/std(accep_emms_tt);
% Bleach type == 1 (Donor has bleached first)
% Bleach type == 2 (Acceptor has bleached first)
if blch_type == 1
    disp 1
elseif blch_type == 2
    disp 2
end

if snr_don_bckg_t < don_bckg_thresh || snr_don_var_t < don_var_thresh ...
        ||  snr_accep_bckg_t < accep_bckg_thresh || snr_accep_var_t < accep_var_thresh
    continue
end

    counter = counter+1;  
    sel_trace(:,counter) = (i);
    fret_traces(:,counter) = fret_calc_trace;
    fret_traces_filt(:,counter) = fret_calc_filt;
    fret_traces_heat(:,counter) = fret_calc_trace_pad;
    fret_traces_filt_heat(:,counter) = fret_calc_filt_pad;    

    don_stdev(:,counter) = std(don_sel_blch);
    accep_stdev(:,counter) = std(accep_sel_blch);
    fret_stdev(:,counter) = std(fret_calc_trace_blch);
    
    snr_don_bckg(:,counter) = snr_don_bckg_t;                            
    snr_don_var(:,counter) = snr_don_var_t;
    snr_accep_bckg(:,counter) = snr_accep_bckg_t;                            
    snr_accep_var(:,counter) = snr_accep_var_t;
    
    blch_type_t = blch_type(:,i);
    if blch_type_t == 1
        counter_don = counter_don + 1;
        blch_don_index(:,counter_don) = (i);
    elseif blch_type_t == 2
        counter_accep = counter_accep + 1;
        blch_accep_index(:,counter_accep) = (i);        
    end
    %% Histogram each trace
            denom_fret_hist = (accep_sel_blch - beta.*don_sel_blch) + (gamma.*don_sel_blch);
            fret_calc_inc_indv = (accep_sel_blch - beta.*don_sel_blch)./denom_fret_hist;
            fret_sel_indv_hist = fret_calc_inc_indv;              
            denom_fret_hist_filt = (trace_filt_accep_blch - beta.*trace_filt_don_blch) + (gamma.*trace_filt_don_blch);
            fret_calc_inc_indv_filt = (trace_filt_accep_blch - beta.*trace_filt_don_blch)./denom_fret_hist_filt;
            fret_sel_indv_hist_filt = fret_calc_inc_indv_filt;
        
           if get_interval_hist == 1              
              counter_fret_hist = 0;
              if bleachpoint_fret >= index_hist
                  index_hist_t = index_hist;
              else
                  index_hist_t = bleachpoint_fret;
              end
              denom_fret_hist_int = (accep_sel_int - beta.*don_sel_int) + (gamma.*don_sel_int);
              denom_fret_hist_filt_int = (trace_filt_accep_int - beta.*trace_filt_don_int)+ (gamma.*trace_filt_don_int);
              fret_int_indv_t = (accep_sel_int - beta.*don_sel_int)./denom_fret_hist_int;
              fret_int_indv = fret_int_indv_t;
              fret_int_filt_indv_t = (trace_filt_accep_int - beta.*trace_filt_don_int)./denom_fret_hist_filt_int;    
              fret_int_filt_indv = fret_int_filt_indv_t;
           end
           
        fret_sel_all_hist = vertcat(fret_sel_all_hist,fret_sel_indv_hist);
        fret_sel_all_hist_filt = vertcat(fret_sel_all_hist_filt,fret_sel_indv_hist_filt);
        num_obs_hist = numel(fret_sel_all_hist);
                
        if get_interval_hist == 1 
        fret_int_indv_all = vertcat(fret_int_indv_all,fret_int_indv);
        fret_int_filt_indv_all = vertcat(fret_int_filt_indv_all,fret_int_filt_indv);
        end
        
        if vis_process ==1
        set(handles.disp_trace_num, 'String',num2str(i));
        axes(handles.axes8)
        histogram(fret_sel_indv_hist,linspace(0,1,50));
        ylabel ('occurence');
        xlabel ('FRET');
        % plot the traces
        axes(handles.axes1)
        plot(time_axis, don_sel,'k',time_axis_blch,don_sel_blch,'g')
        ylim([-300 inf])
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        axes(handles.axes3)
        plot(time_axis,accep_sel,'k',time_axis_blch,accep_sel_blch,'r')
        ylim([-300 inf])
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        axes(handles.axes10)
        plot(time_axis,fret_calc_trace,'k',time_axis_blch,fret_calc_trace_blch,'b');
        ylim([-0.05 1.2])     
        end
        
    don_lifetime(:,counter) = bleachpoint_don*time_ints;
    accep_lifetime(:,counter) = bleachpoint_accep*time_ints;
    fret_lifetime(:,counter) = bleachpoint_fret*time_ints;
    set(handles.disp_num_obs,'String',num2str(num_obs_hist));
    
end
close(h)

%% Update the axes
axes(handles.axes5)
histfit(don_lifetime,hist_bins,'exponential')
don_lifetime_fit = fitdist(don_lifetime','exponential');
set(handles.disp_don_lifetime1,'String',num2str(don_lifetime_fit.mu));

axes(handles.axes6)
histfit(accep_lifetime,hist_bins,'exponential')
accep_lifetime_fit = fitdist(accep_lifetime','exponential');
set(handles.disp_accep_lifetime,'String',num2str(accep_lifetime_fit.mu));

axes(handles.axes7)
histfit(fret_lifetime,hist_bins,'exponential')
fret_lifetime_fit = fitdist(fret_lifetime','exponential');
set(handles.disp_fret_lifetime,'String',num2str(fret_lifetime_fit.mu));

fret_bins = str2num(get(handles.bins_fret_all,'String'));
set(handles.disp_hist_type,'String','All Times');
axes(handles.axes11)
histogram(fret_sel_all_hist, linspace(0,1,fret_bins));
setappdata(handles.replot_overlay, 'fret_sel_all_hist',fret_sel_all_hist);

axes(handles.axes14)
histogram(fret_sel_all_hist_filt, linspace(0,1,fret_bins));
setappdata(handles.replot_overlay, 'fret_sel_all_hist_filt',fret_sel_all_hist_filt);
if get_interval_hist == 1 
setappdata(handles.replot_overlay,'fret_int_indv_all',fret_int_indv_all);
setappdata(handles.replot_overlay,'fret_int_filt_indv_all',fret_int_filt_indv_all);
end

axes(handles.axes15)
histogram(fret_stdev, (0:0.01:0.3));
fit_stdev = fitdist(fret_stdev','gev');
set(handles.text58,'String',num2str(fit_stdev.mu));
set(gca,'ytick',[])
set(gca,'yticklabel',[])
axes(handles.axes16)
histogram(don_stdev,'FaceColor','g')
set(gca,'ytick',[])
set(gca,'yticklabel',[])
axes(handles.axes17)
histogram(accep_stdev,'FaceColor','r')
set(gca,'ytick',[])
set(gca,'yticklabel',[])
axes(handles.axes18)
histogram(snr_don_bckg,20,'FaceColor','g')
axes(handles.axes19)
histogram(snr_don_var,20,'FaceColor','g')
axes(handles.axes20)
histogram(snr_accep_bckg,20,'FaceColor','r')
axes(handles.axes21)
histogram(snr_accep_var,20,'FaceColor','r')


% Update the listboxes
num_process_trace = num2str((sel_trace)');
num_traces_sel = size(num_process_trace,1);
setappdata(handles.listbox2,'process_list',sel_trace');
set(handles.listbox2, 'String', num_process_trace);
set(handles.edit13, 'String', num2str(num_traces_sel));
if counter_don > 0
set(handles.listbox4,'String',num2str(blch_don_index'));
set(handles.disp_don_blch,'String',num2str(size(blch_don_index,2)));
setappdata(handles.listbox4,'process_list_don',blch_don_index');
elseif counter_don ==0
set(handles.listbox4,'String',num2str(blch_don_index'));
set(handles.disp_don_blch,'String',num2str(size(blch_don_index,2)));
end
if counter_accep >0
set(handles.listbox3,'String',num2str(blch_accep_index'));
set(handles.disp_accep_blch,'String',num2str(size(blch_accep_index,2)));
setappdata(handles.listbox3,'process_list_accep',blch_accep_index');
elseif counter_accep ==0
set(handles.listbox3,'String',num2str(blch_accep_index'));
set(handles.disp_accep_blch,'String',num2str(size(blch_accep_index,2)));
end

setappdata(handles.replot_overlay,'time_axis',time_axis);
setappdata(handles.replot_overlay,'fret_traces',fret_traces);
setappdata(handles.replot_overlay,'fret_traces_filt',fret_traces_filt);
setappdata(handles.replot_overlay,'fret_traces_heat',fret_traces_heat);
setappdata(handles.replot_overlay,'fret_traces_filt_heat',fret_traces_filt_heat);
%% Create trace overlay
color_traces_t = get(handles.overlay_color, 'SelectedObject');
color_traces = get(color_traces_t, 'String');
switch color_traces
    case {'Blue'}
    rvscolorMap = [zeros(256,1), linspace(0,1,256)', ones(256,1)];
    rvscolorMap(1:3,:) = ones(3,3);
    map = 0;
        
    case {'Red'}
    rvscolorMap = [ones(256,1), linspace(0,1,256)', zeros(256,1)];
    rvscolorMap(1:3,:) = ones(3,3);     
    map = 0;
    case{'Standard'}
        map = 1;
end  
option_grp = get(handles.uibuttongroup2,'SelectedObject');
over_type = get(option_grp,'String');
p_start = str2num(get(handles.start_overlay,'String'));
p_end = str2num(get(handles.end_overlay,'String'));
Index1 = find(time_axis == p_start);
Index2 = find(time_axis == p_end);
time_axis = time_axis(:,Index1:Index2);
fret_res = str2num(get(handles.overlay_res,'String'));
map_mod = str2num(get(handles.heatmap_fac,'String'));
counter = 0;
switch over_type
    case 'Raw'        
        fret_traces_heat = fret_traces_heat(Index1:Index2,:);
        [time_bins,~] = size(fret_traces_heat);
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            [a,b] = hist(fret_traces_heat(j,:),edges); 
            a_h_t(counter,:) = a;             
        end    
        mol_tot = sum(a_h_t(1,:));
            axes(handles.axes12)
            [M,cf] = contourf(time_axis, edges, a_h_t',map_mod);
            cf.LineStyle = 'none';
            colormap('hot')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            title (['Total number of molecules = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold';
             if map == 0
            colormap(rvscolorMap);            
            else
            colormap('parula')
            end
    case 'Smooth'
        fret_traces_filt_heat = fret_traces_filt_heat(Index1:Index2,:);
        [time_bins,~] = size(fret_traces_filt_heat);
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            [af,bf] = hist(fret_traces_filt_heat(j,:),edges);
            af_h_t(counter,:) = af;            
        end 
        mol_tot = sum(af_h_t(1,:));
            axes(handles.axes12)
            [M, cf] = contourf(time_axis, edges, af_h_t',map_mod);
            cf.LineStyle = 'none';
            colormap('hot')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            title (['Total number of molecules = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold';
            colormap(rvscolorMap)
end


function disp_don_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to disp_don_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_don_lifetime as text
%        str2double(get(hObject,'String')) returns contents of disp_don_lifetime as a double


% --- Executes during object creation, after setting all properties.
function disp_don_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_don_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_gamma_calc.
function run_gamma_calc_Callback(hObject, eventdata, handles)
% hObject    handle to run_gamma_calc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
time_axis = getappdata(handles.load_traces, 'time_axis');
accep_lifetime = getappdata(handles.run_gamma_calc,'accep_lifetime');
axes(handles.axes6)
histogram(accep_lifetime, linspace(0,max(time_axis),10));
hold on
histfit(accep_lifetime)
[accep_fit_time, accep_fit_width] = normfit(accep_lifetime);
set(handles.disp_accep_lifetime, 'String', num2str(accep_fit_time));
hold off



function disp_accep_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to disp_accep_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_accep_lifetime as text
%        str2double(get(hObject,'String')) returns contents of disp_accep_lifetime as a double


% --- Executes during object creation, after setting all properties.
function disp_accep_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_accep_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rebin_hist.
function rebin_hist_Callback(hObject, eventdata, handles)
% hObject    handle to rebin_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% get indicator of histogram range
process_traces_Callback(hObject, eventdata, handles)
recalc_hist = get(handles.hist_new_int,'Value');
fret_bins = str2num(get(handles.bins_fret_all,'String'));

if recalc_hist == 0
set(handles.disp_hist_type,'String','All Times');
fret_sel_all_hist = getappdata(handles.replot_overlay, 'fret_sel_all_hist');
fret_sel_all_hist_filt = getappdata(handles.replot_overlay, 'fret_sel_all_hist_filt');
axes(handles.axes11)
histogram(fret_sel_all_hist, linspace(0,1,fret_bins));
axes(handles.axes14)
histogram(fret_sel_all_hist_filt, linspace(0,1,fret_bins));
num_obs_hist = numel(fret_sel_all_hist);
set(handles.disp_num_obs,'String',num2str(num_obs_hist));
end

if recalc_hist == 1
set(handles.disp_hist_type,'String','Selected Interval');
fret_int_indv_all = getappdata(handles.replot_overlay,'fret_int_indv_all');
fret_int_filt_indv_all = getappdata(handles.replot_overlay,'fret_int_filt_indv_all');
axes(handles.axes11)
histogram(fret_int_indv_all, linspace(0,1,fret_bins));
axes(handles.axes14)
histogram(fret_int_filt_indv_all, linspace(0,1,fret_bins));
num_obs_hist = numel(fret_int_indv_all);
set(handles.disp_num_obs,'String',num2str(num_obs_hist));
end




function disp_fret_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to disp_fret_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_fret_lifetime as text
%        str2double(get(hObject,'String')) returns contents of disp_fret_lifetime as a double


% --- Executes during object creation, after setting all properties.
function disp_fret_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_fret_lifetime (see GCBO)
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



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in del_trace.
function del_trace_Callback(hObject, eventdata, handles)
% hObject    handle to del_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sel_trace.
function sel_trace_Callback(hObject, eventdata, handles)
% hObject    handle to sel_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file_name = getappdata(handles.load_traces, 'file_name')
load(file_name)
sel_trace_sub1 = getappdata(handles.listbox2,'process_list');
a1 = don_tot_trace(:,sel_trace_sub1);
a2 = don_bckg_trace(:,sel_trace_sub1);
a3 = don_spec_trace(:,sel_trace_sub1) ;
a10 = centers_ext(sel_trace_sub1,:);
a5 = accep_tot_trace(:,sel_trace_sub1);
a6 = accep_bckg_trace(:,sel_trace_sub1);
a7 = accep_spec_trace(:,sel_trace_sub1);

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

don_tot_trace=a1; 
don_bckg_trace=a2;
don_spec_trace=a3;
accep_tot_trace=a5;
accep_bckg_trace= a6;
accep_spec_trace= a7;
Picture_d = a8;
Picture_a = a9;
centers_ext = a10;
blch_don = blch_don(:,sel_trace_sub1);
blch_accep = blch_accep(:,sel_trace_sub1);
blch_fret = blch_fret(:,sel_trace_sub1);
blch_type = blch_type(:,sel_trace_sub1);
uisave({'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don'...
                 'blch_accep','blch_fret','blch_type','centers_ext'});


% --- Executes on button press in save_hist.
function save_hist_Callback(hObject, eventdata, handles)
% hObject   handle to save_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
option_grp = get(handles.uibuttongroup3,'SelectedObject');
over_type = get(option_grp,'String');
option_grp2 = get(handles.uibuttongroup4,'SelectedObject');
over_type2 = get(option_grp2,'String');

switch over_type
    case 'Raw'
        switch over_type2
            case 'All'
                file_sel_hist = getappdata(handles.replot_overlay, 'fret_sel_all_hist');
            case 'Selected Interval'
                file_sel_hist = getappdata(handles.replot_overlay,'fret_int_indv_all'); 
        end
counter_hist = 0;
for i = 1:length(file_sel_hist)
    if file_sel_hist(i) > -0.1 && file_sel_hist(i) < 1.1
       counter_hist = counter_hist + 1;
       file_sel_hist_t(:,counter_hist) = file_sel_hist(i);
    end
end
file_sel_hist = file_sel_hist_t;
uisave({'file_sel_hist'})

    case 'Smooth'
        switch over_type2
            case 'All'
            file_sel_hist = getappdata(handles.replot_overlay, 'fret_sel_all_hist_filt');
            case  'Selected Interval'
            file_sel_hist = getappdata(handles.replot_overlay,'fret_int_filt_indv_all');
        end
counter_hist = 0;
for i = 1:length(file_sel_hist)
    if file_sel_hist(i) > -0.1 && file_sel_hist(i) < 1.1
       counter_hist = counter_hist + 1;
       file_sel_hist_t(:,counter_hist) = file_sel_hist(i);
    end
end
file_sel_hist = file_sel_hist_t;
uisave({'file_sel_hist'})
        
end


function gamma_val_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_val as text
%        str2double(get(hObject,'String')) returns contents of gamma_val as a double


% --- Executes during object creation, after setting all properties.
function gamma_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_overlay_Callback(hObject, eventdata, handles)
% hObject    handle to end_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of end_overlay as text
%        str2double(get(hObject,'String')) returns contents of end_overlay as a double


% --- Executes during object creation, after setting all properties.
function end_overlay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function fret_bins_Callback(hObject, eventdata, handles)
% hObject    handle to fret_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fret_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fret_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function disp_don_lifetime1_Callback(hObject, eventdata, handles)
% hObject    handle to disp_don_lifetime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_don_lifetime1 as text
%        str2double(get(hObject,'String')) returns contents of disp_don_lifetime1 as a double


% --- Executes during object creation, after setting all properties.
function disp_don_lifetime1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_don_lifetime1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_files_Callback(hObject, eventdata, handles)
% hObject    handle to num_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_files as text
%        str2double(get(hObject,'String')) returns contents of num_files as a double


% --- Executes during object creation, after setting all properties.
function num_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gamma_hist_val_Callback(hObject, eventdata, handles)
% hObject    handle to gamma_hist_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gamma_hist_val as text
%        str2double(get(hObject,'String')) returns contents of gamma_hist_val as a double


% --- Executes during object creation, after setting all properties.
function gamma_hist_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gamma_hist_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3
global Complete_SET
global time_axis
process_list_accep = getappdata(handles.listbox3,'process_list_accep');
index_l3 = get(handles.listbox4,'Value');
indexl3t = process_list_accep(index_l3);

fret_life_thresh = str2num(get(handles.don_auto_val,'String'));
frame_back = str2num(get(handles.frame_back,'String'));
gamma = str2num(get(handles.gamma_hist_val,'String'));
beta = str2num(get(handles.beta_hist_val,'String'));
hist_bins = str2num(get(handles.hist_bins,'String'));
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_don = getappdata(handles.load_traces, 'blch_don') - frame_back;
blch_accep = getappdata(handles.load_traces,'blch_accep') - frame_back;
blch_fret = getappdata(handles.load_traces,'blch_fret') - frame_back;
time_ints = getappdata(handles.load_traces,'time_ints');

counter = 0;
counter_don = 0;
counter_accep = 0;
fret_sel_all_hist = [];

don_sel = don_spec_trace(:,indexl3t);  
accep_sel = accep_spec_trace(:,indexl3t);

coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
trace_filt_don = filtfilt(coeff, don_sel);  
trace_filt_accep = filtfilt(coeff,accep_sel);

% 2. normalizing the donor data from the digital filter
trace_filt_min_don = min(trace_filt_don);
trace_filt_max_don = max(trace_filt_don);
normdata_don = zeros(size(trace_filt_don,1),1);
        for m = 1 : size(trace_filt_don,1)
            normdata_don(m,1) = (trace_filt_don(m) - trace_filt_min_don) / (trace_filt_max_don - trace_filt_min_don);
        end        
% normalizing the acceptor data from the digital filter
trace_filt_min_accep = min(trace_filt_accep);
trace_filt_max_accep = max(trace_filt_accep);
        for n = 1 : size(trace_filt_accep,1)
            normdata_accep(n,1) = (trace_filt_accep(n) - trace_filt_min_accep) / (trace_filt_max_accep - trace_filt_min_accep);
        end  

denom_fret = (accep_sel - beta.*don_sel)+ (gamma.*don_sel);
denom_fret_filt = (trace_filt_accep - beta.*trace_filt_don) + (gamma.*trace_filt_don);
fret_calc_trace = (accep_sel - beta.*don_sel)./denom_fret;    
fret_calc_filt = (trace_filt_accep - beta.*trace_filt_don)./denom_fret_filt;
bleachpoint_don = blch_don(indexl3t);
bleachpoint_accep = blch_accep(indexl3t);
bleachpoint_fret = blch_fret(indexl3t);      

don_sel_blch = don_sel(1:bleachpoint_fret);
accep_sel_blch = accep_sel(1:bleachpoint_fret);

trace_filt_don_blch = trace_filt_don(1:bleachpoint_fret);
trace_filt_accep_blch = trace_filt_accep(1:bleachpoint_fret);

time_axis_blch = time_axis(1:bleachpoint_fret);
denom_fret_blch = (accep_sel_blch - beta.*don_sel_blch) + (gamma.*don_sel_blch);
fret_calc_trace_blch = (accep_sel_blch - beta.*don_sel_blch)./denom_fret_blch;

%% Histogram each trace
        counter_fret = 0;
        for j = 1:length(don_sel_blch)
            counter_fret = counter_fret + 1;
            denom_fret_hist = (accep_sel_blch (j) - beta.*don_sel_blch(j))+ (gamma.*don_sel_blch(j));
            fret_calc_inc_indv = (accep_sel_blch(j) - beta.*don_sel_blch(j))./denom_fret_hist;
            fret_sel_indv_hist(:,counter_fret) = fret_calc_inc_indv;
        end   
        counter_fret_filt = 0;
        for k = 1:length(trace_filt_don_blch)
            counter_fret_filt = counter_fret_filt+1;
            denom_fret_hist_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k)) + (gamma.*trace_filt_don_blch(k));
            fret_calc_inc_indv_filt = (trace_filt_accep_blch (k)- beta.*trace_filt_don_blch(k))./denom_fret_hist_filt;
            fret_sel_indv_hist_filt(:,counter_fret_filt) = fret_calc_inc_indv_filt;
        end
        
set(handles.disp_trace_num, 'String',num2str(indexl3t));
axes(handles.axes8)
histogram(fret_sel_indv_hist,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Raw)');
axes(handles.axes13)
histogram(fret_sel_indv_hist_filt,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Smooth)');
% plot the traces
axes(handles.axes1)
plot(time_axis, don_sel,'k',time_axis_blch,don_sel_blch,'g',time_axis,trace_filt_don,'--k')
ylabel ('Donor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
axes(handles.axes3)
plot(time_axis,accep_sel,'k',time_axis_blch,accep_sel_blch,'r',time_axis,trace_filt_accep,'--k')
ylabel ('Acceptor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
axes(handles.axes2)
plot(time_axis,normdata_don,'k',time_axis,normdata_accep,'k',time_axis_blch,normdata_don(1:bleachpoint_fret),'g', time_axis_blch,normdata_accep(1:bleachpoint_fret),'r');
axes(handles.axes10)
plot(time_axis,fret_calc_trace,'k',time_axis_blch,fret_calc_trace_blch,'b',time_axis,fret_calc_filt,'--k',time_axis_blch,fret_calc_filt(1:bleachpoint_fret),'m');
ylim([-0.05 1.2])     


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit19 as text
%        str2double(get(hObject,'String')) returns contents of edit19 as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4
global Complete_SET
global time_axis
process_list_don = getappdata(handles.listbox4,'process_list_don');
index_l4 = get(handles.listbox4,'Value');
indexl4t = process_list_don(index_l4);

fret_life_thresh = str2num(get(handles.don_auto_val,'String'));
frame_back = str2num(get(handles.frame_back,'String'));
gamma = str2num(get(handles.gamma_hist_val,'String'));
beta = str2num(get(handles.beta_hist_val,'String'));
hist_bins = str2num(get(handles.hist_bins,'String'));
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_don = getappdata(handles.load_traces, 'blch_don') - frame_back;
blch_accep = getappdata(handles.load_traces,'blch_accep') - frame_back;
blch_fret = getappdata(handles.load_traces,'blch_fret') - frame_back;
time_ints = getappdata(handles.load_traces,'time_ints');

counter = 0;
counter_don = 0;
counter_accep = 0;
fret_sel_all_hist = [];

don_sel = don_spec_trace(:,indexl4t);  
accep_sel = accep_spec_trace(:,indexl4t);

coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
trace_filt_don = filtfilt(coeff, don_sel);  
trace_filt_accep = filtfilt(coeff,accep_sel);

% 2. normalizing the donor data from the digital filter
trace_filt_min_don = min(trace_filt_don);
trace_filt_max_don = max(trace_filt_don);
normdata_don = zeros(size(trace_filt_don,1),1);
        for m = 1 : size(trace_filt_don,1)
            normdata_don(m,1) = (trace_filt_don(m) - trace_filt_min_don) / (trace_filt_max_don - trace_filt_min_don);
        end        
% normalizing the acceptor data from the digital filter
trace_filt_min_accep = min(trace_filt_accep);
trace_filt_max_accep = max(trace_filt_accep);
        for n = 1 : size(trace_filt_accep,1)
            normdata_accep(n,1) = (trace_filt_accep(n) - trace_filt_min_accep) / (trace_filt_max_accep - trace_filt_min_accep);
        end  

denom_fret = (accep_sel - beta.*don_sel)+ (gamma.*don_sel);
denom_fret_filt = (trace_filt_accep - beta.*trace_filt_don) + (gamma.*trace_filt_don);
fret_calc_trace = (accep_sel - beta.*don_sel)./denom_fret;    
fret_calc_filt = (trace_filt_accep - beta.*trace_filt_don)./denom_fret_filt;
bleachpoint_don = blch_don(indexl4t);
bleachpoint_accep = blch_accep(indexl4t);
bleachpoint_fret = blch_fret(indexl4t);      

don_sel_blch = don_sel(1:bleachpoint_fret);
accep_sel_blch = accep_sel(1:bleachpoint_fret);

trace_filt_don_blch = trace_filt_don(1:bleachpoint_fret);
trace_filt_accep_blch = trace_filt_accep(1:bleachpoint_fret);

time_axis_blch = time_axis(1:bleachpoint_fret);
denom_fret_blch = (accep_sel_blch - beta.*don_sel_blch)+ (gamma.*don_sel_blch);
fret_calc_trace_blch = (accep_sel_blch - beta.*don_sel_blch)./denom_fret_blch;

%% Histogram each trace
        counter_fret = 0;
        for j = 1:length(don_sel_blch)
            counter_fret = counter_fret + 1;
            denom_fret_hist = (accep_sel_blch (j) -beta.*don_sel_blch(j))+ (gamma.*don_sel_blch(j));
            fret_calc_inc_indv = (accep_sel_blch(j)-beta.*don_sel_blch(j))./denom_fret_hist;
            fret_sel_indv_hist(:,counter_fret) = fret_calc_inc_indv;
        end   
        counter_fret_filt = 0;
        for k = 1:length(trace_filt_don_blch)
            counter_fret_filt = counter_fret_filt+1;
            denom_fret_hist_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k))+ (gamma.*trace_filt_don_blch(k));
            fret_calc_inc_indv_filt = (trace_filt_accep_blch (k) - beta.*trace_filt_don_blch(k))./denom_fret_hist_filt;
            fret_sel_indv_hist_filt(:,counter_fret_filt) = fret_calc_inc_indv_filt;
        end
        
set(handles.disp_trace_num, 'String',num2str(indexl4t));
axes(handles.axes8)
histogram(fret_sel_indv_hist,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Raw)');
axes(handles.axes13)
histogram(fret_sel_indv_hist_filt,linspace(0,1,50))
ylabel ('occurence');
xlabel ('FRET (Smooth)');
% plot the traces
axes(handles.axes1)
plot(time_axis, don_sel,'k',time_axis_blch,don_sel_blch,'g',time_axis,trace_filt_don,'--k')
ylabel ('Donor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
axes(handles.axes3)
plot(time_axis,accep_sel,'k',time_axis_blch,accep_sel_blch,'r',time_axis,trace_filt_accep,'--k')
ylabel ('Acceptor')
ylim([-300 inf])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
axes(handles.axes2)
plot(time_axis,normdata_don,'k',time_axis,normdata_accep,'k',time_axis_blch,normdata_don(1:bleachpoint_fret),'g', time_axis_blch,normdata_accep(1:bleachpoint_fret),'r');
axes(handles.axes10)
plot(time_axis,fret_calc_trace,'k',time_axis_blch,fret_calc_trace_blch,'b',time_axis,fret_calc_filt,'--k',time_axis_blch,fret_calc_filt(1:bleachpoint_fret),'m');
ylim([-0.05 1.2])     


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_don_blch_Callback(hObject, eventdata, handles)
% hObject    handle to disp_don_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_don_blch as text
%        str2double(get(hObject,'String')) returns contents of disp_don_blch as a double


% --- Executes during object creation, after setting all properties.
function disp_don_blch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_don_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_accep_blch_Callback(hObject, eventdata, handles)
% hObject    handle to disp_accep_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_accep_blch as text
%        str2double(get(hObject,'String')) returns contents of disp_accep_blch as a double


% --- Executes during object creation, after setting all properties.
function disp_accep_blch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_accep_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function hist_bins_Callback(hObject, eventdata, handles)
% hObject    handle to hist_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of hist_bins as text
%        str2double(get(hObject,'String')) returns contents of hist_bins as a double


% --- Executes during object creation, after setting all properties.
function hist_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to hist_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_timeres_Callback(hObject, eventdata, handles)
% hObject    handle to disp_timeres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_timeres as text
%        str2double(get(hObject,'String')) returns contents of disp_timeres as a double


% --- Executes during object creation, after setting all properties.
function disp_timeres_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_timeres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in vis_process.
function vis_process_Callback(hObject, eventdata, handles)
% hObject    handle to vis_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vis_process



function overlay_res_Callback(hObject, eventdata, handles)
% hObject    handle to overlay_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of overlay_res as text
%        str2double(get(hObject,'String')) returns contents of overlay_res as a double


% --- Executes during object creation, after setting all properties.
function overlay_res_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overlay_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in new_analysis.
function new_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to new_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
clear all
close all
run kat_histos



function bins_fret_all_Callback(hObject, eventdata, handles)
% hObject    handle to bins_fret_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bins_fret_all as text
%        str2double(get(hObject,'String')) returns contents of bins_fret_all as a double


% --- Executes during object creation, after setting all properties.
function bins_fret_all_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bins_fret_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in export_overlay.
function export_overlay_Callback(hObject, eventdata, handles)
% hObject    handle to export_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig1 = figure(9);
set(fig1,'units','normalized','position', [0.1, 0.2, 0.85, 0.3])
option_grp = get(handles.uibuttongroup2,'SelectedObject');
over_type = get(option_grp,'String');
p_start = str2num(get(handles.start_overlay,'String'));
p_end = str2num(get(handles.end_overlay,'String'));
time_axis = getappdata(handles.replot_overlay,'time_axis');
Index1 = find(time_axis == p_start);
Index2 = find(time_axis == p_end);
time_axis = time_axis(:,Index1:Index2);
fret_res = str2num(get(handles.overlay_res,'String'));
map_mod = str2num(get(handles.heatmap_fac,'String'));
counter = 0;
%% Create trace overlay
color_traces_t = get(handles.overlay_color, 'SelectedObject');
color_traces = get(color_traces_t, 'String');
switch color_traces
    case {'Blue'}
    rvscolorMap = [zeros(256,1), linspace(0,1,256)', ones(256,1)];
    rvscolorMap(1:3,:) = ones(3,3);   
    map = 0;
    case {'Red'}
    rvscolorMap = [ones(256,1), linspace(0,1,256)', zeros(256,1)];
    rvscolorMap(1:3,:) = ones(3,3);  
    map = 0;
    case{'Standard'}
        map = 1;
end  

switch over_type
    case 'Raw'
        fret_traces = getappdata(handles.replot_overlay,'fret_traces_heat');
        fret_traces = fret_traces(Index1:Index2,:);
        [time_bins,~] = size(fret_traces);
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            [a,b] = hist(fret_traces(j,:),edges); 
            a_h_t(counter,:) = a;             
        end    
        mol_tot = sum(a_h_t(1,:));
            fig1;
            [M, cf] = contourf(time_axis, edges, a_h_t', map_mod);
            cf.LineStyle = 'none';
            colormap('hot')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            title (['Total number of molecules = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold';
             if map == 0
            colormap(rvscolorMap);            
            else
            colormap('parula')
             end
    case 'Smooth'
        fret_traces_filt = getappdata(handles.replot_overlay,'fret_traces_filt_heat');
        fret_traces_filt = fret_traces_filt(Index1:Index2,:);
        [time_bins,~] = size(fret_traces_filt);
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            [af,bf] = hist(fret_traces_filt(j,:),edges);
            af_h_t(counter,:) = af;            
        end 
        mol_tot = sum(af_h_t(1,:));
            fig1;
            [M, cf] = contourf(time_axis, edges, af_h_t', map_mod);
            cf.LineStyle = 'none';
            colormap('hot')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            title (['Total number of molecules = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold';
            colormap(rvscolorMap);            
end


% --- Executes during object creation, after setting all properties.
function process_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to process_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function process_traces_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to process_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in replot_overlay.
function replot_overlay_Callback(hObject, eventdata, handles)
% hObject    handle to replot_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
option_grp = get(handles.uibuttongroup2,'SelectedObject');
over_type = get(option_grp,'String');
p_start = str2num(get(handles.start_overlay,'String'));
p_end = str2num(get(handles.end_overlay,'String'));
time_axis = getappdata(handles.replot_overlay,'time_axis');
Index1 = find(time_axis == p_start);
Index2 = find(time_axis == p_end);
time_axis = time_axis(:,Index1:Index2);
fret_res = str2num(get(handles.overlay_res,'String'));
map_mod = str2num(get(handles.heatmap_fac,'String'));

%% Create trace overlay
color_traces_t = get(handles.overlay_color, 'SelectedObject');
color_traces = get(color_traces_t, 'String');
switch color_traces
    case {'Blue'}
    rvscolorMap = [zeros(256,1), linspace(0,1,256)', ones(256,1)];
    rvscolorMap(1:3,:) = ones(3,3);
    map = 0;
        
    case {'Red'}
    rvscolorMap = [ones(256,1), linspace(0,1,256)', zeros(256,1)];
    rvscolorMap(1:3,:) = ones(3,3); 
    map = 0;
    case{'Standard'}
    map = 1;
end  
counter = 0;
counter_new = 0;
switch over_type
    case 'Raw'
        fret_traces = getappdata(handles.replot_overlay,'fret_traces_heat');
        fret_traces = fret_traces(Index1:Index2,:);
        [time_bins,~] = size(fret_traces);
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            [a,b] = hist(fret_traces(j,:),edges); 
            a_h_t(counter,:) = a;             
        end 
            mol_tot = sum(a_h_t(1,:));
            axes(handles.axes12)
            [M,cf] = contourf(time_axis, edges, a_h_t',map_mod);
            cf.LineStyle = 'none'; 
            colormap('hot')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            title (['Total number of molecules = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold';
            if map == 0
            colormap(rvscolorMap);            
            else
            colormap('parula')
            end
    case 'Smooth'
        fret_traces_filt = getappdata(handles.replot_overlay,'fret_traces_filt_heat');
        fret_traces_filt = fret_traces_filt(Index1:Index2,:);
        [time_bins,num_traces] = size(fret_traces_filt);
        for j = 1:time_bins
            counter = counter+ 1;
            edges = [0:fret_res:1];
            [af,bf] = hist(fret_traces_filt(j,:),edges);
            af_h_t(counter,:) = af;            
        end 
            mol_tot = sum(af_h_t(1,:));
            axes(handles.axes12)
            [M, cf] = contourf(time_axis, edges, af_h_t',map_mod);
            cf.LineStyle = 'none';            
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            title (['Total number of molecules = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Molecules');
            prop.b2.FontWeight = 'bold'; 
            colormap(rvscolorMap);
end



% --- Executes on button press in stringent_filt.
function stringent_filt_Callback(hObject, eventdata, handles)
% hObject    handle to stringent_filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of stringent_filt



function pass_filt_Callback(hObject, eventdata, handles)
% hObject    handle to pass_filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pass_filt as text
%        str2double(get(hObject,'String')) returns contents of pass_filt as a double


% --- Executes during object creation, after setting all properties.
function pass_filt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pass_filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_sigma1.
function get_sigma1_Callback(hObject, eventdata, handles)
% hObject    handle to get_sigma1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of get_sigma1


% --- Executes on button press in get_sigma2.
function get_sigma2_Callback(hObject, eventdata, handles)
% hObject    handle to get_sigma2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of get_sigma2



function val_sigma11_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma11 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma11 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma21_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma21 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma21 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_sigma3.
function get_sigma3_Callback(hObject, eventdata, handles)
% hObject    handle to get_sigma3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of get_sigma3


% --- Executes on button press in get_sigma4.
function get_sigma4_Callback(hObject, eventdata, handles)
% hObject    handle to get_sigma4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of get_sigma4



function val_sigma31_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma31 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma31 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma41_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma41 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma41 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma12_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma12 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma12 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma22_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma22 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma22 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma32_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma32 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma32 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma42_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma42 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma42 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hist_new_int.
function hist_new_int_Callback(hObject, eventdata, handles)
% hObject    handle to hist_new_int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hist_new_int



function disp_hist_type_Callback(hObject, eventdata, handles)
% hObject    handle to disp_hist_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_hist_type as text
%        str2double(get(hObject,'String')) returns contents of disp_hist_type as a double


% --- Executes during object creation, after setting all properties.
function disp_hist_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_hist_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_hists.
function exp_hists_Callback(hObject, eventdata, handles)
% hObject    handle to exp_hists (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig2 = figure(10);
set(fig2,'units','normalized','position', [0.1, 0.2, 0.8, 0.26])
ax1=subplot(1,4,1);
a1 = handles.axes8;
prop.a1 = gca;
ylabel('Occurence-Raw')
xlabel('FRET-Individual Trace')
grid on
prop.a1.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

ax2=subplot(1,4,2);
a2 = handles.axes13;
prop.a2 = gca;
ylabel('Occurence-Smooth')
xlabel('FRET-Individual Trace')
grid on
prop.a2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

ax3=subplot(1,4,3);
a3 = handles.axes11;
prop.a3 = gca;
ylabel('Occurence-Raw')
xlabel('FRET-All Trace')
grid on
prop.a3.FontWeight = 'bold';
copyobj(allchild(a3),ax3);

ax4=subplot(1,4,4);
a4 = handles.axes14;
prop.a4 = gca;
ylabel('Occurence-Smooth')
xlabel('FRET-All Trace')
grid on
prop.a4.FontWeight = 'bold';
copyobj(allchild(a4),ax4);


% --- Executes on button press in qik_guide1.
function qik_guide1_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','1) Filters Traces to Select Specific FRET Ranges',...
         '2) Activate Channels in Sequence F 1-4','3) Value 1 (F) = Desired FRET value','4) Value 2 (Span) = Set Range around FRET Value',...
        '5) Value 3 (Tol) = # of Values outside Range'},...
        'KAT: Histos');


% --- Executes on button press in qik_guide2.
function qik_guide2_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)    
helpdlg({'Quick Step Guide:','Process Histograms at an Interval',...
         '1) Activate the button above (All Histograms at interval) and then click "Process Traces"','2) Set Select Group of Histograms To Save Analyse to "Selected Interval"','3) Select Raw or Smooth Traces to EXPORT in order to fit with GMM',...
         'Filtering Criteria','3) FRET Lifetime-minimum lifetime of the traces'...
         '4) Frames back-change value if traces are cut too far after bleachpoint','5) Start time and End time Sets interval for Overlay and Histograms','6) Overlay can be generated at any time with Selected times start and end',...
         '7) All other histograms require reprocessing by pressing "Process Traces"'},...
        'KAT2-Histograms: Help');

% --- Executes on button press in qik_guide3.
function qik_guide3_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','FRET Traces to Histograms',...
         '1) A Passive Filter allows the specified number of values to lie outside of the 0-1 FRET range','2) A stringent filter allows NO values to be out of range'},...
        'KAT2-Histograms: Help');




function val_sigma13_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma13 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma13 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma23_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma23 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma23 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma33_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma33 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma33 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_sigma43_Callback(hObject, eventdata, handles)
% hObject    handle to val_sigma43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_sigma43 as text
%        str2double(get(hObject,'String')) returns contents of val_sigma43 as a double


% --- Executes during object creation, after setting all properties.
function val_sigma43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_sigma43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_stdev.
function exp_stdev_Callback(hObject, eventdata, handles)
% hObject    handle to exp_stdev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig2 = figure(10);
set(fig2,'units','normalized','position', [0.1, 0.2, 0.8, 0.25])
ax1=subplot(1,3,1);
a1 = handles.axes16;
title('Donor')
copyobj(allchild(a1),ax1);

ax2=subplot(1,3,2);
a2 = handles.axes17;
title('Acceptor')
copyobj(allchild(a2),ax2);

ax3=subplot(1,3,3);
a3 = handles.axes15;
title('FRET')
copyobj(allchild(a3),ax3);



function heatmap_fac_Callback(hObject, eventdata, handles)
% hObject    handle to heatmap_fac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of heatmap_fac as text
%        str2double(get(hObject,'String')) returns contents of heatmap_fac as a double


% --- Executes during object creation, after setting all properties.
function heatmap_fac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to heatmap_fac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function replot_overlay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to replot_overlay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function run_man_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to run_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function uibuttongroup1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function val_don_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to val_don_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_don_bckg as text
%        str2double(get(hObject,'String')) returns contents of val_don_bckg as a double


% --- Executes during object creation, after setting all properties.
function val_don_bckg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_don_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_don_var_Callback(hObject, eventdata, handles)
% hObject    handle to val_don_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_don_var as text
%        str2double(get(hObject,'String')) returns contents of val_don_var as a double


% --- Executes during object creation, after setting all properties.
function val_don_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_don_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_accep_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to val_accep_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_accep_bckg as text
%        str2double(get(hObject,'String')) returns contents of val_accep_bckg as a double


% --- Executes during object creation, after setting all properties.
function val_accep_bckg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_accep_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function val_accep_var_Callback(hObject, eventdata, handles)
% hObject    handle to val_accep_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_accep_var as text
%        str2double(get(hObject,'String')) returns contents of val_accep_var as a double


% --- Executes during object creation, after setting all properties.
function val_accep_var_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_accep_var (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in hist_compar.
function hist_compar_Callback(hObject, eventdata, handles)
% hObject    handle to hist_compar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_hist_comp_v2



function compar_num_Callback(hObject, eventdata, handles)
% hObject    handle to compar_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of compar_num as text
%        str2double(get(hObject,'String')) returns contents of compar_num as a double


% --- Executes during object creation, after setting all properties.
function compar_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to compar_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_hist_val_Callback(hObject, eventdata, handles)
% hObject    handle to beta_hist_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta_hist_val as text
%        str2double(get(hObject,'String')) returns contents of beta_hist_val as a double


% --- Executes during object creation, after setting all properties.
function beta_hist_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta_hist_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = zoom;
h.Motion = 'horizontal';
h.Enable = 'on';
% zoom in on the plot in the horizontal direction.
a1 = (handles.axes1);
a3 = (handles.axes3);
a22 = (handles.axes22);
a2 = (handles.axes2);
a10 = (handles.axes10);
linkaxes([a1,a3,a22,a2, a10],'x');

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1 = (handles.axes1);
a3 = (handles.axes3);
a22 = (handles.axes22);
a2 = (handles.axes2);
a10 = (handles.axes10);

linkaxes([a1,a3,a22,a2, a10],'x');
zoom('out');
linkaxes([a1,a3,a22,a2, a10],'x');
zoom off
linkaxes([a1,a3,a22,a2, a10],'x');



function ax_lim_Callback(hObject, eventdata, handles)
% hObject    handle to ax_lim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ax_lim as text
%        str2double(get(hObject,'String')) returns contents of ax_lim as a double


% --- Executes during object creation, after setting all properties.
function ax_lim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ax_lim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_num_obs_Callback(hObject, eventdata, handles)
% hObject    handle to disp_num_obs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_num_obs as text
%        str2double(get(hObject,'String')) returns contents of disp_num_obs as a double


% --- Executes during object creation, after setting all properties.
function disp_num_obs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_num_obs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
