function currentframe = getCurrentFrame(subfolder)

    disp('    Identify Current Frame')
    oldestImID = 1;
    if isfile([subfolder, '_old.txt'])
        fileID = fopen([subfolder, '_old.txt'],'r');
        oldestImID = fscanf(fileID,'%f');
        fclose(fileID);
    end

    disp('    Read in current frame')
    currentframe = imread([subfolder, 'frame', int2str(oldestImID), '.jpeg']);
end