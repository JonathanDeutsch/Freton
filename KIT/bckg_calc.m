function varargout = bckg_calc(varargin)
% BCKG_CALC MATLAB code for bckg_calc.fig
%      BCKG_CALC, by itself, creates a new BCKG_CALC or raises the existing
%      singleton*.
%
%      H = BCKG_CALC returns the handle to a new BCKG_CALC or the handle to
%      the existing singleton*.
%
%      BCKG_CALC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BCKG_CALC.M with the given input arguments.
%
%      BCKG_CALC('Property','Value',...) creates a new BCKG_CALC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bckg_calc_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bckg_calc_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bckg_calc

% Last Modified by GUIDE v2.5 12-Jun-2019 01:20:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bckg_calc_OpeningFcn, ...
                   'gui_OutputFcn',  @bckg_calc_OutputFcn, ...
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


% --- Executes just before bckg_calc is made visible.
function bckg_calc_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bckg_calc (see VARARGIN)

%% get the global values from frame merger
global image_dt
global image_at
global channel
global bckg_cent_map
global centers_d
global radii_d
global centers_a
global radii_a
global centers_bckg
global radii_bckg
global frame_end
global image_bckg
global back_vals2
global tot_vals2
global spots3

set(handles.bckg_thsh,'String',num2str(150));
% Choose default command line output for bckg_calc
handles.output = hObject;
load ('bckg.mat')
set(handles.channel,'String',channel);

switch channel
    case {'donor'}
    bckg_cent_map = cent_map_d;
    image_bckg = image_dt;
    centers_bckg = centers_d;
    radii_bckg = radii_d;  
    [~,~,frame_end] = size(image_dt);
    
    case{'acceptor'}
    bckg_cent_map = cent_map_a;
    image_bckg = image_at;  
    centers_bckg = centers_a;
    radii_bckg = radii_a;
    [~,~,frame_end] = size(image_at);
end

trace_len = ones(frame_end,1);
counter_out_range = 0;
for i = 1:length(radii_bckg)
            rtd = round(radii_bckg(i))-1;
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
                image_d_t_spot_t(:,i) - bckg_spots_process_t(:,i);
            end
end
tot_spots = image_d_t_spot_t;
bckg_spots_2 = bckg_spots_process_t';
bckg_spots = bckg_spots_process_t;

set(handles.vals_outrange,'String',num2str(counter_out_range));
axes(handles.axes14)
image_d_t_spot_t_ind = find(image_d_t_spot_t > 0);
image_d_t_spot_t = image_d_t_spot_t(image_d_t_spot_t_ind);
set(handles.num_el_first,'String',num2str(numel(image_d_t_spot_t)));
histogram(image_d_t_spot_t)
axes(handles.axes12)
bckg_spots_process_t_ind = find(bckg_spots_process_t>0);
bckg_spots_process_t = bckg_spots_process_t(bckg_spots_process_t_ind);
set(handles.num_el_last,'String',num2str(numel(bckg_spots_process_t_ind)));
histogram(bckg_spots_process_t)
median_nonspecs = median(bckg_spots_process_t);
set(handles.med_nonspec,'String',num2str(median_nonspecs));


count_remains = 0; 
for i = 1:length(bckg_spots_process_t)
    if bckg_spots_process_t(:,i)>=image_d_t_spot_t(:,i)
        bckg_spots_process_t(:,i) = median_nonspecs;        
    end
end

for i = 1:length(bckg_spots_process_t)
    if bckg_spots_process_t(:,i)>=image_d_t_spot_t(:,i)
        count_remains = count_remains + 1;            
    end
end
set(handles.filt_outrange,'String',num2str(count_remains));


