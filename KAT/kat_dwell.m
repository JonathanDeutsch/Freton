function varargout = kat_dwell(varargin)
% KAT_DWELL MATLAB code for kat_dwell.fig
%      KAT_DWELL, by itself, creates a new KAT_DWELL or raises the existing
%      singleton*.
%
%      H = KAT_DWELL returns the handle to a new KAT_DWELL or the handle to
%      the existing singleton*.
%
%      KAT_DWELL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_DWELL.M with the given input arguments.
%
%      KAT_DWELL('Property','Value',...) creates a new KAT_DWELL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_dwell_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_dwell_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_dwell

% Last Modified by GUIDE v2.5 16-Dec-2021 12:12:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_dwell_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_dwell_OutputFcn, ...
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


% --- Executes just before kat_dwell is made visible.
function kat_dwell_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_dwell (see VARARGIN)

% Choose default command line output for kat_dwell
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_dwell wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_dwell_OutputFcn(hObject, eventdata, handles) 
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
num_bins = str2num(get(handles.num_bins,'String'));
[fname, path_trace] = uigetfile(); 
[~,file_name] = fileparts(fname);
load(file_name)
addpath(path_trace);
set(handles.disp_filename, 'String',file_name);
setappdata(handles.load_file, 'path_trace', path_trace);
setappdata(handles.load_file, 'file_name', file_name);
eb_traces = traces;
size(eb_traces);
% 6 colummns
% trace #, donor, acceptor, mean FRET, Viterbi State, Viterbi Mean
num_traces = max(eb_traces(:,1));
list_traces = (1:num_traces)';
num_states = max(eb_traces(:,5));
set(handles.disp_num_traces,'String',num2str(num_traces));
set(handles.disp_num_states,'String',num2str(num_states));
set(handles.listbox1,'String',num2str(list_traces));
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

for i = 1:num_traces
    eb_sel_trace_ind = find(eb_traces(:,1) == i);
    eb_sel_trace = eb_traces(eb_sel_trace_ind,5);
    [state_1, state_2, state_3, state_4, state_5, state_6] = trace_dwells(eb_sel_trace,num_states);
    switch num_states
        case{2}
            state_1_t = state_1.*time_int;
            state_2_t = state_2.*time_int;
            eb_state_1 = vertcat(eb_state_1,state_1_t);
            eb_state_2 = vertcat(eb_state_2,state_2_t);
            setappdata(handles.load_file,'eb_state_1',eb_state_1)
            setappdata(handles.load_file,'eb_state_2',eb_state_2)
        case{3}
            state_1_t = state_1.*time_int;
            state_2_t = state_2.*time_int;
            state_3_t = state_3.*time_int;
            eb_state_1 = vertcat(eb_state_1,state_1_t);
            eb_state_2 = vertcat(eb_state_2,state_2_t);
            eb_state_3 = vertcat(eb_state_3,state_3_t);
            setappdata(handles.load_file,'eb_state_1',eb_state_1)
            setappdata(handles.load_file,'eb_state_2',eb_state_2)
            setappdata(handles.load_file,'eb_state_3',eb_state_3)
    end
end

% total occurences
switch num_states
    case{2}
        tot_occurs = vertcat(eb_state_1, eb_state_2);
        [tot_occurs,~] = size(tot_occurs);
        set(handles.disp_tot_occur,'String',num2str(tot_occurs));
        [state_1_occur,~] = size(eb_state_1);
        [state_2_occur,~] = size(eb_state_2);
        set(handles.disp_occur1,'String',num2str(state_1_occur));
        set(handles.disp_occur2,'String',num2str(state_2_occur));  
    case{3}
        tot_occurs = vertcat(eb_state_1, eb_state_2, eb_state_3);
        [tot_occurs,~] = size(tot_occurs);
        set(handles.disp_tot_occur,'String',num2str(tot_occurs));
        [state_1_occur,~] = size(eb_state_1);
        [state_2_occur,~] = size(eb_state_2);
        [state_3_occur,~] = size(eb_state_3);
        set(handles.disp_occur1,'String',num2str(state_1_occur));
        set(handles.disp_occur2,'String',num2str(state_2_occur));  
        set(handles.disp_occur3,'String',num2str(state_3_occur));          
