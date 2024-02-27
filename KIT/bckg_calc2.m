function varargout = bckg_calc2(varargin)
% BCKG_CALC2 MATLAB code for bckg_calc2.fig
%      BCKG_CALC2, by itself, creates a new BCKG_CALC2 or raises the existing
%      singleton*.
%
%      H = BCKG_CALC2 returns the handle to a new BCKG_CALC2 or the handle to
%      the existing singleton*.
%
%      BCKG_CALC2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BCKG_CALC2.M with the given input arguments.
%
%      BCKG_CALC2('Property','Value',...) creates a new BCKG_CALC2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bckg_calc2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bckg_calc2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bckg_calc2

% Last Modified by GUIDE v2.5 17-Jun-2019 13:05:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bckg_calc2_OpeningFcn, ...
                   'gui_OutputFcn',  @bckg_calc2_OutputFcn, ...
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


% --- Executes just before bckg_calc2 is made visible.
function bckg_calc2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bckg_calc2 (see VARARGIN)

% Choose default command line output for bckg_calc2
handles.output = hObject;

%% Start the opening function Code
global image_dt
global image_at
global channel
global centers_d
global radii_d
global centers_a
global radii_a
global centers_bckg
global radii_bckg
global frame_end
global image_bckg
global type_auto_bckg
load ('bckg.mat')

if exist('abs_bckg_val') == 0
    abs_bckg_val = 0;    
end


set(handles.channel,'String',channel);
set(handles.op_mode,'String',type_auto_bckg)
switch channel
    case {'donor'}
    image_bckg = image_dt;
    centers_bckg = centers_d;
    radii_bckg = radii_d;  
    [~,~,frame_end] = size(image_dt);
    
    case{'acceptor'}
    image_bckg = image_at;  
    centers_bckg = centers_a;
    radii_bckg = radii_a;
    [~,~,frame_end] = size(image_at);
end
axes(handles.axes1)
imagesc(image_bckg(:,:,1));
axes(handles.axes2)
imagesc(image_bckg(:,:,end));
trace_len = ones(frame_end,1);
counter_out_range = 0;
for i = 1:length(radii_bckg)
            rtd = round(radii_bckg(i));
            % get the center
            ind_dfe = centers_bckg(i,:);
            % index on the donor x   
            ind_dfex = ind_dfe(:,2);
            ind_dfexp = ind_dfex + rtd;
            ind_dfexm = ind_dfex - rtd;
            ind_dfext = [ind_dfexm:ind_dfexp];
            % index on the donor y
            ind_dfey = ind_dfe(:,1);
            ind_dfeyp = ind_dfey + rtd;
            ind_dfeym = ind_dfey - rtd;
            ind_dfeyt = [ind_dfeym:ind_dfeyp];
            % compute donor traces  
            %% insert loop here for the last 5 frames to average
            counter_bckg = 0;            
            for k = frame_end:-1:frame_end-4
                counter_bckg = counter_bckg +1;
                image_d_t_bckg = image_bckg(ind_dfext,ind_dfeyt,k);
                bckg_spots_process_tt(:,counter_bckg) = sum(sum(image_d_t_bckg));                
            end
            bckg_spots_process_t(:,i) = mean(bckg_spots_process_tt);
            counter_spot = 0;
            for j = 1:5
                counter_spot = counter_spot +1;
                image_d_t_spot = image_bckg(ind_dfext,ind_dfeyt,j);
                image_d_t_spot_tt(:,counter_spot) = sum(sum(image_d_t_spot));
            end
            image_d_t_spot_t(:,i) = mean(image_d_t_spot_tt);
            %Assess values that are out of range
            if bckg_spots_process_t(:,i)>=image_d_t_spot_t(:,i)
                counter_out_range = counter_out_range + 1;
                image_d_t_spot_t(:,i) = bckg_spots_process_t(:,i);
            end
end
median_nonspecs = median(bckg_spots_process_t);
set(handles.median_last,'String',num2str(median_nonspecs));
median_first = median(image_d_t_spot_t);
set(handles.median_first,'String',num2str(median_first));

