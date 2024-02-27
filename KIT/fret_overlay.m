function varargout = fret_overlay(varargin)
% FRET_OVERLAY MATLAB code for fret_overlay.fig
%      FRET_OVERLAY, by itself, creates a new FRET_OVERLAY or raises the existing
%      singleton*.
%
%      H = FRET_OVERLAY returns the handle to a new FRET_OVERLAY or the handle to
%      the existing singleton*.
%
%      FRET_OVERLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRET_OVERLAY.M with the given input arguments.
%
%      FRET_OVERLAY('Property','Value',...) creates a new FRET_OVERLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fret_overlay_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fret_overlay_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fret_overlay

% Last Modified by GUIDE v2.5 20-Jun-2019 16:46:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fret_overlay_OpeningFcn, ...
                   'gui_OutputFcn',  @fret_overlay_OutputFcn, ...
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

% --- Executes just before fret_overlay is made visible.


function fret_overlay_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fret_overlay (see VARARGIN)

% Choose default command line output for fret_overlay
handles.output = hObject;
% global centers_a
% global centers_d
% global radii_d
% global radii_a
global extract_auto

load('temp_fret_id','centers_a','radii_a','centers_d','radii_d','image_d','image_a_r','type_picker','extract_auto');
set(handles.run_status,'String',extract_auto);
set(handles.particle_mode,'String',type_picker);
setappdata(handles.particle_mode,'type_picker',type_picker);
num_donors = length(radii_d);
num_acceptors = length(radii_a);
list_dons = (1:num_donors)';
list_acceps = (1:num_acceptors)';
set(handles.list_don,'String', num2str(list_dons));
set(handles.disp_don,'String',num2str(num_donors));
set(handles.list_accep,'String',num2str(list_acceps));
set(handles.disp_accep,'String',num2str(num_acceptors));
set(handles.th_filter,'String',num2str(3));
set(handles.overlay_status,'String','Unfiltered Pairs');
set(handles.broad_brush,'String',num2str(12));

axes(handles.axes1);
[x,y]= size(image_d);
img_blank = imshow(uint16(zeros(x,y)));
viscircles(centers_d,radii_d,'Color','g','LineWidth',.01);
viscircles(centers_a,radii_a,'Color','r','LineWidth',.01);
switch extract_auto
    case {'Auto'}
        filter_pairs_Callback(handles.filter_pairs, eventdata, handles)
end
% Update handles structure
guidata(hObject, handles);


function varargout = fret_overlay_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on selection change in list_don.
function list_don_Callback(hObject, eventdata, handles)
% hObject    handle to list_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_don contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_don



% --- Executes during object creation, after setting all properties.
function list_don_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list_accep.
function list_accep_Callback(hObject, eventdata, handles)
% hObject    handle to list_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_accep contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_accep


% --- Executes during object creation, after setting all properties.
function list_accep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in list_fret.
function list_fret_Callback(hObject, eventdata, handles)
% hObject    handle to list_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns list_fret contents as cell array
%        contents{get(hObject,'Value')} returns selected item from list_fret


% --- Executes during object creation, after setting all properties.
function list_fret_CreateFcn(hObject, eventdata, handles)
% hObject    handle to list_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_don_Callback(hObject, eventdata, handles)
% hObject    handle to disp_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_don as text
%        str2double(get(hObject,'String')) returns contents of disp_don as a double


