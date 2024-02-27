function [F] = myObjective_Normal_distribution_LSQ_GLOBAL(x)

global N_TEST
global N 
global Y
global t
global X_individual

% A = [1:2:N];
% B = [2:2:N+1];
%n = ceil(N/2);

N_variables_sigma = N*N_TEST;


A = X_individual';

B = 1:N_variables_sigma; 
B = reshape(B, N ,N_TEST  )';


FUNC = [];
for j = 1:N_TEST
   funcc = -Y(:,j)';
   
   for i= 1:N    
     funcc = funcc + normpdf(t,A(i),x( B(j,i) ) );   
   end
   
   FUNC = [FUNC; funcc];
end

F =  FUNC;


end