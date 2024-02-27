% a = [ 1 1 1 1 1 1 1 1 1 1 2 2 2 1 1 1 1 1 2 2 2 2 2 1 1 1 2 2 1 1 2 2 -4 ];
% b1 = find(diff(a) == 1);
% b2 =find(diff(a) == -1);
% b3 = find(diff(a) == 2);
% b4 = find(diff(a) ==-2);
% b = sort([b1 b2 b3 b4]);
% 
% % get the before and after points;
% counter = 0;
% for i = 1:length(b)
%     counter = counter + 1;
%     e_init = a(b(i)-1);
%     e_fin = a(b(i)+1);
%     tdps(counter,:) = [e_init e_fin];
% end
% 


a = [1 1 1 1 1 1 1 1 4 4 4 4 4 4 4 4 4];
b = [8 8 8 8 2 2 2 2 4 4 4 4 4 4 4 4 4];
histogram2(a,b)












