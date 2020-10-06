function makeBlockOnsetFile(runNb,copyFile, varargin)
% mini function which loops through the N tsv file to create block onset
% for FFX

currDir = cd();
% define the path
if nargin < 3
    pth = '/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/BlockDesign/raw/sub-001/ses-001/func';
else
    pth = varargin{1};
end

cd(pth);
outputpth = '/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/BlockDesign/source/sub-001/ses-001/func';

%define what you want to filter
columnName = 'trial_type';
filterBy = 'block';

% loop through the Run number
for irun = 1:runNb
    tsv = ['sub-001_ses-001_task-RhythmCategBlock_run-00',num2str(irun),...
        '_events.tsv'];
    
    if irun > 9
     tsv = ['sub-001_ses-001_task-RhythmCategBlock_run-0',num2str(irun),...
        '_events.tsv'];   
    end
    
    % call function to read & save filtered .tsv file
    readAndFilterLogfile(columnName, filterBy, 1, tsv);
    
    % move the filtered to the relavent folder
    if copyFile
        
        outputFilterTag = ['_filteredBy-' columnName '_' filterBy '.tsv'];
        outputFileName = strrep(tsv, '.tsv', outputFilterTag);
        
        [success]= movefile(outputFileName,outputpth);
        display(success);
        % [SUCCESS,MESSAGE,MESSAGEID] = movefile(SOURCE,DESTINATION,MODE)
    end
    
    
end

cd(currDir);
end