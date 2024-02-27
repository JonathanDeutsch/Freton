function varargout = kat_hist_comp_v2(varargin)
% KAT_HIST_COMP_V2 MATLAB code for kat_hist_comp_v2.fig
%      KAT_HIST_COMP_V2, by itself, creates a new KAT_HIST_COMP_V2 or raises the existing
%      singleton*.
%
%      H = KAT_HIST_COMP_V2 returns the handle to a new KAT_HIST_COMP_V2 or the handle to
%      the existing singleton*.
%
%      KAT_HIST_COMP_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_HIST_COMP_V2.M with the given input arguments.
%
%      KAT_HIST_COMP_V2('Property','Value',...) creates a new KAT_HIST_COMP_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_hist_comp_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_hist_comp_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_hist_comp_v2

% Last Modified by GUIDE v2.5 02-Jun-2022 02:08:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_hist_comp_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_hist_comp_v2_OutputFcn, ...
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


% --- Executes just before kat_hist_comp_v2 is made visible.
function kat_hist_comp_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_hist_comp_v2 (see VARARGIN)

% Choose default command line output for kat_hist_comp_v2
handles.output = hObject;
set(handles.num_bins,'String',num2str(50));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_hist_comp_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_hist_comp_v2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_1.
function load_1_Callback(hObject, eventdata, handles)
% hObject    handle to load_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)
rot_plot = get(handles.rot_plots,'Value');
[fname1, ~] = uigetfile(); 
[path_hist1,file_name1] = fileparts(fname1);
addpath(path_hist1);
data1=load(file_name1);
load(file_name1,'data_exp');
data_type = exist('data_exp');
if data_type >0
    data_type = 2;
    set(handles.disp_type,'String','FITTED');
else
    data_type = 1;
    set(handles.disp_type,'String','RAW');
end
file_sel_hist1 = data1.file_sel_hist;
[~,num_hist_data1] = size(file_sel_hist1);
set(handles.disp_num_vals1,'String',num2str(num_hist_data1));
setappdata(handles.load_1,'file_sel_hist1',file_sel_hist1);
set(handles.disp_name_1,'String',file_name1);
setappdata(handles.load_1,'filename',file_name1);
num_bins = str2double(get(handles.num_bins,'String'));
axes(handles.axes1)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist1,'BinEdges',edges,'Normalization','pdf','FaceColor', 'none', 'LineWidth',1.15);
prop.b2 = gca;
ylabel('Occurence')
xlabel('FRET')
prop.b2.FontWeight = 'bold';
setappdata(handles.load_1,'num_graph',1);
set(handles.get_num,'String',num2str(1));

if data_type == 2
    hold on
    data_output1 = data1.data_exp;
    set(handles.uitable1,'data',data_output1);
    [~,num_comp1] = size(data_output1);
    set(handles.get_num_comp_1,'String',num2str(num_comp1));
    plot_fig_1_Callback(hObject, eventdata, handles)
end



function disp_name_1_Callback(hObject, eventdata, handles)
% hObject    handle to disp_name_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_name_1 as text
%        str2double(get(hObject,'String')) returns contents of disp_name_1 as a double


% --- Executes during object creation, after setting all properties.
function disp_name_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_name_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function get_num_Callback(hObject, eventdata, handles)
% hObject    handle to get_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_num as text
%        str2double(get(hObject,'String')) returns contents of get_num as a double


% --- Executes during object creation, after setting all properties.
function get_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_graph.
function get_graph_Callback(hObject, eventdata, handles)
% hObject    handle to get_graph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel_type = get(handles.uibuttongroup1,'SelectedObject');
type_data = sel_type.String;
switch type_data
    case{'Vertical'}
        typedata = 1;
    case{'Horizontal'}
        typedata = 2;
end

num_graph = str2double(get(handles.set_nums,'String'));
fig = figure();
if typedata == 1
    set(fig,'units','normalized','position', [0.1, 0.2, 0.2, 0.5])
elseif typedata == 2
    set(fig,'units','normalized','position', [0.1, 0.2, 0.5, 0.2])
end

if num_graph == 1
ax1 = subplot(1,1,1);
a1 = handles.axes1;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);
end

if num_graph >= 2
if typedata == 1
     ax1 = subplot(2,1,1);
elseif typedata ==2
    ax1 = subplot(1,2,1); 
    xlabel ('FRET')
end
a1 = handles.axes1;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(2,1,2);
elseif typedata == 2
    ax2 = subplot(1,2,2);
end
a2 = handles.axes2;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);
end

if num_graph >= 3
    if typedata == 1
        ax1 = subplot(3,1,1);
    elseif typedata == 2
        ax1 = subplot(1,3,1);
        xlabel ('FRET')
    end
