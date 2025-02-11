close all
clear all


INPUT_IMAGE = 'surrey.png';

img_in=double(imread(INPUT_IMAGE))./255;
%img_in=cheqpattern(200,200,5,5);

% build test transform
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

%[img_unwarped score]=ipv_unwarp_score_nearest(img_in,M);
[img_unwarped score]=ipv_unwarp_score_bilinear(img_in,M);
imshow([img_in img_unwarped]);
