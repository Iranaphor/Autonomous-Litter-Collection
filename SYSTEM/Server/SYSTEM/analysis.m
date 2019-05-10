function analysis()
	imPath = 'testimages/';
	
    % Forever
    %while true
        %% Read in the background
        disp('    Read in background')
        bg = imread([imPath, '_bg_median.jpeg']);
        
        %% Read in the frame defined by images/_old.txt
        disp('    Identify Current Frame')
        oldestImID = 1;
        if isfile([imPath, '_old.txt'])
            fileID = fopen([imPath, '_old.txt'],'r');
            oldestImID = fscanf(fileID,'%f');
            fclose(fileID);
        end
       
        disp('    Read in current frame')
        currentframe = imread([imPath, 'frame', int2str(oldestImID), '.jpeg']);
        
        
        %% Perform background subtraction
        
        
        
        
        
        
        
        %Extract the foreground objects
        img = currentframe;
        fprintf('Object Extraction\n');
        a = img~=bg;
        a = permute(  max(  permute(a, [3, 1, 2])   )   , [2, 3, 1]);
        labels = bwlabel(imfill(imdilate(a, ones(3)),'holes'));

        for i = 1:max(max(labels))
            t1 = rgb2gray(img);
            t1( labels ~= i ) = 0;
            objects(:,:,i) = t1;
        end

        
        
        
        
        
        
        
        
        
        
        subplot(2,2,1)
        imshow(currentframe)
        
        subplot(2,2,2)
        imshow(bg)
        
        subplot(2,1,2)
        currentframe(currentframe-bg>0)=0;
        imshow(currentframe)
        
        
        % foreground = currentframe-bg>0

        %% need to isolate objects
    
        %BWLABEL (foreground)
        
        %for each i in range(max(bwlabel)):
            %% need to packedge each object into image
            
        

            %% need to send each object to cloud vision api
            %sendReq("testimages/objects/obj"+int2str(i)+".png","contents_IMID.json");
        
            
            
        
    %end
end