a1 = handles.axes1;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(3,1,2);
elseif typedata == 2
    ax2 = subplot(1,3,2);
    xlabel ('FRET')
end
a2 = handles.axes2;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

if typedata ==1
    ax3 = subplot(3,1,3);
elseif typedata ==2 
    ax3 = subplot(1,3,3);
end
a3 = handles.axes3;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);
end

if num_graph >= 4
    if typedata == 1
        ax1 = subplot(4,1,1);
    elseif typedata == 2
        ax1 = subplot(1,4,1);
        xlabel ('FRET')
    end
a1 = handles.axes1;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(4,1,2);
elseif typedata == 2
    ax2 = subplot(1,4,2);
    xlabel ('FRET')
end
a2 = handles.axes2;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

if typedata == 1
    ax3 = subplot(4,1,3);
elseif typedata == 2
    ax3 = subplot(1,4,3);
    xlabel ('FRET')
end
a3 = handles.axes3;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);

if typedata == 1
     ax4 = subplot(4,1,4); 
elseif typedata == 2
    ax4 = subplot(1,4,4);
end
a4 = handles.axes4;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a4),ax4);
end

if num_graph >= 5
    if typedata == 1
        ax1 = subplot(5,1,1);
    elseif typedata == 2
        ax1 = subplot(1,5,1);
        xlabel ('FRET')
    end
a1 = handles.axes1;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(5,1,2);
elseif typedata == 2
    ax2 = subplot(1,5,2);
    xlabel ('FRET')
end
a2 = handles.axes2;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

if typedata == 1
    ax3 = subplot(5,1,3);
elseif typedata == 2
    ax3 = subplot(1,5,3);
    xlabel ('FRET')
end
a3 = handles.axes3;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);

if typedata == 1
    ax4 = subplot(5,1,4);
elseif typedata == 2
    ax4 = subplot(1,5,4);
    xlabel ('FRET')
end
a4 = handles.axes4;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a4),ax4);

if typedata == 1
    ax5 = subplot(5,1,5);
elseif typedata == 2
    ax5 = subplot(1,5,5);
end
a5 = handles.axes5;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a5),ax5);
end



% --- Executes on button press in load_2.
function load_2_Callback(hObject, eventdata, handles)
% hObject    handle to load_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes2)
[fname2, ~] = uigetfile(); 
[path_hist2,file_name2] = fileparts(fname2);
addpath(path_hist2);
data2=load(file_name2);

load(file_name2,'data_exp');
data_type = exist('data_exp');
if data_type >0
    data_type = 2;
else
    data_type = 1;
end

file_sel_hist2 = data2.file_sel_hist;
[~,num_hist_data2] = size(file_sel_hist2);
set(handles.disp_num_vals2,'String',num2str(num_hist_data2));
setappdata(handles.load_2,'file_sel_hist2',file_sel_hist2);
set(handles.disp_name_2,'String',file_name2);
setappdata(handles.load_2,'filename',file_name2);
num_bins = str2double(get(handles.num_bins,'String'));
axes(handles.axes2)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist2,'BinEdges',edges,'Normalization','pdf','FaceColor', 'none', 'LineWidth',1.15);
prop.b2 = gca;
ylabel('Occurence')
xlabel('FRET')
prop.b2.FontWeight = 'bold';
setappdata(handles.load_1,'num_graph',2);
set(handles.get_num,'String',num2str(2));

if data_type == 2
    hold on
    data_output2 = data2.data_exp;
    set(handles.uitable2,'data',data_output2);
    [~,num_comp2] = size(data_output2);
    set(handles.get_num_comp_2,'String',num2str(num_comp2));
    plot_fig_2_Callback(hObject, eventdata, handles)
end



function disp_name_2_Callback(hObject, eventdata, handles)
% hObject    handle to disp_name_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_name_2 as text
%        str2double(get(hObject,'String')) returns contents of disp_name_2 as a double


% --- Executes during object creation, after setting all properties.
function disp_name_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_name_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_3.
function load_3_Callback(hObject, eventdata, handles)
% hObject    handle to load_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes3)
[fname3, ~] = uigetfile(); 
[path_hist3,file_name3] = fileparts(fname3);
addpath(path_hist3);
data3=load(file_name3);

load(file_name3,'data_exp');
data_type = exist('data_exp');
if data_type >0
    data_type = 2;
else
    data_type = 1;
    set(handles.disp_type,'String','RAW');
end

file_sel_hist3 = data3.file_sel_hist;
[~,num_hist_data3] = size(file_sel_hist3);
set(handles.disp_num_vals3,'String',num2str(num_hist_data3));
setappdata(handles.load_3,'file_sel_hist3',file_sel_hist3);
set(handles.disp_name_3,'String',file_name3);
setappdata(handles.load_3,'filename',file_name3);