bckg_ind = (~bckg_cent_map);
bckg_vals = bckg_ind.*double(image_bckg(:,:,frame_end));
back_vals2 = bckg_vals(:);
% get all the background values
back_vals2( ~any(back_vals2,2), : ) = [];  %rows
% filter the values to some threshold
bckg_th = str2double(get(handles.bckg_thsh,'String'));
back_vals2_ind = find(back_vals2 <=bckg_th);
back_vals2 = back_vals2(back_vals2_ind);
tot_pix_bckg = sum(sum(bckg_ind));
set(handles.num_bckg_pix,'String',num2str(tot_pix_bckg));

tot_vals = bckg_cent_map.*double(image_bckg(:,:,1));
tot_vals2 = tot_vals(:);
tot_vals2(~any(tot_vals2,2), :) = [];
tot_pix_tot = sum(sum(bckg_cent_map));
set(handles.num_spots_pix,'String',num2str(tot_pix_tot));

axes(handles.axes1)
histogram(back_vals2);
axes(handles.axes3)
histogram(tot_vals2);

axes(handles.axes7)
imagesc(image_bckg(:,:,1));
axes(handles.axes8)
imagesc(image_bckg(:,:,end));
set(handles.axes7,'XTick',[]);
set(handles.axes7,'YTick',[]);
set(handles.axes8,'XTick',[]);
set(handles.axes8,'YTick',[]);

% compute the number of pixels per spot
switch channel
    case {'donor'}
    num_d = length(radii_d);
    for i = 1:num_d
        rt = round(radii_d(i))-1;
        pix_w = 1+2*rt;
        pix_h = 1+2*rt;
        tot_pix = pix_w*pix_h;
        pix_d(i) = tot_pix;       
    end
    setappdata(handles.fit_opt_spot,'pix_d',pix_d);
    axes(handles.axes4)
%     histogram(pix_d,[1 9 25 49]);
    histogram(pix_d,5);
    median_pix_d = median(pix_d);
    set(handles.disp_med_pix, 'String',num2str(median_pix_d));
    
    case{'acceptor'}
    num_a = length(radii_a);
    for i = 1:num_a
        rt = round(radii_a(i))-1;
        pix_w = 1+2*rt;
        pix_h = 1+2*rt;
        tot_pix = pix_w*pix_h;
        pix_a(i) = tot_pix;
    end
    setappdata(handles.fit_opt_spot,'pix_a',pix_a);
    axes(handles.axes4)
    histogram(pix_a,5)
    median_pix_a = median(pix_a);
    set(handles.disp_med_pix, 'String',num2str(median_pix_a));    
end

% get the pixel plus/minus
spots3 = 0;
% for i = 1:length(radii_bckg)
%             rtd = round(radii_bckg(i))-1;
%             % get the center
%             ind_dfe = centers_bckg(i,:);
%             % index on the donor x   
%             ind_dfex = ind_dfe(:,2);
%             ind_dfexp = ind_dfex + rtd;
%             ind_dfexm = ind_dfex - rtd;
%             ind_dfext = [ind_dfexm:ind_dfexp];
%             % index on the donor y
%             ind_dfey = ind_dfe(:,1);
%             ind_dfeyp = ind_dfey + rtd;
%             ind_dfeym = ind_dfey - rtd;
%             ind_dfeyt = [ind_dfeym:ind_dfeyp];
%             % compute donor traces  
%             image_d_t = image_bckg(ind_dfext,ind_dfeyt,1);
%             image_d_t_bckg = image_bckg(ind_dfext,ind_dfeyt,frame_end);
%             tot_spots(:,i) = sum(sum(image_d_t));
%             bckg_spots(:,i) = sum(sum(image_d_t_bckg));
%             if rtd == 1
%                 bckg_spots_2(i,:) = sum(sum(image_d_t_bckg)); 
%             elseif rtd == 2
%                 bckg_spots_3(i,:) = sum(sum(image_d_t_bckg));
%                 spots3 =1;
%             end
%             
% end

