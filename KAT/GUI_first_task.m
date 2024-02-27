function varargout = GUI_first_task(varargin)

% GUI_FIRST_TASK MATLAB code for GUI_first_task.fig
%      GUI_FIRST_TASK, by itself, creates a new GUI_FIRST_TASK or raises the existing
%      singleton*.
%
%      H = GUI_FIRST_TASK returns the handle to a new GUI_FIRST_TASK or the handle to
%      the existing singleton*.
%
%      GUI_FIRST_TASK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FIRST_TASK.M with the given input arguments.
%
%      GUI_FIRST_TASK('Property','Value',...) creates a new GUI_FIRST_TASK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_first_task_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_first_task_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_first_task

% Last Modified by GUIDE v2.5 09-Jun-2017 18:04:00

% Begin initialization code - DO NOT EDIT


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_first_task_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_first_task_OutputFcn, ...
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


% --- Executes just before GUI_first_task is made visible.
function GUI_first_task_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_first_task (see VARARGIN)

% Choose default command line output for GUI_first_task
handles.output = hObject;

global RES1
global RES2
global RES3
global RES4
global RES5

global Counter

RES1 = 0;
RES2 = 0;
RES3 = 0;
RES4 = 0;
RES5 = 0;

Counter = 0;

global guess_user
guess_user = 0;
global guess_sdv
guess_sdv = 0;
set(handles.radiobutton1, 'Value', 1);
set(handles.radiobutton2, 'Value', 0);
set(handles.radiobutton3, 'Value', 1);
set(handles.radiobutton4, 'Value', 0);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_first_task wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_first_task_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in G_list_1.
function G_list_1_Callback(hObject, eventdata, handles)
% hObject    handle to G_list_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns G_list_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from G_list_1
global ORDER_global

global t
global N
global RES1
global RES2
global RES3
global RES4
global RES5
global X_individual

global x1
global x2
global x3
global x4
global x5
global y1
global y2
global y3
global y4
global y5
global Y
global N_TEST
global X
global N_points