end

axes(handles.axes1)
histfit(eb_state_1,num_bins,'exponential');
fit1 = fitdist(eb_state_1,'exponential');
ylabel('Occurences')
xlabel('Dwell time')
set(handles.disp_kin1,'String',num2str(fit1.mu));
axes(handles.axes2)
histfit(eb_state_2,num_bins,'exponential');
fit2 = fitdist(eb_state_2,'exponential');
ylabel('Occurences')
xlabel('Dwelll time')
set(handles.disp_kin2,'String',num2str(fit2.mu));
all_state_1_ind = find(eb_traces(:,5) == 1);
all_state_1 = eb_traces(all_state_1_ind,6);
all_state_2_ind = find(eb_traces(:,5) == 2); 
all_state_2 = eb_traces(all_state_2_ind,6);
axes(handles.axes8)
histogram(all_state_1,[0:0.1:1]);
hold on 
histogram(all_state_2,[0:0.1:1]);
hold off
xlabel('Idealised FRET','FontWeight','bold')
legend('State 1', 'State 2');
switch num_states
case{3}
axes(handles.axes3)
histfit(eb_state_3,num_bins,'exponential');
fit3 = fitdist(eb_state_3,'exponential');
ylabel('Occurences')
xlabel('Dwelll time')
set(handles.disp_kin3,'String',num2str(fit3.mu));
all_state_3_ind = find(eb_traces(:,5) == 3); 
all_state_3 = eb_traces(all_state_3_ind,6);
axes(handles.axes8)
histogram(all_state_1,[0:0.1:1]);
hold on 
histogram(all_state_2,[0:0.1:1]);
histogram(all_state_3,[0:0.1:1]);
hold off 
end


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


% --- Executes on button press in reprocess.
function reprocess_Callback(hObject, eventdata, handles)
% hObject    handle to reprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
trace_sel_ind = get(handles.listbox1,'Value');
eb_traces = getappdata(handles.load_file,'eb_traces');
num_states = getappdata(handles.load_file, 'num_states');
num_traces = getappdata(handles.load_file, 'num_traces');
num_bins = str2num(get(handles.num_bins,'String'));
time_int = str2num(get(handles.int_time,'String'));
eb_sel_trace_ind = find(eb_traces(:,1) == trace_sel_ind);
eb_sel_trace = eb_traces(eb_sel_trace_ind,5);
[state_1, state_2, state_3, state_4, state_5, state_6] = trace_dwells(eb_sel_trace,num_states);
% Correct dwell time
state_1 = state_1.*time_int;
state_2 = state_2.*time_int;
state_3 = state_3.*time_int;
state_4 = state_4.*time_int;
state_5 = state_5.*time_int;
state_6 = state_6.*time_int;
time_axis = (1:length(eb_sel_trace_ind)).*time_int;
donor = eb_traces(eb_sel_trace_ind,2);
acceptor = eb_traces(eb_sel_trace_ind,3);
fret_raw = eb_traces(eb_sel_trace_ind,4);
fret_id = eb_traces(eb_sel_trace_ind,6);
axes(handles.axes4)
plot(time_axis, donor,'g', time_axis, acceptor,'r')
axes(handles.axes5)
plot(time_axis, fret_raw,'-b',time_axis,fret_id,'k')
ylim([-0.05 1.05])
ylabel('FRET','FontWeight','bold')
yticks([0:0.2:1])
grid on
axes(handles.axes6)
histogram(state_1,10)
hold on 
histogram(state_2,10)
hold off
legend('State1','State2');
xlabel('Dwell Time','FontWeight','bold')
axes(handles.axes7)
histogram(fret_raw,num_bins);
xlabel('FRET','FontWeight','bold')

fret_states = unique(fret_id);
fret_states = fret_states';
switch num_states
    case{2}
        set(handles.disp_fret_states,'String',num2str(fret_states));
    case{3}
        set(handles.disp_fret_states,'String',num2str(fret_states));
end




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


