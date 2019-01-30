function [] = ourFunction(arg1)
	disp(arg1);
end

%% Function Setup:
% function download_updates()
	% pauseTime = 60;
	% totalIm = 20;
	% imPath = 'images/'; %{add system to define images to load}
	% 
	%% Step A: load older images from files
	% for i = 1:totalIm
		% frames(:,:,:,i) = imread(imPath + "frame" + i + ".jpeg");
	% end
	% 
	%% Step B: download and process updates
	% while True
		%% Step 0: time length of processings
		% startLoopTimer = tic;
		% 
		%% Step 1: downlaod newest frame {add error handling}
		% frames(:,:,:,oldestImage) = http.download('frame.jpeg');
		% 
		%% Step 2: save image to txt file
		% imwrite(frames(:,:,:,oldestImID), imPath + "frame" + oldestImID + ".jpeg");
		% 
		%% Step 3: save ID of new oldest to txt file
		% oldestImID = oldestImID + 1;
		% if oldestImID > N, oledestImageID = 0; end
		% iowrite(oldestImID, 'old.txt');
		% 
		% Step 4: generate and save the bg image
		% imwrite(BGE(frames), 'bg.jpeg');
		% 
		%% Step5: pause till the server image updates
		% if timer < pauseTime, pause(pauseTime-toc(startLoopTimer)); end
	% end
% end