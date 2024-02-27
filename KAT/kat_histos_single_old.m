function varargout = kat_histos_single(varargin)
% KAT_HISTOS_SINGLE MATLAB code for kat_histos_single.fig
%      KAT_HISTOS_SINGLE, by itself, creates a new KAT_HISTOS_SINGLE or raises the existing
%      singleton*.
%
%      H = KAT_HISTOS_SINGLE returns the handle to a new KAT_HISTOS_SINGLE or the handle to
%      the existing singleton*.
%
%      KAT_HISTOS_SINGLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAT_HISTOS_SINGLE.M with the given input arguments.
%
%      KAT_HISTOS_SINGLE('Property','Value',...) creates a new KAT_HISTOS_SINGLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kat_histos_single_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kat_histos_single_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kat_histos_single

% Last Modified by GUIDE v2.5 17-Feb-2019 16:01:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kat_histos_single_OpeningFcn, ...
                   'gui_OutputFcn',  @kat_histos_single_OutputFcn, ...
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


% --- Executes just before kat_histos_single is made visible.
function kat_histos_single_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kat_histos_single (see VARARGIN)

% Choose default command line output for kat_histos_single
handles.output = hObject;
set(handles.bins_lifetime,'String',num2str(20));
set(handles.bins_cps,'String',num2str(100));
set(handles.bins_tots,'String',num2str(100));
set(handles.overlay_res,'String',num2str(0.1));
set(handles.cps_cutoff,'String',num2str(1000));
set(handles.inten_cutoff,'String',num2str(500));
set(handles.end_hist,'String',num2str(2));
set(handles.mult_median,'String',num2str(1.5));
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kat_histos_single wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kat_histos_single_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
sel_index = get(handles.listbox2,'Value');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_single = getappdata(handles.load_traces, 'blch_single');

axes(handles.axes5)
bleachpoint = blch_single(sel_index);
don_sel = don_spec_trace(:,sel_index);
don_sel_blch = don_sel(1:bleachpoint);
time_axis_blch = time_axis(1:bleachpoint);
plot(time_axis,don_sel,'k',time_axis_blch,don_sel_blch,'g')
ylim([-10 (max(don_sel)*1.1)])

axes(handles.axes6)
coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
trace_filt = filtfilt(coeff, don_sel); 
plot(time_axis,trace_filt,'g')
ylim([-10 (max(don_sel)*1.1)])


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


% --- Executes on button press in load_traces.
function load_traces_Callback(hObject, eventdata, handles)
% hObject    handle to load_traces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  global Complete_SET
%  global num_files
%  global fname

[fname, ~] = uigetfile(); 
[path_trace,file_name] = fileparts(fname);
addpath(path_trace);
load(file_name)
set(handles.disp_filename,'String',file_name);
if filtered_data == 1
    set(handles.edit6,'String','Filtered KAT2 data')
end
time_ints = time_axis(2)-time_axis(1);
set(handles.disp_time_ints,'String', num2str(time_ints*1000));
setappdata(handles.load_traces,'time_ints',time_ints);
setappdata(handles.load_traces,'don_spec_trace',don_spec_trace);
set(handles.overlay_end,'String',num2str((time_axis(end))));

mult_intens = str2num(get(handles.mult_median,'String'));
max_intens = median(max(don_spec_trace));
max_intens = roundn(max_intens,3)*mult_intens;
min_intens = min(min(don_spec_trace));
if min_intens < 0
    min_intens = 0;
end
    
