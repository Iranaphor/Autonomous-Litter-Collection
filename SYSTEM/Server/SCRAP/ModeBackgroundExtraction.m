clear;
close all;

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

modeImage = images(:,:,:, 1).*0;

tic, 
a = permute(mode(permute(images, [4, 1, 2, 3])), [2, 3, 4, 1]);
toc

figure, imagesc(a)

beep, pause(0.5)
beep, pause(0.5)
beep, pause(0.5)
beep, pause(0.5)

disp('Complete');