% --- Executes on button press in export_1.
function export_1_Callback(hObject, eventdata, handles)
% hObject    handle to export_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eb_state_1 = getappdata(handles.load_file,'eb_state_1');
save('dwell_state_1.mat', 'eb_state_1');


% --- Executes on button press in export_2.
function export_2_Callback(hObject, eventdata, handles)
% hObject    handle to export_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eb_state_2 = getappdata(handles.load_file,'eb_state_2');
save('dwell_state_2.mat', 'eb_state_2');


% --- Executes on button press in export_3.
function export_3_Callback(hObject, eventdata, handles)
% hObject    handle to export_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eb_state_3 = getappdata(handles.load_file,'eb_state_3');
save('dwell_state_3.mat', 'eb_state_3');



function num_bins_Callback(hObject, eventdata, handles)
% hObject    handle to num_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_bins as text
%        str2double(get(hObject,'String')) returns contents of num_bins as a double


% --- Executes during object creation, after setting all properties.
function num_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_fret_states_Callback(hObject, eventdata, handles)
% hObject    handle to disp_fret_states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_fret_states as text
%        str2double(get(hObject,'String')) returns contents of disp_fret_states as a double


% --- Executes during object creation, after setting all properties.
function disp_fret_states_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_fret_states (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trans_trace_Callback(hObject, eventdata, handles)
% hObject    handle to trans_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans_trace as text
%        str2double(get(hObject,'String')) returns contents of trans_trace as a double


% --- Executes during object creation, after setting all properties.
function trans_trace_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trans_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_kin1_Callback(hObject, eventdata, handles)
% hObject    handle to disp_kin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_kin1 as text
%        str2double(get(hObject,'String')) returns contents of disp_kin1 as a double


% --- Executes during object creation, after setting all properties.
function disp_kin1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_kin1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_kin2_Callback(hObject, eventdata, handles)
% hObject    handle to disp_kin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_kin2 as text
%        str2double(get(hObject,'String')) returns contents of disp_kin2 as a double


% --- Executes during object creation, after setting all properties.
function disp_kin2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_kin2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_kin3_Callback(hObject, eventdata, handles)
% hObject    handle to disp_kin3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_kin3 as text
%        str2double(get(hObject,'String')) returns contents of disp_kin3 as a double


% --- Executes during object creation, after setting all properties.
function disp_kin3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_kin3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_trace.
function exp_trace_Callback(hObject, eventdata, handles)
% hObject    handle to exp_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig1 = figure(10);
set(fig1,'units','normalized','position', [0.1, 0.2, 0.9, 0.4])
ax1=subplot(2,1,1);
ax1(1).LineWidth = 2;
a1 = handles.axes4;
ylabel('Donor/Acceptor')
grid on
ylim([0,inf]);
xlim([0, inf])
copyobj(allchild(a1),ax1);

ax2=subplot(2,1,2);
ax2(1).LineWidth = 2;
a4 = handles.axes5;
ylabel('FRET')
grid on
ylim([-0.05,1.1]);
xlim([0, inf])
yticks(0:0.2:1);
grid on
copyobj(allchild(a4),ax2);



function disp_tot_occur_Callback(hObject, eventdata, handles)
% hObject    handle to disp_tot_occur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_tot_occur as text
%        str2double(get(hObject,'String')) returns contents of disp_tot_occur as a double


% --- Executes during object creation, after setting all properties.
function disp_tot_occur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_tot_occur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_occur1_Callback(hObject, eventdata, handles)
% hObject    handle to disp_occur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_occur1 as text
%        str2double(get(hObject,'String')) returns contents of disp_occur1 as a double


% --- Executes during object creation, after setting all properties.
function disp_occur1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_occur1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_occur2_Callback(hObject, eventdata, handles)
% hObject    handle to disp_occur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_occur2 as text
%        str2double(get(hObject,'String')) returns contents of disp_occur2 as a double


% --- Executes during object creation, after setting all properties.
function disp_occur2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_occur2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_occur3_Callback(hObject, eventdata, handles)
% hObject    handle to disp_occur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_occur3 as text
%        str2double(get(hObject,'String')) returns contents of disp_occur3 as a double


% --- Executes during object creation, after setting all properties.
function disp_occur3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_occur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
