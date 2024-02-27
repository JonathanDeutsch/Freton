function [seg_1_raw, seg_1_ideal, seg_2_raw, seg_2_ideal, seg_3_raw, seg_3_ideal] = tracesegments(eb_sel_trace,num_states,eb_sel_trace1_raw,eb_sel_trace1_ideal,longest_trans)
%Get the individual segments
%   Detailed explanation goes here
a = eb_sel_trace;
counter_1 = 0;
counter_2 = 0;
counter_3 = 0;
counter_4 = 0;
counter_5 = 0;
counter_6 = 0;
counter = 0;
state_1 = [];
state_2 = [];
state_3 = [];
state_4 = [];
state_5 = [];
state_6 = [];
seg_1_raw = [];
seg_1_ideal = [];
seg_2_raw = [];
seg_2_ideal = [];
seg_3_raw = [];
seg_3_ideal = [];
% Select number of states 2-6
switch num_states
    case{2}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            % get indicies
            counter_1 = counter_1 + 1;
            b1(:,counter_1) = i;            
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
            b2(:,counter_2) = i;
        end        
   else      
        counter = counter+1;
        if counter_1 >0
             b1(:,counter_1) = i;
             if length(b1) >=3
             seg_1_raw_tt = eb_sel_trace1_raw(b1(2:end-1));
             seq_1_ideal_tt = eb_sel_trace1_ideal(b1(2:end-1)); 
             else
             seg_1_raw_tt = eb_sel_trace1_raw(b1);
             seq_1_ideal_tt = eb_sel_trace1_ideal(b1);    
             end
             % pad the matrix to equal lengths
             diff_length_t = longest_trans - length(seg_1_raw_tt);
             diff_length = zeros(diff_length_t,1);
             seg_1_raw_t = vertcat(seg_1_raw_tt,diff_length);
             seq_1_ideal_t = vertcat(seq_1_ideal_tt,diff_length);
             seg_1_raw(:,counter) = seg_1_raw_t;
             seg_1_ideal(:,counter) =seq_1_ideal_t;  
        elseif counter_2 >0
             b2(:,counter_2) = i;
             if length(b2) >=3
             seg_2_raw_tt = eb_sel_trace1_raw(b2(2:end-1));
             seq_2_ideal_tt = eb_sel_trace1_ideal(b2(2:end-1));  
             else
             seg_2_raw_tt = eb_sel_trace1_raw(b2);
             seq_2_ideal_tt = eb_sel_trace1_ideal(b2);    
             end
             % pad the matrix to equal lengths
             diff_length_t = longest_trans - length(seg_2_raw_tt);
             diff_length = zeros(diff_length_t,1);
             seg_2_raw_t = vertcat(seg_2_raw_tt,diff_length);
             seg_2_ideal_t = vertcat(seq_2_ideal_tt,diff_length);
             seg_2_raw(:,counter) = seg_2_raw_t;
             seg_2_ideal(:,counter) = seg_2_ideal_t;  
        end        
        counter_1 = 0;
        counter_2 = 0;
        seg_3_raw = [];
        seg_3_ideal = [];
   end     
