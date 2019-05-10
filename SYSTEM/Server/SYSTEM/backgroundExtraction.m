function bg = backgroundExtraction(frames)
    
    disp('    Generate Background')
    
    for i = 1:size(frames, 4)
        frames(:,:,:,i) = histeq(frames(:,:,:,i));
    end
    
    bg = mode(frames, 4);
    
end
