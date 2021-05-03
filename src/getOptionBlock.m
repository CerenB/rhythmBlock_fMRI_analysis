% (C) Copyright 2019 CPP BIDS SPM-pipeline developpers

function opt = getOptionBlock()
  % opt = getOption()
  % returns a structure that contains the options chosen by the user to run
  % slice timing correction, pre-processing, FFX, RFX.

  if nargin < 1
    opt = [];
  end

  % group of subjects to analyze
  opt.groups = {''};
  % suject to run in each group
  opt.subjects = {'010'};

  % '001', '002', '003', '004', '005', '006','007',...
  % '008', '009', '010','011'

  % Uncomment the lines below to run preprocessing
  % - don't use realign and unwarp
  opt.realign.useUnwarp = true;

  % we stay in native space (that of the T1)
  % - in "native" space: don't do normalization
  opt.space = 'individual'; % 'individual', 'MNI'

  % task to analyze
  opt.taskName = 'RhythmBlock';

  %% set paths
  [~, hostname] = system('hostname');
  if strcmp(deblank(hostname), 'tux')
    opt.dataDir = fullfile('/datadisk/data/RhythmCateg-fMRI/RhythmBlock'); 
    opt.derivativesDir = fullfile( ...
                                  '/datadisk/data/RhythmCateg-fMRI/RhythmBlock', ...
                                  'cpp_spm');
  elseif strcmp(deblank(hostname), 'mac-114-168.local')
    % The directory where the data are located
    opt.dataDir = fullfile(fileparts(mfilename('fullpath')), ...
                           '..', '..', '..', 'data', 'raw');
    opt.derivativesDir = fullfile(opt.dataDir, '..', ...
                                  'derivatives', 'cpp_spm');
  end

  % Suffix output directory for the saved jobs
  opt.jobsDir = fullfile( ...
                         opt.dataDir, '..', 'derivatives', ...
                         'cpp_spm', 'JOBS', opt.taskName);
                     
  % specify the model file that contains the contrasts to compute
    % univariate
    opt.model.file =  ...
        fullfile(fileparts(mfilename('fullpath')), '..', ...
                 'model', 'model-RhythmBlock_smdl.json');
