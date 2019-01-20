% clear; close all; clc
%%







%
% f_entropyGroup = @entropyGroup;
% f_entropySig = @entropySig;
% f_entropyCompare = @entropyCompare;
%

% CCS = @cameraControlSystem;
% f_camSetup = @camSetup;
f_camStart= @camStart;
%
%
% f_readIMGs = @readIMGs;
%
%
% f_frameUpdate = @frameUpdate;

BGE = @backgroundExtraction;
% %f_findBG = @findBG_OLD;
% f_entropyBG = @entropyBG;


% FGE = @foregroundExtraction;
hFind = @hFindBase;
f_histeqFind = @histeqFind;
% f_entropyComparison = @entropyComparison;
% f_findFG = @findFG;



dR = @displayAllRegion;

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

% bg = backgroundExtraction(frames);
% im = histeq(frames(:,:,:,12));
% subplot(2, 2, 1); imagesc(bg); axis image
% subplot(2, 2, 2); imagesc(im); axis image
% subplot(2, 1, 2); imagesc(histeqFind(bg, im)); axis image


% bg2 = BGE(images);
% out = hFind(bg2, imn);
% figure;
% subplot(1, 3, 1), imagesc(bg2(640:700, 340:430, :)); title('BG2'); axis image
% subplot(1, 3, 2), imagesc(imn(640:700, 340:430, :)); title('IMN'); axis image
% subplot(1, 3, 3), imagesc(out(640:700, 340:430, :)); title('OUT'); axis image


%% Foreground Extraction Methods


% out_1 = hFind(bg, image_1);
% figure,
% subplot(2, 2, 1); imagesc(bg(600:700, 400:600, :)); axis image;
% subplot(2, 2, 2); imagesc(image_1(600:700, 400:600, :)); axis image;
% subplot(2, 2, 3); imagesc(out_1(600:700, 400:600, :)); axis image;
% subplot(6, 2, 8); h1r = histogram(out_1(600:700, 400:600, 1)); hV1r = h1r.Values; hV1r = hV1r(2:size(hV1r, 2));
% xlim([min(min(out_1(out_1>0))) 1]); ylim([0 max(hV1r)])
% subplot(6, 2, 10); h1g = histogram(out_1(600:700, 400:600, 2)); hV1g = h1g.Values; hV1g = hV1g(2:size(hV1g, 2));
% xlim([min(min(out_1(out_1>0))) 1]); ylim([0 max(hV1g)])
% subplot(6, 2, 12); h1b = histogram(out_1(600:700, 400:600, 3)); hV1b = h1b.Values; hV1b = hV1b(2:size(hV1b, 2));
% xlim([min(min(out_1(out_1>0))) 1]); y lim([0 max(hV1b)])
% 
% out_2 = hFind(bg, image_2);
% figure,
% subplot(2, 2, 1); imagesc(bg(600:700, 400:600, :)); axis image;
% subplot(2, 2, 2); imagesc(image_2(600:700, 400:600, :)); axis image;
% subplot(2, 2, 3); imagesc(out_2(600:700, 400:600, :)); axis image;
% subplot(6, 2, 8); h2r = histogram(out_2(600:700, 400:600, 1)); hV2r = h2r.Values; hV2r = hV2r(2:size(hV2r, 2));
% xlim([min(min(out_2(out_2>0))) 1]); ylim([0 max(hV2r)])
% subplot(6, 2, 10); h2g = histogram(out_2(600:700, 400:600, 2)); hV2g = h2g.Values; hV2g = hV2g(2:size(hV2g, 2));
% xlim([min(min(out_2(out_2>0))) 1]); ylim([0 max(hV2g)])
% subplot(6, 2, 12); h2b = histogram(out_2(600:700, 400:600, 3)); hV2b = h2b.Values; hV2b = hV2b(2:size(hV2b, 2));
% xlim([min(min(out_2(out_2>0))) 1]); ylim([0 max(hV2b)])



a = bottl(170:520,290:400,:); a = imresize(a, 0.03);
subplot(3, 2, 1), imagesc(a); axis image
subplot(9, 2, 2); hr = histogram(a(:, :, 1),5); hVr = hr.Values; hVr = hVr(2:size(hVr, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVr)])
subplot(9, 2, 4); hg = histogram(a(:, :, 2),5); hVg = hg.Values; hVg = hVg(2:size(hVg, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVg)])
subplot(9, 2, 6); hb = histogram(a(:, :, 3),5); hVb = hb.Values; hVb = hVb(2:size(hVb, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVb)])

