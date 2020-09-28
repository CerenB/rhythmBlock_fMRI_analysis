% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function opt = getOption()
    % opt = getOption()
    % returns a structure that contains the options chosen by the user to run
    % slice timing correction, pre-processing, FFX, RFX.

    if nargin < 1
        opt = [];
    end

    % group of subjects to analyze
    opt.groups = {''};
    % suject to run in each group
    opt.subjects = {'001'};

    % task to analyze
    opt.taskName = 'RhythmCategBlock';

    % The directory where the data are located
    opt.dataDir = '/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/SequenceTestcopy/';

    % specify the model file that contains the contrasts to compute
    opt.model.univariate.file = ...
        '/Users/battal/Documents/GitHub/CPPLab/CPP_BIDS_SPM_pipeline/model-RhythmBlock_smdl.json';
    opt.model.multivariate.file = '';

    % specify the result to compute
    % Contrasts.Name has to match one of the contrast defined in the model json file
    %     opt.result.Steps(1) = struct( ...
    %         'Level',  'dataset', ...
    %         'Contrasts', struct( ...
    %                         'Name', 'AllSounds', ... %
    %                         'Mask', false, ... % this might need improving if a mask is required
    %                         'MC', 'none', ... FWE, none, FDR
    %                         'p', 0.001, ...
    %                         'k', 0, ...
    %                         'NIDM', true));

    % Options for slice time correction
    % If left unspecified the slice timing will be done using the mid-volume acquisition
    % time point as reference.
    % Slice order must be entered in time unit (ms) (this is the BIDS way of doing things)
    % instead of the slice index of the reference slice (the "SPM" way of doing things).
    % More info here: https://en.wikibooks.org/wiki/SPM/Slice_Timing
    opt.sliceOrder = [0; 1.47250000000000; 0.0588999000000000; 1.53140000000000; 0.117800000000000; 1.59030000000000; 0.176700000000000; 1.64920000000000; 0.235600000000000; 1.70810000000000; 0.294500000000000; 1.76700000000000; 0.353400000000000; 1.82590000000000; 0.412300000000000; 1.88480000000000; 0.471200000000000; 1.94370000000000; 0.530100000000000; 2.00260000000000; 0.589000000000000; 2.06150000000000; 0.647900000000000; 2.12040000000000; 0.706800000000000; 2.17930000000000; 0.765700000000000; 2.23820000000000; 0.824600000000000; 2.29710000000000; 0.883500000000000; 2.35600000000000; 0.942400000000000; 2.41490000000000; 1.00130000000000; 2.47380000000000; 1.06020000000000; 2.53270000000000; 1.11910000000000; 2.59160000000000; 1.17800000000000; 2.65050000000000; 1.23690000000000; 2.70940000000000; 1.29580000000000; 2.76830000000000; 1.35470000000000; 2.82720000000000; 1.41360000000000; 2.88610000000000];
    opt.STC_referenceSlice = [];

    % Options for normalize
    % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
    opt.funcVoxelDims = [];

    % Suffix output directory for the saved jobs
    opt.jobsDir = fullfile( ...
                           opt.dataDir, 'derivatives', ...
                           'SPM12_CPPL', 'JOBS', opt.taskName);

    % Save the opt variable as a mat file to load directly in the preprocessing
    % scripts
    save('opt.mat', 'opt');

end
