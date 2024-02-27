function [centers, radii,cent_map] = centroid_finder (img_centroid, th,os,optom)
%% This function uses a 2-D gaussian to find centroid of single-particles
% Create a structure s
                % get the image for centroid processing
                d = img_centroid;             
                % edge
                edg = 6;                 
                % indexing within the next for-loop
                sd=size(d);
                [x y]=find(d(edg:sd(1)-2*edg,edg:sd(2)-2*edg));                
                % initialize outputs
                cent=[];%
                cent_map=zeros(sd);                
                x=x+edg-1;
                y=y+edg-1;
                %th=100; % threshold
                %os=2; % offset pixels                
                binary = zeros(sd);                
                % this for-loop interates through all pixels within i-th frame and 
                %searches for center pixel that is larger than neighboring (offset) pixels by threshold (th) 
                for j=1:length(y)
                    if (d(x(j),y(j))-d(x(j)-os,y(j)-os ))>=th &&...
                            (d(x(j),y(j))-d(x(j)-os,y(j)))>th &&...
                            (d(x(j),y(j))-d(x(j)-os,y(j)+os))>=th &&...
                            (d(x(j),y(j))-d(x(j),y(j)-os))>th && ...
                            (d(x(j),y(j))-d(x(j),y(j)+os))>th && ...
                            (d(x(j),y(j))-d(x(j)+os,y(j)-os))>=th && ...
                            (d(x(j),y(j))-d(x(j)+os,y(j)))>th && ...
                            (d(x(j),y(j))-d(x(j)+os,y(j)+os))>=th;  
                        binary(x(j),y(j))=1;                        
                        cent(size(cent,1)+1, 1) = y(j);
                        cent(size(cent,1), 2) = x(j);
                        cent_map(x(j),y(j))=cent_map(x(j),y(j))+1; % if a binary matrix output is desired                        
                    end
                end          
                
% create binary type image to identify centroids
bw = im2bw(binary, 0.5);
stats = regionprops(bw, 'centroid');
centroids = cat(1, stats.Centroid);
stats = regionprops('table',bw,'Centroid',...
    'MajorAxisLength','MinorAxisLength');
centers = stats.Centroid;
diameters = mean([stats.MajorAxisLength stats.MinorAxisLength],2);
radii = (diameters.*optom)/2;
end

