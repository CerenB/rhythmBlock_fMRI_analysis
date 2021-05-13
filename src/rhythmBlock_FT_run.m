clear;
clc;

pth = fullfile(fileparts(mfilename('fullpath')), '..');
addpath(pth);

% add FFT analysis lib
addpath(genpath(fullfile(pth, 'lib', 'FFT_fMRI_analysis')));

%% set paths
% set spm
[~, hostname] = system('hostname');
warning('off');

if strcmp(deblank(hostname), 'tux')
  addpath(genpath('/home/tomo/Documents/MATLAB/spm12'));
elseif strcmp(deblank(hostname), 'mac-114-168.local')
  warning('off');
  addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
end

% add cpp repo
run ../lib/CPP_BIDS_SPM_pipeline/initCppSpm.m;

% get all the parameters needed
opt = getOptionBlock();

%% FFT analysis

opt.anatMask = 0;


% create a whole brain functional mean image mask
% so the mask will be in the same resolution/space as the functional images
% one may not need it if they are running bidsFFX since it creates a
% mask.nii by default
% opt.skullstrip.threshold = 0.5; -->provides bigger mask thn default value
opt.skullstrip.mean = 1;
opt.funcMask = bidsWholeBrainFuncMask(opt);

% want to save each run FFT results
opt.saveEachRun = 0;

for iSmooth = [2 3 6]
    
    opt.FWHM = iSmooth; % 0 2 3 or 6mm smoothing
    
    % step size
    opt.nStepsPerPeriod = 2;
    % run fft
    calculateSNR(opt);
    
    opt.nStepsPerPeriod = 4;
    calculateSNR(opt);
end
