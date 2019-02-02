function download_updates() %% Function Setup:
    pauseTime = 60;
	totalIm = 20;
	imPath = 'images/'; %{add system to define images to load}
    frameURL = 'http://james.yourthought.co.uk/frame.jpeg';
	
	%% Step A: load older images from files
    fprintf("\n\nLoad Existing Images:\n");
    
    disp("    Get image dimensions");
    urlFail = true;
    while (urlFail == true)
        try
            fprintf("    Try frameURL:     ...");
            frm = imread(frameURL);
            urlFail = false;
        catch ERR
            if(strcmp(ERR.identifier,'MATLAB:imagesci:imread:urlRead'))
                fprintf("\b\b\b" + ERR.identifier + "\n");
            end
        end
    end
    fprintf("\b\b\bImage Acquired\n");
    
    
    fprintf("    Set frame holder size\n");
    frames = uint8(ones(size(frm, 1), size(frm, 2), size(frm, 3), totalIm));
    clear frm;
    
    
    disp("    Read in data");
	for i = 1:totalIm
        if isfile([imPath, 'frame', int2str(i), '.jpeg'])
            frames(:,:,:,i) = imread([imPath, 'frame', int2str(i), '.jpeg']);
        end
	end
	
    %% Step B: Load the value for the oldest image
    
    fprintf("\n\nFind oldest image in set\n");
    oldestImID = 1;
    if isfile([imPath, '_old.txt'])
        fileID = fopen([imPath, '_old.txt'],'r');
        oldestImID = fscanf(fileID,'%f');
        fclose(fileID);
    end
    disp("    Begin system at frame - " + int2str(oldestImID));
    
    
	%% Step C: download and process updates
    fprintf("\n\nLoop Begun:\n")
	while true
        disp("    Performing Analysis on Image " + int2str(oldestImID));
        size(frames);
		% Step 0: time length of processings
        fprintf("    Timer started\n");
		startLoopTimer = tic;
		
        
		% Step 1: download newest frame
        urlFail = true;
        while (urlFail == true)
            try
                fprintf("    Try frameURL:     ...");
                frames(:,:,:,oldestImID) = imread(frameURL);
                urlFail = false;
            catch ERR
%                 if(strcmp(ERR.identifier,'MATLAB:imagesci:imread:urlRead'))
                fprintf("\b\b\b" + ERR.identifier + "\n");
                disp("                      " + ERR.message);
%                 end
            end
        end
        fprintf("\b\b\bImage Acquired\n");
        
        
		% Step 2: save image to jpeg file
        disp("    Updating local version of image")
		imwrite(frames(:,:,:,oldestImID), [imPath, 'frame', int2str(oldestImID), '.jpeg']);
		
		
        % Step 3: generate and save the bg image
        disp("    Saving background image");
 		imwrite(mode(frames, 4), [imPath, '_bg.jpeg']);
		
		
        % Step 4: save ID of new oldest to txt file
        fprintf("    New oldestImID: ");
		oldestImID = oldestImID + 1;
		if oldestImID > totalIm, oldestImID = 1; end
        disp(int2str(oldestImID));
        
        
        % Step 5: add oldest image ID to file
        disp("    Log oldestImID");
 		fileID = fopen([imPath, '_old.txt'],'w'); 
        fprintf(fileID, int2str(oldestImID)); 
        fclose(fileID);
        
		
        % Step 6: pause till the server image updates
        fprintf("    Timer end - ( ...... )")
        loopTime = toc(startLoopTimer);
		if loopTime < pauseTime, pause(pauseTime-loopTime); end
        fprintf("\b\b\b\b\b\b\b\b" + loopTime + " )\n\n");
        
        
	end
end