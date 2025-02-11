%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_warp_backward.m
%% Demonstrating of an image warp under affine transformation
%% using backward mapping and nearest neighbour 'interpolation'.
%%
%% Usage:  ipv_warp_backward_func(img,M)
%%
%% IN:  img  -  Input image (RGB or greyscale)
%%      M    -  3x3 warp transform
%% 
%% OUT: out  -  Output image
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function img_out=ipv_warp_backward_func(img_in,M)
H=size(img_in,1);  % height
W=size(img_in,2);  % width


img_out=zeros(H,W,3);

for x=1:W
    for y=1:H
        
        q = [x ; y ; 1];
        p = inv(M) * q;
        
        u = p(1)/p(3);
        v = p(2)/p(3);
        
        u = floor(u);
        v = floor(v);
        
        if (u>0 & u<=W & v>0 & v<=H) 
           img_out(y,x,:)=img_in(v,u,:);
        end
        
    end
end