num_bins = str2double(get(handles.num_bins,'String'));
axes(handles.axes3)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist3,'BinEdges',edges,'Normalization','pdf','FaceColor', 'none', 'LineWidth',1.15);
prop.b2 = gca;
ylabel('Occurence')
xlabel('FRET')
prop.b2.FontWeight = 'bold';

setappdata(handles.load_1,'num_graph',3);
set(handles.get_num,'String',num2str(3));

if data_type == 2
    hold on
    data_output3 = data3.data_exp;
    set(handles.uitable3,'data',data_output3);
    [~,num_comp3] = size(data_output3);
    set(handles.get_num_comp_3,'String',num2str(num_comp3));
    plot_fig_3_Callback(hObject, eventdata, handles)
end



function disp_name_3_Callback(hObject, eventdata, handles)
% hObject    handle to disp_name_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_name_3 as text
%        str2double(get(hObject,'String')) returns contents of disp_name_3 as a double


% --- Executes during object creation, after setting all properties.
function disp_name_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_name_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_4.
function load_4_Callback(hObject, eventdata, handles)
% hObject    handle to load_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes4)

[fname4, ~] = uigetfile(); 
[path_hist4,file_name4] = fileparts(fname4);
addpath(path_hist4);
data4=load(file_name4);

load(file_name4,'data_exp');
data_type = exist('data_exp');
if data_type >0
    data_type = 2;
else
    data_type = 1;
end

file_sel_hist4 = data4.file_sel_hist;
[~,num_hist_data4] = size(file_sel_hist4);
set(handles.disp_num_vals4,'String',num2str(num_hist_data4));
setappdata(handles.load_4,'file_sel_hist4',file_sel_hist4);
set(handles.disp_name_4,'String',file_name4);
setappdata(handles.load_4,'filename',file_name4);

num_bins = str2double(get(handles.num_bins,'String'));
axes(handles.axes4)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist4,'BinEdges',edges,'Normalization','pdf','FaceColor', 'none', 'LineWidth',1.15);
prop.b2 = gca;
ylabel('Occurence')
xlabel('FRET')
prop.b2.FontWeight = 'bold';

setappdata(handles.load_1,'num_graph',4);
set(handles.get_num,'String',num2str(4));

if data_type == 2
    hold on
    data_output4 = data4.data_exp;
    set(handles.uitable4,'data',data_output4);
    [~,num_comp4] = size(data_output4);
    set(handles.get_num_comp_4,'String',num2str(num_comp4));
    plot_fig_4_Callback(hObject, eventdata, handles)
end




function disp_name_4_Callback(hObject, eventdata, handles)
% hObject    handle to disp_name_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_name_4 as text
%        str2double(get(hObject,'String')) returns contents of disp_name_4 as a double


% --- Executes during object creation, after setting all properties.
function disp_name_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_name_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_5.
function load_5_Callback(hObject, eventdata, handles)
% hObject    handle to load_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes5)
[fname5, ~] = uigetfile(); 
[path_hist5,file_name5] = fileparts(fname5);
addpath(path_hist5);
data5=load(file_name5);

load(file_name5,'data_exp');
data_type = exist('data_exp');
if data_type >0
    data_type = 2;
else
    data_type = 1;
end

file_sel_hist5 = data5.file_sel_hist;
[~,num_hist_data5] = size(file_sel_hist5);
set(handles.disp_num_vals5,'String',num2str(num_hist_data5));
setappdata(handles.load_5,'file_sel_hist5',file_sel_hist5);
set(handles.disp_name_5,'String',file_name5);
setappdata(handles.load_5,'filename',file_name5);
num_bins = str2double(get(handles.num_bins,'String'));
axes(handles.axes5)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist5,'BinEdges',edges,'Normalization','pdf','FaceColor', 'none', 'LineWidth',1.15);
prop.b2 = gca;
ylabel('Occurence')
xlabel('FRET')
prop.b2.FontWeight = 'bold';

setappdata(handles.load_1,'num_graph',5);
set(handles.get_num,'String',num2str(5));

if data_type == 2
    hold on
    data_output5 = data5.data_exp;
    set(handles.uitable5,'data',data_output5);
    [~,num_comp5] = size(data_output5);
    set(handles.get_num_comp_5,'String',num2str(num_comp5));
    plot_fig_5_Callback(hObject, eventdata, handles)
end



function disp_name_5_Callback(hObject, eventdata, handles)
% hObject    handle to disp_name_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_name_5 as text
%        str2double(get(hObject,'String')) returns contents of disp_name_5 as a double


