function analysis()

    subfolder = 'testimages2\';
    filetype = 'jpeg';

    % Forever
    while true
        % Read in the background
        %bg = getBackground(subfolder);
        bg = backgroundExtraction(readfiles(subfolder, filetype));
        
        % Read in the frame defined by images/_old.txt
        cf = getCurrentFrame(subfolder);
        
        % Perform foreground extraction
        [labels, objects] = foregroundExtraction(cf, bg);
        imshow(labels)
        
        % Packedge each object into image
        for i =1:max(max(labels))
            disp("hi")
            
            % Save object as image
            
            
            % Send each object to cloud vision api
            sendReq([subfolder, '/objects/obj', i, 'filetype'], ['contents_', i, '.json']);
        
            
        end
    end
end