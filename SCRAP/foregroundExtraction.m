clear;
close all;

lbar = @LOADINGBAR;

baseDir = dir;
cd([baseDir(3).folder, '\', baseDir(3).name]);

%% Read in all snapshots
disp('Reading Snapshots');
FGEDir = dir;
for i = 3:size(FGEDir,1)
    nom = flip(FGEDir(i).name);
    if size(nom,2) > 3
        if nom(1:4) == "GNP."
            a = [FGEDir(i).folder, '\', FGEDir(i).name];
            images(:,:,:,i-2) = imread(a);
        end
    end
end
cd(baseDir(1).folder);

%% Calculate total number of changes for each pixel
disp('Calculating Changes');

% activity = images(:,:,:, 1).*0;
% commonality = double(activity);
% duration = activity;
% consistency = double(activity);
modeImage = images(:,:,:, 1).*0;

tic
fprintf('         ');
for i = 1:size(images, 1)
    for j = 1:size(images, 2)
        for k = 1:size(images, 3)
%             a = images(i, j, k, :);
%             [m, n, q] = unique(flip(shiftdim(a, 3)));
%             
%             %Frequency of changes to pixel A
%             activity(i, j, k) = size(m, 1)./size(a,1);
%             
%             %Percentage of time pixel A == mode
%             commonality(i, j, k) = sum(a==mode(a));
%             
%             %Persistance of current value
%             if size(n,1) > 1 
%                 duration(i, j, k) = size(a,1)-n(2);
%             else
%                 duration(i, j, k) = size(a,1);
%             end
%             
%             %Total time as pixel A
%             consistency(i, j, k) = sum(a==m(1))./size(a,1);
            
            %Mode Image
            modeImage(i, j, k) = mode(images(i, j, k, :));
            
        end 
    end
%     if mod(i,10) == 0
%         lbar(i-1, size(images, 1));
%     end
end
% 
% ff = commonality; clear commonality;
% commonality(:,:) = ff(:,:,1)./3 + ff(:,:,2)./3 + ff(:,:,3)./3;
% ff = consistency; clear consistency;
% consistency(:,:) = ff(:,:,1)./3 + ff(:,:,2)./3 + ff(:,:,3)./3;
% activity = rgb2gray(activity);
% duration = rgb2gray(size(images, 4) - duration);

toc

%% Output Weightings

% subplot(2, 2, 1); imagesc(activity); colorbar;
% title('Activity');
% 
% subplot(2, 2, 2); imagesc(commonality); colorbar;
% title('Commonality');
% 
% subplot(2, 2, 3); imagesc(duration); colorbar;
% title('Time Since Change');
% 
% subplot(2, 2, 4); imagesc(consistency); colorbar;
% title('Consistency');

figure, imagesc(modeImage)

%% Apply Weightings to Attain BG











beep, pause(0.5)
beep, pause(0.5)
beep, pause(0.5)
beep, pause(0.5)

disp('Complete');
%%


% A = imread('FGExtraction/Slide1.png');
% B = imread('FGExtraction/Slide2.png');
% C = imread('FGExtraction/Slide3.png');
% D = imread('FGExtraction/Slide4.png');
% E = imread('FGExtraction/Slide5.png');
% 
% imagesc(~(A == B) + ~(B == C) + ~(C == D) + ~(D == E));
% 
% 
% 
% a = [1 1 3 1];
% b = [1 3 3 1];
% c = [1 3 3 3];
% d = [1 3 3 4];
% disp(~(a == b) + ~(b == c) + ~(c == d));



% %%
% images = uint8(zeros(size(A,1), size(A,2), size(A,3), 3));
%
% images(:,:,:,1) = A;
% images(:,:,:,2) = B;
% images(:,:,:,3) = C;
%
%
% I = uint8(zeros(size(A,1), size(A,2)));
% for i = 2:size(images, 4)
%     I = I + uint8(~(images(:,:,:,i) == images(:,:,:,i-1)));
% end
% I = logical(I);
%
% figure('units','normalized','outerposition',[0 0 1 1]);
% imagesc(I); axis image; colorbar;
%
% %%
% R = A(:,:,1);
% %imagesc(A(I==0));
%
% b = imresize(R(I==0), [size(R,1), size(R,2)]);
%
% size(b);
% imagesc(b);
% % figure('units','normalized','outerposition',[0 0 1 1]);
% % imagesc(J); axis image; colorbar;



function nothing = LOADINGBAR(num, dom)
    
    perc = 30;
    nper = ceil(perc*(num/dom));
    
    bbox = char(9611);
    b = char(9613);
    
    if (num ~= 0)
        for i = 1:perc+7
            fprintf('\b') 
        end
    end
        
    fprintf(['- ', b]);

    for i = 1:nper
        fprintf(bbox);
    end

    for i = nper+1:perc
        fprintf(' ');
    end

    fprintf([b,' -\n']);

    if (num-1 == dom)
        HELP(0, 0, 0);
    end
    
    nothing = 0;
end


