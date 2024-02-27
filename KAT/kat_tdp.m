function varargout = kat_tdp(varargin)
% KAT_TDP MATLAB code for kat_tdp.fig
%      KAT_TDP, by itself, creates a new KAT_TDP or raises the existing
%      singleton*.
%
%      H = KAT_TDP returns the handle to a new KAT_TDP or the handle to
%      the existing singleton*.
%
%      KAT_TDP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_TDP.M with the given input arguments.
%
%      KAT_TDP('Property','Value',...) creates a new KAT_TDP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_tdp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_tdp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_tdp

% Last Modified by GUIDE v2.5 14-Feb-2022 23:38:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_tdp_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_tdp_OutputFcn, ...
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


% --- Executes just before kat_tdp is made visible.
function kat_tdp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_tdp (see VARARGIN)

% Choose default command line output for kat_tdp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_tdp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_tdp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_file.
function load_file_Callback(hObject, eventdata, handles)
% hObject    handle to load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ispc == 1
    seps = '\';
else
    seps = '/';
end
time_int = str2num(get(handles.int_time,'String'));
% num_bins = str2num(get(handles.num_bins,'String'));
[fname, path_trace] = uigetfile(); 
[~,file_name] = fileparts(fname);
load(file_name)
addpath(path_trace);
set(handles.disp_filename, 'String',file_name);
setappdata(handles.load_file, 'path_trace', path_trace);
setappdata(handles.load_file, 'file_name', file_name);
eb_traces = traces;
% There are 6 columns
% 1 Trace ID
% 2 Donor 
% 3 Acceptor
% 4 Mean FRET
% 5 State
% 6 State FRET
num_traces = max(eb_traces(:,1));
num_states = max(eb_traces(:,5));
set(handles.disp_num_traces,'String',num2str(num_traces));
set(handles.disp_num_states,'String',num2str(num_states));
setappdata(handles.load_file,'eb_traces',eb_traces);
setappdata(handles.load_file, 'num_states',num_states);
setappdata(handles.load_file, 'num_traces',num_traces);
% Get the Traces:  Set up the for loop for reading through the traces.
% For each trace, bin the dwell time in each state
eb_state_1= [];
eb_state_2= [];
eb_state_3= [];
eb_state_4= [];
eb_state_5= [];
eb_state_6= [];
ses_1r = [];
ses_1i = [];
ses_2r = [];
ses_2i = [];
ses_3r = [];
ses_3i = [];
f_tdp_raw = [];
f_tdp_ideal = [];
for i = 1:num_traces
    eb_sel_trace_ind = find(eb_traces(:,1) == i);
    eb_sel_trace1 = eb_traces(eb_sel_trace_ind,5);
    [state_1, state_2, state_3, state_4, state_5, state_6] = trace_dwells(eb_sel_trace1,num_states);
    all_states = vertcat(state_1, state_2, state_3, state_4, state_5, state_6);
    if max(all_states) > 1
    longest_trans_t(i) = max(all_states);
    else
    longest_trans_t(i) = 1;    
    end
end
% determine the longest transition 
longest_trans = max(max(longest_trans_t));
set(handles.disp_long_trans,'String', num2str(longest_trans));
for i = 1:num_traces
    eb_sel_trace_ind = find(eb_traces(:,1) == i);
    eb_sel_trace1 = eb_traces(eb_sel_trace_ind,5);
    eb_sel_trace1_raw = eb_traces(eb_sel_trace_ind,4);
    eb_sel_trace1_ideal = eb_traces(eb_sel_trace_ind,6);
    [seg_1_raw, seg_1_ideal, seg_2_raw, seg_2_ideal, seg_3_raw, seg_3_ideal] = tracesegments(eb_sel_trace1,num_states,eb_sel_trace1_raw,eb_sel_trace1_ideal,longest_trans);   
    ses_1r = [ses_1r seg_1_raw];
    ses_2r = [ses_2r seg_2_raw];
    ses_3r = [ses_3r seg_3_raw];
    ses_1i = [ses_1i seg_1_ideal];
    ses_2i = [ses_2i seg_2_ideal]; 
    ses_3i = [ses_3i seg_3_ideal];
    % are these variables present
    [tdps_raw, tdps_ideal] = tdp_pts(eb_sel_trace1,eb_sel_trace1_raw,eb_sel_trace1_ideal);
    f_tdp_raw = vertcat(f_tdp_raw, tdps_raw);
    f_tdp_ideal = vertcat(f_tdp_ideal, tdps_ideal);
    
end
    axes(handles.axes1)   
    histogram2(f_tdp_raw(:,1), f_tdp_raw(:,2),20, 'DisplayStyle','tile');
    h.Normalization = 'countdensity';
    colormap('hot')
    ylabel('FRET after','FontWeight','bold')
    xlabel('FRET before','FontWeight','bold')
    grid off
    axes(handles.axes2)   
    histogram2(f_tdp_ideal(:,1), f_tdp_ideal(:,2),25,'DisplayStyle','tile');
    colormap('hot')
    ylabel('FRET after','FontWeight','bold')
    xlabel('FRET before','FontWeight','bold')
    grid off
    
