function varargout = kat_blch_mod(varargin)
% KAT_BLCH_MOD MATLAB code for kat_blch_mod.fig
%      KAT_BLCH_MOD, by itself, creates a new KAT_BLCH_MOD or raises the existing
%      singleton*.
%
%      H = KAT_BLCH_MOD returns the handle to a new KAT_BLCH_MOD or the handle to
%      the existing singleton*.
%
%      KAT_BLCH_MOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_BLCH_MOD.M with the given input arguments.
%
%      KAT_BLCH_MOD('Property','Value',...) creates a new KAT_BLCH_MOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_blch_mod_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_blch_mod_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_blch_mod

% Last Modified by GUIDE v2.5 12-Jun-2022 00:29:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_blch_mod_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_blch_mod_OutputFcn, ...
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


% --- Executes just before kat_blch_mod is made visible.
function kat_blch_mod_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_blch_mod (see VARARGIN)

% Choose default command line output for kat_blch_mod
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_blch_mod wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_blch_mod_OutputFcn(hObject, eventdata, handles) 
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
index_sel = get(handles.listbox1,'Value');
set(handles.disp_trace_num,'String',num2str(index_sel));

time_axis = getappdata(handles.load_traces, 'time_axis');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
% get the original blch pts
blch_don = getappdata(handles.load_traces,'blch_don');
blch_don_t = getappdata(handles.load_traces,'blch_don_t');
blch_accep = getappdata(handles.load_traces,'blch_accep');
blch_accep_t = getappdata(handles.load_traces,'blch_accep_t');
blch_fret = getappdata(handles.load_traces,'blch_fret');
blch_fret_t = getappdata(handles.load_traces,'blch_fret_t');

sel_blch1 = blch_fret_t(index_sel);
set(handles.disp_old_blch,'String',num2str(sel_blch1));
sel_blch = blch_fret(index_sel);
set(handles.disp_new_blch,'String',num2str(sel_blch));

don_sel = don_spec_trace(:,index_sel);
don_sel_blch = don_sel(1:sel_blch);
accep_sel = accep_spec_trace(:,index_sel);
accep_sel_blch = accep_sel(1:sel_blch);

% don_sel_blch1 = don_sel(1:sel_blch1);
% accep_sel_blch1 = accep_sel(1:sel_blch1);

time_axis_blch = time_axis(1:sel_blch);
axes(handles.axes1);
plot(time_axis, don_sel,'--k', time_axis_blch, don_sel_blch,'g');
ylabel('Donor','FontWeight','bold')
ylim([0 +inf]);
grid on

axes(handles.axes2);
plot(time_axis, accep_sel,'--k', time_axis_blch, accep_sel_blch,'r');
ylabel('Acceptor','FontWeight','bold')
ylim([0 +inf]);
grid on

axes(handles.axes4);
max_don_sel = (mean(don_sel(1:10)));
max_accep_sel = (mean(accep_sel(1:10)));
norm_don_trace = don_sel./max_don_sel;
norm_accep_trace = accep_sel./max_accep_sel;
plot(time_axis,norm_don_trace,'g',time_axis, norm_accep_trace, 'r');
ylabel('Norm. Overlay','FontWeight','bold')
ylim([0 +inf]);
grid on

gamma = str2num(get(handles.gamma_corr_val,'String'));
denom_fret = accep_sel + (gamma.*don_sel);
fret_calc_trace = accep_sel./denom_fret;
axes(handles.axes6);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET','FontWeight','bold')
xlabel('Time (s)')
ylim([0 1]);
yticks(0:0.2:1);
grid on

% Histogram Initial
axes(handles.axes8)
[fret_indiv_curr,tot_hist_obs_curr] = trace_to_hist(don_sel, accep_sel, sel_blch1, gamma);
histogram(fret_indiv_curr, linspace(0,1,50),'LineWidth', 1.25,'FaceColor', 'none')
set(handles.disp_old_ind,'String', num2str(tot_hist_obs_curr))

