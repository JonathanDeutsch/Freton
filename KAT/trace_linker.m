function varargout = trace_linker(varargin)
% TRACE_LINKER MATLAB code for trace_linker.fig
%      TRACE_LINKER, by itself, creates a new TRACE_LINKER or raises the existing
%      singleton*.
%
%      H = TRACE_LINKER returns the handle to a new TRACE_LINKER or the handle to
%      the existing singleton*.
%
%      TRACE_LINKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRACE_LINKER.M with the given input arguments.
%
%      TRACE_LINKER('Property','Value',...) creates a new TRACE_LINKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before trace_linker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to trace_linker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help trace_linker

% Last Modified by GUIDE v2.5 10-May-2022 20:33:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @trace_linker_OpeningFcn, ...
                   'gui_OutputFcn',  @trace_linker_OutputFcn, ...
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


% --- Executes just before trace_linker is made visible.
function trace_linker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to trace_linker (see VARARGIN)
%  [~, num_traces] = size(trace_fret_out);
%         set(handles.raw_trace_total,'String', num2str(num_traces));
%         num_list_trace = num2str ((1:num_traces)');
%         set(handles.list_traces, 'String', num_list_trace);

%setappdata(handles.load_traces, 'file_name', file_name);
  
%folder_files=uigetdir();
%[pathstr, sample_name]= fileparts(folder_files);
%path_data = genpath(pathstr);
%addpath(path_data);
%files = 'trace_to_link.mat';

% files = size(trace_fret_out,1);

load('trace_to_link.mat')
tot_traces = size(trace_fret_out,2);
% files = trace_fret_out;
all_traces = num2str((1:tot_traces)');
setappdata(handles.list_traces,'all_traces',all_traces);
set(handles.disp_tot_traces, 'String', num2str(tot_traces));
set(handles.list_traces, 'String', all_traces);
%setappdata(handles.start_linker, 'files', files);
trace_sel_fret = [];
setappdata(handles.sel_accept, 'trace_sel_fret',trace_sel_fret)
sel_num = 0;
setappdata(handles.cont_link, 'sel_num', sel_num)

% Choose default command line output for trace_linker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes trace_linker wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = trace_linker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in start_linker.
function start_linker_Callback(hObject, eventdata, handles)
% hObject    handle to start_linker (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% [fname, ~] = uigetfile();    
% [path_trace,file_name] = fileparts(fname);
% addpath(path_trace);
% setappdata(handles.load_traces, 'path_trace', path_trace);
% load('trace_to_link.mat')
% %setappdata(handles.load_traces, 'file_name', file_name);
%   
% %folder_files=uigetdir();
% %[pathstr, sample_name]= fileparts(folder_files);
% %path_data = genpath(pathstr);
% %addpath(path_data);
% %files = dir([folder_files,'\*.mat']);
% files = V_tosave;
% tot_traces = numel(files);
% all_traces = num2str((1:tot_traces)');
% set(handles.disp_tot_traces, 'String', num2str(tot_traces));
% set(handles.list_traces, 'String', all_traces);
% %setappdata(handles.start_linker, 'files', files);
% trace_sel_fret = [];
% setappdata(handles.sel_accept, 'trace_sel_fret',trace_sel_fret)
% sel_num = 0;
% setappdata(handles.cont_link, 'sel_num', sel_num)

function disp_cur_trace_Callback(hObject, eventdata, handles)
% hObject    handle to disp_cur_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_cur_trace as text
%        str2double(get(hObject,'String')) returns contents of disp_cur_trace as a double

% --- Executes during object creation, after setting all properties.
function disp_cur_trace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_cur_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function disp_tot_sel_traces_Callback(hObject, eventdata, handles)
% hObject    handle to disp_tot_sel_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_tot_sel_traces as text
%        str2double(get(hObject,'String')) returns contents of disp_tot_sel_traces as a double

% --- Executes during object creation, after setting all properties.
function disp_tot_sel_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_tot_sel_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in sel_blch.
function sel_blch_Callback(hObject, eventdata, handles)
% hObject    handle to sel_blch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    load('trace_to_link.mat')
    auto_run = get(handles.radiobutton3,'Value');
    curr_trace1 = str2num((get(handles.disp_sel_trace, 'String')));
    % files = getappdata(handles.start_linker, 'files');
    trace_fret_out = rmmissing(trace_fret_out(:,curr_trace1));
    %trace_fret_out = trace_fret_out';
    trace_time_out = trace_time_out(1:length(trace_fret_out))';
%     trace_blch = find(trace_fret_out>0.1);
%     trace_fret_out_t = trace_fret_out(1:trace_blch(end));
%     trace_time_out_t = trace_time_out(1:trace_blch(end));
    trace_fret_out_t = trace_fret_out;
    trace_time_out_t = trace_time_out;
    axes(handles.axes2)
    plot(trace_time_out_t, trace_fret_out_t);
    setappdata(handles.sel_accept,'trace_fret_out_t',trace_fret_out_t);
    setappdata(handles.sel_accept,'trace_time_out_t',trace_time_out_t);  
    
    if auto_run == 1
        sel_accept_Callback(hObject, eventdata, handles)
    end


% --- Executes on button press in sel_man.
function sel_man_Callback(hObject, eventdata, handles)
% hObject    handle to sel_man (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('trace_to_link.mat')
curr_trace1 = str2num((get(handles.disp_sel_trace, 'String')));
% files = getappdata(handles.start_linker, 'files');
% load (files(curr_trace1).name);
trace_fret_out = rmmissing(trace_fret_out(:,curr_trace1));
trace_time_out = trace_time_out(1:length(trace_fret_out))';
    trace_man = ginput(2);
    trace_man = trace_man(:,1)';
    trace_man1_t = find(trace_time_out<trace_man(:,1));
    trace_man1 = trace_man1_t(end);
    if trace_man1 == 0
        trace_man1 = trace_time_out(2);
    end
    trace_man2_t = find(trace_time_out>trace_man(:,2));
    trace_man2 = trace_man2_t(1);    
    trace_fret_out_t = trace_fret_out(trace_man1:trace_man2);
    trace_time_out_t = trace_time_out(trace_man1:trace_man2);    
axes(handles.axes2)
plot(trace_time_out_t, trace_fret_out_t);
setappdata(handles.sel_accept,'trace_fret_out_t',trace_fret_out_t);
setappdata(handles.sel_accept,'trace_time_out_t',trace_time_out_t);

% --- Executes on button press in sel_undo.
function sel_undo_Callback(hObject, eventdata, handles)
% hObject    handle to sel_undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('trace_to_link.mat')
curr_trace1 = str2num((get(handles.disp_sel_trace, 'String')));
trace_fret_out = rmmissing(trace_fret_out(:,curr_trace1));
trace_time_out = trace_time_out';
trace_fret_out_t = trace_fret_out';
trace_time_out_t = trace_time_out';
axes(handles.axes2)
plot(trace_time_out_t, trace_fret_out_t);
setappdata(handles.sel_accept,'trace_fret_out_t',trace_fret_out_t);
setappdata(handles.sel_accept,'trace_time_out_t',trace_time_out_t);

% --- Executes on button press in sel_accept.
function sel_accept_Callback(hObject, eventdata, handles)
% hObject    handle to sel_accept (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('trace_to_link.mat')
trace_fret_out_t = getappdata(handles.sel_accept,'trace_fret_out_t');
trace_sel_fret_t = getappdata(handles.sel_accept, 'trace_sel_fret');
setappdata(handles.cont_link, 'trace_sel_t',trace_sel_fret_t);
sel_num = getappdata(handles.cont_link, 'sel_num');
    if size (trace_sel_fret_t) == 0
        trace_sel_fret = trace_fret_out_t;
        setappdata(handles.sel_accept, 'trace_sel_fret', trace_sel_fret);
        axes(handles.axes3)
        plot(trace_sel_fret, 'b') 
        sel_num = sel_num + 1;
        setappdata(handles.cont_link, 'sel_num',sel_num)
    elseif size (trace_sel_fret_t) >= 1
    trace_sel_fret = vertcat(trace_sel_fret_t, trace_fret_out_t);
    setappdata(handles.sel_accept, 'trace_sel_fret', trace_sel_fret);
    setappdata(handles.cont_link, 'trace_sel',trace_sel_fret);
    sel_num = sel_num + 1;
    setappdata(handles.cont_link, 'sel_num',sel_num)
    axes(handles.axes3)
    x1 = 1:numel(trace_sel_fret_t);
    x2 = 1:numel(trace_sel_fret);
    plot(x2,trace_sel_fret, 'r',x1, trace_sel_fret_t,'b')
    end
    auto_run = get(handles.radiobutton3,'Value');
    if auto_run == 1
    cont_link_Callback(hObject, eventdata, handles)
    end

% --- Executes on button press in cur_sel.
function cur_sel_Callback(hObject, eventdata, handles)
% hObject    handle to cur_sel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('trace_to_link.mat')
auto_run = get(handles.radiobutton3,'Value');
    curr_trace = getappdata(handles.list_traces, 'curr_trace');
    set(handles.disp_sel_trace, 'String', num2str(curr_trace));
    files = getappdata(handles.start_linker, 'files');
%load (files(index_sel_t).name);
    trace_fret_out = rmmissing(trace_fret_out(:,curr_trace))';
    trace_time_out = trace_time_out(1:length(trace_fret_out))';
% load (files(curr_trace).name);
% trace_fret_out = trace_fret_out';
% trace_time_out = trace_time_out';
    axes(handles.axes2)
    plot(trace_time_out, trace_fret_out);  
    if auto_run == 1  
        sel_blch_Callback(hObject, eventdata, handles)    
    end


% --- Executes on selection change in list_traces.
function list_traces_Callback(hObject, eventdata, handles)
% hObject    handle to list_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns list_traces contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_traces
load('trace_to_link.mat')
% if auto_run == 1
%     all_traces = getappdata(handles.list_traces,'all_traces');
%     num_traces = length(all_traces);
%     for i = 1:num_traces
%         index_sel_t = i;
%         curr_trace = index_sel_t;
%         setappdata(handles.list_traces, 'curr_trace', curr_trace);
%         set(handles.disp_cur_trace, 'String', num2str(index_sel_t));
%         files = getappdata(handles.start_linker, 'files');
%         %load (files(index_sel_t).name);
%         trace_fret_out = rmmissing(trace_fret_out(:,index_sel_t))';
%         trace_time_out = trace_time_out(1:length(trace_fret_out))';
%         axes(handles.axes1)
%         plot(trace_time_out, trace_fret_out);      
%     end
% else    
index_sel_t = get(handles.list_traces,'Value');
curr_trace = index_sel_t;
setappdata(handles.list_traces, 'curr_trace', curr_trace);
set(handles.disp_cur_trace, 'String', num2str(index_sel_t));
files = getappdata(handles.start_linker, 'files');
%load (files(index_sel_t).name);
trace_fret_out = rmmissing(trace_fret_out(:,index_sel_t))';
trace_time_out = trace_time_out(1:length(trace_fret_out))';
axes(handles.axes1)
plot(trace_time_out, trace_fret_out);



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


function disp_tot_traces_Callback(hObject, eventdata, handles)
% hObject    handle to disp_tot_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_tot_traces as text
%        str2double(get(hObject,'String')) returns contents of disp_tot_traces as a double


% --- Executes during object creation, after setting all properties.
function disp_tot_traces_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_tot_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function disp_sel_trace_Callback(hObject, eventdata, handles)
% hObject    handle to disp_sel_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_sel_trace as text
%        str2double(get(hObject,'String')) returns contents of disp_sel_trace as a double
val_sel = get(handles.disp_sel_trace, 'Value');
setappdata(handles.disp_sel_trace, 'val_sel', val_sel);


% --- Executes during object creation, after setting all properties.
function disp_sel_trace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_sel_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in revert_link.
function revert_link_Callback(hObject, eventdata, handles)
% hObject    handle to revert_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rev_trace = getappdata(handles.cont_link, 'trace_sel_t');
setappdata(handles.sel_accept, 'trace_sel_fret', rev_trace);
setappdata(handles.cont_link, 'trace_sel',rev_trace);
axes(handles.axes3)
x1 = 1:numel(rev_trace);
plot(x1,rev_trace, 'b')
axes(handles.axes4)
plot(x1,rev_trace,'k')
sel_num = getappdata(handles.cont_link, 'sel_num');
sel_num = sel_num - 1;
setappdata(handles.cont_link, 'sel_num',sel_num)
set(handles.disp_tot_sel_traces, 'String', num2str(sel_num));


% --- Executes on button press in cont_link.
function cont_link_Callback(hObject, eventdata, handles)
% hObject    handle to cont_link (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
auto_run = get(handles.radiobutton3,'Value');
cont_trace = getappdata(handles.sel_accept, 'trace_sel_fret');
sel_num = getappdata(handles.cont_link, 'sel_num');
set(handles.disp_tot_sel_traces, 'String', num2str(sel_num));
axes(handles.axes3)
x1 = 1:numel(cont_trace);
plot(x1, cont_trace,'b');
axes(handles.axes4)
plot(x1, cont_trace,'k');

if auto_run == 1  
   
end

% --- Executes on button press in export_sel_traces.
function export_sel_traces_Callback(hObject, eventdata, handles)
% hObject    handle to export_sel_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel_final_traces = getappdata(handles.cont_link, 'trace_sel');
temp_save = struct('raw_data',sel_final_traces);
[file_ex, path_ex] = uiputfile('*.mat');
save([file_ex],'temp_save');


% --- Executes on button press in auto_run.
function auto_run_Callback(hObject, eventdata, handles)
% hObject    handle to auto_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('trace_to_link.mat');
axes(handles.axes4)
plot(fret_all)


% --- Executes on button press in run_all.
function run_all_Callback(hObject, eventdata, handles)
% hObject    handle to run_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of run_all


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
