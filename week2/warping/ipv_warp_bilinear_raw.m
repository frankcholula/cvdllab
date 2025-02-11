%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_warp_backward.m
%% Demonstrating of an image warp under affine transformation
%% using backward mapping and bilinear 'interpolation'.
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

function img_out=ipv_warp_bilinear_raw(img_in,M)

H=size(img_in,1);
W=size(img_in,2);

newW=W;
newH=H;

img_out=zeros(newH,newW,3);

for x=1:newW
    for y=1:newH
        
        q = [x ; y ; 1];
        p = inv(M) * q;
        
        u = p(1)/p(3);
        v = p(2)/p(3);

        vertblend=u-floor(u);
        horizblend=v-floor(v);
        
        if (u>1 & u<=W-1 & v>1 & v<=H-1) 
           A=img_in(floor(v),floor(u),:);
           B=img_in(ceil(v),floor(u),:);
           C=img_in(floor(v),ceil(u),:);
           D=img_in(ceil(v),ceil(u),:);
           
           E=A*(1-vertblend) + C*vertblend;
           F=B*(1-vertblend) + D*vertblend;
           
           G=(1-horizblend)*E + horizblend*F;
           img_out(y,x,:)=G;
        end
        
    end
end

