%script to test the value of MI between images
%sd     cc        gcc      MR
%4.2228 4.5931   0.6706   3.9068
%1.0918 1.0329   0.7390   2.4326
%0.3562 0.3402   0.7371   2.5883
%
clear all, close all,clc
% import images
reg =imread('./Results/brain1_to_brain3_reg_sd_MR.png'); 
Ifixed=rgb2gray(imread('brain3.png'));
MI_GG(Ifixed, reg)