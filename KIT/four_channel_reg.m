% For Future Release 
% 4 Channel registration
%Rotation 1
% Do the registration
         tform = imregtform(image_d1, image_d, 'rigid', optimizer, metric);
         movingRegisteredDefault = imwarp(image_d1,tform,'OutputView',imref2d(size(image_d)));         
         %Rotation 2
         tform = imregtform(image_d, image_a1, 'rigid', optimizer, metric);
         movingRegisteredDefault = imwarp(image_d,tform,'OutputView',imref2d(size(image_a1)));         
         tform = imregtform(image_d1, image_a1, 'rigid', optimizer, metric);
         movingRegisteredDefault = imwarp(image_d1,tform,'OutputView',imref2d(size(image_a1)));         
         %Rotation 3
         tform = imregtform(image_a1, image_a, 'rigid', optimizer, metric);
         movingRegisteredDefault = imwarp(image_a1,tform,'OutputView',imref2d(size(image_a)));         
         tform = imregtform(image_d1, image_a, 'rigid', optimizer, metric);
         movingRegisteredDefault = imwarp(image_d1,tform,'OutputView',imref2d(size(image_a)));         
         tform = imregtform(image_d, image_a, 'rigid', optimizer, metric);
         movingRegisteredDefault = imwarp(image_d,tform,'OutputView',imref2d(size(image_a)));
         
         
% Apply the registration         
         reg_file1 = uigetfile('.mat', 'Select reg_coordin file1');
         setappdata(handles.image_register1,'reg_coord1',reg_file1);
         load(reg_file1,'tform1');
             
         reg_file2 = uigetfile('.mat', 'Select reg_coordin file2');
         setappdata(handles.image_register2,'reg_coord2',reg_file2);
         load(reg_file2,'tform2');
             
             %1st Rotation
          movingRegisteredDefault0 = imwarp(image_d1,tform1,'OutputView',imref2d(size(image_d1)));
          movingRegisteredDefault1 = imwarp(image_d,tform1,'OutputView',imref2d(size(image_d)));
             %2nd Rotation
          movingRegisteredDefault2 = imwarp(image_d1,tform2,'OutputView',imref2d(size(image_d)));
          movingRegisteredDefault3 = imwarp(image_d,tform2,'OutputView',imref2d(size(image_d)));
          movingRegisteredDefault4 = imwarp(image_a1,tform2,'OutputView',imref2d(size(image_d)));
          movingRegisteredDefault5 = imwarp(image_a,tform2,'OutputView',imref2d(size(image_d)));