end
    case{3}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            % get indicies
            counter_1 = counter_1 + 1;
            b1(:,counter_1) = i;            
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
            b2(:,counter_2) = i;
        elseif a(i) == 3
            counter_3 = counter_3 + 1;
            b3(:,counter_3) = i;
        end        
   else      
        counter = counter+1;
        if counter_1 >0
             b1(:,counter_1) = i;
             if length(b1) >=3
             seg_1_raw_tt = eb_sel_trace1_raw(b1(2:end-1));
             seq_1_ideal_tt = eb_sel_trace1_ideal(b1(2:end-1)); 
             else
             seg_1_raw_tt = eb_sel_trace1_raw(b1);
             seq_1_ideal_tt = eb_sel_trace1_ideal(b1);    
             end
             % pad the matrix to equal lengths
             diff_length_t = longest_trans - length(seg_1_raw_tt);
             diff_length = zeros(diff_length_t,1);
             seg_1_raw_t = vertcat(seg_1_raw_tt,diff_length);
             seq_1_ideal_t = vertcat(seq_1_ideal_tt,diff_length);
             seg_1_raw(:,counter) = seg_1_raw_t;
             seg_1_ideal(:,counter) =seq_1_ideal_t;  
        elseif counter_2 >0
             b2(:,counter_2) = i;
             if length(b2) >=3
             seg_2_raw_tt = eb_sel_trace1_raw(b2(2:end-1));
             seq_2_ideal_tt = eb_sel_trace1_ideal(b2(2:end-1));  
             else
             seg_2_raw_tt = eb_sel_trace1_raw(b2);
             seq_2_ideal_tt = eb_sel_trace1_ideal(b2);    
             end
             % pad the matrix to equal lengths
             diff_length_t = longest_trans - length(seg_2_raw_tt);
             diff_length = zeros(diff_length_t,1);
             seg_2_raw_t = vertcat(seg_2_raw_tt,diff_length);
             seg_2_ideal_t = vertcat(seq_2_ideal_tt,diff_length);
             seg_2_raw(:,counter) = seg_2_raw_t;
             seg_2_ideal(:,counter) = seg_2_ideal_t;  
        elseif counter_3 >0
             b3(:,counter_3) = i;
             if length(b3) >=3
             seg_3_raw_tt = eb_sel_trace1_raw(b3(2:end-1));
             seq_3_ideal_tt = eb_sel_trace1_ideal(b3(2:end-1));  
             else
             seg_3_raw_tt = eb_sel_trace1_raw(b3);
             seq_3_ideal_tt = eb_sel_trace1_ideal(b3);    
             end
             % pad the matrix to equal lengths
             diff_length_t = longest_trans - length(seg_3_raw_tt);
             diff_length = zeros(diff_length_t,1);
             seg_3_raw_t = vertcat(seg_3_raw_tt,diff_length);
             seg_3_ideal_t = vertcat(seq_3_ideal_tt,diff_length);
             seg_3_raw(:,counter) = seg_3_raw_t;
             seg_3_ideal(:,counter) = seg_3_ideal_t;  
        end        
        counter_1 = 0;
        counter_2 = 0;
        counter_3 = 0;
   end     
end
case{4}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            counter_1 = counter_1 + 1;                        
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
        elseif a(i) == 3
            counter_3 = counter_3 + 1; 
        elseif a(i) == 4
            counter_4 = counter_4 + 1; 
        end
   else      
        counter = counter+1;
        if counter_1 >0
            state_1(counter) = counter_1+1;
        elseif counter_2 >0
            state_2 (counter) = counter_2+1;
        elseif counter_3 >0
            state_3(counter) = counter_3+1;
        elseif counter_4 >0
            state_4(counter) = counter_4+1;            
        end
        counter_1 = 0;
        counter_2 = 0;
        counter_3 = 0;
        counter_4 = 0;
   end  
end
case{5}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            counter_1 = counter_1 + 1;                        
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
        elseif a(i) == 3
            counter_3 = counter_3 + 1; 
        elseif a(i) == 4
            counter_4 = counter_4 + 1; 
        elseif a(i) == 5
            counter_5 = counter_5 + 1; 
        end
   else      
        counter = counter+1;
        if counter_1 >0
            state_1(counter) = counter_1+1;
        elseif counter_2 >0
            state_2 (counter) = counter_2+1;
        elseif counter_3 >0
            state_3(counter) = counter_3+1;
        elseif counter_4 >0
            state_4(counter) = counter_4+1;  
        elseif counter_5 >0
            state_5(counter) = counter_5+1;  
        end
        counter_1 = 0;
        counter_2 = 0;
        counter_3 = 0;
        counter_4 = 0;
        counter_5 = 0;
   end 
end
case{6}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            counter_1 = counter_1 + 1;                        
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
        elseif a(i) == 3
            counter_3 = counter_3 + 1; 
        elseif a(i) == 4
            counter_4 = counter_4 + 1; 
        elseif a(i) == 5
            counter_5 = counter_5 + 1; 
        elseif a(i) == 6
            counter_6 = counter_6 + 1; 
        end
   else      
        counter = counter+1;
        if counter_1 >0
            state_1(counter) = counter_1+1;
        elseif counter_2 >0
            state_2 (counter) = counter_2+1;
        elseif counter_3 >0
            state_3(counter) = counter_3+1;
        elseif counter_4 >0
            state_4(counter) = counter_4+1;  
        elseif counter_5 >0
            state_5(counter) = counter_5+1; 
        elseif counter_6 >0
            state_6(counter) = counter_6+1;            
        end
        counter_1 = 0;
        counter_2 = 0;
        counter_3 = 0;
        counter_4 = 0;
        counter_5 = 0;
        counter_6 = 0;
   end 
end
end
end




