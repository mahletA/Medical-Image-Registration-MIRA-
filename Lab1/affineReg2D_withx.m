function [ Iregistered, M, x] = affineReg2D_withx( Imoving, Ifixed, x )
%Example of 2D affine registration
%   Robert Martí  (robert.marti@udg.edu)
%   Based on the files from  D.Kroon University of Twente 

% clean
%clear all; close all; clc;

% Read two imges 
% Imoving=im2double(rgb2gray(imread('brain1.png'))); 
% Ifixed=im2double(rgb2gray(imread('brain2.png')));

Im=Imoving;
If=Ifixed;

Im_smooth = imgaussfilt(Im);
If_smooth = imgaussfilt(If);
mtype = 'sd'; % metric type: sd: ssd gcc: gradient correlation; cc: cross-correlation
ttype = 'a'; % rigid registration, options: r: rigid, a: affine

   
% Parameter scaling of the Translation and Rotation
% and initial parameters
switch ttype
    case 'r'
        if ~exist('x','var')
            x=[0 0 0];
        end
        scale = [1 1 0.1];
    case 'a'
        if ~exist('x','var')
            x=[ 1 0 0 ;
            0 1 0 ];
        end
        
%         scale = [0.001 0.001 10 ; 0.001 0.001 10]; % for 1 and 2 
         scale = [0.1 0.1 10 ; 0.1 0.1 10]; % for 1 and 3 
%         scale = [0.01 0.01 1; 0.01 0.01 1]; % for 1 and 4 
end



x=x./scale;
    
    
[x]=fminsearch(@(x)affine_registration_function(x,scale,Im_smooth,If_smooth,mtype,ttype),x,optimset('MaxIter',1000, 'TolFun', 1.000000e-10,'TolX',1.000000e-10, 'MaxFunEvals', 1000*length(x), 'PlotFcns',@optimplotfval));

x=x.*scale;

switch ttype
	case 'r'
        % Make the rigid transformation matrix
         M=[ cos(x(3)) sin(x(3)) x(1);
            -sin(x(3)) cos(x(3)) x(2);
           0 0 1];
      
    case 'a'
        % Make the affine transformation matrix
         M=[ x(1,1) x(1,2) x(1,3);
             x(2,1) x(2,2) x(2,3);
           0 0 1];
end
     

 % Transform the image 
Icor=affine_transform_2d_double(double(Im),double(M),0); % 3 stands for cubic interpolation

% Show the registration results
figure,
subplot(2,2,1), imshow(If);
subplot(2,2,2), imshow(Im);
subplot(2,2,3), imshow(Icor);
subplot(2,2,4), imshow(abs(If-Icor));

%imwrite(Icor, './Results/brain1_to_brain3_reg_cc.png');
Iregistered = Icor;
end

