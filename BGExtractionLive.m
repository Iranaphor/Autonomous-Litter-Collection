% clear; close all; clc
%%







% 
% f_entropyGroup = @entropyGroup;
% f_entropySig = @entropySig;
% f_entropyCompare = @entropyCompare;
% 

% CCS = @cameraControlSystem;
% f_camSetup = @camSetup;
% f_camStart= @camStart;
% 
% 
% f_readIMGs = @readIMGs;
% 
% 
% f_frameUpdate = @frameUpdate;

BGE = @backgroundExtraction;
% % f_findBG = @findBG_OLD;
% f_entropyBG = @entropyBG;


% FGE = @foregroundExtraction;
f_histeqFind = @histeqFind;
% f_entropyComparison = @entropyComparison;
% f_findFG = @findFG;



%%

% pause(0.1); obj = camSetup('winvideo', 2);
% pause(0.1); preview(obj);
% pause(0.1); frames = camStart(obj, 20, 1); %Grab 20 images, 1 sec apart from cam "obj"
% pause(0.1); frames = frameUpdate(frames, obj, 3);
% pause(0.1); bg = findBG(frames);
% pause(0.1); imagesc(bg)


% images = f_readIMGs("beachIMG", ".jpg");
% pause(0.1); images = readIMGs("yacht_images", ".PNG");
% pause(0.1); bg = findBG(images);
% pause(0.1); imagesc(bg);
% [labels, objects] = findFG(images(:,:,:,1), bg);


% pause(0.1); images = readIMGs("yacht_images", ".PNG");
% pause(0.1); frameEntropy = f_entropyGroup(images);
% pause(0.1); bgEntropy = f_entropyBG(frameEntropy);
% pause(0.1); [objs, lbl] = f_entropyCompare(bgEntropy, frameEntropy(:,:,1));



%% Foreground Extraction Methods

bg = backgroundExtraction(frames);
im = histeq(frames(:,:,:,12));
subplot(2, 2, 1); imagesc(bg); axis image
subplot(2, 2, 2); imagesc(im); axis image
subplot(2, 1, 2); imagesc(histeqFind(bg, im)); axis image



function bg = backgroundExtraction(frames)
    
    for i = 1:size(frames, 4)
        frames(:,:,:,i) = histeq(frames(:,:,:,i));
    end
    
    bg = mode(frames, 4);
end





function [out, hi, bina, filt, dila, slicer] = histeqFind(bg, img)
    out = zeros(size(img));
    
    a = rgb2gray(histeq(img)) - rgb2gray(histeq(bg));
    bina = imbinarize(a, 0.3);
    filt = medfilt2(bina, [5 5]);
    dila = imdilate(filt, ones(15));
    slicer = imerode(dila, ones(10));
    
    slice=img(:,:,1); slice(~slicer)=0; out(:,:,1) = slice;
    slice=img(:,:,2); slice(~slicer)=0; out(:,:,2) = slice;
    slice=img(:,:,3); slice(~slicer)=0; out(:,:,3) = slice;
    
    hi = 0;
end





%Can detect changes in texture (not my bottle on 1C floor)
%better when histogram equaised: imagesc(~histeq(im1./max(max(im1))) + ~histeq(im2./max(max(im1))))
function [out, im1, im2] = entropyComparison(bg, img)

    r = 3;
    im1 = entropySig(double(bg),r);
    im2 = entropySig(double(img),r);
    t = im1 - im2;
    t(t < 0.96)=0;
    
    
    slice=img(:,:,1); slice(t(1:size(img, 1), 1:size(img, 2))==0)=0; out(:,:,1) = slice;
    slice=img(:,:,2); slice(t(1:size(img, 1), 1:size(img, 2))==0)=0; out(:,:,2) = slice;
    slice=img(:,:,3); slice(t(1:size(img, 1), 1:size(img, 2))==0)=0; out(:,:,3) = slice;
end



