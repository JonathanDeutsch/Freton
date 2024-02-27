function [F] = myObjective_Normal_distribution_LSQ(x)

global N 
global y
global t

% A = [1:2:N];
% B = [2:2:N+1];
%n = ceil(N/2);

A = 1:N;
B = N+1:2*N; 
funcc = 0;

for i= 1:N  
   
   funcc = funcc + normpdf(t,x(A(i)),x(B(i)));  
%    funcc = funcc + gaussmf(t,[x(A(i)) x(B(i))])  ; 
%    funcc = funcc   + gauss_distribution(t,x(A(i)),x(B(i))) ; 
  

end
F =   funcc  - y;

% F =   funcc ;
end



function f = gauss_distribution(x, mu, s)
p1 = -.5 * ((x - mu)/s) .^ 2;
p2 = (s * sqrt(2*pi));
f = exp(p1) ./ p2; 

end


