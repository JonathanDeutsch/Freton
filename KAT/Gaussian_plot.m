function [F] = Gaussian_plot(x)

load('traces_All.mat')

%% Creating Raw Data

global y
global t
t = linspace(0,1,20);
global TT
aaa = min(t);
bbb = max(t);
TT = linspace(aaa,bbb,2000);

[file] = histc(file,linspace(0,1,20));
y = file; 

N = 5;
n = num2str(N);
name = ['gauss' n];

f = fit(t.',y.',name);

% Coef = coeffvalues(f);
% Coef = reshape(Coef,[2,3]);
fff = gauss_distribution(f,N,TT);



figure()
plot(t,y,'r-','LineWidth',3)
hold on
plot(TT,fff,'b--','LineWidth',3)
xlabel('Time')
legend('Normal density','Fitted function')
T = ylabel('Occurrences');
set(T,'Rotation',0); 
grid on



end

function fff = gauss_distribution(f,N,x)

if N == 1
fff = @(x) f.a1.*exp(-((x-f.b1)./f.c1).^2);
fff = fff(x);
end
if N == 2
fff = @(x) f.a1.*exp(-((x-f.b1)./f.c1).^2) + f.a2.*exp(-((x-f.b2)./f.c2).^2);
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

end