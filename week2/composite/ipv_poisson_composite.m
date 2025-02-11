%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_poisson_composite.m
%% Demonstration of Poisson image in-painting using Laplacian smoothness
%% constraint.  Works over greyscale and RGB images.
%%
%% Usage:  ipv_poisson_composite(img_in, img_ins, mask, offset)
%%
%% IN:  img_in  -  The source image in double format (RGB or greyscale)
%%      img_ins -  The image to be compositing into the source image
%%      mask    -  Binary mask of region within img_ins to be composited
%%      offset  -  Where to position img_ins inside img_in, specifically
%%                 image top-left is positioned at these coordinates
%%
%% OUT: img_out -  The composited image.
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function out=ipv_poisson_composite(img,ins,mask,P)

K=[0 1 0 ; 1 -4 1 ; 0 1 0];
for z=1:size(ins,3)
    divins(:,:,z)=conv2(ins(:,:,z),K,'same');
end

M=zeros(size(img,1),size(img,2));
MH=size(mask,1);
MW=size(mask,2);
M(P(2):(P(2)+MH-1),P(1):(P(1)+MW-1))=mask;

H=size(img,1);
W=size(img,2);

Npix=W*H;
A=speye(Npix,Npix);
for z=1:size(img,3)
    X(:,z)=reshape(img(:,:,z)',[],1);
end

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
    %X(row,1)=0;
    srcpix=[x(n);y(n)]-P;
    for z=1:size(img,3)
%        if srcpix(1)>0 & srcpix(2)>0 & srcpix(2)<=size(srcpix,1) & srcpix(1)<=size(srcpix,2)
            X(row,z)=divins(srcpix(2),srcpix(1),z);
%        end
    end
end


for chan=1:size(img,3)
    b=full(A\(X(:,chan)));
    out(:,:,chan)=reshape(b,W,H)';
end
