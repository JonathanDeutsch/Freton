function varargout = kat_GMM(varargin)
% KAT_GMM MATLAB code for kat_GMM.fig
%      KAT_GMM, by itself, creates a new KAT_GMM or raises the existing
%      singleton*.
%
%      H = KAT_GMM returns the handle to a new KAT_GMM or the handle to
%      the existing singleton*.
%
%      KAT_GMM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_GMM.M with the given input arguments.
%
%      KAT_GMM('Property','Value',...) creates a new KAT_GMM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_GMM_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_GMM_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_GMM

% Last Modified by GUIDE v2.5 30-May-2022 12:31:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_GMM_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_GMM_OutputFcn, ...
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


% --- Executes just before kat_GMM is made visible.
function kat_GMM_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_GMM (see VARARGIN)

% Choose default command line output for kat_GMM
handles.output = hObject;

set(handles.set_num_bins,'String',num2str(50));
set(handles.set_num_comp, 'String', num2str(6));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_GMM wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_GMM_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in load_data.
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, ~] = uigetfile(); 
[path_hist,file_name] = fileparts(fname);
addpath(path_hist);
data=load(file_name);
file_sel_hist = data.file_sel_hist;
[~,num_hist_data] = size(file_sel_hist);
set(handles.disp_num_vals,'String',num2str(num_hist_data));
setappdata(handles.load_data,'file_sel_hist',file_sel_hist);
set(handles.disp_file_name,'String',file_name);
setappdata(handles.load_data,'filename',file_name);
display_data_Callback(hObject, eventdata, handles)



function disp_file_name_Callback(hObject, eventdata, handles)
% hObject    handle to disp_file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_file_name as text
%        str2double(get(hObject,'String')) returns contents of disp_file_name as a double


% --- Executes during object creation, after setting all properties.
function disp_file_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_file_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_num_comp_Callback(hObject, eventdata, handles)
% hObject    handle to set_num_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_num_comp as text
%        str2double(get(hObject,'String')) returns contents of set_num_comp as a double




% --- Executes during object creation, after setting all properties.
function set_num_comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_num_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in export_hist.
function export_hist_Callback(hObject, eventdata, handles)
% hObject    handle to export_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig = figure();
set(fig,'units','normalized','position', [0.1, 0.2, 0.8, 0.4])
ax1 = subplot(1,1,1);
ax1(1).LineWidth = 1.25;
a1 = handles.axes1;
xlabel('FRET')
ylabel('Distribution')
grid on
ylim([0,inf]);
xlim([0 1]);
prop.b2 = gca;
ylabel('Occurence')
title('Gaussian Mixture Model')
sel_type = get(handles.uibuttongroup1,'SelectedObject');
type_data = sel_type.String;
switch type_data
    case {'FRET Histogram'}
        xlabel ('FRET')
    case {'Intensity Histogram'}
        xlabel ('CPS')
    case {'Arbitrary Histogram'}
        xlabel ('Arbitrary')
end
prop.b2.FontWeight = 'bold';
copyobj(allchild(a1),ax1);
hist_plot2 = get(handles.hist_axis_rot,'Value');
if hist_plot2 == 1
    set(fig,'units','normalized','position', [0.1, 0.2, 0.4, 0.4]);
    set(fig,view([90 -90]));
end


% --- Executes on button press in export_aic.
function export_aic_Callback(hObject, eventdata, handles)
% hObject    handle to export_aic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig = figure();
set(fig,'units','normalized','position', [0.1, 0.2, 0.8, 0.7])
ax2 = subplot(1,1,1);
a2 = handles.axes2;
xlabel('Components')
ylabel('AIC')
grid on
ylim([0,inf]);
copyobj(allchild(a2),ax2);



function set_num_bins_Callback(hObject, eventdata, handles)
% hObject    handle to set_num_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_num_bins as text
%        str2double(get(hObject,'String')) returns contents of set_num_bins as a double