%   % multivariate
%   opt.model.file =  ...
%      fullfile(fileparts(mfilename('fullpath')), '..', ...
%               'model', 'model-RhythmBlockDecoding2_smdl.json');

  % to add the hrf temporal derivative = [1 0]
  % to add the hrf temporal and dispersion derivative = [1 1]
  % opt.model.hrfDerivatives = [0 0];

  %% Specify the result to compute
  opt.result.Steps(1) = returnDefaultResultsStructure();

  opt.result.Steps(1).Level = 'subject';

  opt.result.Steps(1).Contrasts(1).Name = 'AllCateg';
  opt.result.Steps(1).Contrasts(1).MC =  'none';
  opt.result.Steps(1).Contrasts(1).p = 0.001;
  opt.result.Steps(1).Contrasts(1).k = 0;

  % For each contrats, you can adapt:
  %  - voxel level (p)
  %  - cluster (k) level threshold
  %  - type of multiple comparison (MC):
  %    - 'FWE' is the defaut
  %    - 'FDR'
  %    - 'none'
  %
  % not working for multiple contrasts
  opt.result.Steps(1).Contrasts(2).Name = 'CategA_gt_CategB';
  opt.result.Steps(1).Contrasts(2).MC =  'none';
  opt.result.Steps(1).Contrasts(2).p = 0.001;
  opt.result.Steps(1).Contrasts(2).k = 0;
  %
  opt.result.Steps(1).Contrasts(3).Name = 'CategB_gt_CategA';
  opt.result.Steps(1).Contrasts(3).MC =  'none';
  opt.result.Steps(1).Contrasts(3).p = 0.001;
  opt.result.Steps(1).Contrasts(3).k = 0;

  % Specify how you want your output (all the following are on false by default)
  opt.result.Steps(1).Output.png = true();

  opt.result.Steps(1).Output.csv = true();

  opt.result.Steps(1).Output.thresh_spm = true();

  opt.result.Steps(1).Output.binary = true();

  opt.result.Steps(1).Output.montage.do = true();
  opt.result.Steps(1).Output.montage.slices = -12:4:60; % in mm -8:3:15;
  % axial is default 'sagittal', 'coronal'
  opt.result.Steps(1).Output.montage.orientation = 'axial';

  % will use the MNI T1 template by default but the underlay image can be
  % changed.
  opt.result.Steps(1).Output.montage.background = ...
      fullfile(spm('dir'), 'canonical', 'avg152T1.nii,1');

  %   opt.result.Steps(1).Output.NIDM_results = true();

  % Options for slice time correction

  % sub-001
  %     opt.sliceOrder = [0;1.3000;0.0590;1.3591;0.1181;1.4182;0.1772;1.4773; ...
  %                         0.2363;1.5363;0.2954;1.5954;0.3545;1.6545;0.4136; ...
  %                         1.7136;0.4727;1.7727;0.5318;1.8318;0.5909;1.8909; ...
  %                         0.6500;1.9500;0.7091;2.0091;0.7681;2.0682;0.8272; ...
  %                         2.1272;0.8863;2.1863;0.9454;2.2454;1.0045;2.3045; ...
  %                         1.0636;2.3636;1.1227;2.4227;1.1818;2.4818;1.2409; ...
  %                         2.5409];

  % sub-002
  %     opt.sliceOrder = [0; 1.3549; 0.0588999; 1.4138; 0.1178; 1.4728; 0.1767; 1.5317; ...
  %                       0.2356; 1.5906; 0.2945; 1.6495; 0.3534; 1.7084; 0.4123; ...
  %                       1.7673; 0.4712; 1.8262; 0.5302; 1.8851; 0.5891; 1.944; ...
  %                       0.648; 2.003; 0.7069; 2.0619; 0.7658; 2.1208; 0.8247; ...
  %                       2.1797; 0.8836; 2.2386; 0.9425; 2.2975; 1.0015; 2.3564; ...
  %                       1.0604; 2.4153; 1.1193; 2.4742; 1.1782; 2.5331; 1.2371; ...
  %                       2.592; 1.296];
  %     opt.sliceOrder = [0, 0.9051, 0.0603, 0.9655, 0.1206, 1.0258, 0.181, ...
  %                       1.0862, 0.2413, 1.1465, 0.3017, 1.2069, 0.362, ...
  %                       1.2672, 0.4224, 1.3275, 0.4827, 1.3879, 0.5431, ...
  %                       1.4482, 0.6034, 1.5086, 0.6638, 1.5689, 0.7241, ...
  %                       1.6293, 0.7844, 1.6896, 0.8448, 0, 0.9051, 0.0603, ...
  %                       0.9655, 0.1206, 1.0258, 0.181, 1.0862, 0.2413, ...
  %                       1.1465, 0.3017, 1.2069, 0.362, 1.2672, 0.4224, ...
  %                       1.3275, 0.4827, 1.3879, 0.5431, 1.4482, 0.6034, ...
  %                       1.5086, 0.6638, 1.5689, 0.7241, 1.6293, 0.7844, ...
  %                       1.6896, 0.8448];
  opt.sliceOrder = [];
  opt.STC_referenceSlice = [];

  % Options for normalize
  % Voxel dimensions for resampling at normalization of functional data or leave empty [ ].
  opt.funcVoxelDims = [2.6 2.6 2.6];

  opt.parallelize.do = true;
  opt.parallelize.nbWorkers = 3;
  opt.parallelize.killOnExit = true;

  %% DO NOT TOUCH
  opt = checkOptions(opt);
  saveOptions(opt);

end
