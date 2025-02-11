%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_poisson_composite_demo.m
%% Demonstration of Gradient Domain (Poisson) compositing
%% Works over greyscale and RGB images.  Calls ipv_poisson_composite for
%% heavy lifting.
%%
%% Usage:  ipv_poisson_composite_demo
%%
%% IN:  N/A - filenames hardcoded please edit to experiment
%%
%% OUT: N/A
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all
clear all

BG_IMAGE=double(imread('pool.jpg'))./255;
FG_IMAGE=double(imread('dog.jpg'))./255;
FG_MASK=double(imread('dogmask.png'))./255;


%Offset dog from bottom-right
P=[(size(BG_IMAGE,2) - size(FG_IMAGE,2) -1);
    (size(BG_IMAGE,1) - size(FG_IMAGE,1) -1);]

out=ipv_poisson_composite(BG_IMAGE,FG_IMAGE,FG_MASK,P);

imshow(out);