% --- Executes during object creation, after setting all properties.
function set_num_bins_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_num_bins (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in display_data.
function display_data_Callback(hObject, eventdata, handles)
% hObject    handle to display_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_type_t = get(handles.hist_type_plot,'SelectedObject');
plot_type = plot_type_t.String;
num_bins = str2double(get(handles.set_num_bins,'String'));  
file_sel_hist = getappdata(handles.load_data,'file_sel_hist')';
axes(handles.axes1)
edges = linspace(0,1,num_bins);


switch plot_type
    case {'Histograms'}
        hist_plot1 = get(handles.hist_fc_clear,'Value');        
        if hist_plot1 == 1
        histogram(file_sel_hist,'BinEdges',edges,'FaceColor','none','LineWidth',1.5);        
        else
        histogram(file_sel_hist,'BinEdges',edges);         
        end      
        
    case {'Kernel density'}
        ksdensity(file_sel_hist,edges)        
end

prop.b2 = gca;
ylabel('Occurence')

sel_type = get(handles.uibuttongroup1,'SelectedObject');
type_data = sel_type.String;
switch type_data
    case {'FRET Histogram'}
        xlabel ('FRET')
    case {'Intensity Histogram'}
        xlabel ('CPS')
    case {'Arbitrary Histogram'}
        xlabel ('Arbitrary')
end
prop.b2.FontWeight = 'bold';

hist_plot2 = get(handles.hist_axis_rot,'Value');
if hist_plot2 == 1
set(gca,view([90 -90])) 
end


% --- Executes on button press in data_fit.
function data_fit_Callback(hObject, eventdata, handles)
% hObject    handle to data_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
output_table = [];
j=[];
k=[];
numComponents = [];
C = str2double(get(handles.set_num_comp, 'String'));
num_bins = str2double(get(handles.set_num_bins,'String'));
data = getappdata(handles.load_data,'file_sel_hist');
h = msgbox('Fitting Data: Please Wait...');
maxIterations = 5000;
X = data; % this particular dataset is loaded as a struct 
[~, n] = size(X);
numData = n;
X = X.';
setAIC = true; % boolean: get the best model using AIC scoring on 1 to C number of mixtures
regularize = true;
[numComponents, BestModel, AIC,reg_AIC] = kat_gaussian_mixture_model(X, C, maxIterations, setAIC,regularize); % run GMM
% plot the results
xmin = min(X);
xmax = max(X);
edges = linspace(0,1,num_bins);
[counts, bins] = hist(X,edges);
est_pdf = counts / sum(counts * mean(diff(bins)));
pd = BestModel;
x_pdf = linspace(xmin, xmax, 1000);
y_pdf = pdf(pd, x_pdf');

axes(handles.axes1)
cla
hold on;
plot_type_t = get(handles.hist_type_plot,'SelectedObject');
plot_type = plot_type_t.String;
num_bins = str2double(get(handles.set_num_bins,'String'));  
file_sel_hist = getappdata(handles.load_data,'file_sel_hist')';
edges = linspace(0,1,num_bins);
switch plot_type
    case {'Histograms'}
        hist_plot1 = get(handles.hist_fc_clear,'Value');        
        if hist_plot1 == 1
        bar(bins, est_pdf, 'FaceColor', 'none', 'LineWidth',1.15);      
        else
        bar(bins, est_pdf, 'LineWidth',1.15);         
        end 
    case {'Kernel density'}
        ksdensity(file_sel_hist,edges)        
end
plot(x_pdf, y_pdf, '-r', 'Linewidth', 2);
xlim([0 1])
% plot the individual components
for j=1:numComponents
    plot(x_pdf, BestModel.PComponents(j) * normpdf(x_pdf, BestModel.mu(j), sqrt(BestModel.Sigma(j))), 'Linewidth', 2)
end
title('Gaussian Mixture Model')
xlim([0 1])
hold off;

hist_plot2 = get(handles.hist_axis_rot,'Value');
if hist_plot2 == 1
set(gca,view([90 -90])) 
end

counter=0;
for k=1:numComponents
    counter = counter +1;
    pcomponents_t(:,counter) = BestModel.PComponents(k);
    best_mean_t(:,counter) = BestModel.mu(k);
    best_sigma_t(:,counter) = sqrt(BestModel.Sigma(k));
end
[best_mean,bmi] = sort(best_mean_t);
pcomponents= pcomponents_t(bmi);
best_sigma = best_sigma_t(bmi);
set(handles.disp_best_model,'String',num2str(numComponents));

% plot the AIC curve if specified
axes(handles.axes2)
cla
if setAIC == true    
    plot(1:C, AIC)
    title('AIC Curve')
end
axes(handles.axes3);
if regularize == true
    plot([0.01, 0.001, 0.0001, 0.00001, 0.000001], reg_AIC)
    title('Regularization AIC curve')
end
%Assemble table of values
output_table(1,:) = best_mean;
output_table(2,:) = best_sigma;
output_table(3,:) = pcomponents;
set(handles.uitable3,'data',output_table)
axes(handles.axes4)
bar(pcomponents)
close (h)



function disp_best_model_Callback(hObject, eventdata, handles)
% hObject    handle to disp_best_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_best_model as text
%        str2double(get(hObject,'String')) returns contents of disp_best_model as a double


% --- Executes during object creation, after setting all properties.
function disp_best_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_best_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_mu_Callback(hObject, eventdata, handles)
% hObject    handle to disp_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_mu as text
%        str2double(get(hObject,'String')) returns contents of disp_mu as a double


% --- Executes during object creation, after setting all properties.
function disp_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_mu_err_Callback(hObject, eventdata, handles)
% hObject    handle to disp_mu_err (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_mu_err as text
%        str2double(get(hObject,'String')) returns contents of disp_mu_err as a double


% --- Executes during object creation, after setting all properties.
function disp_mu_err_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_mu_err (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to disp_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_sigma as text
%        str2double(get(hObject,'String')) returns contents of disp_sigma as a double


% --- Executes during object creation, after setting all properties.
function disp_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_sigma_err_Callback(hObject, eventdata, handles)
% hObject    handle to disp_sigma_err (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_sigma_err as text
%        str2double(get(hObject,'String')) returns contents of disp_sigma_err as a double


% --- Executes during object creation, after setting all properties.
function disp_sigma_err_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_sigma_err (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function disp_comp_Callback(hObject, eventdata, handles)
% hObject    handle to disp_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_comp as text
%        str2double(get(hObject,'String')) returns contents of disp_comp as a double


% --- Executes during object creation, after setting all properties.
function disp_comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_comp_err_Callback(hObject, eventdata, handles)
% hObject    handle to disp_comp_err (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_comp_err as text
%        str2double(get(hObject,'String')) returns contents of disp_comp_err as a double


% --- Executes during object creation, after setting all properties.
function disp_comp_err_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_comp_err (see GCBO)
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



function disp_num_vals_Callback(hObject, eventdata, handles)
% hObject    handle to disp_num_vals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_num_vals as text
%        str2double(get(hObject,'String')) returns contents of disp_num_vals as a double


% --- Executes during object creation, after setting all properties.
function disp_num_vals_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_num_vals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in new_anal.
function new_anal_Callback(hObject, eventdata, handles)
% hObject    handle to new_anal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
clear all
close all
run kat_GMM


% --- Executes on button press in exp_xls.
function exp_xls_Callback(hObject, eventdata, handles)
% hObject    handle to exp_xls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_exp = get(handles.uitable3, 'data');
filename_t = getappdata(handles.load_data,'filename');
filename = [filename_t,'.xls'];
xlswrite(filename,data_exp);


% --- Executes on button press in qik_guide1.
function qik_guide1_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','FRET Traces to Histograms',...
         '1) Set number of Bins and Press Display Data Show Histogram','2)Select Nature of Data from options below'},...
        'KAT2-GMM: Help');


% --- Executes on button press in qik_guide2.
function qik_guide2_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','FRET Traces to Histograms',...
         '1) First Overfit Data to generate an AIC that will plateau','2)Select Optimal number of Components and "Fit Data" Again','3) Export Fitted Data and Excel sheet of Values'},...
        'KAT2-Histograms: Help');


% --- Executes on button press in hist_fc_clear.
function hist_fc_clear_Callback(hObject, eventdata, handles)
% hObject    handle to hist_fc_clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hist_fc_clear

% --- Executes on button press in hist_axis_rot.
function hist_axis_rot_Callback(hObject, eventdata, handles)
% hObject    handle to hist_axis_rot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of hist_axis_rot

% --- Executes on button press in exp_vals.
function exp_vals_Callback(hObject, eventdata, handles)
% hObject    handle to exp_vals (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_exp = get(handles.uitable3, 'data');
file_sel_hist = getappdata(handles.load_data,'file_sel_hist');
filename_t = getappdata(handles.load_data,'filename');
save([filename_t,'gmm_export.mat'],'data_exp','file_sel_hist');
msgbox([filename_t,'gmm_export.mat'], 'GMM Export')


% --- Executes on button press in go_global_fit.
function go_global_fit_Callback(hObject, eventdata, handles)
% hObject    handle to go_global_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hist_comp.
function hist_comp_Callback(hObject, eventdata, handles)
% hObject    handle to hist_comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run kat_hist_comp_v2
