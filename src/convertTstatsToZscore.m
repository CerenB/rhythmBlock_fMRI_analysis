function [img, outputName] = convertTstatsToZscore(inputImgName,  df)
  % mini function to convert t-stats to z-scores

  % load the image to be read t-stats
  hdr = spm_vol(inputImgName);
  img = spm_read_vols(hdr);

  %replace nans with zeros
  img(isnan(img(:)))=0;

  % rename 
  [~, name, ext]= fileparts(inputImgName);
  if contains(name,'T')
    newName = replace(name, 'T', 'Z');
  else
    newName = [name, '_Zmap'];
  end
  newName = [newName,ext];
  
  hdr.fname = spm_file(hdr.fname, 'filename', newName);

  % rename the description as well
  newDescrip = [hdr.descrip, ' t->z converted'];
  hdr.descrip = spm_file(hdr.descrip, 'filename', newDescrip);

  % convert t-values to z-score
  img = spm_t2z(img, df);

  % save zscore image
  spm_write_vol(hdr, img);

  % output the file name
  outputName = hdr.fname;

end