setappdata(handles.fit_opt_spot,'bckg_spots_2',bckg_spots_2);
if spots3 ==1
setappdata(handles.fit_opt_spot,'bckg_spots_3',bckg_spots_3);
end
bckg_min = min(bckg_spots);
bckg_max = max(bckg_spots);
tots_min = min(tot_spots);
tots_max = max(tot_spots);
bckg_spots_2( ~any(bckg_spots_2,2), : ) = [];  %rows
if spots3 == 1
bckg_spots_3( ~any(bckg_spots_3,2), : ) = [];  %rows
end

axes(handles.axes5)
histogram(tot_spots,tots_min:100:tots_max)
axes(handles.axes6)
histogram(bckg_spots,tots_min:100:tots_max)
axes(handles.axes9)
histogram(bckg_spots_2,bckg_min:100:bckg_max)
med_bckg_2_val = median(bckg_spots_2);
pix_9_thresh = med_bckg_2_val*3;
set(handles.med_bckg_2,'String',num2str(med_bckg_2_val));
set(handles.thresh_9,'String',num2str(pix_9_thresh));
if spots3 ==1
axes(handles.axes10)
histogram(bckg_spots_3,bckg_min:100:bckg_max)
med_bckg_3_val = median(bckg_spots_3);
pix_25_thresh = med_bckg_3_val*2;
set(handles.thresh_25,'String',num2str(pix_25_thresh));
set(handles.med_bckg_3,'String',num2str(med_bckg_3_val));
end

% Update handles structure
guidata(hObject, handles);
% UIWAIT makes bckg_calc wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = bckg_calc_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function num_spots_pix_Callback(hObject, eventdata, handles)
% hObject    handle to num_spots_pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_spots_pix as text
%        str2double(get(hObject,'String')) returns contents of num_spots_pix as a double

% --- Executes during object creation, after setting all properties.
function num_spots_pix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_spots_pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function num_bckg_pix_Callback(hObject, eventdata, handles)
% hObject    handle to num_bckg_pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num_bckg_pix as text
%        str2double(get(hObject,'String')) returns contents of num_bckg_pix as a double

% --- Executes during object creation, after setting all properties.
function num_bckg_pix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num_bckg_pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function val_tot_Callback(hObject, eventdata, handles)
% hObject    handle to val_tot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_tot as text
%        str2double(get(hObject,'String')) returns contents of val_tot as a double

% --- Executes during object creation, after setting all properties.
function val_tot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_tot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function val_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to val_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_bckg as text
%        str2double(get(hObject,'String')) returns contents of val_bckg as a double


% --- Executes during object creation, after setting all properties.
function val_bckg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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


% --- Executes on button press in bckg_trace.
function bckg_trace_Callback(hObject, eventdata, handles)
% hObject    handle to bckg_trace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global channel
global bckg_cent_map
global image_dt
global image_at
global bckg_dt
global bckg_at
global pix_d
global pix_a

load ('bckg.mat')
set(handles.channel,'String',channel);

% compute the number of pixels per spot
switch channel
    case {'donor'}
    num_d = length(radii_d);
    for i = 1:num_d
        rt = round(radii_d(i))-1;
        pix_w = 1+2*rt;
        pix_h = 1+2*rt;
        tot_pix = pix_w*pix_h;
        pix_d(i) = tot_pix;
    end
    axes(handles.axes4)
    histogram(pix_d,[1 9 25 49]);
    median_pix_d = median(pix_d);
    set(handles.disp_med_pix, 'String',num2str(median_pix_d));
    
    case{'acceptor'}
    num_a = length(radii_a);
    for i = 1:num_a
        rt = round(radii_a(i))-1;
        pix_w = 1+2*rt;
        pix_h = 1+2*rt;
        tot_pix = pix_w*pix_h;
        pix_a(i) = tot_pix;
    end
    axes(handles.axes4)
    histogram(pix_a,[1 9 25 49])
    median_pix_a = median(pix_a);
    set(handles.disp_med_pix, 'String',num2str(median_pix_a));
    
