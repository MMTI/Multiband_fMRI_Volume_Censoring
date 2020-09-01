function [optimal_LPFFD_threshold,optimal_GEVDV_d] = getOptimalStudyThresholds(runLength,numRuns,numRegressors,usingGSR)
    % This is a function that can be used to obtain the optimal LPF-FD and
    %   GEV-DV thresholds given a specified number of volumes per run, the
    %   number of runs per subject, and whether the data are additionally
    %   processed using global signal regression (GSR).
    %
    % Inputs
    % I.    runLength: The number of volumes per run in the dataset
    %   (e.g., 1000).
    % II.   numRuns: The number of runs per subject in the dataset (e.g., 4).
    % III.  numRegressors: The number of variables controlled for in generating
    %   partial correlations (e.g. 28 or 30), including global signal and any
    %   global signal derivatives.
    % IV.   usingGSR: True or 1 if global signal regression (GSR) is being
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
        A = 0.003745;
        B = 1.559;
        C = 264.4;
        D = 0.02748;
        FDtoDVratio = 0.02438;
    else %If you are not using GSR
        A = 1.728;
        B = 2.312;
        C = 294.3;
        D = 10.07;
        FDtoDVratio = 11.0277;
    end
    
    optimal_LPFFD_threshold = D + ( A * exp( (B/numRuns) + ( C/(runLength - 3 - numRegressors) ) ) );  %This is the bivariate formula in the paper
        
    optimal_GEVDV_d = optimal_LPFFD_threshold / FDtoDVratio; %Get optimal GEV d

end