%% Entropy Function Testing


function [objOut, labels] = entropyCompare(bgEntropy, imgEntropy)
    fprintf('Compare Entropy Background with Image Signature\n');
    a = imgEntropy~=bgEntropy;
    labels = bwlabel(imfill(imdilate(a, ones(3)),'holes'));
    imagesc(labels); title("labels");
    for i = 1:max(max(labels))
        t1 = imgEntropy;
        t1(labels ~= i) = 0;
        objOut(:,:,i) = t1;
    end
    
end

function background = entropyBG(frames)
    fprintf('Generate Entropy Background Signature\n');
    a = permute(frames, [3, 1, 2]);
    b = mode(a);
    background = permute(b, [2, 3, 1]);
end

function SIGs = entropyGroup(images)
    fprintf('Generate All Entropy Signatures\n');
    entropyRadius = 10;
    for i = 1:size(images, 4)
        tic; 
        SIGs(:,:,i) = entropySig(rgb2gray(images(:,:,:,i)), entropyRadius);
        fprintf(i + "/" + size(images, 4) + " - ");
        toc;
    end
end

function SIG = entropySig(IMAGE, RADIUS)
    fprintf('Generate Entropy Signature\n');
    r = RADIUS;
    
    PaddIMAGE = padarray(IMAGE, [r r]);
 
    
    SIG = zeros(floor(size(IMAGE, 1)/r), floor(size(IMAGE, 2)/r));
    for i = 1:r:size(IMAGE, 1)
        for j = 1:r:size(IMAGE, 2)
            n = PaddIMAGE(i:i+r+r, j:j+r+r);
            SIG(i:i+r-1, j:j+r-1) = entropy(n);
        end
    end
end





%% Basic Function Testing
%Create the camera object
function camObj = camSetup (videoDevice, videoIndex)
    fprintf('Cam Setup\n');
    camObj = imaq.VideoDevice(videoDevice, videoIndex);
    camObj.ReturnedColorSpace = 'rgb';
end

%Grab the initial 10 images
function frames = camStart(obj, inc, pau)
    fprintf('Grab Initial Fames\n');
    pause(4);
    for i = 1:inc
        pause(pau); frames(:,:,:,i) = step(obj);
        %imwrite(frame(:,:,:,i), i + ".png");
        disp("IMAGE " + i);
    end
end

%Included to test when camera not available
%dir('images\yacht_images\*.PNG')
function images = readIMGs(subfolder, fileType)
    fprintf('Reading Snapshots\n');
    
    baseDir = dir;
    cd(baseDir(3).folder + "\images\" + subfolder);
    FGEDir = dir;
    
    for i = 3:size(FGEDir,1)
        nom = flip(FGEDir(i).name);
        if size(nom,2) > 3
            if flip(nom(1:4)) == fileType
                a = [FGEDir(i).folder, '\', FGEDir(i).name];
                images(:,:,:,i-2) = imread(a);
            end
        end
    end
    cd(baseDir(1).folder);
end

%Replace the oldest of the images
function frames = frameUpdate(frames, obj, replace)
    fprintf('Add New Frame\n');
    frames(:,:,:,replace) = step(obj);
end

%Extract the background
function background = findBG_OLD(frames)
    fprintf('Extract Background\n');
    a = permute(frames, [4, 1, 2, 3]);
    b = mode(a);
    background = permute(b, [2, 3, 4, 1]);
end

%Extract the foreground objects
function [labels, objects] = findFG(img, bg)
    fprintf('Object Extraction\n');
    a = img~=bg;
    a = permute(  max(  permute(a, [3, 1, 2])   )   , [2, 3, 1]);
    labels = bwlabel(imfill(imdilate(a, ones(3)),'holes'));

    for i = 1:max(max(labels))
        t1 = rgb2gray(img);
        t1( labels ~= i ) = 0;
        objects(:,:,i) = t1;
    end
    
end
