% function [] = ourFunction(arg1)
% 	disp(arg1);
% end




% {test if it is procedural.y or async}
% {add error handling}

%% Function Setup:
function download_updates()
    clear

    pauseTime = 5;
	totalIm = 20;
	imPath = 'images/'; %{add system to define images to load}
	
	%% Step A: load older images from files
    
    frm = imread('http://james.yourthought.co.uk/frame.png');
    frames = ones(size(frm, 1), size(frm, 2), size(frm, 3), totalIm);
    clear frm;
    
	for i = 1:totalIm
        if isfile([imPath, 'frame', int2str(i), '.jpeg'])
            frames(:,:,:,i) = imread([imPath, 'frame', int2str(i), '.png']);
        end
	end
	
    %% Step B: Load the value for the oldest image
    
%     if isfile([imPath, '_old.txt'])
%         fileID = fopen([imPath, '_old.txt'],'r');
%         oldestImID = fscanf(fileID,'%f');
%         fclose(fileID);
%     else
        oldestImID = 1;
%     end
%     
%    
    
	%% Step C: download and process updates
	while true
		% Step 0: time length of processings
		startLoopTimer = tic;
        disp(oldestImID);
		
		% Step 1: downlaod newest frame
		fff = imread('http://james.yourthought.co.uk/frame.png');
        
        frames(:,:,:,oldestImID) = fff(:,:,:);
        
		% Step 2: save image to jpeg file
		imwrite(frames(:,:,:,oldestImID), [imPath, 'frame', int2str(oldestImID), '.png']);
		
        % Step 3: add newest frame to working list
%         frames(:,:,:,oldestImID) = fff;
        
		% Step 4: save ID of new oldest to txt file
		oldestImID = oldestImID + 1;
		if oldestImID > totalIm, oldestImID = 1; end
        
        % Step 5: add oldest image ID to file
 		fileID = fopen([imPath, '_old.txt'],'w'); 
        fprintf(fileID, int2str(oldestImID)); 
        fclose(fileID);
		
		%Step 5: generate and save the bg image
 		imwrite(mode(frames, 4), [imPath, '_bg.jpeg']);
		
		% Step 6: pause till the server image updates
        loopTime = toc(startLoopTimer);
		if loopTime < pauseTime, pause(pauseTime-loopTime); end
        disp(loopTime)
	end
end