% --- Executes during object creation, after setting all properties.
function disp_name_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_name_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in re_display.
function re_display_Callback(hObject, eventdata, handles)
% hObject    handle to re_display (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_bins = str2double(get(handles.num_bins,'String'));
num_graph = getappdata(handles.load_1,'num_graph');

file_sel_hist1 = getappdata(handles.load_1,'file_sel_hist1')';
axes(handles.axes1)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist1,'BinEdges',edges);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')   
prop.b2.FontWeight = 'bold';


if num_graph >=2
file_sel_hist2 = getappdata(handles.load_2,'file_sel_hist2')';
axes(handles.axes2)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist2,'BinEdges',edges);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')   
prop.b2.FontWeight = 'bold';
end

if num_graph >=3
file_sel_hist3 = getappdata(handles.load_3,'file_sel_hist3')';
axes(handles.axes3)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist3,'BinEdges',edges);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')   
prop.b2.FontWeight = 'bold';
end

if num_graph >=4
file_sel_hist4 = getappdata(handles.load_4,'file_sel_hist4')';
axes(handles.axes4)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist4,'BinEdges',edges);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')   
prop.b2.FontWeight = 'bold';
end

if num_graph >=5
file_sel_hist5 = getappdata(handles.load_5,'file_sel_hist5')';
axes(handles.axes5)
edges = linspace(0,1,num_bins);
histogram(file_sel_hist5,'BinEdges',edges);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')   
prop.b2.FontWeight = 'bold';
end


% --- Executes on button press in vis_fit_1.
function vis_fit_1_Callback(hObject, eventdata, handles)
% hObject    handle to vis_fit_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of vis_fit_1


% --- Executes on button press in plot_fig_1.
function plot_fig_1_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fig_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rot_plot = get(handles.rot_plots,'Value');
num_bins = str2num(get(handles.num_bins,'String'));
x_pdf = linspace(0, 1, num_bins);
table = get(handles.uitable1,'data');
num_comp_1 = str2num(get(handles.get_num_comp_1,'String'));
axes(handles.axes1)
if num_comp_1 >=1    
    vals1_gauss_1_mu = table(1,1);
    vals1_gauss_1_sigma = table(2,1);
    vals1_gauss_1_frac = table(3,1);    
    y1_comp1 = vals1_gauss_1_frac*normpdf(x_pdf,vals1_gauss_1_mu, vals1_gauss_1_sigma);
    plot(x_pdf,y1_comp1,'r','Linewidth', 1.1)
 if num_comp_1 >=2
    vals1_gauss_2_mu = table(1,2);
    vals1_gauss_2_sigma = table(2,2);
    vals1_gauss_2_frac = table(3,2);    
    y1_comp2 = vals1_gauss_2_frac*normpdf(x_pdf,vals1_gauss_2_mu, vals1_gauss_2_sigma);
    plot(x_pdf,y1_comp2,'m','Linewidth', 1.1)
 end
 if num_comp_1 >=3
    vals1_gauss_3_mu = table(1,3);
    vals1_gauss_3_sigma = table(2,3);
    vals1_gauss_3_frac = table(3,3);    
    y1_comp3 = vals1_gauss_3_frac*normpdf(x_pdf,vals1_gauss_3_mu, vals1_gauss_3_sigma);
    plot(x_pdf,y1_comp3,'b','Linewidth', 1.1)
 end
 if num_comp_1 >=4
    vals1_gauss_4_mu = table(1,4);
    vals1_gauss_4_sigma = table(2,4);
    vals1_gauss_4_frac = table(3,4);    
    y1_comp4 = vals1_gauss_4_frac*normpdf(x_pdf,vals1_gauss_4_mu, vals1_gauss_4_sigma);  
    plot(x_pdf,y1_comp4,'g','Linewidth', 1.1)
 end
 
if num_comp_1 == 1
    y1 = y1_comp1;
elseif num_comp_1 == 2
    y1 = y1_comp1+y1_comp2;  
elseif num_comp_1 == 3
    y1 = y1_comp1+y1_comp2+y1_comp3;  
elseif num_comp_1 == 4
    y1 = (y1_comp1+y1_comp2+y1_comp3+y1_comp4);        
end
    axes(handles.axes1)
    plot(x_pdf,y1,'k','Linewidth',1.2);
    axes(handles.axes7)
    plot(x_pdf,y1,'k','Linewidth',1.2);
end
hold off
setappdata(handles.load_1,'y1',y1);

