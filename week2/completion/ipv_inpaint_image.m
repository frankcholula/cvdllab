%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_inpaint_image.m
%% Demonstration of Poisson image in-painting using Laplacian smoothness
%% constraint.  Works over greyscale and RGB images.
%%
%% Usage:  ipv_inpaint_image(img_in, mask)
%%
%% IN:  img_in  -  The source image in double format (RGB or greyscale)
%%      mask    -  Binary mask of region to be inpainted
%%
%% OUT: img_out -  The inpainted image.
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function out=ipv_inpaint_image(img,M)

H=size(img,1);
W=size(img,2);

Npix=W*H;
A=speye(Npix,Npix);
X=ones(Npix,1);

[y x]=find(M);
for n=1:length(x)
    if mod(round((100*n)/length(x)),10)==0
        fprintf('%d%%\n',round((n*100)/length(x)));
    end
    row=x(n)+((y(n)-1)*W);
    A(row,row)=-4;
    A(row,row-1)=1; 
    A(row,row+1)=1; 
    A(row,row-W)=1;
    A(row,row+W)=1;
    X(row,1)=0;
end

out=zeros(size(img));
for chan=1:size(img,3)
    thisX=reshape(img(:,:,chan)',[],1);
    thisX=thisX.*X;
    b=full(A\thisX);
    out(:,:,chan)=reshape(b,W,H)';
end
