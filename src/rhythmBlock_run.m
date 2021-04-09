clear;
clc;

% cd(fileparts(mfilename('fullpath')));

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));
warning('off');
addpath(genpath('/Users/battal/Documents/MATLAB/spm12'));
% spm fmri
% addpath(genpath('/Users/battal/Documents/MATLAB/bspmview'));
% add xjview
% addpath(genpath('/Users/battal/Documents/MATLAB/xjview'));

initEnv();

% we add all the subfunctions that are in the sub directories
opt = getOptionBlock();

checkDependencies();

%% Run batches
% reportBIDS(opt);
% bidsCopyRawFolder(opt, 1);
%
% % In case you just want to run segmentation and skull stripping
% % Skull stripping is also included in 'bidsSpatialPrepro'
%  bidsSegmentSkullStrip(opt);
% %
% bidsSTC(opt);
% % %
% bidsSpatialPrepro(opt);
%
% % Quality control
% % anatomicalQA(opt);
% % bidsResliceTpmToFunc(opt);
% % functionalQA(opt);
%
% % smoothing
% funcFWHM = 6;
% bidsSmoothing(funcFWHM, opt);
%
%
% % subject level univariate
% bidsFFX('specifyAndEstimate', opt, funcFWHM);
% bidsFFX('contrasts', opt, funcFWHM);
%
%
% funcFWHM = 3;
% bidsSmoothing(funcFWHM, opt);
% bidsFFX('specifyAndEstimate', opt, funcFWHM);
% bidsFFX('contrasts', opt, funcFWHM);
%
% %visualise the results
% %bidsResults(opt, funcFWHM);
%
% % % group level univariate
% % conFWHM = 8;
% % bidsRFX('smoothContrasts', opt,funcFWHM, conFWHM);
% % bidsRFX('RFX', opt, funcFWHM, conFWHM);
%
% % WIP: group level results
% % bidsResults(opt, FWHM);
%

%% MVPA - prep
funcFWHM = 2;
% bidsSmoothing(funcFWHM, opt);
%
% subject level univariate
bidsFFX('specifyAndEstimate', opt, funcFWHM);
bidsFFX('contrasts', opt, funcFWHM);
% prep for mvpa
bidsConcatBetaTmaps(opt, funcFWHM, 0, 0);

funcFWHM = 0;
% bidsSmoothing(funcFWHM, opt);

% subject level univariate
bidsFFX('specifyAndEstimate', opt, funcFWHM);
bidsFFX('contrasts', opt, funcFWHM);

% prep for mvpa
bidsConcatBetaTmaps(opt, funcFWHM, 0, 0);

% strvcat(SPM.xX.name)
