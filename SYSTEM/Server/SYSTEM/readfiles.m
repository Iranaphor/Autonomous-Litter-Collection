%Included to test when camera not available
%dir('images\yacht_images\*.PNG')
function images = readfiles(subfolder, filetype)
    
    disp('    Find Files')
    files = dir([subfolder, '*.', filetype]);
    
    disp('    Read in files')
    for i = 1:length(files)
        images(:,:,:,i) = imread([subfolder, files(i).name]);
    end

end
