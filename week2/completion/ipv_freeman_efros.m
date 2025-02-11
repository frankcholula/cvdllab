%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_freeman_efros.m
%% Demonstration of Freeman-Efros in-painting using image patches
%% Works over greyscale and RGB images.
%%
%% Usage:  ipv_freeman_efros()
%%
%% IN:  N/A - filenames hardcoded please edit to experiment
%%
%% OUT: N/A
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

close all;
clear all;

WINDOW=11;
STEP=floor(WINDOW/2);

FG_IMAGE=double(imread('dog.jpg'))./255;
FG_MASK=double(imread('dogmask.png'))./255;

%FG_IMAGE=double(imread('ali.jpg'))./255;
%FG_MASK=double(rgb2gray(imread('alimask.png'))>0);

H=size(FG_IMAGE,1);
W=size(FG_IMAGE,2);

% Build patch DB
DB=[];
for x=(STEP+1):STEP:W-WINDOW
    for y=(STEP+1):STEP:H-WINDOW
        pt=FG_IMAGE((y-STEP):(y+STEP),(x-STEP):(x+STEP),:);
        ptm=FG_MASK((y-STEP):(y+STEP),(x-STEP):(x+STEP));
        ptr=reshape(pt,1,[]);
        if sum(sum(ptm))==0
            DB=[DB;ptr];        
        end
    end
end
fprintf('Got %d patches\n',size(DB,1));

imshow(FG_IMAGE);
hold on;
while (1)
    [c r]=find(FG_MASK);
    if isempty(r)
        break;
    end
    x=r(1);
    y=c(1);
    localpatch=reshape(FG_IMAGE((y-STEP):(y+STEP),(x-STEP):(x+STEP),:),1,[]);
    localmask=reshape(FG_MASK((y-STEP):(y+STEP),(x-STEP):(x+STEP),:),1,[]);
    localmask=repmat(localmask,1,size(FG_IMAGE,3));
    DBC=DB;
    badidx=find(localmask);
    goodidx=find(localmask==0);
    DBC(:,badidx)=[];
    localpatchorig=localpatch;
    localpatch(:,badidx)=[];
    pquery=(repmat(localpatch,size(DBC,1),1)-DBC).^2;
    dists=sum(pquery');
    idx=find(dists==min(dists));
    idx=idx(1);
    bestpatch=reshape(DB(idx,:),WINDOW,WINDOW,3);    
    bestpatch(goodidx)=localpatchorig(goodidx);
    FG_IMAGE((y-STEP):(y+STEP),(x-STEP):(x+STEP),:)=bestpatch;
    FG_MASK((y-STEP):(y+STEP),(x-STEP):(x+STEP))=0;
    cla
    imshow(FG_IMAGE);drawnow;
end


