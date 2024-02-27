function varargout = kat_gamma_adv(varargin)
% kat_gamma_adv MATLAB code for kat_gamma_adv.fig
%      kat_gamma_adv, by itself, creates a new KAT_GAMMA or raises the existing
%      singleton*.
%
%      H = KAT_GAMMA returns the handle to a new KAT_GAMMA or the handle to
%      the existing singleton*.
%
%      KAT_GAMMA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_GAMMA.M with the given input arguments.
%
%      KAT_GAMMA('Property','Value',...) creates a new KAT_GAMMA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_gamma_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_gamma_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_gamma

% Last Modified by GUIDE v2.5 04-Jun-2017 17:41:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_gamma_adv_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_gamma_adv_OutputFcn, ...
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


% --- Executes just before kat_gamma_adv is made visible.
function kat_gamma_adv_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_gamma (see VARARGIN)

% Choose default command line output for kat_gamma
handles.output = hObject;
global beta
global num_files
global all_gamma
global all_fret
beta = [];
num_files = 1;
set(handles.edit7, 'String', num2str(beta));
set(handles.edit8, 'String', num2str(num_files));
% Update handles structure
all_gamma = [];
all_fret = [];
guidata(hObject, handles);

% UIWAIT makes kat_gamma wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_gamma_adv_OutputFcn(hObject, eventdata, handles) 
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
global time_axis
global don_sel
global accep_sel
global gamma
global beta;
global pre_blch_x
global post_blch_x
global p_blch_yd
global p_blch_ya


don_tot_trace = getappdata(handles.load_traces, 'don_tot_trace');
don_bckg_trace = getappdata(handles.load_traces, 'don_bckg_trace');
accep_tot_trace = getappdata(handles.load_traces, 'accep_tot_trace');
accep_bckg_trace = getappdata(handles.load_traces, 'accep_bckg_trace');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
accep_spec_trace = getappdata(handles.load_traces, 'accep_spec_trace');
% Picture_d = getappdata(handles.load_traces, 'Picture_d');
% Picture_a = getappdata(handles.load_traces, 'Picture_a');

pre_blch_x = (ones(1,100).*time_axis(end));
p_blch_yd = [1:20:2000];
p_blch_ya = [1:20:2000];
post_blch_x = (ones(1,100).*time_axis(end));
don_sel = don_spec_trace(:,index1);  
accep_sel = accep_spec_trace(:,index1);

axes(handles.axes1);
plot(time_axis, don_sel,'g',pre_blch_x, p_blch_yd,'-g',post_blch_x,p_blch_yd,'-g');
ylabel('Donor')
ylim([0 +inf]);

axes(handles.axes2);
plot(time_axis, accep_sel,'r',pre_blch_x,p_blch_ya,'-r',post_blch_x, p_blch_ya,'-r');
ylabel ('Acceptor')
ylim([0 +inf]);
%% No Gamma correction
denom_fret = accep_sel + don_sel;
fret_calc_trace = accep_sel./denom_fret;

axes(handles.axes3);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET, No gamma')
ylim([0 1]);

cla(handles.axes4)

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



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
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
global index
global Complete_SET
global num_list_trace
Complete_SET_old = Complete_SET;
% num_sel_trace = length(Complete_SET);
% if index ~= Complete_SET(end)
    new_list = setdiff(Complete_SET_old,Complete_SET(index));
    new_list_size = size(new_list);
    new_val = new_list_size(1,1);
    set(handles.listbox1,'Value',new_val)
    set(handles.listbox1,'String',new_list)

    Complete_SET(index) = [];
    sel_trace_sub = Complete_SET';

    num_sel_trace = nnz(sel_trace_sub);
    set(handles.edit1,'String',num2str(num_sel_trace));
    [aa,~] =size(sel_trace_sub);
    if aa == 0
        sel_trace_sub = sel_trace_sub';
    end
% else
%     num_sel_trace = num_sel_trace -1 ;
%     Complete_SET = Complete_SET(1:end-1);
%     set(handles.listbox1,'Value',num2str(Complete_SET));
%     set(handles.edit1,'String',num2str(num_sel_trace));
% end