for i = 1:length(bckg_spots_process_t)
    if bckg_spots_process_t(:,i)>=image_d_t_spot_t(:,i)*1.25
        if abs_bckg_val ==0
            bckg_spots_process_t(:,i) = median_nonspecs;        
        end                
    end
end
count_remains = 0; 
for i = 1:length(bckg_spots_process_t)
    if bckg_spots_process_t(:,i)>=image_d_t_spot_t(:,i)*1.25
        count_remains = count_remains + 1;            
    end
end

%Assemble table of values
output_table(:,1) = counter_out_range;
output_table(:,2) = median_nonspecs;
output_table(:,3) = count_remains;
set(handles.uitable1,'data',output_table);

axes(handles.axes4)
image_d_t_spot_t_ind = find(image_d_t_spot_t > 0);
image_d_t_spot_t = image_d_t_spot_t(image_d_t_spot_t_ind);
set(handles.num_el_first,'String',num2str(numel(image_d_t_spot_t)));
histogram(image_d_t_spot_t, min(image_d_t_spot_t):100:max(image_d_t_spot_t))

%% Run the fitting procedure
axes(handles.axes5)
bckg_spots_process_t_ind = find(bckg_spots_process_t>0);
bckg_spots_process_t = bckg_spots_process_t(bckg_spots_process_t_ind);
set(handles.num_el_last,'String',num2str(numel(bckg_spots_process_t_ind)));
histogram(bckg_spots_process_t, min(bckg_spots_process_t):100:max(bckg_spots_process_t))
axes(handles.axes5)
histfit(bckg_spots_process_t,100,'gev')
fit_9_bckg = fitdist(bckg_spots_process_t','gev');
output_table1(:,1) = fit_9_bckg.mu;
output_table1(:,2) = fit_9_bckg.sigma;
fit_9_bckg_low = fit_9_bckg.mu-fit_9_bckg.sigma;
fit_9_bckg_up = fit_9_bckg.mu+fit_9_bckg.sigma;
output_table1(:,3) = fit_9_bckg_low;
output_table1(:,4) = fit_9_bckg_up;
range_9 = (round(fit_9_bckg_low):round(fit_9_bckg_up));
set(handles.uitable2,'data',output_table1);

%%  
for i = 1:length(bckg_spots_process_t)   
    if abs_bckg_val == 0
        if bckg_spots_process_t(i)>fit_9_bckg_up
           bckg_spots_process_t(i) = fit_9_bckg.mu;
        end
    end
end

axes(handles.axes8)
histogram(bckg_spots_process_t,min(bckg_spots_process_t):100:max(bckg_spots_process_t))
axes(handles.axes3)
trace_len = 1:frame_end;
bckg_trace2 = ones(frame_end)*fit_9_bckg.mu;
plot(trace_len,bckg_trace2,'k')

switch type_auto_bckg
    case('Auto')
        switch channel
            case {'donor'} 
                bckg_don1 = bckg_spots_process_t;                 
                bckg_don_avg = fit_9_bckg.mu;                
                if ispc == 1
                save('Variables\bckg_don1.mat','bckg_don1');
                save('Variables\bckg_don_avg.mat','bckg_don_avg');
                elseif ismac == 1
                save('Variables/bckg_don1.mat','bckg_don1');
                save('Variables/bckg_don_avg.mat','bckg_don_avg');
                end
        
            case {'acceptor'}
                bckg_accep1 = bckg_spots_process_t;
                bckg_accep_avg = fit_9_bckg.mu;                
                if ispc == 1
                save('Variables\bckg_accep1.mat','bckg_accep1');                
                save('Variables\bckg_accep_avg.mat','bckg_accep_avg');
                elseif ismac == 1
                save('Variables/bckg_accep1.mat','bckg_accep1');                
                save('Variables/bckg_accep_avg.mat','bckg_accep_avg');
                end
                

        end  
    case('Manual')
        switch channel
            case {'donor'} 
                bckg_don1 = bckg_spots_process_t;
                setappdata(handles.accept_bckg,'bckg_don1',bckg_don1);
                bckg_don_avg = fit_9_bckg.mu;
                setappdata(handles.accept_bckg,'bckg_don_avg',bckg_don_avg);
        
            case {'acceptor'}
                bckg_accep1 = bckg_spots_process_t;
                setappdata(handles.accept_bckg,'bckg_accep1',bckg_accep1);
                bckg_accep_avg = fit_9_bckg.mu;
                setappdata(handles.accept_bckg,'bckg_accep_avg',bckg_accep_avg);
        end
end


% Update handles structure
guidata(hObject, handles);


% UIWAIT makes bckg_calc2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bckg_calc2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global type_auto_bckg
switch type_auto_bckg
    case('Auto')
        close bckg_calc2
end


function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of channel as text
%        str2double(get(hObject,'String')) returns contents of channel as a double


% --- Executes during object creation, after setting all properties.
function channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function median_last_Callback(hObject, eventdata, handles)
% hObject    handle to median_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of median_last as text
%        str2double(get(hObject,'String')) returns contents of median_last as a double


% --- Executes during object creation, after setting all properties.
function median_last_CreateFcn(hObject, eventdata, handles)
% hObject    handle to median_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fitted_last_Callback(hObject, eventdata, handles)
% hObject    handle to fitted_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fitted_last as text
%        str2double(get(hObject,'String')) returns contents of fitted_last as a double


% --- Executes during object creation, after setting all properties.
function fitted_last_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fitted_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in accept_bckg.
function accept_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to accept_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global type_auto_bckg
global channel
        switch channel
            case {'donor'} 
                bckg_don1 = getappdata(handles.accept_bckg,'bckg_don1');
                bckg_don_avg = getappdata(handles.accept_bckg,'bckg_don_avg');               
                if ispc == 1
                save('Variables\bckg_don1.mat','bckg_don1');
                save('Variables\bckg_don_avg.mat','bckg_don_avg');
                elseif ismac == 1
                save('Variables/bckg_don1.mat','bckg_don1');
                save('Variables/bckg_don_avg.mat','bckg_don_avg');
                end
        
            case {'acceptor'}
                bckg_accep1 = getappdata(handles.accept_bckg,'bckg_accep1');
                bckg_accep_avg = getappdata(handles.accept_bckg,'bckg_accep_avg'); 
                if ispc == 1
                save('Variables\bckg_accep1.mat','bckg_accep1');                
                save('Variables\bckg_accep_avg.mat','bckg_accep_avg');
                elseif ismac == 1
                save('Variables/bckg_accep1.mat','bckg_accep1');                
                save('Variables/bckg_accep_avg.mat','bckg_accep_avg');
                end
        end  


function num_el_first_Callback(hObject, eventdata, handles)
% hObject    handle to num_el_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_el_first as text
%        str2double(get(hObject,'String')) returns contents of num_el_first as a double


% --- Executes during object creation, after setting all properties.
function num_el_first_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_el_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num_el_last_Callback(hObject, eventdata, handles)
% hObject    handle to num_el_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_el_last as text
%        str2double(get(hObject,'String')) returns contents of num_el_last as a double


% --- Executes during object creation, after setting all properties.
function num_el_last_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_el_last (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function median_first_Callback(hObject, eventdata, handles)
% hObject    handle to median_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of median_first as text
%        str2double(get(hObject,'String')) returns contents of median_first as a double


% --- Executes during object creation, after setting all properties.
function median_first_CreateFcn(hObject, eventdata, handles)
% hObject    handle to median_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fitted_first_Callback(hObject, eventdata, handles)
% hObject    handle to fitted_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fitted_first as text
%        str2double(get(hObject,'String')) returns contents of fitted_first as a double


% --- Executes during object creation, after setting all properties.
function fitted_first_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fitted_first (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function op_mode_Callback(hObject, eventdata, handles)
% hObject    handle to op_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of op_mode as text
%        str2double(get(hObject,'String')) returns contents of op_mode as a double


% --- Executes during object creation, after setting all properties.
function op_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to op_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
