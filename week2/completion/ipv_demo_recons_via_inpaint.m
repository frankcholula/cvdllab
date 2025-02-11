%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_demo_inpainting.m
%% Simple demo around the ipv_inpaint_image function to demo 
%% Laplacian image inpainting to reconstruct an image from little data
%%
%% Usage:  ipv_demo_recons_via_inpaint
%%
%% IN:  N/A
%% OUT: N/A
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all
clear all;

LINECOUNT=35;

img=double(imread('johnface.jpg'))./255;

img=imresize(img,[400 400]);
H=size(img,1);
W=size(img,2);

LineMask=zeros(size(H,W));


for l=1:LINECOUNT
   P=0.025*H+rand(2,1)*H*0.95;
   Q=0.025*H+rand(2,1)*H*0.95;
   LineMask=ipv_bresenham(LineMask,P(1),P(2),Q(1),Q(2)); 
end
LineMask(LineMask>1)=1;
LineMask(H,W)=0;
LineMask=LineMask(1:H,1:W);

for z=1:size(img,3)
    LineMask(:,:,z)=LineMask(:,:,1);
end
img_to_inpaint=img.*LineMask;

figure;
imshow(img_to_inpaint);
title('Input to inpainting');

figure;
PaintMask=ones(size(LineMask))-LineMask;
PaintMask(1,1:end,:)=0;
PaintMask(end,1:end,:)=0;
PaintMask(1:end,1,:)=0;
PaintMask(1:end,end,:)=0;
out=ipv_inpaint_image(img_to_inpaint,PaintMask(:,:,1));

imshow(out);
title('Result of inpainting');