clear;
clc;

%cd(fileparts(mfilename('fullpath')));

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
% spm fmri
% addpath(genpath('/Users/battal/Documents/MATLAB/bspmview-master'));

initEnv();

% we add all the subfunctions that are in the sub directories
opt = getOptionBlock();

checkDependencies();

%% Run batches
reportBIDS(opt);
bidsCopyRawFolder(opt, 1);
%
% % In case you just want to run segmentation and skull stripping
% % Skull stripping is also included in 'bidsSpatialPrepro'
%  bidsSegmentSkullStrip(opt);
% %
bidsSTC(opt);
% %
bidsSpatialPrepro(opt);

% Quality control
anatomicalQA(opt);
bidsResliceTpmToFunc(opt);
functionalQA(opt);

% smoothing
funcFWHM = 6;
conFWHM = 8;

bidsSmoothing(funcFWHM, opt);


% subject level univariate
bidsFFX('specifyAndEstimate', opt, funcFWHM);
bidsFFX('contrasts', opt, funcFWHM);

%visualise the results 
bidsResults(opt, funcFWHM);

% group level univariate
bidsRFX('smoothContrasts', opt,funcFWHM, conFWHM);
bidsRFX('RFX', opt, funcFWHM, conFWHM);

% WIP: group level results
% bidsResults(opt, FWHM);


% isMVPA = false;