a = bottlnCUP(125:520,290:400,:); a = imresize(a, 0.03);
subplot(3, 2, 3), imagesc(a); axis image
subplot(9, 2, 8); hr = histogram(a(:, :, 1),5); hVr = hr.Values; hVr = hVr(2:size(hVr, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVr)])
subplot(9, 2,10); hg = histogram(a(:, :, 2),5); hVg = hg.Values; hVg = hVg(2:size(hVg, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVg)])
subplot(9, 2,12); hb = histogram(a(:, :, 3),5); hVb = hb.Values; hVb = hVb(2:size(hVb, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVb)])


out = f_histeqFind(bg, image_2, 0.1, 5, 15, 15);
a = histeq(histeq(out(656:659,506:514,:)));
subplot(3, 2, 5), imagesc(a); axis image %a(:, :, 1) where sum(a)>0 {should use to reomve black pixels (or work from bina?)}
subplot(9, 2,14); hr = histogram(a(:, :, 1),5); hVr = hr.Values; hVr = hVr(2:size(hVr, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVr)])
subplot(9, 2,16); hg = histogram(a(:, :, 2),5); hVg = hg.Values; hVg = hVg(2:size(hVg, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVg)])
subplot(9, 2,18); hb = histogram(a(:, :, 3),5); hVb = hb.Values; hVb = hVb(2:size(hVb, 2)); xlim([min(min(a(a>0))) 1]); ylim([0 max(hVb)])














function bg = backgroundExtraction(frames)
    for i = 1:size(frames, 4)
        frames(:,:,:,i) = histeq(frames(:,:,:,i));
    end
    bg = mode(frames, 4);
end


function displayAllRegion(frames, y1, y2,x1, x2, hE)

    %Polymorphism for optional values
    if ~exist('x1', 'var'), x1 = 1; end
    if ~exist('x2', 'var'), x2 = size(frames, 2); end
    if ~exist('y1', 'var'), y1 = 1; end
    if ~exist('y2', 'var'), y2 = size(frames, 1); end
    if ~exist('hE', 'var'), hE = 0; end

    %Format subplot size
    d = divisors(size(frames, 4)); 
    dx = d(floor(size(d, 2)/2)); dy = d(floor(size(d, 2)/2)+1);
    if floor(sqrt(size(frames, 4))) == sqrt(size(frames, 4)), dx = dy; end
    
    %Plot hist_equalized or not
    if ~hE
        for i = 1:size(frames, 4)
            subplot(dx, dy, i); imagesc(frames(y1:y2, x1:x2, :, i)); axis image
        end
    else
        for i = 1:size(frames, 4)
            subplot(dx, dy, i); imagesc(histeq(frames(y1:y2, x1:x2, :, i))); axis image
        end
    end
end


function out = hFindBase(bg, img)
    out = histeqFind(bg, img);
end


function [out, hi, bina, filt, dila, slicer] = histeqFind(bg, img, th, fi, di, er)
    out = zeros(size(img));

    if ~exist('th', 'var'), th = 0.1; end
    if ~exist('fi', 'var'), fi = 5; end
    if ~exist('di', 'var'), di = 15; end
    if ~exist('er', 'var'), er = 10; end
    
    
    a = rgb2gray(histeq(img)) - rgb2gray(histeq(bg));
    bina = imbinarize(abs(a), th);
    filt = medfilt2(bina, [fi fi]);
    dila = imdilate(filt, ones(di));
    slicer = imerode(dila, ones(er));
    img = histeq(img);
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
        disp("IMAGE " + i + "/" + inc);
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









%% SCRAP

% for i = 1:1000, pause(0.2); 
%     a = floor(rand(1, 1000).*3)-1; 
%     a(1) = 0; a(a>1)=1;
%     subplot(1, 4, 1:3), line(cumsum(a), 1:size(a, 2)); 
%     subplot(1, 4, 4), scatter(a, 1:size(a, 2)); 
% end
 



% row = 123;
% col = 925689756987567846565467846565478663;
% 
% out = nan(1, row);
% for i=flip(1:row)
%     out(1, i) = mod(col, 3);
%     col = floor(col / 3); 
% end
% 
% disp(out-1);
