% script to run a test on the functions

clear all, close all,clc
% import images
Imoving=im2double(rgb2gray(imread('brain1.png'))); 
Ifixed=im2double(rgb2gray(imread('brain4.png')));

%% simple registration 
[ ~, ~] = affineReg2D( Imoving, Ifixed );

%% multiresolution register
res_level = 4;
[Iregistered, M] = multiresolution(Imoving, Ifixed, res_level );