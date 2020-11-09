function outputFiltered = makeFilterTag(subNb, runNb, columnName, filterTag, saveOutputTsv)
    % It will make filter_tag in the specified column to be filtered later
    % on for making onset files
    % It will display in the command window the content of the `output.tsv' filtered by one element
    % of a target column.
    %
    % INPUT:
    %
    %  - columnName: string, the header of the column where the content of insterest is stored
    %    (e.g., for 'trigger' will be 'trial type')
    %  - filterTag: string, the content of the column you want to filter out. It can take just
    %    part of the content name (e.g., you want to display the triggers and you have
    %    'trigger_motion' and 'trigger_static', 'trigger' as input will do)
    currDir = cd();
    pth = ['/Users/battal/Cerens_files/fMRI/Processed/RhythmCateg/'...
           'Pilots/SequenceTest/source/sub-00', num2str(subNb), ...
           '/ses-001/func'];

    cd(pth);
    % columnName = 'trial_type';
    % filterTag = 'block';

    % Create tag to add to output file in case you want to save it
    outputFilterTag = ['_filteredBy-' columnName '_' filterTag '.tsv'];

    % Checke if input is cfg or the file path and assign the output filename for later saving
    tsvFile = ['sub-00', num2str(subNb), ...
               '_ses-001_task-RhythmCategBlock_run-00', ...
               num2str(runNb), '_events.tsv'];

    % Create output file name
    outputFileName = strrep(tsvFile, '.tsv', outputFilterTag);

    % Check if the file exists
    if ~exist(tsvFile, 'file')
        error([newline 'Input file does not exist: %s'], tsvFile);
    end

    try
        % Read the the tsv file and store each column in a field of `output` structure
        output = bids.util.tsvread(tsvFile);
    catch
        % Add the 'bids-matlab' in case is not in the path
        addpath(genpath(fullfile(pwd, '..', 'lib')));
        % Read the the tsv file and store each column in a field of `output` structure
        output = bids.util.tsvread(tsvFile);
    end

    % insert the tag
    for i = 1:length(output.onset)
        if mod(i, 4) == 1
            output.trial_type{i} = [filterTag, '_', output.trial_type{i}];
            output.duration(i) = 9.12;
        end
    end

    % Get the index of the target contentent to filter and display
    filterIdx = strncmp(output.(columnName), filterTag, length(filterTag));

    % apply the filter
    listFields = fieldnames(output);
    for iField = 1:numel(listFields)
        output.(listFields{iField})(~filterIdx) = [];
    end

    output = convertStruct(output);

    % Convert the structure to dataset
    try
        outputFiltered = struct2dataset(output);
    catch
        % dataset not yet supported by octave
        outputFiltered = output;
    end

    if saveOutputTsv
        % convert back to struc to save in .tsv
        outputFiltered = dataset2struct(outputFiltered);
        bids.util.tsvwrite(outputFileName, outputFiltered);

    end

    cd(currDir);

end

function structure = convertStruct(structure)
    % changes the structure
    %
    % from struct.field(i,1) to struct(i,1).field(1)

    fieldsList = fieldnames(structure);
    tmp = struct();

    for iField = 1:numel(fieldsList)
        for i = 1:numel(structure.(fieldsList{iField}))
            tmp(i, 1).(fieldsList{iField}) =  structure.(fieldsList{iField})(i, 1);
        end
    end

    structure = tmp;

end
