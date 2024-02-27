function varargout = kit_kat_launch(varargin)
% KIT_KAT_LAUNCH MATLAB code for kit_kat_launch.fig
%      KIT_KAT_LAUNCH, by itself, creates a new KIT_KAT_LAUNCH or raises the existing
%      singleton*.
%
%      H = KIT_KAT_LAUNCH returns the handle to a new KIT_KAT_LAUNCH or the handle to
%      the existing singleton*.
%
%      KIT_KAT_LAUNCH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KIT_KAT_LAUNCH.M with the given input arguments.
%
%      KIT_KAT_LAUNCH('Property','Value',...) creates a new KIT_KAT_LAUNCH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kit_kat_launch_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kit_kat_launch_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kit_kat_launch

% Last Modified by GUIDE v2.5 09-Jun-2022 14:33:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kit_kat_launch_OpeningFcn, ...
                   'gui_OutputFcn',  @kit_kat_launch_OutputFcn, ...
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


% --- Executes just before kit_kat_launch is made visible.
function kit_kat_launch_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kit_kat_launch (see VARARGIN)

% Choose default command line output for kit_kat_launch
handles.output = hObject;
current_directory = pwd;
if ispc == 1
addpath([pwd,'\KIT']);
addpath([pwd,'\KAT']);
addpath([pwd,'\CONV']);
addpath([pwd,'\Variables']);
elseif ismac == 1
addpath([pwd,'/KIT']);
addpath([pwd,'/KAT']);  
addpath([pwd,'/CONV']);
addpath([pwd,'/Variables']);
end

axes(handles.axes1)
matlabImage = imread('stanford_logo.png');
imshow(matlabImage)
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kit_kat_launch wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kit_kat_launch_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in launch_kit.
function launch_kit_Callback(hObject, eventdata, handles)
% hObject    handle to launch_kit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run frame_merger


% --- Executes on button press in launch_kat.
function launch_kat_Callback(hObject, eventdata, handles)
% hObject    handle to launch_kat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run KAT_2


% --- Executes on button press in set_work_dirc.
function set_work_dirc_Callback(hObject, eventdata, handles)
% hObject    handle to set_work_dirc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global working_directory
working_directory = uigetdir;
addpath(working_directory);
set(handles.work_dirc,'String',working_directory);


function work_dirc_Callback(hObject, eventdata, handles)
% hObject    handle to work_dirc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of work_dirc as text
%        str2double(get(hObject,'String')) returns contents of work_dirc as a double


% --- Executes during object creation, after setting all properties.
function work_dirc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to work_dirc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in launch_single.
function launch_single_Callback(hObject, eventdata, handles)
% hObject    handle to launch_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_histos_single


% --- Executes on button press in launch_fret.
function launch_fret_Callback(hObject, eventdata, handles)
% hObject    handle to launch_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_histos

% --- Executes on button press in launch_gmm.
function launch_gmm_Callback(hObject, eventdata, handles)
% hObject    handle to launch_gmm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_GMM


% --- Executes on button press in launch_overlays.
function launch_overlays_Callback(hObject, eventdata, handles)
% hObject    handle to launch_overlays (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_dwell


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in chk_compat.
function chk_compat_Callback(hObject, eventdata, handles)
% hObject    handle to chk_compat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filtered_data = 0;
[fname, ~] = uigetfile(); 
[path_trace,file_name] = fileparts(fname);
addpath(path_trace);
load(file_name)
list_data = who;
set(handles.name_file_disp,'String',file_name);

if filtered_data == 1
    set(handles.pre_chk_disp,'String','Filtered KAT2 data')
    if strcmp(Mode1,'onecolor')
    set(handles.post_chk_disp, 'String','Single/Dye Analysis');
    elseif strcmp(Mode1,'Multicolor')
    set(handles.post_chk_disp, 'String','FRET Analysis');
    end

elseif sum(strcmp('file_sel_hist',list_data))>=1
    set(handles.pre_chk_disp,'String','Histogram Values')
    set(handles.post_chk_disp,'String','Process Via GMM');
else
    set(handles.pre_chk_disp,'String','Data Not Processed')
    set(handles.post_chk_disp,'String','Process Via Kat2');
end

function pre_chk_disp_Callback(hObject, eventdata, handles)
% hObject    handle to pre_chk_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pre_chk_disp as text
%        str2double(get(hObject,'String')) returns contents of pre_chk_disp as a double


% --- Executes during object creation, after setting all properties.
function pre_chk_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pre_chk_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function post_chk_disp_Callback(hObject, eventdata, handles)
% hObject    handle to post_chk_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of post_chk_disp as text
%        str2double(get(hObject,'String')) returns contents of post_chk_disp as a double


% --- Executes during object creation, after setting all properties.
function post_chk_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to post_chk_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function name_file_disp_Callback(hObject, eventdata, handles)
% hObject    handle to name_file_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of name_file_disp as text
%        str2double(get(hObject,'String')) returns contents of name_file_disp as a double


% --- Executes during object creation, after setting all properties.
function name_file_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to name_file_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in info_bttn.
function info_bttn_Callback(hObject, eventdata, handles)
% hObject    handle to info_bttn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','Provides Information about Settings and Parameters'},...
        'KIT/KAT: Help');


% --- Executes on button press in launch_help.
function launch_help_Callback(hObject, eventdata, handles)
% hObject    handle to launch_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','This helps you understand parameters and settings'},...
        'KIT?KAT: Help');


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in launch_trimmer.
function launch_trimmer_Callback(hObject, eventdata, handles)
% hObject    handle to launch_trimmer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kit_img_trimmer


% --- Executes on button press in trace_converter.
function trace_converter_Callback(hObject, eventdata, handles)
% hObject    handle to trace_converter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run trace_conv.m

% --- Executes on button press in file_output.
function file_output_Callback(hObject, eventdata, handles)
% hObject    handle to file_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Folder reader
if ispc == 1
    seps = '\';
else
    seps = '/';
end
        folder = uigetdir();
        types_t = get(handles.uibuttongroup1, 'SelectedObject');
        types_file = get(types_t, 'String');
        switch types_file
            case{'TIF'}
        fileList = dir(fullfile(folder, '*.TIF'));
            case {'All'}
        fileList = dir(fullfile(folder));        
        end
        counter_processing = 0;
        num_files = length(fileList);
        disp(folder)
        disp(['Total Files = ','  ',num2str(num_files)])
        for     k = 1:num_files
                counter_processing = counter_processing +1;
%                 disp(['Processing File number  ', num2str(counter_processing)]);
                file_name_t = fileList(k).name;
                disp(file_name_t)
                path_img_t = fileList(k).folder;
                fname = [path_img_t,seps,file_name_t];
                [path_img,file_name] = fileparts(fname); 
        end
