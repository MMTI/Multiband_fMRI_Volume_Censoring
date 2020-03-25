function [optimal_LPFFD_threshold,optimal_GEVDV_d] = getOptimalStudyThresholds(runLength,numRuns,usingGSR)
% This is a function that can be used to obtain the optimal LPF-FD and 
%   GEV-DV thresholds given a specified number of volumes per run, the 
%   number of runs per subject, and whether the data are additionally 
%   processed using global signal regression (GSR).
%
% Inputs
% I.    runLength: The number of volumes per run in the dataset 
%   (e.g., 1000).
% II.   numRuns: The number of runs per subject in the dataset (e.g., 4).
% III.  usingGSR: True or 1 if global signal regression (GSR) is being 
%   used; false or 0 if GSR is now being used. 
%
% Outputs
% I.    optimal_LPFFD_threshold: The optimal LPF-FD threshold for the study 
%   given the inputs.
% II.   optimal_GEVDV_d: The optimal GEV-DV d for the study given the 
%   inputs.
%
% Author: John C. Williams, MS
%   John.Williams@StonyBrookMedicine.edu
% PI: Jared X. Van Snellenberg, PhD
%   Jared.VanSnellenberg@stonybrookmedicine.edu
% Multi-Modal Translational Imaging Laboratory
% Department of Psychiatry and Behavioral Health
% Renaissance School of Medicine at Stony Brook University 
% Stony Brook, NY, USA.
% 
    
    usingGSR = logical(usingGSR);
    
    if(~usingGSR) %If you are using GSR
        A = 0.5591;
        b = 269.6;
        c = 1.15;
        ratio =  0.0339 / 1.39;
    else %If you are not using GSR
        A = 0.0903;
        b = 937.3;
        c = 1.277;
        ratio = 14.336 / 1.30;
    end
    
    x = numRuns * (runLength - 3); %This is x in the paper used to curve fit
    
    optimal_GEVDV_d = A * exp(b/x) + c; %Get optimal GEV d 
    
    optimal_LPFFD_threshold = optimal_GEVDV_d * ratio; %Get optimal LPF-FD threshold
end