% --- Executes on button press in plot_fig_2.
function plot_fig_2_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fig_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_bins = str2num(get(handles.num_bins,'String'));
x_pdf = linspace(0, 1, num_bins);
table = get(handles.uitable2,'data');
num_comp_2 = str2num(get(handles.get_num_comp_2,'String'));
axes(handles.axes2)
if num_comp_2 >=1    
    vals2_gauss_1_mu = table(1,1);
    vals2_gauss_1_sigma = table(2,1);
    vals2_gauss_1_frac = table(3,1);    
    y2_comp1 = vals2_gauss_1_frac*normpdf(x_pdf,vals2_gauss_1_mu, vals2_gauss_1_sigma);
    plot(x_pdf,y2_comp1,'r','Linewidth', 1.1)
 if num_comp_2 >=2
    vals2_gauss_2_mu = table(1,2);
    vals2_gauss_2_sigma = table(2,2);
    vals2_gauss_2_frac = table(3,2);    
    y2_comp2 = vals2_gauss_2_frac*normpdf(x_pdf,vals2_gauss_2_mu, vals2_gauss_2_sigma);
    plot(x_pdf,y2_comp2,'m','Linewidth', 1.1)
 end
 if num_comp_2 >=3
    vals2_gauss_3_mu = table(1,3);
    vals2_gauss_3_sigma = table(2,3);
    vals2_gauss_3_frac = table(3,3);    
    y2_comp3 = vals2_gauss_3_frac*normpdf(x_pdf,vals2_gauss_3_mu, vals2_gauss_3_sigma);
    plot(x_pdf,y2_comp3,'b','Linewidth', 1.1)
 end
 if num_comp_2 >=4
    vals2_gauss_4_mu = table(1,4);
    vals2_gauss_4_sigma = table(2,4);
    vals2_gauss_4_frac = table(3,4);    
    y2_comp4 = vals2_gauss_4_frac*normpdf(x_pdf,vals2_gauss_4_mu, vals2_gauss_4_sigma); 
    plot(x_pdf,y2_comp4,'g','Linewidth', 1.1)
 end

if num_comp_2 == 1
y2 = y2_comp1;    
elseif num_comp_2 == 2
y2 = y2_comp1+y2_comp2;    
elseif num_comp_2 == 3
y2 = y2_comp1+y2_comp2+y2_comp3;    
elseif num_comp_2 == 4
y2 = y2_comp1+y2_comp2+y2_comp3+y2_comp4;        
end
axes(handles.axes2)
plot(x_pdf,y2,'k','Linewidth',1.2);
axes(handles.axes8)
plot(x_pdf,y2,'k','Linewidth',1.2);
end
hold off
setappdata(handles.load_1,'y2',y2);

% --- Executes on button press in plot_fig_3.
function plot_fig_3_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fig_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_bins = str2num(get(handles.num_bins,'String'));
x_pdf = linspace(0, 1, num_bins);
table = get(handles.uitable3,'data');
num_comp_3 = str2num(get(handles.get_num_comp_3,'String'));
axes(handles.axes3)
if num_comp_3 >=1    
    vals3_gauss_1_mu = table(1,1);
    vals3_gauss_1_sigma = table(2,1);
    vals3_gauss_1_frac = table(3,1);    
    y3_comp1 = vals3_gauss_1_frac*normpdf(x_pdf,vals3_gauss_1_mu, vals3_gauss_1_sigma);
    plot(x_pdf,y3_comp1,'r','Linewidth', 1.1)
 if num_comp_3 >=2
    vals3_gauss_2_mu = table(1,2);
    vals3_gauss_2_sigma = table(2,2);
    vals3_gauss_2_frac = table(3,2);    
    y3_comp2 = vals3_gauss_2_frac*normpdf(x_pdf,vals3_gauss_2_mu, vals3_gauss_2_sigma);
    plot(x_pdf,y3_comp2,'m','Linewidth', 1.1)
 end
 if num_comp_3 >=3
    vals3_gauss_3_mu = table(1,3);
    vals3_gauss_3_sigma = table(2,3);
    vals3_gauss_3_frac = table(3,3);    
    y3_comp3 = vals3_gauss_3_frac*normpdf(x_pdf,vals3_gauss_3_mu, vals3_gauss_3_sigma);
    plot(x_pdf,y3_comp3,'b','Linewidth', 1.1)
 end
 if num_comp_3 >=4
    vals3_gauss_4_mu = table(1,4);
    vals3_gauss_4_sigma = table(2,4);
    vals3_gauss_4_frac = table(3,4);    
    y3_comp4 = vals3_gauss_4_frac*normpdf(x_pdf,vals3_gauss_4_mu, vals3_gauss_4_sigma);
    plot(x_pdf,y3_comp4,'g','Linewidth', 1.1)
 end
axes(handles.axes9)
if num_comp_3 == 1
y3 = y3_comp1;    
elseif num_comp_3 == 2
y3 = y3_comp1+y3_comp2;    
elseif num_comp_3 == 3
y3 = y3_comp1+y3_comp2+y3_comp3;    
elseif num_comp_3 == 4
y3 = y3_comp1+y3_comp2+y3_comp3+y3_comp4;        
end

