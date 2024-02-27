function [F] = myObjective_Normal_distribution_plot1(x)

global N 
global t
global TT

% A = [1:2:N];
% B = [2:2:N+1];
%n = ceil(N/2);



A = 1:N;
B = N+1:2*N; 
funcc =  0;

for i= 1 : N    
   funcc = funcc + normpdf(TT,x(A(i)),x(B(i)));    
end

F =  funcc;




end