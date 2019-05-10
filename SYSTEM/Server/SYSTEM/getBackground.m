function bg = getBackground(subfolder)
    disp('    Read in background')
    bg = imread([subfolder, '_bg_median.jpeg']);
end