end

%% this function will calculate the background across all frames
        bckg_ind = (~bckg_cent_map);
% filter the values to some threshold
bckg_th = str2double(get(handles.bckg_thsh,'String'));        
        
switch channel
    case {'donor'}
    [~, ~, dt_stack]=size(image_dt);
    for i = 1:dt_stack
        bckg_vals = bckg_ind.*double(image_dt(:,:,i));
        back_vals2 = bckg_vals(:);
        back_vals2( ~any(back_vals2,2), : ) = [];
        back_vals2_ind = find(back_vals2 <=bckg_th);
        back_vals2 = back_vals2(back_vals2_ind);
        bckg_dt(i) = median(back_vals2);
    end
    axes(handles.axes2)
    plot(bckg_dt)
    
    case{'acceptor'}
    [~, ~, at_stack]=size(image_at);    
    for i = 1:at_stack
        bckg_vals = bckg_ind.*double(image_at(:,:,i));
        back_vals2 = bckg_vals(:);
        back_vals2( ~any(back_vals2,2), : ) = [];  
        bckg_at(i) = median(back_vals2);  
    end
       axes(handles.axes2)
    plot(bckg_at)
end


function sig_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to sig_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_bckg as text
%        str2double(get(hObject,'String')) returns contents of sig_bckg as a double


