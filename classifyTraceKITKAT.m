function [prediction] = classifyTraceKITKAT(index, donor, acceptor, gamma, model)
%CLASSIFYTRACE Will supply a classification prediction with given model
%   index           : the index of the trace for which this model predicts
%   donor           : donor matrix (likely don_spec_trace)
%   acceptor        : acceptor matrix (likely accep_spec_trace)
%   gamma           : normalization factor
%   model           : the trained ML model that will classify trace

data = [transpose(donor(:, index)); transpose(acceptor(:, index))];
        %normFactor = 1 / max([conv(data(1,:),[1/3,1/3,1/3],'same')+conv(data(2,:),[1/3,1/3,1/3],'same')]);
        data = gamma * [
            reshape(data(1,1:end-mod(end,10)),10,[]);
            reshape(data(2,1:end-mod(end,10)),10,[])
            ];

prediction = predict(model, data);
end