% Histogram Current
axes(handles.axes7)
[fret_indiv_init,tot_hist_obs_init] = trace_to_hist(don_sel, accep_sel,sel_blch, gamma);
histogram(fret_indiv_init, linspace(0,1,50),'LineWidth', 1.25,'FaceColor', 'none')
set(handles.disp_new_ind,'String', num2str(tot_hist_obs_init));

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


% --- Executes on button press in load_traces.
function load_traces_Callback(hObject, eventdata, handles)
% hObject    handle to load_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[fname, path_trace] = uigetfile(); 
[~,file_name] = fileparts(fname);
addpath(path_trace);
set(handles.disp_filename, 'String',file_name);
setappdata(handles.load_traces, 'path_trace', path_trace);
setappdata(handles.load_traces, 'file_name', file_name);
%% Load File data
load(file_name)
setappdata(handles.load_traces, 'Mode1', Mode1);
setappdata(handles.load_traces,'filtered_data',filtered_data)
setappdata(handles.load_traces, 'time_axis', time_axis);
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
% get the original blch pts
blch_don_t = blch_don;
blch_accep_t = blch_accep;
blch_fret_t = blch_fret;
setappdata(handles.load_traces,'blch_don', blch_don);
setappdata(handles.load_traces,'blch_don_t', blch_don_t);
setappdata(handles.load_traces,'blch_accep', blch_accep);
setappdata(handles.load_traces,'blch_accep_t', blch_accep_t);
setappdata(handles.load_traces,'blch_fret', blch_fret);
setappdata(handles.load_traces,'blch_fret_t', blch_fret_t);
setappdata(handles.load_traces,'blch_type', blch_type);
% get the time interval
time_ints = time_axis(2)-time_axis(1);
set(handles.disp_time_int,'String',num2str(time_ints*1000));
[~, num_traces] = size(don_spec_trace);
set(handles.disp_tot_num_traces,'String', num2str(num_traces));
list_trace = num2str ((1:num_traces)');
set(handles.listbox1, 'String', list_trace);
% Generate Histogram
gamma = str2num(get(handles.gamma_corr_val,'String'));
[fret_sel_all_hist2,tot_hist_obs] = trace_to_hist(don_spec_trace, accep_spec_trace, blch_fret, gamma);
set(handles.disp_old_all,'String', num2str(tot_hist_obs));
axes(handles.axes10)
histogram(fret_sel_all_hist2, linspace(0,1,50),'LineWidth', 1.25,'FaceColor', 'none')

function disp_filename_Callback(hObject, eventdata, handles)
% hObject    handle to disp_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_filename as text
%        str2double(get(hObject,'String')) returns contents of disp_filename as a double


% --- Executes during object creation, after setting all properties.
function disp_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_old_blch_Callback(hObject, eventdata, handles)
% hObject    handle to disp_old_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_old_blch as text
%        str2double(get(hObject,'String')) returns contents of disp_old_blch as a double


% --- Executes during object creation, after setting all properties.
function disp_old_blch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_old_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_new_blch_Callback(hObject, eventdata, handles)
% hObject    handle to disp_new_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_new_blch as text
%        str2double(get(hObject,'String')) returns contents of disp_new_blch as a double


% --- Executes during object creation, after setting all properties.
function disp_new_blch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_new_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_new_blch.
function get_new_blch_Callback(hObject, eventdata, handles)
% hObject    handle to get_new_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_sel = get(handles.listbox1,'Value');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_don = getappdata(handles.load_traces,'blch_don');
blch_accep = getappdata(handles.load_traces,'blch_accep');
blch_fret = getappdata(handles.load_traces,'blch_fret');

% Get the New Bleach point
[xval,yval] = ginput(1);
ind_t = find(xval <=time_axis);
ind_sel = ind_t(1);        
bleachpoint_fret = ind_sel;

% set the new bleachpoint
blch_don(index_sel) = bleachpoint_fret;
blch_accep(index_sel) = bleachpoint_fret;
blch_fret(index_sel) = bleachpoint_fret;
setappdata(handles.load_traces,'blch_don',blch_don);
setappdata(handles.load_traces,'blch_accep',blch_accep);
setappdata(handles.load_traces,'blch_fret',blch_fret);
listbox1_Callback(hObject, eventdata, handles)
reprocess_Callback(hObject, eventdata, handles)



% --- Executes on button press in save_traces.
function save_traces_Callback(hObject, eventdata, handles)
% hObject    handle to save_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
time_axis = getappdata(handles.load_traces, 'time_axis');
Mode1 = getappdata(handles.load_traces, 'Mode1');
filtered_data = getappdata(handles.load_traces,'filtered_data');
don_tot_trace = getappdata(handles.load_traces, 'don_tot_trace');
don_bckg_trace = getappdata(handles.load_traces, 'don_bckg_trace');
accep_tot_trace = getappdata(handles.load_traces, 'accep_tot_trace');
accep_bckg_trace = getappdata(handles.load_traces, 'accep_bckg_trace');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
Picture_d = getappdata(handles.load_traces, 'Picture_d');
Picture_a = getappdata(handles.load_traces, 'Picture_a');
centers_ext = getappdata(handles.load_traces, 'centers_ext');
blch_don = getappdata(handles.load_traces,'blch_don');
blch_accep = getappdata(handles.load_traces,'blch_accep');
blch_fret = getappdata(handles.load_traces,'blch_fret');
blch_type = getappdata(handles.load_traces,'blch_type');


file_name = getappdata(handles.load_traces, 'file_name');

save([file_name,'_mod.mat'],'time_axis','don_tot_trace','don_bckg_trace','don_spec_trace',...
                 'accep_tot_trace','accep_bckg_trace','accep_spec_trace', 'Picture_d','Picture_a','Mode1','filtered_data','blch_don',...
                 'blch_accep','blch_fret','blch_type','centers_ext');
msgbox([file_name,'_mod.mat'])       


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



function disp_new_ind_Callback(hObject, eventdata, handles)
% hObject    handle to disp_new_ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_new_ind as text
%        str2double(get(hObject,'String')) returns contents of disp_new_ind as a double


% --- Executes during object creation, after setting all properties.
function disp_new_ind_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_new_ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_old_ind_Callback(hObject, eventdata, handles)
% hObject    handle to disp_old_ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_old_ind as text
%        str2double(get(hObject,'String')) returns contents of disp_old_ind as a double


% --- Executes during object creation, after setting all properties.
function disp_old_ind_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_old_ind (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_new_all_Callback(hObject, eventdata, handles)
% hObject    handle to disp_new_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_new_all as text
%        str2double(get(hObject,'String')) returns contents of disp_new_all as a double


% --- Executes during object creation, after setting all properties.
function disp_new_all_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_new_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_old_all_Callback(hObject, eventdata, handles)
% hObject    handle to disp_old_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_old_all as text
%        str2double(get(hObject,'String')) returns contents of disp_old_all as a double


% --- Executes during object creation, after setting all properties.
function disp_old_all_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_old_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reprocess.
function reprocess_Callback(hObject, eventdata, handles)
% hObject    handle to reprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
blch_fret = getappdata(handles.load_traces,'blch_fret');
blch_fret_t = getappdata(handles.load_traces,'blch_fret_t');
gamma = str2num(get(handles.gamma_corr_val,'String'));

% Current
[fret_sel_all_hist2,tot_hist_obs] = trace_to_hist(don_spec_trace, accep_spec_trace, blch_fret, gamma);
set(handles.disp_new_all,'String', num2str(tot_hist_obs));
axes(handles.axes9)
histogram(fret_sel_all_hist2, linspace(0,1,50),'LineWidth', 1.25,'FaceColor', 'none')

% Initial
[fret_sel_all_hist2_init,tot_hist_obs_init] = trace_to_hist(don_spec_trace, accep_spec_trace, blch_fret_t, gamma);
set(handles.disp_old_all,'String', num2str(tot_hist_obs_init));
axes(handles.axes10)
histogram(fret_sel_all_hist2_init, linspace(0,1,50),'LineWidth', 1.25,'FaceColor', 'none')
