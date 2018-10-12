function [CC]= NormalizedCC (Imoving, Ifixed)

moving_mean = mean2(Imoving);
fixed_mean = mean2(Ifixed);

CC = sum((Imoving(:) - moving_mean).*(Ifixed(:) - fixed_mean));
CC = CC / sqrt(sum((Imoving(:) - moving_mean).^2) * sum((Ifixed(:) - fixed_mean).^2));


end