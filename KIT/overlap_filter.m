function [index_tot] = overlap_filter(centers, radii)
%UNTITLED Summary of this function goes here
%   This function compares the circles identified in any channel to itself
%   to remove overlap

num_circ = length(radii);
overlap = [];
for i = 1:num_circ
    x1 = centers(i,1);
    y1 = centers(i,2);
    r1 = radii(i);
    for j = 1:num_circ
        x2 = centers(j,1);
        y2 = centers(j,2);
        r2 = radii(j);        
        d2 = (x2-x1)^2+(y2-y1)^2;
        d = sqrt(d2);
        t = ((r1+r2)^2-d2)*(d2-(r2-r1)^2);
            if t >= 0 % The circles overlap
                A = r1^2*acos((r1^2-r2^2+d2)/(2*d*r1)) ...
                +r2^2*acos((r2^2-r1^2+d2)/(2*d*r2)) ...
                -1/2*sqrt(t);
            elseif d > r1+r2  % The circles are disjoint
                A = 0;
            else  % One circle is contained entirely within the other
                A = pi*min(r1,r2)^2;
            end
            % Get the overlap points
            % th = A
            if  A>=1
                pos = i;
                overlap = vertcat(overlap, pos);   
            end        
    end
end
sort(overlap);
index_tot = (1:num_circ)';
index_tot(overlap) = [];