axes(handles.axes3)
plot(x_pdf,y3,'k','Linewidth',1.2);
axes(handles.axes9)
plot(x_pdf,y3,'k','Linewidth',1.2);
end
setappdata(handles.load_1,'y3',y3);



% --- Executes on button press in plot_fig_4.
function plot_fig_4_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fig_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_bins = str2num(get(handles.num_bins,'String'));
x_pdf = linspace(0, 1, num_bins);
table = get(handles.uitable4,'data');
num_comp_4 = str2num(get(handles.get_num_comp_4,'String'));
axes(handles.axes4)
if num_comp_4 >=1    
    vals4_gauss_1_mu = table(1,1);
    vals4_gauss_1_sigma = table(2,1);
    vals4_gauss_1_frac = table(3,1);    
    y4_comp1 = vals4_gauss_1_frac*normpdf(x_pdf,vals4_gauss_1_mu, vals4_gauss_1_sigma);
    plot(x_pdf,y4_comp1,'r','Linewidth', 1.1)
 if num_comp_4 >=2
    vals4_gauss_2_mu = table(1,2);
    vals4_gauss_2_sigma = table(2,2);
    vals4_gauss_2_frac = table(3,2);    
    y4_comp2 = vals4_gauss_2_frac*normpdf(x_pdf,vals4_gauss_2_mu, vals4_gauss_2_sigma);
    plot(x_pdf,y4_comp2,'m','Linewidth', 1.1)
 end
 if num_comp_4 >=3
    vals4_gauss_3_mu = table(1,3);
    vals4_gauss_3_sigma = table(2,3);
    vals4_gauss_3_frac = table(3,3);    
    y4_comp3 = vals4_gauss_3_frac*normpdf(x_pdf,vals4_gauss_3_mu, vals4_gauss_3_sigma);
     plot(x_pdf,y4_comp3,'b','Linewidth', 1.1)
 end
 if num_comp_4 >=4
    vals4_gauss_4_mu = table(1,4);
    vals4_gauss_4_sigma = table(2,4);
    vals4_gauss_4_frac = table(3,4);    
    y4_comp4 = vals4_gauss_4_frac*normpdf(x_pdf,vals4_gauss_4_mu, vals4_gauss_4_sigma); 
    plot(x_pdf,y4_comp4,'g','Linewidth', 1.1)
 end

if num_comp_4 == 1
y4 = y4_comp1;    
elseif num_comp_4 == 2
y4 = y4_comp1+y4_comp2;    
elseif num_comp_4 == 3
y4 = y4_comp1+y4_comp2+y4_comp3;    
elseif num_comp_4 == 4
y4 = y4_comp1+y4_comp2+y4_comp3+y4_comp4;        
end
    axes(handles.axes4)
    plot(x_pdf,y4,'k','Linewidth',1.2);
    axes(handles.axes10)
    plot(x_pdf,y4,'k','Linewidth',1.2);
end
setappdata(handles.load_1,'y4',y4);


% --- Executes on button press in plot_fig_5.
function plot_fig_5_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fig_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_bins = str2num(get(handles.num_bins,'String'));
x_pdf = linspace(0, 1, num_bins);
table = get(handles.uitable5,'data');
num_comp_5 = str2num(get(handles.get_num_comp_5,'String'));
axes(handles.axes5)
if num_comp_5 >=1    
    vals5_gauss_1_mu = table(1,1);
    vals5_gauss_1_sigma = table(2,1);
    vals5_gauss_1_frac = table(3,1);    
    y5_comp1 = vals5_gauss_1_frac*normpdf(x_pdf,vals5_gauss_1_mu, vals5_gauss_1_sigma);
    plot(x_pdf,y5_comp1,'r','Linewidth', 1.1)
 if num_comp_5 >=2
    vals5_gauss_2_mu = table(1,2);
    vals5_gauss_2_sigma = table(2,2);
    vals5_gauss_2_frac = table(3,2);    
    y5_comp2 = vals5_gauss_2_frac*normpdf(x_pdf,vals5_gauss_2_mu, vals5_gauss_2_sigma);
    plot(x_pdf,y5_comp2,'m','Linewidth', 1.1)
 end
 if num_comp_5 >=3
    vals5_gauss_3_mu = table(1,3);
    vals5_gauss_3_sigma = table(2,3);
    vals5_gauss_3_frac = table(3,3);    
    y5_comp3 = vals5_gauss_3_frac*normpdf(x_pdf,vals5_gauss_3_mu, vals5_gauss_3_sigma);
    plot(x_pdf,y5_comp3,'b','Linewidth', 1.1)    
 end
 if num_comp_5 >=4
    vals5_gauss_4_mu = table(1,4);
    vals5_gauss_4_sigma = table(2,4);
    vals5_gauss_4_frac = table(3,4);    
    y5_comp4 = vals5_gauss_4_frac*normpdf(x_pdf,vals5_gauss_4_mu, vals5_gauss_4_sigma); 
    plot(x_pdf,y5_comp4,'g','Linewidth', 1.1)
 end

