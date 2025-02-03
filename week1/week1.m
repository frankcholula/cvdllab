img = imread('assets/surrey.png');
imshow(img);
axis on;
size(img);

% extract vertical slice of (2,3)
p = img(3,2,:);

% extract red
% this is using rgb frame buffer (24 bit frame buffer).
p = img(2,1,1);

% crop image
img(200:300,100:150,:)=255;
imshow(img);
 
subimg = img(200:300,100:150,:);
imshow (subimg);

% note that jpg is lossy so better to save as .bmp or .png
imwrite(subimg, 'assets/out.jpg')

normimg = double(img)./255;
imshow(normimg);

% convert img to grey image
greyimg = normimg(:,:,1)*0.30 + normimg(:,:,2)*0.59 +normimg(:,:,3)*0.11;
imshow(greyimg);

% convert img to hsv img
hsvimg = rgb2hsv(normimg);
size(hsvimg);

% setting the hue to zero.
hsvimg(:, :, 1) =0;
rgbimg = hsv2rgb(hsvimg);
imshow(rgbimg);


% interpolation in rgb space gives you murky green because it doesn't
% consider human perception.
black = zeros (100,100,3);
red = black;
red (:, :, 1) = 1;
green = black;
green(:,:, 2) = 1;

imshow(red);
imshow(green);

rgbinterp = (red + green ) /2;
rgbinterp(1,1,:)


% interpolation in hsv space respects the perceptual color wheel and
% naturally blends red and green into yellow, which is what our eyes expect
redhsv=rgb2hsv(red);
greenhsv=rgb2hsv(green);
hsvinterp = (redhsv+ greenhsv) /2;

out = hsv2rgb(hsvinterp);
imshow(out);