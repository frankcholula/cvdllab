%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% cheqpattern.m
%% Create an image of a chequerboard pattern.  Serves as a simple test
%% for image processing in particular digital image warping coursework.
%%
%% Usage:  cheqpattern (H,W,Sx,Sy)
%%
%% IN:  H        - The desired height of the image to be generated (pixels)
%% IN:  W        - The desired width of the image to be generated (pixels)
%% IN:  Sx       - The desired height of a chequer in the pattern (pixels)
%% IN:  Sy       - The desired width of a chequer in the pattern (pixels)
%% 
%% OUT: The generated image (in form of a H x W matrix) pixels range [0,1]
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function out=cheqpattern(H,W,Sx,Sy)

out=zeros(H,W);

flipx=0;
flipy=1;
for x=1:W
    if mod(x,Sx)==1
        flipx=1-flipx;
    end
    for y=1:H
        if mod(y,Sy)==1
            flipy=1-flipy;
        end
        out(y,x)=xor(flipx,flipy);        
    end
end