if N_TEST == 5
Y = [y1', y2', y3', y4', y5'];
% X = [x1',x2', x3', x4', x5'];
elseif  N_TEST == 4
Y = [y1', y2', y3', y4'];
% X = [x1',x2', x3', x4'];
elseif  N_TEST == 3
Y = [y1', y2', y3'];
% X = [x1',x2', x3'];
elseif  N_TEST == 2
Y = [y1', y2'];
% X = [x1',x2'];
elseif  N_TEST == 1
Y = y1';
% X = x1';
end

% X = X';



global guess_user


items = get(hObject,'String');
index_selected = get(hObject,'Value');
a = items{index_selected};
% display(a);
if strcmp(ORDER_global, 'Global')
        if strcmp(a, '1 Gaussian')
            N_individual_1  = 1; 
        elseif strcmp(a, '2 Gaussians')
            N_individual_1  = 2 ;
        elseif strcmp(a, '3 Gaussians')
            N_individual_1  = 3; 
        elseif strcmp(a, '4 Gaussians')
            N_individual_1  = 4; 
        elseif strcmp(a, '5 Gaussians')
            N_individual_1  = 5; 
        end
        

        %%  OPTMIZATION
        
        N = N_individual_1;
        Total_Points = N_points*N_TEST;
        N_variables = (N_TEST*N)*2;
        DOF_global =  Total_Points - N_variables;
        DOF_individual =  DOF_global - N_TEST*N;
        Residual_individual = RES1+RES2+RES3+RES4+RES5;
        
X = [];
F = [];

R = [];
R1 = [];

 if guess_user == 1 
   [x_range1,~] = ginput(N);
 end
       
        


for i = 1:N_TEST
 
%Choosing the number of Gaussian

y = Y(:,i)';

options.MaxIter = N*500;
options.TolX = 1e-27;
options.TolFun = 1e-27;
options.MaxFunEvals = N*500;
% options.Algorithm = 'levenberg-marquardt';
options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');

interv = (t(end)-t(1))/(N+1);

if guess_user == 1 
  x_guess = x_range1;
else
  x_guess = linspace(t(1)+interv,t(end)-interv,N);
end

x0(1:N) = x_guess;
x0(N+1:2*N) = 1;
lb = zeros(length(x0),1);
ub = zeros(length(x0),1);
lb(1:N) = min(t)*ones(N,1);
ub(1:N) = max(t)*ones(N,1);
lb(N+1:2*N) = 1e-7;
ub(N+1:2*N) = 1e+7;

x_sol = lsqnonlin(@myObjective_Normal_distribution_LSQ ,x0,lb,ub,options);
X = [X, x_sol'];

[r, rmse] = rsquare(y,myObjective_Normal_distribution_plot(x_sol));
f = myObjective_Normal_distribution_plot(x_sol);

F = [F, f'];
R = [R, r];
R1 = [R1, rmse];
end


        X_individual = zeros(1,N);

        for i = 1:N
        X_individual(i) = X(i,1);
        
        end
        
        
        [Y_toplot,I_toplot] = sort(X_individual(1:N));
        
        
        
        if N_TEST >=1
        S = {num2str(Y_toplot)};
        set(handles.States1,'String',S);
        end
        
        if N_TEST >=2
        S = {num2str(Y_toplot)};
        set(handles.States2,'String',S);
        end
        
        if N_TEST >=3
        S = {num2str(Y_toplot)};
        set(handles.States3,'String',S);
        end
        
        if N_TEST >=4
        S = {num2str(Y_toplot)};
        set(handles.States4,'String',S);
        end
        
        if N_TEST >=5
        S = {num2str(Y_toplot)};
        set(handles.States5,'String',S);
        end
        

        %interv = (t(end)-t(1))/(N+1);
        %x_guess = linspace(t(1)+interv,t(end)-interv,N);
        %x0(1:N) = x_guess;
        x0 = 0.5*ones( 1, N*N_TEST );
        lb = zeros(length(x0),1);
        ub = zeros(length(x0),1);
        lb(1 : N*N_TEST) = 1e-7;
        ub(1 : N*N_TEST) = 1e+10;

        options.MaxIter = N*1500;
        options.TolX = 1e-27;
        options.TolFun = 1e-27;
        options.MaxFunEvals = N*1500;
%         options.Algorithm = 'levenberg-marquardt';
        options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');

%         [x,resnorm,residual]
        [x,resnorm] = lsqnonlin(@myObjective_Normal_distribution_LSQ_GLOBAL , x0,lb,ub,options);
        
        Residual_global = resnorm;




        x_single =  zeros(1,N*2);
        x_single(1:N) = X_individual;

        x = reshape(x, N ,N_TEST  )';
        
        global TT
        
        FF = [];
        RR = [];
        RR1 = [];
        for i = 1:N_TEST

        x_single(N+1:2*N) = x(i,1:N);
        fff = myObjective_Normal_distribution_plot1(x_single);
        FF = [FF, fff'];

        [r, rmse] = rsquare(Y(:,i)',myObjective_Normal_distribution_plot(x));
        RR = [RR, r];
        RR1 = [RR1, rmse];
        end
        
       
        
        
        if N_TEST >=1
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(1,I_toplot(i));
        end
        A = A'; 
        
        S = {num2str( A  )};
        set(handles.States11,'String',S)
        end
        
        if N_TEST >=2
        
            A = zeros(N,1);
        for i = 1:N
        A(i) = x(2,I_toplot(i));
        end
        A = A';
        
        S = {num2str( A )};
        set(handles.States22,'String',S)
        end
        
        if N_TEST >=3
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(3,I_toplot(i));
        end
        A = A';
        
        S = {num2str( A  )};
        set(handles.States33,'String',S)
        end
        
        if N_TEST >=4
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(4,I_toplot(i));
        end
        A = A';
        
        S = {num2str( A  )};
        set(handles.States44,'String',S)
        end
        
        if N_TEST >=5
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(1,I_toplot(i));
        end
        A = A';
        
        S = {num2str( A  )};
        set(handles.States55,'String',S)
        end

        
        
        
        
        if N_TEST == 5
        axes(handles.Plot5);
        bar(t,y5)
        hold on
        plot(TT,FF(:,5),'g-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Global Fitted Function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y5);
y_max = max(y5);
axis([x_min x_max y_min 1.8*y_max]);
        end
        
        if N_TEST >= 4
        axes(handles.Plot4);
        bar(t, y4)
        hold on
        plot(TT,FF(:,4),'g-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Global Fitted Function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y4);
y_max = max(y4);
axis([x_min x_max y_min 1.8*y_max]);
        end
        
        if N_TEST >= 3
        axes(handles.Plot3);
        bar(t,y3)
        hold on
        plot(TT,FF(:,3),'g-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Global Fitted Function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y3);
y_max = max(y3);
axis([x_min x_max y_min 1.8*y_max]);
        end
        
        if N_TEST >= 2
        axes(handles.Plot2);
        bar(t, y2)
        hold on
        plot(TT,FF(:,2),'g-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Global Fitted Function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y2);
y_max = max(y2);
axis([x_min x_max y_min 1.8*y_max]);
        end
        
        if N_TEST >= 1
        axes(handles.Plot1);
        bar(t, y1)
        hold on
        plot(TT,FF(:,1),'g-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Global Fitted Function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y1);
y_max = max(y1);
axis([x_min x_max y_min 1.8*y_max]);
        end
        
%         wssq_2 = Residual_global;
%         wssq_1 = Residual_individual;
%         dfe_2 = DOF_global;
%         dfe_1 = DOF_individual;
%         dfe_diff = dfe_2-dfe_1;
%         %% compute the F statistic
%         F_stat = ( (wssq_2 - wssq_1)/(dfe_2-dfe_1) ) / (wssq_1/dfe_1);
%         p = 1-fcdf(F_stat,dfe_diff,dfe_1);

        n = Total_Points;
        np1 = DOF_individual;
        np2 = DOF_global;
        chi1 = Residual_individual;
        chi2 = Residual_global;
        [ p ] = ftest(n,np1,np2,chi1,chi2);
        disp(p)
        
        p = 1 - p;
         
        S = {'P value = ' num2str(p)};
        set(handles.P_value,'String',S)
 end


% --- Executes during object creation, after setting all properties.
function G_list_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to G_list_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Global_1.
function Global_1_Callback(hObject, eventdata, handles)
% hObject    handle to Global_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Global_1
global ORDER_global
a = get(hObject,'Value');

if a == 1
ORDER_global = 'Global';
else 
ORDER_global = 'Nothing';    
end

% --- Executes on button press in Individual_1.
function Individual_1_Callback(hObject, eventdata, handles)
% hObject    handle to Individual_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global ORDER1
a = get(hObject,'Value');

if a == 1
ORDER1 = 'Individual';
else 
ORDER1 = 'Nothing';    
end


% --- Executes on button press in Individual_2.
function Individual_2_Callback(hObject, eventdata, handles)
% hObject    handle to Individual_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Individual_2
global ORDER2
a = get(hObject,'Value');

if a == 1
ORDER2 = 'Individual';
else 
ORDER2 = 'Nothing';    
end

% --- Executes on button press in Individual_3.
function Individual_3_Callback(hObject, eventdata, handles)
% hObject    handle to Individual_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Individual_3
global ORDER3
a = get(hObject,'Value');

if a == 1
ORDER3 = 'Individual';
else 
ORDER3 = 'Nothing';    
end

% --- Executes on button press in Individual_4.
function Individual_4_Callback(hObject, eventdata, handles)
% hObject    handle to Individual_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Individual_4
global ORDER4
a = get(hObject,'Value');

if a == 1
ORDER4 = 'Individual';
else 
ORDER4 = 'Nothing';    
end

% --- Executes on button press in Individual_5.
function Individual_5_Callback(hObject, eventdata, handles)
% hObject    handle to Individual_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Individual_5
global ORDER5
a = get(hObject,'Value');

if a == 1
ORDER5 = 'Individual';
else 
ORDER5 = 'Nothing';    
end


% --- Executes on selection change in I_list_1.
function I_list_1_Callback(hObject, eventdata, handles)
% hObject    handle to I_list_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns I_list_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from I_list_1
global ORDER1
global x1
global y1
global y
global t
global N
global RES1
global RES2
global RES3
global RES4
global RES5

global TT

items = get(hObject,'String');
index_selected = get(hObject,'Value');
a = items{index_selected};
% display(a);
global guess_user
global guess_sdv
if strcmp(ORDER1, 'Individual')
        if strcmp(a, '1 Gaussian')
            N_individual_1  = 1; 
        elseif strcmp(a, '2 Gaussians')
            N_individual_1  = 2 ;
        elseif strcmp(a, '3 Gaussians')
            N_individual_1  = 3; 
        elseif strcmp(a, '4 Gaussians')
            N_individual_1  = 4; 
        elseif strcmp(a, '5 Gaussians')
            N_individual_1  = 5; 
        end


        %%  OPTMIZATION
        N = N_individual_1;
        y = y1;

        if guess_user == 1 
            [x_range1,y_range1] = ginput(N);
        end
        
        if guess_sdv == 1 
%             [~,y_range1] = ginput(2*N);
            Y_guess = [];
            for i = 1:N 
               yg = abs(y_range1(i) - 0)/600;
               Y_guess = [Y_guess, yg];
            end
        end
  

if N > 1 
        interv = (t(end)-t(1))/(N+1);
        
         if guess_user == 1 
            x_guess = x_range1;
         else
            x_guess = linspace(t(1)+interv,t(end)-interv,N);
         end
        x0(1:N) = x_guess;
        if guess_sdv == 1 
            x0(N+1:2*N) = Y_guess;
        else
            x0(N+1:2*N) = 0.02;
        end
        
        lb = zeros(length(x0),1);
        ub = zeros(length(x0),1);

        lb(1:N) = min(t)*ones(N,1);
        ub(1:N) = max(t)*ones(N,1);
        lb(N+1:2*N) = 1e-4;
        ub(N+1:2*N) = 1e+6;

        options.MaxIter = N*500;
        options.TolX = 1e-27;
        options.TolFun = 1e-27;
        options.MaxFunEvals = N*500;
        % options.Algorithm = 'levenberg-marquardt';
        options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
        [x,resnorm] = lsqnonlin(@myObjective_Normal_distribution_LSQ , x0,lb,ub,options);

        RES1 = resnorm;
        % R2 : Coefficient of determination 
        % RMSE : Root mean squared error 
        [r2, rmse] = rsquare(y,myObjective_Normal_distribution_plot(x));
        
        
        axes(handles.Plot1);
        bar(t,y1)
        hold on
        plot(TT,myObjective_Normal_distribution_plot1(x),'b-.','LineWidth',3)
        hold off
        
        
%         plot(t,y1,'r-',TT,myObjective_Normal_distribution_plot1(x),'b-.','LineWidth',3)
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        S = {'wss = ' num2str(RES1)};
        set(handles.Rsquared_1,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        x1 = x;
        
        [Y,I] = sort(x(1:N));
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(N+I(i));
        end
        A = A';
        
        S = {num2str(Y)};
        set(handles.States1,'String',S)
        
        S = {num2str(A)};
        set(handles.States11,'String',S)
        
end        
        
if N <= 1   
x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
        n = num2str(N);
        name = ['gauss' n];

        f = fit(t.',y.',name);
        

        Coef = coeffvalues(f);
        Coef = reshape(Coef,[N,3]);

        fff = gauss_distribution(f,N,TT);
        axes(handles.Plot1);
        bar(t,y)
        hold on        
        plot(TT,fff,'b-.','LineWidth',3)
        hold off

        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on

axis([x_min x_max y_min 1.8*y_max]);
        
        
        S = {num2str(Coef(:,2)')};
        set(handles.States1,'String',S)
        
        
        sigma = [];
        for i = 1:N
        as = Coef(i,1)*(sqrt(2*pi));    
        ss = 1/as;
        sigma = [sigma ss];
        end
        
        S = {num2str(sigma)};
        set(handles.States11,'String',S)
        
%         [r2, rmse] = rsquare(y,gauss_distribution(f,N,t));
        f_res = abs(gauss_distribution(f,N,t) -  y);
        resnorm = sum( f_res.^2 ) ;
        RES2 = resnorm;
        S = {'wss = ' num2str(RES2)};
        set(handles.Rsquared_2,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        
        end



end



% --- Executes during object creation, after setting all properties.
function I_list_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I_list_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in I_list_2.
function I_list_2_Callback(hObject, eventdata, handles)
% hObject    handle to I_list_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns I_list_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from I_list_2
global ORDER2
global x2
global y2
global y
global t
global N
global RES1
global RES2
global RES3
global RES4
global RES5
global TT
items = get(hObject,'String');
index_selected = get(hObject,'Value');
a = items{index_selected};
% display(a);
 global guess_user 

if strcmp(ORDER2, 'Individual')
        if strcmp(a, '1 Gaussian')
            N_individual_1  = 1; 
        elseif strcmp(a, '2 Gaussians')
            N_individual_1  = 2 ;
        elseif strcmp(a, '3 Gaussians')
            N_individual_1  = 3; 
        elseif strcmp(a, '4 Gaussians')
            N_individual_1  = 4; 
        elseif strcmp(a, '5 Gaussians')
            N_individual_1  = 5; 
        end


        %%  OPTMIZATION
        N = N_individual_1;
        y = y2;
        
        if guess_user == 1 
            [x_range1,~] = ginput(N);
        end
        
        if N > 1
        interv = (t(end)-t(1))/(N+1);
        if guess_user == 1 
            x_guess = x_range1;
         else
            x_guess = linspace(t(1)+interv,t(end)-interv,N);
         end
        x0(1:N) = x_guess;
        x0(N+1:2*N) =0.02;
        lb = zeros(length(x0),1);
        ub = zeros(length(x0),1);

        lb(1:N) = min(t)*ones(N,1);
        ub(1:N) = max(t)*ones(N,1);
        lb(N+1:2*N) = 1e-4;
        ub(N+1:2*N) = 1e+6;

        options.MaxIter = N*500;
        options.TolX = 1e-27;
        options.TolFun = 1e-27;
        options.MaxFunEvals = N*500;
        % options.Algorithm = 'levenberg-marquardt';
        options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
        [x,resnorm] = lsqnonlin(@myObjective_Normal_distribution_LSQ , x0,lb,ub,options);

        RES2 = resnorm;
        % R2 : Coefficient of determination 
        % RMSE : Root mean squared error 
        [r2, rmse] = rsquare(y,myObjective_Normal_distribution_plot(x));

        axes(handles.Plot2);
        bar(t,y)
        hold on
        plot(TT,myObjective_Normal_distribution_plot1(x),'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);


axis([x_min x_max y_min 1.8*y_max]);
        
        S = {'wss = ' num2str(RES2)};
        set(handles.Rsquared_2,'String',S)
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        x2 = x;
        
        [Y,I] = sort(x(1:N));
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(N+I(i));
        end
        A = A';
        
        S = {num2str(Y)};
        set(handles.States2,'String',S)
        
        S = {num2str(A)};
        set(handles.States22,'String',S)
        
        end

        if N <= 1   
        n = num2str(N);
        name = ['gauss' n];

        f = fit(t.',y.',name);

        Coef = coeffvalues(f);
        Coef = reshape(Coef,[N,3]);

        fff = gauss_distribution(f,N,TT);
        axes(handles.Plot2);
        bar(t,y)
        hold on
        plot(TT,fff,'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
        x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        
        S = {num2str(Coef(:,2)')};
        set(handles.States2,'String',S)
        
        
        sigma = [];
        for i = 1:N
        as = Coef(i,1)*(sqrt(2*pi));    
        ss = 1/as;
        sigma = [sigma ss];
        end
        
        S = {num2str(sigma)};
        set(handles.States22,'String',S)
        
%         [r2, rmse] = rsquare(y,gauss_distribution(f,N,t));
        f_res = abs(gauss_distribution(f,N,t) -  y);
        resnorm = sum( f_res.^2 ) ;
        RES2 = resnorm;
        S = {'wss = ' num2str(RES2)};
        set(handles.Rsquared_2,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        
        end

end
 

% --- Executes during object creation, after setting all properties.
function I_list_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I_list_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.





if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in I_list_3.
function I_list_3_Callback(hObject, eventdata, handles)
% hObject    handle to I_list_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns I_list_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from I_list_3
global ORDER3
global x3
global y3
global y
global t
global N
global RES1
global RES2
global RES3
global RES4
global RES5

global TT
global guess_user
items = get(hObject,'String');
index_selected = get(hObject,'Value');
a = items{index_selected};
% display(a);
if strcmp(ORDER3, 'Individual')
        if strcmp(a, '1 Gaussian')
            N_individual_1  = 1; 
        elseif strcmp(a, '2 Gaussians')
            N_individual_1  = 2 ;
        elseif strcmp(a, '3 Gaussians')
            N_individual_1  = 3; 
        elseif strcmp(a, '4 Gaussians')
            N_individual_1  = 4; 
        elseif strcmp(a, '5 Gaussians')
            N_individual_1  = 5; 
        end


        %%  OPTMIZATION
        N = N_individual_1;
        y = y3;
        if guess_user == 1 
            [x_range1,~] = ginput(N);
        end
        
        if N > 2
        interv = (t(end)-t(1))/(N+1);
        if guess_user == 1 
            x_guess = x_range1;
        else
            x_guess = linspace(t(1)+interv,t(end)-interv,N);
        end
        x0(1:N) = x_guess;
        x0(N+1:2*N) = 1;
        lb = zeros(length(x0),1);
        ub = zeros(length(x0),1);

        lb(1:N) = min(t)*ones(N,1);
        ub(1:N) = max(t)*ones(N,1);
        lb(N+1:2*N) = 1e-7;
        ub(N+1:2*N) = 1e+7;

        options.MaxIter = N*500;
        options.TolX = 1e-27;
        options.TolFun = 1e-27;
        options.MaxFunEvals = N*500;
        % options.Algorithm = 'levenberg-marquardt';
        options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
        [x,resnorm] = lsqnonlin(@myObjective_Normal_distribution_LSQ , x0,lb,ub,options);

        RES3 = resnorm;
        % R2 : Coefficient of determination 
        % RMSE : Root mean squared error 
        [r2, rmse] = rsquare(y,myObjective_Normal_distribution_plot(x));

        axes(handles.Plot3);
        bar(t,y)
        hold on
        plot(TT,myObjective_Normal_distribution_plot1(x),'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);

        
        S = {'wss = ' num2str(RES3)};
        set(handles.Rsquared_3,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        x3 = x;
        
        [Y,I] = sort(x(1:N));
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(N+I(i));
        end
        A = A';
        
        S = {num2str(Y)};
        set(handles.States3,'String',S)
        
        S = {num2str(A)};
        set(handles.States33,'String',S)
        
        end
        
if N <= 2   
        n = num2str(N);
        name = ['gauss' n];

        f = fit(t.',y.',name);

        Coef = coeffvalues(f);
        Coef = reshape(Coef,[N,3]);

        fff = gauss_distribution(f,N,TT);
        axes(handles.Plot3);
        bar(t,y)
        hold on
        plot(TT,fff,'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
        x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        
        S = {num2str(Coef(:,2)')};
        set(handles.States3,'String',S)
        
        sigma = [];
        for i = 1:N
        as = Coef(i,1)*(sqrt(2*pi));    
        ss = 1/as;
        sigma = [sigma ss];
        end
        
        S = {num2str(sigma)};
        set(handles.States33,'String',S)
        
%         [r2, rmse] = rsquare(y,gauss_distribution(f,N,t));
        f_res = abs(gauss_distribution(f,N,t) -  y);
        resnorm = sum( f_res.^2 ) ;
        RES3 = resnorm;
        S = {'wss = ' num2str(RES3)};
        set(handles.Rsquared_3,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        
end
end

% --- Executes during object creation, after setting all properties.
function I_list_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I_list_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in I_list_4.
function I_list_4_Callback(hObject, eventdata, handles)
% hObject    handle to I_list_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns I_list_4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from I_list_4
global ORDER4
global x4
global y4
global y
global t
global N
global RES1
global RES2
global RES3
global RES4
global RES5
global TT
global guess_user
items = get(hObject,'String');
index_selected = get(hObject,'Value');
a = items{index_selected};
% display(a);
if strcmp(ORDER4, 'Individual')
        if strcmp(a, '1 Gaussian')
            N_individual_1  = 1; 
        elseif strcmp(a, '2 Gaussians')
            N_individual_1  = 2 ;
        elseif strcmp(a, '3 Gaussians')
            N_individual_1  = 3; 
        elseif strcmp(a, '4 Gaussians')
            N_individual_1  = 4; 
        elseif strcmp(a, '5 Gaussians')
            N_individual_1  = 5; 
        end


        %%  OPTMIZATION
        N = N_individual_1;
        y = y4;
        if guess_user == 1 
            [x_range1,~] = ginput(N);
        end
        
        if N > 2
        interv = (t(end)-t(1))/(N+1);
        if guess_user == 1 
            x_guess = x_range1;
        else
            x_guess = linspace(t(1)+interv,t(end)-interv,N);
        end
        x0(1:N) = x_guess;
        x0(N+1:2*N) = 1;
        lb = zeros(length(x0),1);
        ub = zeros(length(x0),1);

        lb(1:N) = min(t)*ones(N,1);
        ub(1:N) = max(t)*ones(N,1);
        lb(N+1:2*N) = 1e-7;
        ub(N+1:2*N) = 1e+7;

        options.MaxIter = N*500;
        options.TolX = 1e-27;
        options.TolFun = 1e-27;
        options.MaxFunEvals = N*500;
        % options.Algorithm = 'levenberg-marquardt';
        options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
        [x,resnorm] = lsqnonlin(@myObjective_Normal_distribution_LSQ , x0,lb,ub,options);

        RES4 = resnorm;
        % R2 : Coefficient of determination 
        % RMSE : Root mean squared error 
        [r2, rmse] = rsquare(y,myObjective_Normal_distribution_plot(x));

        axes(handles.Plot4);
        bar(t,y)
        hold on
        plot(TT,myObjective_Normal_distribution_plot1(x),'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        S = {'wss = ' num2str(RES4)};
        set(handles.Rsquared_4,'String',S)
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        x4 = x;
        
        [Y,I] = sort(x(1:N));
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(N+I(i));
        end
        A = A';
        
        S = {num2str(Y)};
        set(handles.States4,'String',S)
        
        S = {num2str(A)};
        set(handles.States44,'String',S)
        end
        
if N <= 2   
        n = num2str(N);
        name = ['gauss' n];

        f = fit(t.',y.',name);

        Coef = coeffvalues(f);
        Coef = reshape(Coef,[N,3]);

        fff = gauss_distribution(f,N,TT);
        axes(handles.Plot4);
        bar(t,y)
        hold on
        plot(TT,fff,'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
        x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        
        S = {num2str(Coef(:,2)')};
        set(handles.States4,'String',S)
        
        sigma = [];
        for i = 1:N
        as = Coef(i,1)*(sqrt(2*pi));    
        ss = 1/as;
        sigma = [sigma ss];
        end
        
        S = {num2str(sigma)};
        set(handles.States44,'String',S)
        
%         [r2, rmse] = rsquare(y,gauss_distribution(f,N,t));
        f_res = abs(gauss_distribution(f,N,t) -  y);
        resnorm = sum( f_res.^2 ) ;
        RES4 = resnorm;
        S = {'wss = ' num2str(RES4)};
        set(handles.Rsquared_4,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        
end
end

% --- Executes during object creation, after setting all properties.
function I_list_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I_list_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in I_list_5.
function I_list_5_Callback(hObject, eventdata, handles)
% hObject    handle to I_list_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns I_list_5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from I_list_5
global ORDER5
global x5
global y5
global y
global t
global N
global RES1
global RES2
global RES3
global RES4
global RES5
global guess_user
global TT
items = get(hObject,'String');
index_selected = get(hObject,'Value');
a = items{index_selected};
% display(a);
if strcmp(ORDER5, 'Individual')
        if strcmp(a, '1 Gaussian')
            N_individual_1  = 1; 
        elseif strcmp(a, '2 Gaussians')
            N_individual_1  = 2 ;
        elseif strcmp(a, '3 Gaussians')
            N_individual_1  = 3; 
        elseif strcmp(a, '4 Gaussians')
            N_individual_1  = 4; 
        elseif strcmp(a, '5 Gaussians')
            N_individual_1  = 5; 
        end


        %%  OPTMIZATION
        N = N_individual_1;
        y = y5;
        if guess_user == 1 
            [x_range1,~] = ginput(N);
        end

        if N > 2
        interv = (t(end)-t(1))/(N+1);
        if guess_user == 1 
            x_guess = x_range1;
        else
            x_guess = linspace(t(1)+interv,t(end)-interv,N);
        end
        x0(1:N) = x_guess;
        x0(N+1:2*N) = 1;
        lb = zeros(length(x0),1);
        ub = zeros(length(x0),1);

        lb(1:N) = min(t)*ones(N,1);
        ub(1:N) = max(t)*ones(N,1);
        lb(N+1:2*N) = 1e-7;
        ub(N+1:2*N) = 1e+7;

        options.MaxIter = N*500;
        options.TolX = 1e-27;
        options.TolFun = 1e-27;
        options.MaxFunEvals = N*500;
        % options.Algorithm = 'levenberg-marquardt';
        options = optimoptions(@lsqnonlin,'Algorithm','trust-region-reflective');
        [x,resnorm] = lsqnonlin(@myObjective_Normal_distribution_LSQ , x0,lb,ub,options);

        
        RES5 = resnorm;
        % R2 : Coefficient of determination 
        % RMSE : Root mean squared error 
        [r2, rmse] = rsquare(y,myObjective_Normal_distribution_plot(x));

        axes(handles.Plot5);
        bar (t,y)
        hold on
        plot(TT,myObjective_Normal_distribution_plot1(x),'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        S = {'wss = ' num2str(RES5)};
        set(handles.Rsquared_5,'String',S)  
        
        
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        x5 = x;
        
        
        [Y,I] = sort(x(1:N));
        A = zeros(N,1);
        for i = 1:N
        A(i) = x(N+I(i));
        end
        A = A';
        
        S = {num2str(Y)};
        set(handles.States5,'String',S)

        S = {num2str(A)};
        set(handles.States55,'String',S)
        end
        
if N <= 2   
        n = num2str(N);
        name = ['gauss' n];

        f = fit(t.',y.',name);

        Coef = coeffvalues(f);
        Coef = reshape(Coef,[N,3]);

        fff = gauss_distribution(f,N,TT);
        axes(handles.Plot5);
        bar(t,y)
        hold on
        plot(TT,fff,'b-.','LineWidth',3)
        hold off
        xlabel('FRET')
        legend('Normal density','Fitted function')
        T = ylabel('Occ.');
        set(T,'Rotation',0); 
        grid on
        x_min = min(t);
x_max = max(t);
y_min = min(y);
y_max = max(y);
axis([x_min x_max y_min 1.8*y_max]);
        
        
        S = {num2str(Coef(:,2)')};
        set(handles.States5,'String',S)
        
        sigma = [];
        for i = 1:N
        as = Coef(i,1)*(sqrt(2*pi));    
        ss = 1/as;
        sigma = [sigma ss];
        end
        
        S = {num2str(sigma)};
        set(handles.States55,'String',S)
        
%         [r2, rmse] = rsquare(y,gauss_distribution(f,N,t));
        f_res = abs(gauss_distribution(f,N,t) -  y);
        resnorm = sum( f_res.^2 ) ;
        RES5 = resnorm;
        S = {'wss = ' num2str(RES5)};
        set(handles.Rsquared_5,'String',S) 
        
        S = {'wss total = ' num2str(RES1+RES2+RES3+RES4+RES5)};
        set(handles.total,'String',S)
        
end
end

% --- Executes during object creation, after setting all properties.
function I_list_5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to I_list_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Creating Data to Plot
global t
global y1
global y2
global y3
global y4
global y5
global N_points
global Counter
global N_TEST
%y1 = [];
% y2 = [];
% y3 = [];
% y4 = [];
% y5 = [];




[filename, pathname] = uigetfile({'*'},'File Selector');

% filename = load(filename);
% file = load('filename');
% filename = fopen(filename);
% filename = dlmread(filename);
% filename = load(filename,'file');
% filename = eval(filename);
% filename = importdata(filename);
% filename =  open filename
load(filename)

% filename = load(filename,'file');  % Function output form of LOAD
% filename = filename.file;

Counter = Counter +1;
num = length(file_sel_hist);
if Counter == 1
factor = round(0.01*num);
[file1] = histc(file_sel_hist,linspace(0,1,factor));
end
if Counter > 1
factor = length(y1);
[file1] = histc(file_sel_hist,linspace(0,1,factor));
end




if Counter == 1
y1 = file1;
end
if Counter == 2
y2 = file1;
end
if Counter == 3
y3 = file1;
end
if Counter == 4
y4 = file1;
end
if Counter == 5
y5 = file1;
end

global TT

% t = 1:length(filename);
t = linspace(0,1,factor);
% t = linspace(0,10,100);
N_points = length(t);

aaa = min(t);
bbb = max(t);
TT = linspace(aaa,bbb,300);


x_min = 0;
x_max = 1;
y_min = 0;
y_max = max(file1);


N_TEST = Counter;

if N_TEST == 5
axes(handles.Plot5);
bar(t,y5)
xlabel('FRET')
legend('Normal density')
T = ylabel('Occ.');
set(T,'Rotation',0); 
grid on
axis([x_min x_max y_min 1.8*y_max]);
end

if N_TEST == 4
axes(handles.Plot4);
bar(t,y4)
xlabel('FRET')
legend('Normal density')
T = ylabel('Occ.');
set(T,'Rotation',0); 
grid on
axis([x_min x_max y_min 1.8*y_max]);
end

if N_TEST == 3
axes(handles.Plot3);
bar(t,y3)
xlabel('FRET')
legend('Normal density')
T = ylabel('Occ.');
set(T,'Rotation',0); 
grid on
axis([x_min x_max y_min 1.8*y_max]);
end

if N_TEST == 2
axes(handles.Plot2);
bar(t,y2)
xlabel('FRET')
legend('Normal density')
T = ylabel('Occ.');
set(T,'Rotation',0); 
grid on
axis([x_min x_max y_min 1.8*y_max]);
end

if N_TEST == 1
axes(handles.Plot1);
bar(t,y1)
xlabel('FRET')
legend('Normal density')
T = ylabel('Occ.');
set(T,'Rotation',0); 
grid on
axis([x_min x_max y_min 1.8*y_max]);
end


% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close
clear
clear global
clc
GUI_first_task





function fff = gauss_distribution(f,N,x)

if N == 1
a1 = f.a1;
b1 = f.b1;
c1 = f.c1;
fff = @(x) a1.*exp( -( (x-b1)./c1 ).^2   )  ;
fff = fff(x);
end

if N == 2
a1 = f.a1;
b1 = f.b1;
c1 = f.c1;
a2 = f.a2;
b2 = f.b2;
c2 = f.c2;
fff = @(x) a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2);
fff = fff(x);
end

if N == 3
fff = @(x) f.a1.*exp(-((x-f.b1)./f.c1).^2) + f.a2.*exp(-((x-f.b2)./f.c2).^2) + ...
           f.a3.*exp(-((x-f.b3)./f.c3).^2);
fff = fff(x);
end
if N == 4
fff = @(x) f.a1.*exp(-((x-f.b1)./f.c1).^2) + f.a2.*exp(-((x-f.b2)./f.c2).^2) + ...
           f.a3.*exp(-((x-f.b3)./f.c3).^2) + f.a4.*exp(-((x-f.b4)./f.c4).^2);
fff = fff(x);
end
if N == 5
fff = @(x) f.a1.*exp(-((x-f.b1)./f.c1).^2) + f.a2.*exp(-((x-f.b2)./f.c2).^2) + ...
           f.a3.*exp(-((x-f.b3)./f.c3).^2) + f.a4.*exp(-((x-f.b4)./f.c4).^2) + ...
           f.a5.*exp(-((x-f.b5)./f.c5).^2);
fff = fff(x);
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
global guess_user
guess_user = 0;


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
global guess_user
guess_user = 1;


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
global guess_sdv
guess_sdv = 0;


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4
global guess_sdv
guess_sdv = 1;
