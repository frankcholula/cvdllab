%% EEEM010 - Image Processing and Vision (eem.ipv)
%%
%% ipv_bresenham.m
%% Implementation of Bresenham's algorithm for plotting a rasterised line
%% on a 2D image.
%%
%% Usage:  ipv_bresenham(img_in, tlx, tly, brx, bry)
%%
%% IN:  img_in  -  The source raster to be drawn on (greyscale)
%%      tlx     -  Top left corner of line (x coord)
%%      tly     -  Top left corner of line (y coord)
%%      brx     -  Bot left corner of line (x coord)
%%      bry     -  Bot left corner of line (y coord)
%%
%% OUT: img_out -  The raster with line plotted in white (255)
%%
%% (c) John Collomosse 2015  (J.Collomosse@surrey.ac.uk)
%% Centre for Vision Speech and Signal Processing (CVSSP)
%% University of Surrey, United Kingdom

function buffer = ipv_bresenham(buffer, x1,y1,x2,y2)

x1=floor(x1+0.5);
x2=floor(x2+0.5);
y1=floor(y1+0.5); 
y2=floor(y2+0.5);

dx=abs(x2-x1);
dy=abs(y2-y1);

steep = abs(dy)>abs(dx);

if steep 
    t=dx;
    dx=dy;
    dy=t;
end  



 q_start = floor(dx/2);
 q_increment =  -dy;
 q_end = -dy*dx+floor(dx/2);
    
 if dy==0 
     q_size= dx+1;
 else
       q_size = floor((q_end - q_start)/q_increment)+1;
 end
 
 
 sgn_y = 1;
 sgn_x = 1;
if steep   
    
     if y1<=y2 
        sgn_y = 1;
    else
        sgn_y = -1;
    end
    
    if x1<=x2
        sgn_x = 1;  
    else
        sgn_x = -1; 
    end
    
else
    
    if x1<=x2 
        sgn_x = 1;
    else
        sgn_x = -1;
    end
       
    if y1<=y2
        sgn_y = 1; 
    else
        sgn_y = -1;
    end
   
 end
    

    sum = q_start;
    m_prev = dx ;  
    q_sum = 0;
    for i=0:q_size-1  
        
         m = mod(sum, dx);
         d = m -  m_prev;
        
         if (d>=0)  
               q_sum = q_sum + 1;        
         end     
        
         m_prev = m; 
         sum = sum + q_increment;  
        
        if dy==0 
            q_sum = 0;      
        end      
        
         x = 0;
         y = 0;
        if steep  
             y = y1 + sgn_y*i;
             x = x1 + sgn_x*q_sum;  
        else
             x = x1 + sgn_x*i;
             y = y1 + sgn_y*q_sum;
        end
        
        buffer(y+1, x+1) = 255;
        
    end    
 
 
    

