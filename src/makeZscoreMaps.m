function opt = makeZscoreMaps(funcFWHM, opt)

  % this is a small function to read/load & rename the t-maps and convert
  % them into z-maps.

  resultReport = opt.result.Steps;

  for iSub = 1:numel(opt.subjects)

    % find the tmaps to load
    subLabel = opt.subjects{iSub};
    imagePath =  getFFXdir(subLabel, funcFWHM, opt);

    imageName = returnName(subLabel, resultReport, opt);

    imageNameLoad = [imageName, '_spmT.nii'];
    imageNameSave = [imageName, '_spmZ.nii'];

    % do the t to z-map conversion here
    % outputImage = convertTstatsToZscore(inputImage, df)

    % then save the z-map
    % do we need this part? convertTstatsToZscore is already saving
    hdr = spm_vol(fullfile(imagePath, imageNameLoad));
    img = spm_read_vols(hdr);

  end

end

function name = returnName(sub, result, opt)

  contrastName = result.Contrasts(1).Name;
  correction = result.Contrasts(1).MC;
  pvalue = result.Contrasts(1).p;
  clusterSize = result.Contrasts(1).k;
  tLabel = '0023';

  name = ['sub-', sub, ...
          '_task-', opt.taskName, ...
          '_space-', opt.space, ...
          '_desc-', contrastName, ...
          '_label-', tLabel, ...
          '_p-', num2str(pvalue), ...
          '_k-', num2str(clusterSize), ...
          '_MC-', correction];

  name = strrep(name, '.', '');

end
