function [numComponents, BestModel, AIC, reg_AIC] = ...
    kat_gaussian_mixture_model(X, C, maxIterations, setAIC, regularize)

% gaussian_mixture_model.m
%
% inputs:
% X - values 
% C - number of classes/ components
% maxIterations - max number of iterations to run EM
% setAIC - boolean specifies whether or not to use AIC scoring to return
% the best fit model and the number of components in the model
%
% outputs:
% numComponents - number of components in the model
% BestModel - if setAIC is 'true', then BestModel is the best scoring model
% with the lowest AIC score. Else if setAIC is 'false' then simply returns
% the model found.
%

if setAIC == false
    options = statset('MaxIter', maxIterations);
    
    if regularize == true
        [BestModel, reg_AIC, reg_index] = regModel(X, C, options);
        numComponents = C;
        AIC = zeros(1, C);
    else
        try
            GMM = fitgmdist(X, C, 'Options', options, 'CovarianceType', 'diagonal');
            BestModel = GMM;
            AIC = zeros(1, C);
            numComponents = C;
            
        catch exception
            disp('There was an error fitting the Gaussian mixture model, try with regularization.')
            error = exception.message
        end
    end
else
    if regularize == true
        reg_terms = [0.01, 0.001, 0.0001, 0.00001, 0.000001];
        options = statset('MaxIter', maxIterations);
        [BestModel, reg_AIC, reg_index] = regModel(X, C, options);
        AIC = zeros(1, C);
        GMModels = cell(1, C);
        for k = 1:C
            GMModels{k} = fitgmdist(X, k, 'Options', options, 'CovarianceType', 'diagonal', 'Regularize', reg_terms(reg_index));
            AIC(k) = GMModels{k}.AIC;
        end

        [minAIC, numComponents] = min(AIC);

        BestModel = GMModels{numComponents};

    else
        reg_AIC = zeros(1, C);
        AIC = zeros(1, C);
        GMModels = cell(1, C);
        options = statset('MaxIter', maxIterations);
        for k = 1:C
            GMModels{k} = fitgmdist(X, k, 'Options', options, 'CovarianceType', 'diagonal');
            AIC(k) = GMModels{k}.AIC;
        end

        [minAIC, numComponents] = min(AIC);
        BestModel = GMModels{numComponents};
    end
end

function [best_reg_model, reg_AIC, reg_index] = regModel(X, C, options)
    reg_terms = [0.01, 0.001, 0.0001, 0.00001, 0.000001];
    num_reg_terms = length(reg_terms);
    reg_AIC = zeros(1, 5);
    reg_GMModels = cell(1, num_reg_terms);
    for i = 1:num_reg_terms
        reg_term = reg_terms(i);
        reg_GMModels{i} = fitgmdist(X, C, 'Options', options, 'CovarianceType', 'diagonal', 'Regularize', reg_term);
        reg_AIC(i) = reg_GMModels{i}.AIC;
    end
    [minAIC, reg_index] = min(reg_AIC);
    best_reg_model = reg_GMModels{reg_index};
end
end