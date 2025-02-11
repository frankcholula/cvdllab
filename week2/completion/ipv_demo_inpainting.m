%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_demo_inpainting.m
%% Simple UI built around the ipv_inpaint_image function to demo 
%% Poisson based image inpainting aka Perez, Blake et al. SIGGRAPH 2003.
%%
%% Usage:  ipv_inpaint_image(img_in, mask)
%%
%% IN:  N/A
%% OUT: N/A
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all
clear all;

img=double(imread('\ali.jpg'))./255;

M=roipoly(img);

out=ipv_inpaint_image(img,M);

imshow(out);
title('Inpainted result');