function [CC] =NormalizedGCC (im_Gx,im_Gy,if_Gx,if_Gy)
    CC = sum((im_Gx(:).* if_Gx(:))+(im_Gy(:).* if_Gy(:)));
    CC = CC / sqrt( sum( (im_Gx(:).^2) + (im_Gy(:).^2) ) .* sum( (if_Gx(:).^2) + (if_Gy(:).^2) ) );

end