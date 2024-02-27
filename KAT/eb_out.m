load('trial_eb.mat')
min(data_d)
for i = 1:length(data_d)
    if data_d(i) <0
        data_d(i) = 0 ;       
    end
end
min(data_d)