if num_comp_5 == 1
y5 = y5_comp1;    
elseif num_comp_5 == 2
y5 = y5_comp1+y5_comp2;    
elseif num_comp_5 == 3
y5 = y5_comp1+y5_comp2+y5_comp3;    
elseif num_comp_5 == 4
y5 = y5_comp1+y5_comp2+y5_comp3+y5_comp4;        
end

axes(handles.axes5)
plot(x_pdf,y5,'k','Linewidth',1.2);
axes(handles.axes11)
plot(x_pdf,y5,'k','Linewidth',1.2) 
end
setappdata(handles.load_1,'y5',y5);



function get_num_comp_1_Callback(hObject, eventdata, handles)
% hObject    handle to get_num_comp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_num_comp_1 as text
%        str2double(get(hObject,'String')) returns contents of get_num_comp_1 as a double


% --- Executes during object creation, after setting all properties.
function get_num_comp_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_num_comp_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function get_num_comp_2_Callback(hObject, eventdata, handles)
% hObject    handle to get_num_comp_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_num_comp_2 as text
%        str2double(get(hObject,'String')) returns contents of get_num_comp_2 as a double


% --- Executes during object creation, after setting all properties.
function get_num_comp_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_num_comp_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function get_num_comp_3_Callback(hObject, eventdata, handles)
% hObject    handle to get_num_comp_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_num_comp_3 as text
%        str2double(get(hObject,'String')) returns contents of get_num_comp_3 as a double


% --- Executes during object creation, after setting all properties.
function get_num_comp_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_num_comp_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function get_num_comp_4_Callback(hObject, eventdata, handles)
% hObject    handle to get_num_comp_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_num_comp_4 as text
%        str2double(get(hObject,'String')) returns contents of get_num_comp_4 as a double


% --- Executes during object creation, after setting all properties.
function get_num_comp_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_num_comp_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function get_num_comp_5_Callback(hObject, eventdata, handles)
% hObject    handle to get_num_comp_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_num_comp_5 as text
%        str2double(get(hObject,'String')) returns contents of get_num_comp_5 as a double


% --- Executes during object creation, after setting all properties.
function get_num_comp_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_num_comp_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in get_sims.
function get_sims_Callback(hObject, eventdata, handles)
% hObject    handle to get_sims (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sel_type = get(handles.uibuttongroup1,'SelectedObject');
type_data = sel_type.String;
switch type_data
    case{'Vertical'}
        typedata = 1;
    case{'Horizontal'}
        typedata = 2;
end

num_graph = str2double(get(handles.set_nums,'String'));
fig = figure();
if typedata == 1
    set(fig,'units','normalized','position', [0.1, 0.2, 0.2, 0.5])
elseif typedata == 2
    set(fig,'units','normalized','position', [0.1, 0.2, 0.5, 0.2])
end

if num_graph == 1
ax1 = subplot(1,1,1);
a1 = handles.axes7;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);
end

if num_graph >= 2
if typedata == 1
     ax1 = subplot(2,1,1);
elseif typedata ==2
    ax1 = subplot(1,2,1); 
    xlabel ('FRET')
end
a1 = handles.axes7;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(2,1,2);
elseif typedata == 2
    ax2 = subplot(1,2,2);
end
a2 = handles.axes8;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);
end

if num_graph >= 3
    if typedata == 1
        ax1 = subplot(3,1,1);
    elseif typedata == 2
        ax1 = subplot(1,3,1);
        xlabel ('FRET')
    end
a1 = handles.axes7;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(3,1,2);
elseif typedata == 2
    ax2 = subplot(1,3,2);
    xlabel ('FRET')
end
a2 = handles.axes8;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

if typedata ==1
    ax3 = subplot(3,1,3);
elseif typedata ==2 
    ax3 = subplot(1,3,3);
end
a3 = handles.axes9;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);
end

if num_graph >= 4
    if typedata == 1
        ax1 = subplot(4,1,1);
    elseif typedata == 2
        ax1 = subplot(1,4,1);
        xlabel ('FRET')
    end
a1 = handles.axes7;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(4,1,2);
elseif typedata == 2
    ax2 = subplot(1,4,2);
    xlabel ('FRET')
end
a2 = handles.axes8;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

if typedata == 1
    ax3 = subplot(4,1,3);
elseif typedata == 2
    ax3 = subplot(1,4,3);
    xlabel ('FRET')
end
a3 = handles.axes9;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);

if typedata == 1
     ax4 = subplot(4,1,4); 
