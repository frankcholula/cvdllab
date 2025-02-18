%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_warp_backward.m
%% Demonstrating of an image warp under affine transformation
%% using naive forward mapping and nearest neighbour 'interpolation'.
%% NOTE this is not presented as a sensible solution to image warping!
%%
%% Usage:  ipv_warp_forward
%%
%% IN:  N/A 
%% 
%% OUT: N/A
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

INPUT_IMAGE = 'surrey.png';

img_in=double(imread(INPUT_IMAGE))./255;

H=size(img_in,1);  % height
W=size(img_in,2);  % width

th=pi/4;
R=[cos(th) -sin(th) 0 ; ...
   sin(th)  cos(th) 0 ; ...
   0        0       1];

T=[1 0 -W/2 ; ...
   0 1 -H/2 ; ...
   0 0 1];

M=inv(T)*R*T;


img_out=zeros(H,W,3);

for x=1:W
    for y=1:H
        
        p = [x ; y ; 1];
        q = M * p;
        
        u = q(1)/q(3);
        v = q(2)/q(3);
        
        u = floor(u);
        v = floor(v);
        
        if (u>0 & u<=W & v>0 & v<=H) 
           img_out(v,u,:)=img_in(y,x,:);
        end
        
    end
end

imgshow(img_out);
