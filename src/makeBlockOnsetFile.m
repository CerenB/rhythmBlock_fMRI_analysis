function makeBlockOnsetFile(runNb, copyFile, varargin)
  % mini function which loops through the N tsv file to create block onset
  % for FFX

  currDir = cd();
  sub = 'pil002';

  % define the path
  if nargin < 3
    pth = ['/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/'...
           'Pilots/RhythmBlock/raw/sub-', sub, '/ses-001/func'];

  else
    pth = varargin{1};
  end

  cd(pth);
  outputpth = ['/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/'...
               'Pilots/RhythmBlock/source/sub-', sub, '/ses-001/func'];

  % define what you want to filter
  columnName = 'trial_type';
  filterBy = 'block';

  outputFilterTag = ['_filteredBy-' columnName '_' filterBy '.tsv'];

  % loop through the Run number
  for irun = 1:runNb
    tsv = ['sub-', sub, '_ses-001_task-RhythmBlock_run-00', num2str(irun), ...
           '_events.tsv'];

    if irun > 9
      tsv = ['sub-', sub, '_ses-001_task-RhythmBlock_run-0', num2str(irun), ...
             '_events.tsv'];
    end

    % make output file name
    outputFileName = strrep(tsv, '.tsv', outputFilterTag);

    % call function to read & save filtered .tsv file
    readAndFilterLogfile(columnName, filterBy, 1, tsv);

    % move the filtered to the relevent folder
    if copyFile
      [success] = movefile(outputFileName, outputpth);
      display(success);
    end

  end

  cd(currDir);
end
