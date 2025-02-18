function [img_unwarped,score]=ipv_unwarp_score_nearest(img_in,M)

H=size(img_in,1);
W=size(img_in,2);

% warp 4 corners
corners=[1 1 H W ; 1 W W 1];
corners(3,:)=1;
warped_corners=M*corners;
minx=min(warped_corners(1,:));
maxx=max(warped_corners(1,:));
miny=min(warped_corners(2,:));
maxy=max(warped_corners(2,:));

shift=[1 0 -minx ; 0 1 -miny ; 0 0 1];
M=shift*M;
newW=ceil(maxx-minx+1);
newH=ceil(maxy-miny+1);

img_out=zeros(newH,newW,size(img_in,3));

for x=1:newW
    for y=1:newH
        
        q = [x ; y ; 1];
        p = inv(M) * q;
        
        u = p(1)/p(3);
        v = p(2)/p(3);

        u=floor(u);
        v=floor(v);
        
        if (u>1 & u<=W-1 & v>1 & v<=H-1) 
           img_out(y,x,:)=img_in(v,u,:);
        end
        
    end
end

img_unwarped=zeros(H,W,size(img_in,3));

for x=1:W
    for y=1:H
        
        q = [x ; y ; 1];
        p = M * q;
        
        u = p(1)/p(3);
        v = p(2)/p(3);

        u=floor(u);
        v=floor(v);
        
        if (u>1 & u<=newW-1 & v>1 & v<=newH-1) 
           img_unwarped(y,x,:)=img_out(v,u,:);
        end
                
    end
end

diffimg=abs(img_in-img_unwarped);
chn=zeros(size(img_in,1),size(img_in,2));
for n=1:size(img_in,3)
    chn=chn+diffimg(:,:,n);
end
diffimg=diffimg./size(img_in,3);

imshow(diffimg);

rs1=reshape(diffimg,1,[]);
score=sum(rs1.^2)/(H*W);

fprintf('MSE Score = %f%%\n',score*100);