elseif typedata == 2
    ax4 = subplot(1,4,4);
end
a4 = handles.axes10;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a4),ax4);
end

if num_graph >= 5
    if typedata == 1
        ax1 = subplot(5,1,1);
    elseif typedata == 2
        ax1 = subplot(1,5,1);
        xlabel ('FRET')
    end
a1 = handles.axes7;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

if typedata == 1
    ax2 = subplot(5,1,2);
elseif typedata == 2
    ax2 = subplot(1,5,2);
    xlabel ('FRET')
end
a2 = handles.axes8;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

if typedata == 1
    ax3 = subplot(5,1,3);
elseif typedata == 2
    ax3 = subplot(1,5,3);
    xlabel ('FRET')
end
a3 = handles.axes9;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);

if typedata == 1
    ax4 = subplot(5,1,4);
elseif typedata == 2
    ax4 = subplot(1,5,4);
    xlabel ('FRET')
end
a4 = handles.axes10;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a4),ax4);

if typedata == 1
    ax5 = subplot(5,1,5);
elseif typedata == 2
    ax5 = subplot(1,5,5);
end
a5 = handles.axes11;
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a5),ax5);
end



function set_nums_Callback(hObject, eventdata, handles)
% hObject    handle to set_nums (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_nums as text
%        str2double(get(hObject,'String')) returns contents of set_nums as a double


% --- Executes during object creation, after setting all properties.
function set_nums_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_nums (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in plot_superimpose.
function plot_superimpose_Callback(hObject, eventdata, handles)
% hObject    handle to plot_superimpose (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num_bins = str2num(get(handles.num_bins,'String'));
x_pdf = linspace(0, 1, num_bins);
%get the number of graphs
num_superimpose = str2double(get(handles.set_nums,'String'));
ramp = linspace(0, 0.75, num_superimpose);
listOfGrayColors = [ramp; ramp; ramp]';
color_plot_t = get(handles.uibuttongroup3,'SelectedObject');
color_plot = get(color_plot_t, 'String');

axes(handles.axes6)
 if num_superimpose >= 1
        ind =1;
     y1 = getappdata(handles.load_1,'y1');
     if strcmpi (color_plot,'Multi-Color') == 1
     plot(x_pdf, y1,'b','LineWidth',1.2)
     else
     plot(x_pdf, y1,'Color', listOfGrayColors(ind, :),'LineWidth',1.2)    
     end
     hold on
     
    if num_superimpose >=2
        ind =2;
     y2 = getappdata(handles.load_1,'y2');
     if strcmpi (color_plot,'Multi-Color') == 1
     plot(x_pdf, y2,'color',[0 0.4470 0.7410], 'LineWidth',1.2)
     else
     plot(x_pdf, y2,'Color',listOfGrayColors(ind, :),'LineWidth',1.2)      
     end
    end
    
    if num_superimpose >= 3
        ind = 3;
     y3 = getappdata(handles.load_1,'y3');
     if strcmpi (color_plot,'Multi-Color') == 1
     plot(x_pdf, y3,'color',[0.4940 0.1840 0.5560],'LineWidth',1.2) 
     else
      plot(x_pdf, y3,'Color',listOfGrayColors(ind, :),'LineWidth',1.2)     
     end
    end
    
    if num_superimpose >= 4
        ind = 4;
      y4 = getappdata(handles.load_1,'y4');
      if strcmpi (color_plot,'Multi-Color') == 1
        plot(x_pdf, y4,'color',[0.8500 0.3250 0.0980],'LineWidth',1.2)
      else
        plot(x_pdf, y4,'Color',listOfGrayColors(ind, :),'LineWidth',1.2)   
      end
    end
    
    if num_superimpose >= 5
        ind = 5;
      y5 = getappdata(handles.load_1,'y5');
      if strcmpi (color_plot,'Multi-Color') == 1
        plot(x_pdf, y5,'r','LineWidth',1.2)  
      else
        plot(x_pdf, y5,'Color',listOfGrayColors(ind, :),'LineWidth',1.2)   
      end
    end
 end
hold off
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';


% --- Executes on button press in export_multi.
function export_multi_Callback(hObject, eventdata, handles)
% hObject    handle to export_multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure()
a1 = handles.axes6;
ax1 = subplot(1,1,1);
grid on
ylim([0,inf]);
prop.b2 = gca;
ylabel('Occurence')
xlabel ('FRET')
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);



function disp_type_Callback(hObject, eventdata, handles)
% hObject    handle to disp_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_type as text
%        str2double(get(hObject,'String')) returns contents of disp_type as a double


% --- Executes during object creation, after setting all properties.
function disp_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rot_plots.
function rot_plots_Callback(hObject, eventdata, handles)
% hObject    handle to rot_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rot_plots


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton8


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton9
