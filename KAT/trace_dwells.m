function [state_1,state_2,state_3, state_4,state_5, state_6] = trace_dwells(eb_sel_trace,num_states)
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
% Select number of states 2-6
switch num_states
    case{2}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            counter_1 = counter_1 + 1;                        
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
        end        
   else      
        counter = counter+1;
        if counter_1 >0
        state_1(counter) = counter_1+1;
        elseif counter_2 >0
        state_2 (counter) = counter_2+1;
        end
        counter_1 = 0;
        counter_2 = 0;
   end     
end
    case{3}
for i = 1:length(a)-1    
   if a(i) - a(i+1) == 0
        if a(i) ==1
            counter_1 = counter_1 + 1;                        
        elseif a(i) == 2
            counter_2 = counter_2 + 1;
        elseif a(i) == 3
            counter_3 = counter_3 + 1; 
        end
   else      
        counter = counter+1;
        if counter_1 >0
            state_1(counter) = counter_1+1;
        elseif counter_2 >0
            state_2 (counter) = counter_2+1;
        elseif counter_3 >0
            state_3(counter) = counter_3+1;
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
state_1 = nonzeros(state_1);
state_2 = nonzeros(state_2);
state_3 = nonzeros(state_3);
state_4 = nonzeros(state_4);
state_5 = nonzeros(state_5);
state_6 = nonzeros(state_6);
end