%save('all_tdps.mat', 'f_tdp_raw')
ses_allr = [ses_1r ses_2r];
ses_alli = [ses_1i ses_2i];
    switch num_states            
    case{3}             
ses_allr = [ses_1r ses_2r ses_3r];
ses_alli = [ses_1i ses_2i ses_3i];             
    end
%
setappdata(handles.load_file, 'ses_allr',ses_allr);
setappdata(handles.load_file, 'ses_alli',ses_alli);
heat_lim = 0;
heat_end = 0;
axes(handles.axes3)
            [a_h_t, time_axis, edges] = dwell_heatmap(ses_allr, heat_lim,heat_end);
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
%             colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Transitions');
            prop.b2.FontWeight = 'bold';
axes(handles.axes4)
            [a_h_t, time_axis, edges] = dwell_heatmap(ses_alli,heat_lim, heat_end);
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
%             colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Transitions');
            prop.b2.FontWeight = 'bold';
            
            
            

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



function disp_num_traces_Callback(hObject, eventdata, handles)
% hObject    handle to disp_num_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_num_traces as text
%        str2double(get(hObject,'String')) returns contents of disp_num_traces as a double


% --- Executes during object creation, after setting all properties.
function disp_num_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_num_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_num_states_Callback(hObject, eventdata, handles)
% hObject    handle to disp_num_states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_num_states as text
%        str2double(get(hObject,'String')) returns contents of disp_num_states as a double


% --- Executes during object creation, after setting all properties.
function disp_num_states_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_num_states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_process.
function run_process_Callback(hObject, eventdata, handles)
% hObject    handle to run_process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in export_plots.
function export_plots_Callback(hObject, eventdata, handles)
% hObject    handle to export_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
heat_lim = get(handles.heat_lim_tdp, 'Value');
if heat_lim ==0
    heat_end = 0;
else
    heat_end = str2num(get(handles.get_heat_len,'String'));
end

ses_allr = getappdata(handles.load_file, 'ses_allr');
ses_alli = getappdata(handles.load_file, 'ses_alli');
axes(handles.axes3)
            [a_h_t, time_axis, edges] = dwell_heatmap(ses_allr, heat_lim,heat_end);
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
%             colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Transitions');
            prop.b2.FontWeight = 'bold';
axes(handles.axes4)
            [a_h_t, time_axis, edges] = dwell_heatmap(ses_alli,heat_lim,heat_end);
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
%             colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Transitions');
            prop.b2.FontWeight = 'bold';




% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function int_time_Callback(hObject, eventdata, handles)
% hObject    handle to int_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of int_time as text
%        str2double(get(hObject,'String')) returns contents of int_time as a double


% --- Executes during object creation, after setting all properties.
function int_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to int_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_long_trans_Callback(hObject, eventdata, handles)
% hObject    handle to disp_long_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_long_trans as text
%        str2double(get(hObject,'String')) returns contents of disp_long_trans as a double


% --- Executes during object creation, after setting all properties.
function disp_long_trans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_long_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3



function get_heat_len_Callback(hObject, eventdata, handles)
% hObject    handle to get_heat_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_heat_len as text
%        str2double(get(hObject,'String')) returns contents of get_heat_len as a double


% --- Executes during object creation, after setting all properties.
function get_heat_len_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_heat_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in heat_lim_tdp.
function heat_lim_tdp_Callback(hObject, eventdata, handles)
% hObject    handle to heat_lim_tdp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of heat_lim_tdp


% --- Executes on button press in export_figs.
function export_figs_Callback(hObject, eventdata, handles)
% hObject    handle to export_figs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

heat_lim = get(handles.heat_lim_tdp, 'Value');
if heat_lim ==0
    heat_end = 0;
else
    heat_end = str2num(get(handles.get_heat_len,'String'));
end

ses_allr = getappdata(handles.load_file, 'ses_allr');
ses_alli = getappdata(handles.load_file, 'ses_alli');
figure(2)
            [a_h_t, time_axis, edges] = dwell_heatmap(ses_allr, heat_lim,heat_end);
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
%             colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Transitions');
            prop.b2.FontWeight = 'bold';
figure(3)
            [a_h_t, time_axis, edges] = dwell_heatmap(ses_alli,heat_lim,heat_end);
            mol_tot = sum(a_h_t(1,:));
            [M,cf] = contourf(time_axis, edges, a_h_t');
            cf.LineStyle = 'none'; 
%             colormap('parula')
            prop.b2 = gca;
            ylabel ('FRET Efficiency')
            xlabel ('Dwell time')
            title (['Total number of Transitions = ',num2str(mol_tot)]);
            c = colorbar ('northoutside');
            set(get(c,'title'),'string','Number of Transitions');
            prop.b2.FontWeight = 'bold';

