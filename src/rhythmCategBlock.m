clear;
clc;

% Smoothing to apply
FWHM = 6;
isMVPA = false;

cd(fileparts(mfilename('fullpath')));

addpath(fullfile(fileparts(mfilename('fullpath')), '..'));

initEnv();

% we add all the subfunctions that are in the sub directories
opt = getOptionCategBlock();

checkDependencies();

%% Run batches

%bidsCopyRawFolder(opt, 0);
bidsSTC(opt);
% BIDS_SpatialPrepro(opt);
% BIDS_Smoothing(6, opt);


% bidsRealignReslice(opt);
% bidsSmoothing(FWHM, opt);
% bidsFFX('specifyAndEstimate', opt, FWHM, isMVPA);
% bidsFFX('contrasts', opt, FWHM, isMVPA);
% % bidsResults(opt, FWHM, [], isMVPA);
% bidsFFX('specifyAndEstimate', opt, 0, isMVPA);
% bidsFFX('contrasts', opt, 0, isMVPA);
% bidsResults(opt, FWHM, [], isMVPA);