% --- Executes on button press in fit_gamma.
function fit_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to fit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global all_gamma
axes(handles.axes5)
histogram(all_gamma,10)
histfit(all_gamma)
[gamma_norm, gamma_width] = normfit(all_gamma);
set(handles.disp_fit_gamma, 'String', num2str(gamma_norm));





function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_traces.
function load_traces_Callback(hObject, eventdata, handles)
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

if num_files > 1
   ALL_NAME =  cell(1,num_files);
   for i = 1:num_files
      [fname, ~] = uigetfile();
      ALL_NAME{i} = fname;
   end
   Traces_merger_together1(ALL_NAME{:})
   fname = 'gamma_to_analyze.mat';
   [path_trace,file_name] = fileparts(fname);
   addpath(path_trace);

   load(file_name)
[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((1:num_traces)');
Complete_SET = 1:num_traces;
set(handles.listbox1, 'String', num_list_trace);
set(handles.edit1, 'String', num2str(num_traces));

else
[fname, ~] = uigetfile(); 
[path_trace,file_name] = fileparts(fname);
addpath(path_trace);

load(file_name)
    
[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((1:num_traces)');
Complete_SET = 1:num_traces;
set(handles.listbox1, 'String', num_list_trace);
set(handles.edit1, 'String', num2str(num_traces));
end

setappdata(handles.load_traces, 'don_tot_trace', don_tot_trace);
setappdata(handles.load_traces, 'don_bckg_trace', don_bckg_trace);
setappdata(handles.load_traces, 'accep_tot_trace', accep_tot_trace);
setappdata(handles.load_traces, 'accep_bckg_trace', accep_bckg_trace);
setappdata(handles.load_traces, 'don_spec_trace', don_spec_trace);
setappdata(handles.load_traces, 'time_axis', time_axis);
setappdata(handles.load_traces, 'accep_spec_trace', accep_spec_trace);
% setappdata(handles.load_traces, 'Picture_d', Picture_d);
% setappdata(handles.load_traces, 'Picture_a', Picture_a);





function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double




% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
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
close
clear
clear global
clc
kat_gamma_adv;



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
global beta;
beta = str2double(get(handles.edit7,'String'));

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



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
global num_files
num_files = str2double(get(handles.edit8,'String'));

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




function Traces_merger_together1(varargin)
number_arguments = length(varargin);
%% Update names to reflect the names of the traces

%Initialization
DON_Bleach_temp = [];
ACC_Bleach_temp = [];
pre_DON_temp = [];
after_DON_temp = [];
pre_ACC_temp = [];
after_ACC_temp = [];



%Merging all the vectors
for i = 1:number_arguments
file = varargin(i);
file1 = [file{1}];
load(file1)

DON_Bleach_temp = [DON_Bleach_temp, DON_Bleach];
ACC_Bleach_temp = [ACC_Bleach_temp, ACC_Bleach];
pre_DON_temp = [pre_DON_temp, pre_DON];
after_DON_temp = [after_DON_temp, after_DON];
pre_ACC_temp = [pre_ACC_temp, pre_ACC];
after_ACC_temp = [after_ACC_temp, after_ACC];

end
time_axis_temp =  time_axis;

DON_Bleach = DON_Bleach_temp;
ACC_Bleach = ACC_Bleach_temp;
pre_DON = pre_DON_temp;
after_DON = after_DON_temp;
pre_ACC = pre_ACC_temp;
after_ACC = after_ACC_temp;

save('Traces_to_analyze.mat','time_axis','DON_Bleach','ACC_Bleach','pre_DON','after_DON','pre_ACC','after_ACC'); 


% --- Executes on button press in calc_gamma.
function calc_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to calc_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Complete_SET
global don_sel
global accep_sel
global time_axis
global pre_blch_x
global post_blch_x
global p_blch_yd
global p_blch_ya
global gamma
global alpha
global beta
global all_gamma_t
global all_beta_t
global all_alpha_t


[blch_index,~] = ginput(2);
pre_blch_time = find(time_axis >=(blch_index(1)),1);
pre_index = pre_blch_time;
post_blch_time = find(time_axis >=(blch_index(2)),1);
post_index = post_blch_time;

pre_blch_x = (ones(1,100).*time_axis(pre_index));
post_blch_x = (ones(1,100).*time_axis(post_index));

don_pre = mean(don_sel(pre_index-10:pre_index));
don_post = mean(don_sel(post_index:post_index+10));

accep_pre = mean(accep_sel(pre_index-10:pre_index));
accep_post = mean(accep_sel(post_index:post_index+10));

gamma = (accep_pre-accep_post)/(don_post-don_pre);
all_gamma_t = gamma;
if don_post-don_pre >1
beta = accep_post/accep_pre;
alpha = [];
all_beta_t = beta;
end
if don_post - don_pre < 1
alpha = accep_post/accep_pre;
beta = [];
all_alpha_t = alpha;
end

set(handles.edit2, 'String', num2str(don_pre));
set(handles.edit3, 'String', num2str(don_post));
set(handles.edit4, 'String', num2str(accep_pre));
set(handles.edit5, 'String', num2str(accep_post));
set(handles.edit6, 'String', num2str(gamma));
set(handles.edit7, 'String', num2str(beta));
set(handles.edit9, 'String', num2str(alpha));

axes(handles.axes1);
plot(time_axis, don_sel,'g',pre_blch_x, p_blch_yd,'-g',post_blch_x,p_blch_yd,'-g');
ylabel('Donor')
ylim([0 +inf]);

axes(handles.axes2);
plot(time_axis, accep_sel,'r',pre_blch_x,p_blch_ya,'-r',post_blch_x, p_blch_ya,'-r');
ylabel ('Acceptor')
ylim([0 +inf]);
%% No Gamma correction
denom_fret = accep_sel + don_sel;
fret_calc_trace = accep_sel./denom_fret;

axes(handles.axes3);
plot(time_axis, fret_calc_trace,'b');
ylabel('FRET, No gamma')
ylim([0 1]);

%% Gamma correction
denom_fret_gamma = accep_sel + don_sel.*gamma;
fret_calc_trace_gamma = accep_sel./denom_fret_gamma;

axes(handles.axes4);
plot(time_axis, fret_calc_trace_gamma,'b');
ylabel('FRET, Gamma')
ylim([0 1]);

%% beta or alpha corrections
if don_post-don_pre >1
% Beta correction
numer_beta = accep_sel - (beta.*don_sel);
denom_beta = numer_beta + (gamma.*don_sel);
fret_beta = numer_beta./denom_beta;
axes(handles.axes6)
plot(time_axis, fret_beta,'b');
ylabel('FRET, Beta')
ylim([0 1]);
end
if don_post - don_pre < 1
% Alpha correction
numer_alpha = accep_sel- (alpha.*accep_sel);
denom_alpha = numer_alpha  + (gamma.*don_sel);
axes(handles.axes6)
plot(time_axis, fret_alpha,'b');
ylabel('FRET, alpha')
ylim([0 1]);
end


% --- Executes on button press in log_gamma.
function log_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to log_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global all_gamma_t
global all_gamma
global all_fret
global all_fret_t

if size(all_gamma)> 0
    all_gamma = [all_gamma all_gamma_t];   
    all_fret = [all_fret all_fret_t];
else
    all_gamma = all_gamma_t;
    all_fret = all_fret_t;
end
axes(handles.axes5)
histogram(all_gamma,10)


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



function disp_fit_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to disp_fit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_fit_gamma as text
%        str2double(get(hObject,'String')) returns contents of disp_fit_gamma as a double


% --- Executes during object creation, after setting all properties.
function disp_fit_gamma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_fit_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_gamma.
function exp_gamma_Callback(hObject, eventdata, handles)
% hObject    handle to exp_gamma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global all_gamma
uisave({'all_gamma'});


% --- Executes on button press in fit_alpha.
function fit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to fit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global all_gamma
global all_fret
figure (1)
plot(all_fret,all_gamma,'ok')
xlabel('FRET')
ylabel('Gamma')



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


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


% --- Executes on button press in fit_beta.
function fit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to fit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Executes on button press in log_beta.
function log_beta_Callback(hObject, eventdata, handles)
% hObject    handle to log_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in log_alpha.
function log_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to log_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
