% this is a quick and easy wat to convert the GLM tmaps into zmaps
% we are only converting the group level maps.
% subject level will be done elsewhere to SNR calculation see script
% calculatePeakSNR.m

% we only use GLM results - meaning only rhythmBlock design + GLM analysis
% tmap


df = 20; % number of subjects - 2
mainpath = '/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/RhythmBlock/derivatives/cpp_spm-stats/group/task-RhythmBlock_space-MNI_FWHM-6_conFWHM-0/';


% all sounds
inputImagePath = fullfile(mainpath,'AllCateg');
inputImgName = fullfile(inputImagePath, 'Block_AllSounds_p005_fwe_s6_con0.nii');
[img, outputName] = convertTstatsToZscore(inputImgName,  df);


inputImgName = fullfile(inputImagePath, 'Block_AllSounds_p0001_uncorr_s6_con0.nii');
[img, outputName] = convertTstatsToZscore(inputImgName,  df);


% block_complex
inputImagePath = fullfile(mainpath,'block_complex');
inputImgName = fullfile(inputImagePath, 'ComplexvsRest_Block_p0001_uncorr.nii');
[img, outputName] = convertTstatsToZscore(inputImgName,  df);


inputImgName = fullfile(inputImagePath, 'ComplexvsRest_Block_p005_fwe.nii');
[img, outputName] = convertTstatsToZscore(inputImgName,  df);

% block_simple
inputImagePath = fullfile(mainpath,'block_simple');
inputImgName = fullfile(inputImagePath, 'ComplexvsRest_Block_p0001_uncorr.nii');
[img, outputName] = convertTstatsToZscore(inputImgName,  df);