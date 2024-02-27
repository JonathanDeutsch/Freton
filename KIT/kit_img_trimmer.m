function varargout = kit_img_trimmer(varargin)
% KIT_IMG_TRIMMER MATLAB code for kit_img_trimmer.fig
%      KIT_IMG_TRIMMER, by itself, creates a new KIT_IMG_TRIMMER or raises the existing
%      singleton*.
%
%      H = KIT_IMG_TRIMMER returns the handle to a new KIT_IMG_TRIMMER or the handle to
%      the existing singleton*.
%
%      KIT_IMG_TRIMMER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KIT_IMG_TRIMMER.M with the given input arguments.
%
%      KIT_IMG_TRIMMER('Property','Value',...) creates a new KIT_IMG_TRIMMER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kit_img_trimmer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kit_img_trimmer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kit_img_trimmer

% Last Modified by GUIDE v2.5 07-Mar-2020 12:18:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kit_img_trimmer_OpeningFcn, ...
                   'gui_OutputFcn',  @kit_img_trimmer_OutputFcn, ...
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


% --- Executes just before kit_img_trimmer is made visible.
function kit_img_trimmer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kit_img_trimmer (see VARARGIN)

% Choose default command line output for kit_img_trimmer
handles.output = hObject;
set(handles.mov_window,'String', num2str(5));
set(handles.var_trim,'String',num2str(100));
set(handles.trim_length,'String',num2str(500));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kit_img_trimmer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kit_img_trimmer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_preprocess.
function listbox_preprocess_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_preprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_preprocess contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_preprocess


