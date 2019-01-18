entCalc = @piss;
cam = camsetup();





function imout = piss(im, r)
%     r = 5;
    START = tic;
%     padarray(im, [ceil(r/2), ceil(r/2)], 0)
    
    for i = (r+1):r:size(im, 1)-(r+1)
        for j = (r+1):r:size(im, 2)-(r+1)
            imout(i-r:i+r, j-r:j+r, :) = ...
                entropy(double(im(i-r:i+r, j-r:j+r, :)));
        end
    end
    toc(START);
end



function cam = camsetup()
    cam = imaq.VideoDevice('winvideo', 1);
    cam.ReturnedColorSpace = 'rgb';
end



