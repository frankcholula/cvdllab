%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_warp_backward.m
%% Demonstrating of an image warp under affine transformation
%% using backward mapping and nearest neighbour 'interpolation'.
%%
%% Usage:  ipv_warp_backward
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

corners = [0 W 0 W; 0 0 H H]
corners(3,:) = 1
warpedcorners = M * corners;


minx = min(warpedcorners(1,:));
miny = min(warpedcorners(2,:));
maxx = max(warpedcorners(1,:));
maxy = max(warpedcorners(2,:));

T = [1 0 -minx; 0 1 -miny; 0 0 1];
M = T*M;
newW = ceil(maxx - minx + 1);
newH = ceil(maxy - miny + 1);


img_out=zeros(newH,newW,3);

M=inv(M);

for x=1:newW
    for y=1:newH
        
        q = [x ; y ; 1];
        p = M * q;
        
        u = p(1)/p(3);
        v = p(2)/p(3);
        
        u = floor(u);
        v = floor(v);
        
        if (u>0 & u<=W-1 & v>0 & v<=H-1) 
           img_out(y,x,:)=img_in(v,u,:);
        end
        
    end
end

imgshow(img_out);