% --- Executes during object creation, after setting all properties.
function listbox_preprocess_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_preprocess (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function total_frames_Callback(hObject, eventdata, handles)
% hObject    handle to total_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of total_frames as text
%        str2double(get(hObject,'String')) returns contents of total_frames as a double


% --- Executes during object creation, after setting all properties.
function total_frames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to total_frames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_folder.
function load_folder_Callback(hObject, eventdata, handles)
% hObject    handle to load_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ispc == 1
    seps = '\';
else
    seps = '/';
end
trim_length = str2num(get(handles.trim_length,'String'));

        colors_num_t = get(handles.folder_type,'SelectedObject');
        colors_num = get(colors_num_t,'String');
        switch colors_num 
            case ('Single Color')
                extraction_state = 1;
            case ('Dual Color')
                extraction_state = 2;           
        end
        
        set(handles.auto_run,'Value',1);
        set(handles.auto_write,'Value',1);
        
        
        if extraction_state == 1
        folder = uigetdir();
        fileList = dir(fullfile(folder, '*.TIF'));
        num_files = length(fileList);
        set(handles.listbox_preprocess, 'String', 1:num_files);
        disp(['Total Files = ','  ',num2str(num_files)])
        file_name_all = [];
        counter = 0;
            for     k = 1:1:num_files
                counter = counter + 1;
                disp(['Processing File number  ', num2str(counter)])
                set(handles.listbox2,'String',1:counter);
                file_name_t = fileList(k).name;
                path_img_t = fileList(k).folder;
                fname = [path_img_t,seps,file_name_t];
                [path_img,file_name] = fileparts(fname);
                setappdata(handles.load_folder,'fname',fname);
                setappdata(handles.load_folder,'path_img',path_img);
                setappdata(handles.load_folder,'file_name',file_name);
                pks_d_t =load_file_Callback(handles.load_file, eventdata, handles);
                pks_d(counter) = pks_d_t;
                set(handles.listbox3,'String',pks_d);
                % write file
                counter_write = 0;
                h = waitbar(0,'Writing trimmed image...');
                end_frame = pks_d_t + trim_length;
                for i = pks_d_t+1:end_frame
                        counter_write = counter_write + 1;
                        waitbar((counter_write/trim_length),h)
                        D = imread([file_name,'.tif'],i);
                        imwrite(D,[file_name,'_t','.tif'],'WriteMode','append');  
                end  
                close(h)
            end
            
            
        elseif extraction_state == 2
            folder = uigetdir();
        fileList = dir(fullfile(folder, '*.TIF'));
        counter_processing = 0;
        num_files = length(fileList);
        disp(['Total Files = ','  ',num2str(num_files/2)])
        num_files_disp = 1:num_files/2;
        set(handles.listbox_preprocess, 'String', num_files_disp);
        counter = 0;
            for     k = 1:2:num_files
                counter = counter + 1;
                set(handles.listbox2,'String',1:counter);
                disp(['Processing File number  ', num2str(counter)])
                file_name_t = fileList(k).name;
                path_img_t = fileList(k).folder;
                fname = [path_img_t,seps,file_name_t];
                [path_img,file_name] = fileparts(fname);
                setappdata(handles.load_folder,'fname',fname);
                setappdata(handles.load_folder,'path_img',path_img);
                setappdata(handles.load_folder,'file_name',file_name);
                pks_d_t = load_file_Callback(handles.load_file, eventdata, handles);
                % write file
                counter_write = 0;
                h = waitbar(0,'Writing trimmed image...');
                end_frame = pks_d_t + trim_length;
                for i = pks_d_t+1:end_frame
                        counter_write = counter_write + 1;
                        waitbar((counter_write/trim_length),h)
                        D = imread([file_name,'.tif'],i);
                        imwrite(D,[file_name,'_t','.tif'],'WriteMode','append');                            
                        A = imread([file_name,'b','.tif'],i);
                        imwrite(A,[file_name,'_tb','.tif'],'WriteMode','append');                            
                end
                close(h)
                pks_d(counter) = pks_d_t;
                set(handles.listbox3,'String',pks_d);                
            end
           axes(handles.axes3)
           histogram(pks_d)  
           close(h)
        end
       
        


% --- Executes on button press in load_file.
function [pks_d_t] = load_file_Callback(hObject, eventdata, handles)
% hObject    handle to load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
colors_num_t = get(handles.folder_type,'SelectedObject');
colors_num = get(colors_num_t,'String');
        switch colors_num 
            case ('Single Color')
                extraction_state = 1;
            case ('Dual Color')
                extraction_state = 2;           
        end        
setappdata(handles.eval_trim,'extraction_state',extraction_state);
img_op_mode_t = get(handles.op_mode, 'SelectedObject');
img_source = get(img_op_mode_t, 'String');   
auto_run = get(handles.auto_run,'Value');


switch img_source
    case char('Eval')  
        if auto_run == 0
            [fname, user_cancel] = imgetfile();
            [path_img,file_name] = fileparts(fname);
        elseif auto_run == 1
            fname = getappdata(handles.load_folder,'fname');
            path_img = getappdata(handles.load_folder,'path_img');
            file_name = getappdata(handles.load_folder,'file_name');
        end
set(handles.disp_loaded_name,'String',file_name);
addpath(path_img);
info = imfinfo(fname);
num_images = numel(info);
frames = 1:num_images;
set(handles.total_frames,'String',num2str(num_images));
f = msgbox('loading images');
            for k = 1:num_images  
                D = imread([file_name,'.tif'],k);
                sum_D(k) = sum(sum(D));
                if extraction_state == 2
                A = imread([file_name,'b','.tif'],k);
                sum_A(k) = sum(sum(A));
                end
            end                         
axes(handles.axes1)
plot(frames,sum_D);
if extraction_state == 2
    axes(handles.axes2)
    plot(frames,sum_A)
end
setappdata(handles.eval_trim,'d_trace',sum_D);
if extraction_state == 2
    setappdata(handles.eval_trim,'a_trace',sum_A);
end
pks_d_t = 0;
if auto_run == 1
    pks_d_t = eval_trim_Callback(handles.load_file, eventdata, handles);    
end

    case char('Trim')
        if auto_run == 0
            [fname, user_cancel] = imgetfile();
            [path_img,file_name] = fileparts(fname);
        elseif auto_run == 1
            fname = getappdata(handles.load_folder,'fname');
            path_img = getappdata(handles.load_folder,'path_img');
            file_name = getappdata(handles.load_folder,'file_name');
        end
set(handles.disp_loaded_name,'String',file_name);
addpath(path_img);
info = imfinfo(fname);
num_images = numel(info);
frames = 1:num_images;
set(handles.total_frames,'String',num2str(num_images));
            for k = 1:num_images  
                D = imread([file_name,'.tif'],k);
                sum_D(k) = sum(sum(D));
                if extraction_state == 2
                A = imread([file_name,'b','.tif'],k);
                sum_A(k) = sum(sum(A));
                end
            end                         
axes(handles.axes1)
plot(frames,sum_D);
if extraction_state == 2
    axes(handles.axes2)
    plot(frames,sum_A)
end
pks_d_t = 0;
end
close (f)


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


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



function trim_length_Callback(hObject, eventdata, handles)
% hObject    handle to trim_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trim_length as text
%        str2double(get(hObject,'String')) returns contents of trim_length as a double


% --- Executes during object creation, after setting all properties.
function trim_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trim_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in trim_data.
function trim_data_Callback(hObject, eventdata, handles)
% hObject    handle to trim_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function disp_loaded_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_loaded_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function var_trim_Callback(hObject, eventdata, handles)
% hObject    handle to var_trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of var_trim as text
%        str2double(get(hObject,'String')) returns contents of var_trim as a double


% --- Executes during object creation, after setting all properties.
function var_trim_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var_trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mov_window_Callback(hObject, eventdata, handles)
% hObject    handle to mov_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mov_window as text
%        str2double(get(hObject,'String')) returns contents of mov_window as a double


% --- Executes during object creation, after setting all properties.
function mov_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mov_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in eval_trim.
function [locs_d] = eval_trim_Callback(hObject, eventdata, handles)
% hObject    handle to eval_trim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
trim_length = str2num(get(handles.trim_length,'String'));
mov_window = str2num(get(handles.mov_window,'String'));
% cutoff = str2num(get(handles.var_trim,'String'));
extraction_state = getappdata(handles.eval_trim,'extraction_state');
% Calculate the start and end frames
d_trace = getappdata(handles.eval_trim,'d_trace');
d_trace_var = movvar(d_trace,mov_window);
[pks_d_t,~] = findpeaks(d_trace_var);
sel_pks_d = max(pks_d_t)/2;
[pks_d, locs_d] = findpeaks(d_trace_var, 'MinPeakHeight', sel_pks_d);
axes(handles.axes5)
findpeaks(d_trace_var, 'MinPeakHeight', sel_pks_d);
set(handles.start_frame,'String',num2str(locs_d));
set(handles.end_frame,'String',num2str(locs_d+trim_length));
locs_d = locs_d(1);
if extraction_state == 2
    a_trace = getappdata(handles.eval_trim,'a_trace');
    a_trace_var = movvar(a_trace,mov_window);
    [pks_a_t,~] = findpeaks(a_trace_var);
    sel_pks_a = max(pks_a_t)/2;
    [pks_a, locs_a] = findpeaks(a_trace_var, 'MinPeakHeight', sel_pks_a);
    axes(handles.axes6)
    findpeaks(a_trace_var, 'MinPeakHeight', sel_pks_a);      
end


function start_frame_Callback(hObject, eventdata, handles)
% hObject    handle to start_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of start_frame as text
%        str2double(get(hObject,'String')) returns contents of start_frame as a double


% --- Executes during object creation, after setting all properties.
function start_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to start_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function end_frame_Callback(hObject, eventdata, handles)
% hObject    handle to end_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of end_frame as text
%        str2double(get(hObject,'String')) returns contents of end_frame as a double


% --- Executes during object creation, after setting all properties.
function end_frame_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_frame (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in write_file.
function write_file_Callback(hObject, eventdata, handles)
% hObject    handle to write_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start_frame = str2num(get(handles.start_frame,'String'));
end_frame = str2num(get(handles.end_frame,'String'));
extraction_state = getappdata(handles.eval_trim,'extraction_state');

counter = 0;
frames_write = end_frame - start_frame;
h = waitbar(0,'Writing files...');
file_name = get(handles.disp_loaded_name,'String');
        for k = start_frame+1:end_frame
            counter = counter+1;
            waitbar((counter/frames_write),h)
            D = imread([file_name,'.tif'],k);
            imwrite(D,[file_name,'_t','.tif'],'WriteMode','append')
                if extraction_state == 2
                    A = imread([file_name,'b','.tif'],k);
                    imwrite(A,[file_name,'_tb','.tif'],'WriteMode','append');
                end
        end
        close(h)
        


% --- Executes on button press in new_analysis.
function new_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to new_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
clear
clear global
clc
kit_img_trimmer


% --- Executes on button press in auto_run.
function auto_run_Callback(hObject, eventdata, handles)
% hObject    handle to auto_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_run


% --- Executes on button press in auto_write.
function auto_write_Callback(hObject, eventdata, handles)
% hObject    handle to auto_write (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of auto_write