% --- Executes during object creation, after setting all properties.
function disp_don_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_don (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_accep_Callback(hObject, eventdata, handles)
% hObject    handle to disp_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_accep as text
%        str2double(get(hObject,'String')) returns contents of disp_accep as a double


% --- Executes during object creation, after setting all properties.
function disp_accep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_accep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_fret_Callback(hObject, eventdata, handles)
% hObject    handle to disp_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_fret as text
%        str2double(get(hObject,'String')) returns contents of disp_fret as a double


% --- Executes during object creation, after setting all properties.
function disp_fret_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_fret (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_pairs.
function filter_pairs_Callback(hObject, eventdata, handles)
% hObject    handle to filter_pairs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% First Pass Circle Overlap Identifier 
% global centers_a
% global centers_d
% global radii_d
% global radii_a
% global image_d
global centers_d_o
global radii_d_o 
global centers_a_o 
global radii_a_o 
global bckg_dt
global bckg_at
global extract_auto

broad_brush = str2num(get(handles.broad_brush,'String'));
load('temp_fret_id','centers_a','radii_a','centers_d','radii_d','image_d','image_a_r','type_picker');
th =  str2double(get(handles.th_filter,'String'));
num_donors = length(radii_d);
num_acceptors = length(radii_a);
overlap = [];
non_overlap = [];
h = waitbar(0,'Filtering for Matched FRET Pairs');
for i = 1:num_donors
    waitbar(i/num_donors)
    x1 = centers_d(i,2);
    y1 = centers_d(i,1);
    r1 = radii_d(i);
    for j = 1:num_acceptors
        x2 = centers_a(j,2);
        y2 = centers_a(j,1);
        r2 = radii_a(j);        
         % set criteria for filtration
         x1t = round(x1);
         x2t = round(x2);
         r1t = round(r1);
         r2t = round(r2);
         y1t = round(y1);
         y2t = round(y2);         
         if abs(x1t-x2t) > broad_brush && abs(y1t-y2t) > broad_brush
             continue
         end         
         % create ranges for x1 and x2
         x1range = (x1t-r1t:x1t+r1t);
         x2range = (x2t-r2t:x2t+r2t);
         y1range = (y1t-r1t:y1t+r1t);
         y2range = (y2t-r2t:y2t+r2t);         
         %% Update method to find the coordinates within range
          if ismember(x1,x2range)>0 ||ismember(x2,x1range)>0 &&...
              ismember(y1,y2range)>0 || ismember(y2,y1range)>0
                 d_int1= (i);
                 a_int1= (j);
          elseif ismember(y1,y2range)>0 || ismember(y2,y1range)>0 &&...
              ismember(x1,x2range)>0 ||ismember(x2,x1range)>0
                  d_int1= (i);
                  a_int1= (j);  
          else
              d_int1 = 0;  
              continue
          end
          %%
          if d_int1>0
                d2 = (x2-x1)^2+(y2-y1)^2;
                d = sqrt(d2);
                t = ((r1+r2)^2-d2)*(d2-(r2-r1)^2);            
                A = r1^2*acos((r1^2-r2^2+d2)/(2*d*r1)) ...
                +r2^2*acos((r2^2-r1^2+d2)/(2*d*r2)) ...
                -1/2*sqrt(t);  
                if isnan(A)
                   A = pi*min(r1,r2)^2;
                end
                if  A>th
                pos = [i,j];
                overlap = vertcat(overlap, pos);   
                val_a = vertcat(A);
                end                         
          end          
    end
end
close (h)
don_overlap = overlap(:,1);
all_dons = (1:num_donors)';
accep_overlap = overlap(:,2);
all_accep = (1:num_acceptors)';
ex_dons = setdiff(all_dons,don_overlap);
ex_accep = setdiff(all_accep,accep_overlap);
setappdata(handles.filter_pairs,'don_overlap',don_overlap);
setappdata(handles.filter_pairs,'accep_overlap',accep_overlap);
%save('all_particles.mat','don_overlap','all_dons','accep_overlap','all_accep','ex_dons','ex_accep');
switch type_picker
    case ('Run Matcher')
% don_overlap = d_int1;
% accep_overlap = a_int1;
centers_d_o = centers_d(don_overlap,:);
radii_d_o = radii_d(don_overlap);
centers_a_o = centers_a(accep_overlap,:);
radii_a_o = radii_a(accep_overlap);
set(handles.avg_a,'String',mean(val_a));
    case ('All Particles')
        % get non-matched donor and make the acceptor centers those
        centers_d_to = centers_d(don_overlap,:);
        centers_d_t1 = centers_d(ex_dons,:);
        centers_d_t2 = centers_a(ex_accep,:);
        radii_d_to = radii_d(don_overlap);
        radii_d_t1 = radii_d(ex_dons);
        radii_d_t2 = radii_a(ex_accep);
        % do the same for the acceptor
        centers_a_to = centers_a(accep_overlap,:);
        centers_a_t1 = centers_d(ex_dons,:);
        centers_a_t2 = centers_a(ex_accep,:);
        radii_a_to = radii_a(accep_overlap);
        radii_a_t1 = radii_d(ex_dons);
        radii_a_t2 = radii_a(ex_accep);
        % combine all the particles
        centers_d_o = vertcat(centers_d_to, centers_d_t1, centers_d_t2);
        radii_d_o = vertcat(radii_d_to,radii_d_t1,radii_d_t2);
        centers_a_o = vertcat(centers_a_to, centers_a_t1, centers_a_t2);
        radii_a_o = vertcat(radii_a_to,radii_a_t1,radii_a_t2);
end

axes(handles.axes2)
[x,y]= size(image_d);
img_blank = imshow(uint16(zeros(x,y)));
viscircles(centers_d_o,radii_d_o,'Color','g','LineWidth',.01);
viscircles(centers_a_o,radii_a_o,'Color','r','LineWidth',.01);
num_overlap = size(radii_d_o,1);
set(handles.disp_matched,'String',num2str(num_overlap));

axes(handles.axes1);
[x,y]= size(image_d);
img_blank = imshow(uint16(zeros(x,y)));
viscircles(centers_d,radii_d,'Color','g','LineWidth',.01);
viscircles(centers_a,radii_a,'Color','r','LineWidth',.01);
viscircles(centers_d_o,radii_d_o,'Color','w','LineWidth',.01);
viscircles(centers_a_o,radii_a_o,'Color','w','LineWidth',.01);
set(handles.overlay_status,'String','Filtered Pairs');

switch extract_auto
    case {'Auto'}
        accep_colocal_Callback(handles.accep_colocal, eventdata, handles)
end



% --- Executes on button press in accep_colocal.
function accep_colocal_Callback(hObject, eventdata, handles)
% hObject    handle to accep_colocal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global centers_d_o
global radii_d_o 
global centers_a_o 
global radii_a_o 
load('bckg_don1.mat','bckg_don1');
load('bckg_accep1.mat','bckg_accep1'); 

don_overlap = getappdata(handles.filter_pairs,'don_overlap');
accep_overlap = getappdata(handles.filter_pairs,'accep_overlap');
bckg_don1_o = bckg_don1(:,don_overlap);
bckg_accep1_o = bckg_accep1(:,accep_overlap);
[num_fret,~]= size(radii_d_o);
list_fret = (1:num_fret)';
set(handles.list_fret,'String',num2str(list_fret));
set(handles.disp_fret,'String',num2str(num_fret));

if ispc == 1
save('Variables\bckg_don1_o.mat','bckg_don1_o');
save('Variables\bckg_accep1_o.mat','bckg_accep1_o'); 
save('Variables\matched_fret.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
elseif ismac == 1
save('Variables/bckg_don1_o.mat','bckg_don1_o');
save('Variables/bckg_accep1_o.mat','bckg_accep1_o'); 
save('Variables/matched_fret.mat','centers_d_o','radii_d_o','centers_a_o','radii_a_o');
end


function th_filter_Callback(hObject, eventdata, handles)
% hObject    handle to th_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of th_filter as text
%        str2double(get(hObject,'String')) returns contents of th_filter as a double


% --- Executes during object creation, after setting all properties.
function th_filter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to th_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function avg_a_Callback(hObject, eventdata, handles)
% hObject    handle to avg_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of avg_a as text
%        str2double(get(hObject,'String')) returns contents of avg_a as a double


% --- Executes during object creation, after setting all properties.
function avg_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to avg_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function disp_matched_Callback(hObject, eventdata, handles)
% hObject    handle to disp_matched (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of disp_matched as text
%        str2double(get(hObject,'String')) returns contents of disp_matched as a double


% --- Executes during object creation, after setting all properties.
function disp_matched_CreateFcn(hObject, eventdata, handles)
% hObject    handle to disp_matched (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function overlay_status_Callback(hObject, eventdata, handles)
% hObject    handle to overlay_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of overlay_status as text
%        str2double(get(hObject,'String')) returns contents of overlay_status as a double


% --- Executes during object creation, after setting all properties.
function overlay_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overlay_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in zoom_on.
function zoom_on_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_on (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = zoom;
%h.Motion = 'horizontal';
h.Enable = 'on';
% zoom in on the plot in the horizontal direction.
a1 = (handles.axes1);

linkaxes([a1],'x');


% --- Executes on button press in zoom_off.
function zoom_off_Callback(hObject, eventdata, handles)
% hObject    handle to zoom_off (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a1 = (handles.axes1);
linkaxes([a1],'x');
zoom('out');
linkaxes([a1],'x');
zoom off
linkaxes([a1],'x');


function broad_brush_Callback(hObject, eventdata, handles)
% hObject    handle to broad_brush (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of broad_brush as text
%        str2double(get(hObject,'String')) returns contents of broad_brush as a double


% --- Executes during object creation, after setting all properties.
function broad_brush_CreateFcn(hObject, eventdata, handles)
% hObject    handle to broad_brush (see GCBO)
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
helpdlg({'Quick Step Guide:','This Module identifies pairs that have an overlap in both channels',...
         '1) Threshold determines the degree of Overlap ','2) Press "Filter pairs" to run computation',...
         '4) Broad Filter sets threshold (pixels) between spots for fast computation of overlap','5) Accept to continue',...
         '6) Return to KIT and Identify FRET and Extract Traces'},...
        'KIT-Matcher: Help');



function particle_mode_Callback(hObject, eventdata, handles)
% hObject    handle to particle_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of particle_mode as text
%        str2double(get(hObject,'String')) returns contents of particle_mode as a double


% --- Executes during object creation, after setting all properties.
function particle_mode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to particle_mode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function don_only_part_Callback(hObject, eventdata, handles)
% hObject    handle to don_only_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of don_only_part as text
%        str2double(get(hObject,'String')) returns contents of don_only_part as a double


% --- Executes during object creation, after setting all properties.
function don_only_part_CreateFcn(hObject, eventdata, handles)
% hObject    handle to don_only_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function accep_only_part_Callback(hObject, eventdata, handles)
% hObject    handle to accep_only_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of accep_only_part as text
%        str2double(get(hObject,'String')) returns contents of accep_only_part as a double


% --- Executes during object creation, after setting all properties.
function accep_only_part_CreateFcn(hObject, eventdata, handles)
% hObject    handle to accep_only_part (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function run_status_Callback(hObject, eventdata, handles)
% hObject    handle to run_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of run_status as text
%        str2double(get(hObject,'String')) returns contents of run_status as a double


% --- Executes during object creation, after setting all properties.
function run_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to run_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