% --- Executes during object creation, after setting all properties.
function sig_bckg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in robust_est.
function robust_est_Callback(hObject, eventdata, handles)
% hObject    handle to robust_est (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of robust_est



function val_bckg_med_Callback(hObject, eventdata, handles)
% hObject    handle to val_bckg_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of val_bckg_med as text
%        str2double(get(hObject,'String')) returns contents of val_bckg_med as a double


% --- Executes during object creation, after setting all properties.
function val_bckg_med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to val_bckg_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sig_bckg_med_Callback(hObject, eventdata, handles)
% hObject    handle to sig_bckg_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sig_bckg_med as text
%        str2double(get(hObject,'String')) returns contents of sig_bckg_med as a double


% --- Executes during object creation, after setting all properties.
function sig_bckg_med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sig_bckg_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_med_pix_Callback(hObject, eventdata, handles)
% hObject    handle to disp_med_pix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_med_pix as text
%        str2double(get(hObject,'String')) returns contents of disp_med_pix as a double


% --- Executes during object creation, after setting all properties.
function disp_med_pix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_med_pix (see GCBO)
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
global bckg_dt
global bckg_at
global pix_d
global pix_a
global channel

switch channel
    case {'donor'}
        num_db = length(pix_d);
        for i = 1:num_db
            bckg_don1t = pix_d(i).*bckg_dt;
            bckg_don1(:,i) = bckg_don1t;            
        end        
        save('bckg_don1.mat','bckg_don1');
        
    case {'acceptor'}
        num_ab = length(pix_a);
        for i = 1:num_ab
            bckg_accep1t = pix_a(i).*bckg_at;
            bckg_accep1(:,i) = bckg_accep1t;
        end        
        save('bckg_accep1.mat','bckg_accep1');        
end



function bckg_thsh_Callback(hObject, eventdata, handles)
% hObject    handle to bckg_thsh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of bckg_thsh as text
%        str2double(get(hObject,'String')) returns contents of bckg_thsh as a double


% --- Executes during object creation, after setting all properties.
function bckg_thsh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bckg_thsh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in fit_pixel.
function fit_pixel_Callback(hObject, eventdata, handles)
% hObject    handle to fit_pixel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global back_vals2
global tot_vals2

axes(handles.axes1)
histfit(back_vals2,100,'gev');
bckg_val =fitdist(back_vals2,'gev');
bckg = bckg_val.mu;
bckg_median = median(back_vals2);
%phat = mle(back_vals2,'distribution','gev')
set(handles.val_bckg,'String', num2str(bckg));

axes(handles.axes3)
histfit(tot_vals2,100,'gev');
tot_val =fitdist(tot_vals2,'gev');
tot = tot_val.mu;
set(handles.val_tot,'String',num2str(tot));
sig_bckg = tot/bckg;
sig_bckg_med = tot/bckg_median;
set(handles.sig_bckg,'String',num2str(sig_bckg));
set(handles.val_bckg_med,'String',num2str(bckg_median));
set(handles.sig_bckg_med,'String',num2str(sig_bckg_med));


% --- Executes on button press in fit_opt_spot.
function fit_opt_spot_Callback(hObject, eventdata, handles)
% hObject    handle to fit_opt_spot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global channel
global image_dt
global image_at
global centers_bckg
global radii_bckg
global frame_end
global image_bckg
global fit_9_bckg
global fit_25_bckg
global range_9
global range_25
global spots3

h1 = msgbox('Please Wait: Assessing Backgrounds');
pix_9_thresh = str2num(get(handles.thresh_9,'String'));
bckg_spots_2_all = getappdata(handles.fit_opt_spot,'bckg_spots_2');
bckg_spots_2 = getappdata(handles.fit_opt_spot,'bckg_spots_2');
bckg_spots_2( ~any(bckg_spots_2,2), : ) = [];  %rows
bckg_spots_2_ind = find(bckg_spots_2 <= pix_9_thresh);
bckg_spots_2_filt = bckg_spots_2(bckg_spots_2_ind);
axes(handles.axes9)
histfit(bckg_spots_2_filt,50,'gev')
fit_9_bckg = fitdist(bckg_spots_2_filt,'gev');
set(handles.disp_9_mu,'String',num2str(fit_9_bckg.mu));
set(handles.disp_9_sig,'String',num2str(fit_9_bckg.sigma));
fit_9_bckg_low = fit_9_bckg.mu-fit_9_bckg.sigma;
fit_9_bckg_up = fit_9_bckg.mu+fit_9_bckg.sigma;
set(handles.disp_9_low,'String',num2str(fit_9_bckg_low));
set(handles.disp_9_up,'String',num2str(fit_9_bckg_up));
med_filt_9 = median(bckg_spots_2_filt);
set(handles.disp_9_med,'String',num2str(med_filt_9));
range_9 = (round(fit_9_bckg_low):round(fit_9_bckg_up));

if spots3 == 1
pix_25_thresh = str2num(get(handles.thresh_25,'String'));
bckg_spots_3_all = getappdata(handles.fit_opt_spot,'bckg_spots_3');
bckg_spots_3 = getappdata(handles.fit_opt_spot,'bckg_spots_3');
bckg_spots_3( ~any(bckg_spots_3,2), : ) = [];  %rows
bckg_spots_3_ind = find(bckg_spots_3 <= pix_25_thresh);
bckg_spots_3_filt = bckg_spots_3(bckg_spots_3_ind);
axes(handles.axes10)
histfit(bckg_spots_3_filt,50,'gev')
fit_25_bckg = fitdist(bckg_spots_3_filt,'gev');
set(handles.disp_25_mu,'String',num2str(fit_25_bckg.mu));
set(handles.disp_25_sig,'String',num2str(fit_25_bckg.sigma));
fit_25_bckg_low = fit_25_bckg.mu-fit_25_bckg.sigma;
fit_25_bckg_up = fit_25_bckg.mu+fit_25_bckg.sigma;
set(handles.disp_25_low,'String',num2str(fit_25_bckg_low));
set(handles.disp_25_up,'String',num2str(fit_25_bckg_up));
fit_25_bckg = fitdist(bckg_spots_3_filt,'gev');
med_filt_25 = median(bckg_spots_3_filt);
set(handles.disp_25_med,'String',num2str(med_filt_25));
range_25 = (round(fit_25_bckg_low):round(fit_25_bckg_up));
end

for i = 1:length(bckg_spots_2)     
    if ismember(bckg_spots_2(i),range_9)<=0
        bckg_spots_2_filt(i) = fit_9_bckg.mu;
    else
        bckg_spots_2_filt(i) = bckg_spots_2(i);
    end
end

if spots3 ==1
for i = 1:length(bckg_spots_3)
    if ismember(bckg_spots_3(i),range_25)<=0
        bckg_spots_3_filt(i) = fit_25_bckg.mu;
    else
        bckg_spots_3_filt(i) = bckg_spots_3(i);
    end
end
end
    
axes(handles.axes11)
histogram(bckg_spots_2_filt,50)
hold on
if spots3 == 1
histogram(bckg_spots_3_filt,50)
end
hold off

    axes(handles.axes2)
    trace_len = 1:frame_end;
    bckg_trace2 = ones(frame_end)*fit_9_bckg.mu;
    plot(trace_len,bckg_trace2,'k')
    if spots3==1
    bckg_trace3 = ones(frame_end)*fit_25_bckg.mu;
    plot(trace_len,bckg_trace2,'k',trace_len,bckg_trace3,'b')
    end
    close(h1)

function med_bckg_2_Callback(hObject, eventdata, handles)
% hObject    handle to med_bckg_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of med_bckg_2 as text
%        str2double(get(hObject,'String')) returns contents of med_bckg_2 as a double


% --- Executes during object creation, after setting all properties.
function med_bckg_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to med_bckg_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function med_bckg_3_Callback(hObject, eventdata, handles)
% hObject    handle to med_bckg_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of med_bckg_3 as text
%        str2double(get(hObject,'String')) returns contents of med_bckg_3 as a double

% --- Executes during object creation, after setting all properties.
function med_bckg_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to med_bckg_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function thresh_9_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_9 as text
%        str2double(get(hObject,'String')) returns contents of thresh_9 as a double


% --- Executes during object creation, after setting all properties.
function thresh_9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thresh_25_Callback(hObject, eventdata, handles)
% hObject    handle to thresh_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thresh_25 as text
%        str2double(get(hObject,'String')) returns contents of thresh_25 as a double


% --- Executes during object creation, after setting all properties.
function thresh_25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thresh_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_9_med_Callback(hObject, eventdata, handles)
% hObject    handle to disp_9_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_9_med as text
%        str2double(get(hObject,'String')) returns contents of disp_9_med as a double


% --- Executes during object creation, after setting all properties.
function disp_9_med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_9_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_9_mu_Callback(hObject, eventdata, handles)
% hObject    handle to disp_9_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_9_mu as text
%        str2double(get(hObject,'String')) returns contents of disp_9_mu as a double


% --- Executes during object creation, after setting all properties.
function disp_9_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_9_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_25_med_Callback(hObject, eventdata, handles)
% hObject    handle to disp_25_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_25_med as text
%        str2double(get(hObject,'String')) returns contents of disp_25_med as a double


% --- Executes during object creation, after setting all properties.
function disp_25_med_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_25_med (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_25_mu_Callback(hObject, eventdata, handles)
% hObject    handle to disp_25_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_25_mu as text
%        str2double(get(hObject,'String')) returns contents of disp_25_mu as a double


% --- Executes during object creation, after setting all properties.
function disp_25_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_25_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_9_sig_Callback(hObject, eventdata, handles)
% hObject    handle to disp_9_sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_9_sig as text
%        str2double(get(hObject,'String')) returns contents of disp_9_sig as a double


% --- Executes during object creation, after setting all properties.
function disp_9_sig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_9_sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_25_sig_Callback(hObject, eventdata, handles)
% hObject    handle to disp_25_sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_25_sig as text
%        str2double(get(hObject,'String')) returns contents of disp_25_sig as a double


% --- Executes during object creation, after setting all properties.
function disp_25_sig_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_25_sig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_9_low_Callback(hObject, eventdata, handles)
% hObject    handle to disp_9_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_9_low as text
%        str2double(get(hObject,'String')) returns contents of disp_9_low as a double


% --- Executes during object creation, after setting all properties.
function disp_9_low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_9_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_25_low_Callback(hObject, eventdata, handles)
% hObject    handle to disp_25_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_25_low as text
%        str2double(get(hObject,'String')) returns contents of disp_25_low as a double


% --- Executes during object creation, after setting all properties.
function disp_25_low_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_25_low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_9_up_Callback(hObject, eventdata, handles)
% hObject    handle to disp_9_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_9_up as text
%        str2double(get(hObject,'String')) returns contents of disp_9_up as a double


% --- Executes during object creation, after setting all properties.
function disp_9_up_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_9_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_25_up_Callback(hObject, eventdata, handles)
% hObject    handle to disp_25_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_25_up as text
%        str2double(get(hObject,'String')) returns contents of disp_25_up as a double


% --- Executes during object creation, after setting all properties.
function disp_25_up_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_25_up (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in new_filt_bckg.
function new_filt_bckg_Callback(hObject, eventdata, handles)
% hObject    handle to new_filt_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global channel
global frame_end
global fit_9_bckg
global fit_25_bckg
global range_9
global range_25
global image_dt
global image_at
global radii_bckg
global centers_bckg
global image_bckg
%% check this
% get the pixel plus/minus
trace_len = ones(frame_end,1);
for i = 1:length(radii_bckg)
            rtd = round(radii_bckg(i))-1;
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
            for i = frame_end:-1:frame_end-4
                counter_bckg = counter_bckg +1;
                image_d_t_bckg = image_bckg(ind_dfext,ind_dfeyt,i);
                bckg_spots_process_tt(:,counter_bckg) = sum(sum(image_d_t_bckg))                
            end
            bckg_spots_process_t = mean(bckg_spots_process_tt);
            %% end loop here
            if rtd <1
                bckg_spots_process(:,i) =  bckg_spots_process_t.*trace_len;
            end
            if rtd == 1                
                if ismember(bckg_spots_process_t,range_9)<=0
                    bckg_spots_process(:,i) = fit_9_bckg.mu.*trace_len;
                else
                    bckg_spots_process(:,i) =  bckg_spots_process_t.*trace_len;
                end
            elseif rtd == 2
                if ismember(bckg_spots_process_t,range_25)<=0
                    bckg_spots_process(:,i) = fit_25_bckg.mu.*trace_len;
                else
                    bckg_spots_process(:,i) = bckg_spots_process_t.*trace_len;
                end
            elseif rtd>2
                    bckg_spots_process(:,i) = bckg_spots_process_t.*trace_len;
                
            end 
end

switch channel
    case {'donor'} 
        bckg_don1 = bckg_spots_process;
        save('bckg_don1.mat','bckg_don1');
        
    case {'acceptor'}
        bckg_accep1 = bckg_spots_process;
        save('bckg_accep1.mat','bckg_accep1');
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



function vals_outrange_Callback(hObject, eventdata, handles)
% hObject    handle to vals_outrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vals_outrange as text
%        str2double(get(hObject,'String')) returns contents of vals_outrange as a double


% --- Executes during object creation, after setting all properties.
function vals_outrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vals_outrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function med_nonspec_Callback(hObject, eventdata, handles)
% hObject    handle to med_nonspec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of med_nonspec as text
%        str2double(get(hObject,'String')) returns contents of med_nonspec as a double


% --- Executes during object creation, after setting all properties.
function med_nonspec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to med_nonspec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function filt_outrange_Callback(hObject, eventdata, handles)
% hObject    handle to filt_outrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filt_outrange as text
%        str2double(get(hObject,'String')) returns contents of filt_outrange as a double


% --- Executes during object creation, after setting all properties.
function filt_outrange_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filt_outrange (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function new_filt_bckg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_filt_bckg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