[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((1:num_traces)');
Complete_SET = 1:num_traces;
set(handles.listbox2, 'String', num_list_trace);
set(handles.disp_num_traces, 'String', num2str(num_traces));
over_res = str2num(get(handles.overlay_res,'String'));

    counter = 0;
    for i = 1: num_traces
       counter = counter + 1;
       don_spec_norm(:,i) = don_spec_trace(:,i)./max(don_spec_trace(:,i));
    end    
TR = 2;    
Index1 = 1;
Index2 = length(time_axis);
[time_bins,num_traces] = size(don_spec_norm);
counter = 0;
counter_inten = 0;

for j = 1:time_bins
    counter = counter+ 1;
    edges = [0:over_res:1];
   [a,b] = hist(don_spec_norm(j,:),edges);   
   a_h_t(counter,:) = a;  
end

for k = 1:time_bins
    counter_inten = counter_inten + 1;
    edges_intens = linspace(min_intens, max_intens, 10);
    [c,d] = hist(don_spec_trace(k,:),edges_intens);
    c_h_t(counter_inten,:) = c;
end

[a1,~] = size((a_h_t)');
re_hist = a_h_t';
counter2 = 0;
        for i = 1:a1
            counter2 = counter2+1;
            bar_count(counter2,:) = sum(re_hist(i,:));
        end
mol_tot = sum(a_h_t(1,:));
setappdata(handles.disp_num_traces,'mol_tot',mol_tot);

axes(handles.axes4)
contourf(time_axis(Index1:Index2), edges, a_h_t');
xlabel('Time (s)')
ylabel ('Norm Intensity')

title (['Total number of molecules = ',num2str(mol_tot)]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');

axes(handles.axes7)
contourf(time_axis(Index1:Index2), edges_intens, c_h_t');
ylabel ('Intensity')
c = colorbar ('northoutside');

setappdata(handles.load_traces, 'don_tot_trace', don_tot_trace);
setappdata(handles.load_traces, 'don_bckg_trace', don_bckg_trace);
setappdata(handles.load_traces, 'don_spec_trace', don_spec_trace);
setappdata(handles.load_traces, 'time_axis', time_axis);
setappdata(handles.load_traces, 'blch_single', blch_single);


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



function bins_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to bins_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bins_lifetime as text
%        str2double(get(hObject,'String')) returns contents of bins_lifetime as a double


% --- Executes during object creation, after setting all properties.
function bins_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bins_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bins_cps_Callback(hObject, eventdata, handles)
% hObject    handle to bins_cps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bins_cps as text
%        str2double(get(hObject,'String')) returns contents of bins_cps as a double


% --- Executes during object creation, after setting all properties.
function bins_cps_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bins_cps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function bins_tots_Callback(hObject, eventdata, handles)
% hObject    handle to bins_tots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bins_tots as text
%        str2double(get(hObject,'String')) returns contents of bins_tots as a double


% --- Executes during object creation, after setting all properties.
function bins_tots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bins_tots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in process_data.
function process_data_Callback(hObject, eventdata, handles)
% hObject    handle to process_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_single = getappdata(handles.load_traces, 'blch_single');
time_ints = getappdata(handles.load_traces,'time_ints');
[~,num_traces] = size(don_spec_trace);

bins_lifetime = str2num(get(handles.bins_lifetime,'String'));
bins_cps = str2num(get(handles.bins_cps,'String'));
bins_tots = str2num(get(handles.bins_tots,'String'));


counter = 0;
for i = 1:num_traces
    counter = counter+1;
    don_sel = don_spec_trace(:,i);    
    bleachpoint = blch_single(i);  
    don_lifetime(:,counter) = bleachpoint*time_ints;
    don_emms_tt = (don_sel(1:bleachpoint)');
    don_emms_t = sum(don_emms_tt);
    cps = bleachpoint*time_ints;
    don_emms(:,counter) = don_emms_t;
    don_cps(:,counter) = don_emms_t/cps; 
    don_sel_n = don_sel./max(don_sel);
    don_stdev(:,counter) = std(don_sel_n);
end
%lifetime
axes(handles.axes1)
don_lifetime_t = find(don_lifetime>0);
don_lifetime = don_lifetime(don_lifetime_t);
histfit(don_lifetime,bins_lifetime,'exponential')
prop_ax1 = gca;
prop_ax1.FontWeight = 'bold';
lifetime_fit = fitdist(don_lifetime','exponential');
set(handles.disp_life_fit,'String',num2str(lifetime_fit.mu));
% cps
axes(handles.axes2)
don_cps_t = find(don_cps>0);
don_cps = don_cps(don_cps_t);
histogram(don_cps,bins_cps)
prop.ax2 = gca;
prop.ax2.FontWeight = 'bold';
% counts per trace
axes(handles.axes3)
don_stdev_t = find(don_stdev >0);
don_stdev = don_stdev(don_stdev_t);
histogram(don_stdev,bins_tots)
%cpt_fit = fitdist(don_emms','gev');
stdev_fit = fitdist(don_stdev','gev');
prop.ax3 = gca;
prop.ax3.FontWeight = 'bold';
set(handles.disp_cpt,'String',num2str(stdev_fit.mu));
% histogram(don_emms,bins_tots)
setappdata(handles.run_gmm,'don_lifetime',don_lifetime);
setappdata(handles.run_gmm,'don_cps',don_cps);
setappdata(handles.run_gmm,'don_tots',don_stdev);




function disp_time_ints_Callback(hObject, eventdata, handles)
% hObject    handle to disp_time_ints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_time_ints as text
%        str2double(get(hObject,'String')) returns contents of disp_time_ints as a double


% --- Executes during object creation, after setting all properties.
function disp_time_ints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_time_ints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_gmm.
function run_gmm_Callback(hObject, eventdata, handles)
% hObject    handle to run_gmm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
don_lifetime = getappdata(handles.run_gmm,'don_lifetime');
don_cps = getappdata(handles.run_gmm,'don_cps');
don_tots = getappdata(handles.run_gmm,'don_tots');
file_sel_hist = don_lifetime;
filename = get(handles.disp_filename,'String');
save([filename,'_lifetime.mat'],'file_sel_hist');

file_sel_hist = don_cps;
save([filename,'_cps.mat'],'file_sel_hist');

file_sel_hist = don_tots;
save([filename,'_tot.mat'],'file_sel_hist');

run kat_GMM


% --- Executes on button press in exp_figs.
function exp_figs_Callback(hObject, eventdata, handles)
% hObject    handle to exp_figs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
bar_count = getappdata(handles.run_filter,'bar_count');
bar_count2 = getappdata(handles.run_filter,'bar_count3');
bar_counti = getappdata(handles.run_filter,'bar_counti');
bar_count2i = getappdata(handles.run_filter,'bar_count3i');
edges = getappdata(handles.run_filter,'edges');
Index1 = getappdata(handles.run_filter,'start_overlay');
Index2 = getappdata(handles.run_filter,'end_overlay');
edges = getappdata(handles.run_filter,'edges');
a_h_t = getappdata(handles.run_filter,'a_h_t');
c_h_t = getappdata(handles.run_filter,'c_h_t');
time_axis = getappdata(handles.run_filter,'time_axis');
edges_intens = getappdata(handles.run_filter,'edges_intens');

fig1 = figure(7);
set(fig1,'units','normalized','position', [0.1, 0.2, 0.85, 0.7])
ax1=subplot(2,1,1);
a1 = handles.axes5;
prop.a1 = gca;
xlabel('Time (s)')
ylabel('Donor')
grid on
ylim([0,inf]);
prop.a1.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

ax3=subplot(2,1,2);
a3 = handles.axes4;
prop.a2 = gca;
xlabel('Time (s)')
ylabel('Overlay')
grid on
mol_tot = getappdata(handles.disp_num_traces,'mol_tot');
title (['Total number of molecules = ', mol_tot]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');
prop.a2.FontWeight = 'bold';
copyobj(allchild(a3),ax3);

fig2 = figure(8);
life_fit = get(handles.disp_life_fit,'String');
set(fig2,'units','normalized','position', [0.1, 0.2, 0.7, 0.3])
ax1=subplot(1,3,1);
a1 = handles.axes1;
prop.ax1 = gca;
xlabel('Time (s)')
ylabel('occurence')
title(['Lifetime Distribution ' life_fit ' sec'])
grid on
prop.ax1.FontWeight = 'bold';
copyobj(allchild(a1),ax1);

ax2=subplot(1,3,2);
a2 = handles.axes2;
prop.ax2 = gca;
xlabel('CPS')
ylabel('Occurence')
title('CPS Distribution')
grid on
prop.ax2.FontWeight = 'bold';
copyobj(allchild(a2),ax2);

ax3=subplot(1,3,3);
a3 = handles.axes3;
prop.ax3 = gca;
xlabel('Intensity')
ylabel('Occurence')
grid on
cpt_fit = get(handles.disp_cpt,'String');
title(['Intensity Distribution  ' cpt_fit ])
prop.ax3.FontWeight = 'bold';
copyobj(allchild(a3),ax3);


%% edit this section
fig1 = figure(2);
set(fig1,'units','normalized','position', [0.1, 0.2, 0.8, 0.22])
subplot(1,5,[1 2 3 4]),contourf(time_axis(Index1:Index2), edges, a_h_t');
prop.a2 = gca;
xlabel('Time (s)')
ylabel ('Norm Intensity')
title (['Total number of molecules = ',num2str(mol_tot)]);
prop.a2.FontWeight = 'bold';

subplot(1,5,5)
barh(edges', bar_counti, 'histc')
ylim1 = edges(1);
ylim2 = edges(end);
ylim([ylim1 ylim2]);
title('Histogram')
xlabel('Number of Events')

fig2 = figure(3);
set(fig2,'units','normalized','position', [0.1, 0.2, 0.8, 0.22])
subplot(1,5,[1 2 3 4]),contourf(time_axis(Index1:Index2), edges_intens, c_h_t');
prop.a2 = gca;
xlabel('Time (s)')
ylabel ('Intensity')
title (['Total number of molecules = ',num2str(mol_tot)]);
prop.a2.FontWeight = 'bold';

subplot(1,5,5)
barh(edges_intens', bar_count2i, 'histc')
ylim1i = edges_intens(1);
ylim2i = edges_intens(end);
ylim([ylim1i ylim2i]);
title('Histogram')
xlabel('Number of Events')


function disp_life_fit_Callback(hObject, eventdata, handles)
% hObject    handle to disp_life_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_life_fit as text
%        str2double(get(hObject,'String')) returns contents of disp_life_fit as a double


% --- Executes during object creation, after setting all properties.
function disp_life_fit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_life_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_cpt_Callback(hObject, eventdata, handles)
% hObject    handle to disp_cpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_cpt as text
%        str2double(get(hObject,'String')) returns contents of disp_cpt as a double


% --- Executes during object creation, after setting all properties.
function disp_cpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_cpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_analysis.
function run_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to run_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
clear
clear global
clc
kat_histos_single



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


% --- Executes on button press in qik_guide.
function qik_guide_Callback(hObject, eventdata, handles)
% hObject    handle to qik_guide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
helpdlg({'Quick Step Guide:','This Module is for Analysis of Single-Color or Dye Analysis',...
         '1) To Process Data, Load Selected Traces from KAT2','2) Click "Process"',...
         '3) Click on Trace Number to see the Plots ','4) Click Export Figures to get Figures for Output',...
         '5) Click Run GMM and Select to Fit either the CPS or Total Intensity ','6) Can Change Overlay resolution on Y-axis (change Y-axis bin interval)',...
         '7) Files saved as filename and appendix when click Run GMM'},...
        'KAT2: Help');


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3
sel_index = get(handles.listbox3,'Value');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_single = getappdata(handles.load_traces, 'blch_single');

axes(handles.axes5)
bleachpoint = blch_single(sel_index);
don_sel = don_spec_trace(:,sel_index);
don_sel_blch = don_sel(1:bleachpoint);
time_axis_blch = time_axis(1:bleachpoint);
plot(time_axis,don_sel,'k',time_axis_blch,don_sel_blch,'g')
ylim([-10 (max(don_sel)*1.1)])

axes(handles.axes6)
coeff = designfilt('lowpassfir', 'PassbandFrequency', .01, 'StopbandFrequency', .55, 'PassbandRipple', 1, 'StopbandAttenuation', 60, 'DesignMethod', 'kaiserwin');
trace_filt = filtfilt(coeff, don_sel); 
plot(time_axis,trace_filt,'g')
ylim([-10 (max(don_sel)*1.1)])

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



function mult_median_Callback(hObject, eventdata, handles)
% hObject    handle to mult_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mult_median as text
%        str2double(get(hObject,'String')) returns contents of mult_median as a double


% --- Executes during object creation, after setting all properties.
function mult_median_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mult_median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_num_filt_Callback(hObject, eventdata, handles)
% hObject    handle to disp_num_filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_num_filt as text
%        str2double(get(hObject,'String')) returns contents of disp_num_filt as a double


% --- Executes during object creation, after setting all properties.
function disp_num_filt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_num_filt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cps_cutoff_Callback(hObject, eventdata, handles)
% hObject    handle to cps_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cps_cutoff as text
%        str2double(get(hObject,'String')) returns contents of cps_cutoff as a double


% --- Executes during object creation, after setting all properties.
function cps_cutoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cps_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inten_cutoff_Callback(hObject, eventdata, handles)
% hObject    handle to inten_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inten_cutoff as text
%        str2double(get(hObject,'String')) returns contents of inten_cutoff as a double


% --- Executes during object creation, after setting all properties.
function inten_cutoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inten_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_filter.
function run_filter_Callback(hObject, eventdata, handles)
% hObject    handle to run_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cps_cutoff = str2num(get(handles.cps_cutoff,'String'));
inten_cutoff = str2num(get(handles.inten_cutoff,'String'));
h=get(handles.uibuttongroup1,'SelectedObject');
don_spec_trace = getappdata(handles.load_traces, 'don_spec_trace');
time_axis = getappdata(handles.load_traces, 'time_axis');
blch_single = getappdata(handles.load_traces, 'blch_single');
time_ints = getappdata(handles.load_traces,'time_ints');
[~,num_traces] = size(don_spec_trace);
bins_lifetime = str2num(get(handles.bins_lifetime,'String'));
bins_cps = str2num(get(handles.bins_cps,'String'));
bins_tots = str2num(get(handles.bins_tots,'String'));

filt_type = get(h,'String');
switch filt_type
    case {'CPS'}
        cps_filt = 1; 
        intens_filt = 0;
    case {'Intensity'}
        cps_filt = 0;
        intens_filt = 1;
    case {'Both'}
        cps_filt = 1;
        intens_filt = 1;
end

counter = 0;
for i = 1:num_traces
    counter = counter+1;
    don_sel = don_spec_trace(:,i);    
    bleachpoint = blch_single(i);      
    don_emms_tt = (don_sel(1:bleachpoint)');
    don_emms_t = sum(don_emms_tt);
    cps = bleachpoint*time_ints;    
    don_cps_t = don_emms_t/cps;
    don_sel_n = don_sel./max(don_sel);
    
    
        if cps_filt ==1 && intens_filt == 0
            if don_cps_t >=cps_cutoff                
                don_cps(:,counter) = don_cps_t;
                don_cps_pre(:,i) = don_cps_t;
                don_lifetime(:,counter) = bleachpoint*time_ints;
                don_emms(:,counter) = don_emms_t; 
                don_stdev(:,counter) = std(don_sel_n);
            end
        end
        
        if cps_filt ==0 && intens_filt == 1
            if don_sel(1:10,:)/10 >=inten_cutoff
                don_cps(:,counter) = don_cps_t;
                don_cps_pre(:,i) = don_cps_t;
                don_lifetime(:,counter) = bleachpoint*time_ints;
                don_emms(:,counter) = don_emms_t;
                don_stdev(:,counter) = std(don_sel_n);
            end
        end
        
        if cps_filt == 1 && intens_filt ==1
            if don_sel(1:10,:)/10 >=inten_cutoff 
                if don_cps_t >=cps_cutoff 
                don_cps(:,counter) = don_cps_t;
                don_cps_pre(:,i) = don_cps_t;
                don_lifetime(:,counter) = bleachpoint*time_ints;
                don_emms(:,counter) = don_emms_t;
                don_stdev(:,counter) = std(don_sel_n);
                end
            end
        end                
end
%lifetime
axes(handles.axes1)
don_lifetime_t = find(don_lifetime>0);
don_lifetime = don_lifetime(don_lifetime_t);
histfit(don_lifetime,bins_lifetime,'exponential')
prop_ax1 = gca;
prop_ax1.FontWeight = 'bold';
lifetime_fit = fitdist(don_lifetime','exponential');
set(handles.disp_life_fit,'String',num2str(lifetime_fit.mu));
% cps
axes(handles.axes2)
don_cps_t = find(don_cps>0);
don_cps_pre_t = find(don_cps_pre>0);
don_cps = don_cps(don_cps_t);
histogram(don_cps,bins_cps)
prop.ax2 = gca;
prop.ax2.FontWeight = 'bold';
% counts per trace
axes(handles.axes3)
% don_emms_t = find(don_emms >0);
% don_emms = don_emms(don_emms_t);
% histogram(don_emms,bins_tots)
% cpt_fit = fitdist(don_emms','gev');
% prop.ax3 = gca;
% prop.ax3.FontWeight = 'bold';
% set(handles.disp_cpt,'String',num2str(cpt_fit.mu));
% histogram(don_emms,bins_tots)
don_stdev_t = find(don_stdev >0);
don_stdev = don_stdev(don_stdev_t);
histogram(don_stdev,bins_tots)
%cpt_fit = fitdist(don_emms','gev');
stdev_fit = fitdist(don_stdev','gev');
prop.ax3 = gca;
prop.ax3.FontWeight = 'bold';
set(handles.disp_cpt,'String',num2str(stdev_fit.mu));

setappdata(handles.run_gmm,'don_lifetime',don_lifetime);
setappdata(handles.run_gmm,'don_cps',don_cps);
setappdata(handles.run_gmm,'don_tots',don_stdev);
mult_intens = str2num(get(handles.mult_median,'String'));
max_intens = median(max(don_spec_trace));
max_intens = roundn(max_intens,3)*mult_intens;
min_intens = min(min(don_spec_trace));
if min_intens < 0
    min_intens = 0;
end

for m = 1:length(don_cps_pre_t)
    don_spec_trace_t(:,m) = don_spec_trace(:,(don_cps_pre_t(m)));
end
don_spec_trace = don_spec_trace_t;

[~, num_traces] = size(don_spec_trace);
num_list_trace = num2str ((don_cps_pre_t)');
Complete_SET = 1:num_traces;
set(handles.listbox3, 'String', num_list_trace);
set(handles.disp_num_filts, 'String', num2str(num_traces));
over_res = str2num(get(handles.overlay_res,'String'));

    counter = 0;
    for i = 1: num_traces
       counter = counter + 1;
       don_spec_norm(:,i) = don_spec_trace(:,i)./max(don_spec_trace(:,i));
    end    
%% input set end time
Index1 = 1;
Index2_t = str2num(get(handles.overlay_end,'String'));
Index2 = find(time_axis == Index2_t);
hist_end_t = str2num(get(handles.end_hist,'String'));
hist_end = find(time_axis == hist_end_t);
don_spec_norm_t = don_spec_norm(Index1:Index2,1);
% Index2 = length(time_axis);
[time_bins,~] = size(don_spec_norm_t);
counter = 0;
counter_inten = 0;
for j = 1:time_bins
    counter = counter+ 1;
    edges = [0:over_res:1];
   [a,b] = hist(don_spec_norm(j,:),edges);   
   a_h_t(counter,:) = a;  
end

for j = 1:hist_end
    counter = counter+ 1;
    edges = [0:over_res:1];
   [a,b] = hist(don_spec_norm(j,:),edges);   
   a2_h_t(counter,:) = a;  
end

for k = 1:time_bins
    counter_inten = counter_inten + 1;
    edges_intens = linspace(min_intens, max_intens, 10);
    [c,d] = hist(don_spec_trace(k,:),edges_intens);
    c_h_t(counter_inten,:) = c;
end

for k = 1:hist_end
    counter_inten = counter_inten + 1;
    edges_intens = linspace(min_intens, max_intens, 10);
    [c,d] = hist(don_spec_trace(k,:),edges_intens);
    c2_h_t(counter_inten,:) = c;
end

[a1,~] = size((a_h_t)');
[c1,~] = size((c_h_t)');
[a2,~] = size((a2_h_t)');
[c2,~] = size((c2_h_t)');
re_hist = a_h_t';
re_histi = a2_h_t';
re_hist2 = c_h_t';
re_hist2i = c2_h_t';

        counter2 = 0;
        for i = 1:a1
            counter2 = counter2+1;
            bar_count(counter2,:) = sum(re_hist(i,:));
        end
        
        counter2 = 0;
        for i = 1:a2
            counter2 = counter2+1;
            bar_counti(counter2,:) = sum(re_histi(i,:));
        end
        
        
        counter3 = 0;
        for k = 1:c1
            counter3 = counter3+1;
            bar_count3(counter3,:) = sum(re_hist2(k,:));
        end
        
        counter3 = 0;
        for k = 1:c2
            counter3 = counter3+1;
            bar_count3i(counter3,:) = sum(re_hist2i(k,:));
        end
        
        mol_tot = sum(a_h_t(1,:));
axes(handles.axes4)
contourf(time_axis(Index1:Index2), edges, a_h_t');
xlabel('Time (s)')
ylabel ('Norm Intensity')
title (['Total number of molecules = ',num2str(mol_tot)]);
c = colorbar ('northoutside');
set(get(c,'title'),'string','Number of Molecules');

axes(handles.axes7)
contourf(time_axis(Index1:Index2), edges_intens, c_h_t');
ylabel ('Intensity')
c = colorbar ('northoutside');

axes(handles.axes8)
barh(edges', bar_counti, 'histc')
ylim1 = edges(1);
ylim2 = edges(end);
ylim([ylim1 ylim2]);
title('Histogram')
xlabel('Number of Events')

axes (handles.axes9)
f = fit(edges_intens',bar_count3i,'gauss1');
set(handles.disp_hist,'String',num2str(f.b1));
barh(edges_intens', bar_count3i, 'histc')
ylim1i = edges_intens(1);
ylim2i = edges_intens(end);
ylim([ylim1i ylim2i]);
title('Histogram')
xlabel('Number of Events')

start_overlay = Index1;
end_overlay = Index2;
setappdata(handles.run_filter,'bar_count',bar_count);
setappdata(handles.run_filter,'bar_count3',bar_count3);
setappdata(handles.run_filter,'bar_counti',bar_counti);
setappdata(handles.run_filter,'bar_count3i',bar_count3i);
setappdata(handles.run_filter,'edges',edges);
setappdata(handles.run_filter,'edges_intens',edges_intens);
setappdata(handles.run_filter,'a_h_t',a_h_t);
setappdata(handles.run_filter,'c_h_t',c_h_t);
setappdata(handles.run_filter,'start_overlay',start_overlay);
setappdata(handles.run_filter,'end_overlay',end_overlay);
setappdata(handles.run_filter,'time_axis',time_axis);
setappdata(handles.disp_num_traces,'mol_tot',mol_tot);

function disp_num_filts_Callback(hObject, eventdata, handles)
% hObject    handle to disp_num_filts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_num_filts as text
%        str2double(get(hObject,'String')) returns contents of disp_num_filts as a double


% --- Executes during object creation, after setting all properties.
function disp_num_filts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_num_filts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_new.
function save_new_Callback(hObject, eventdata, handles)
% hObject    handle to save_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function overlay_end_Callback(hObject, eventdata, handles)
% hObject    handle to overlay_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of overlay_end as text
%        str2double(get(hObject,'String')) returns contents of overlay_end as a double


% --- Executes during object creation, after setting all properties.
function overlay_end_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overlay_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function end_hist_Callback(hObject, eventdata, handles)
% hObject    handle to end_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of end_hist as text
%        str2double(get(hObject,'String')) returns contents of end_hist as a double


% --- Executes during object creation, after setting all properties.
function end_hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to end_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_hist_Callback(hObject, eventdata, handles)
% hObject    handle to disp_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_hist as text
%        str2double(get(hObject,'String')) returns contents of disp_hist as a double


% --- Executes during object creation, after setting all properties.
function disp_hist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fit_hist.
function fit_hist_Callback(hObject, eventdata, handles)
% hObject    handle to fit_hist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fit_hist
