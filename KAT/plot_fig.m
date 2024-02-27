load('exp_25.mat')
%25 length
x_axis = 1:30;
x_axis = x_axis*0.25;
f_trace = fret_trace(1:30);
d_trace = don_sel(1:30)./mean(don_sel(1:5));
a_trace = accep_sel(1:30)./mean(accep_sel(1:5));
figure(1)
subplot(2,1,1)
plot(x_axis, d_trace,'g', x_axis, a_trace,'r');
set(gca,'FontSize',20)
set(gca,'Xticklabel',[]) 
subplot(2,1,2)
plot(x_axis, f_trace);
ylim ([0 1])
set(gca,'FontSize',20)
hold on
 load('exp_92.mat')
 f_trace2 = fret_trace(1:22);
 plot(x_axis(1:22), f_trace2,'k');
% load('exp_132.mat')
% f_trace3 = fret_trace(1:25);
% plot(x_axis, f_trace3);
