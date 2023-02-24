close all; 
clc;

img = imread('unnamed.png');
img = rgb2gray(img);


height = 512;
width = 512;

img_padded = zeros(height+1,width+1);
img_padded(1:height,1:width) = img;
% img_padded = img;

K = 2;
h = floor(height/K);
w = floor(width/K);

width = width + 1;
height = height + 1;

img_downsampled = zeros(h,w);
img_flattened = reshape(img_padded',[1,height*width]);

filter = [1/16 1/8 1/16; 1/8 1/4 1/8; 1/16 1/8 1/16];

for i = K:K:height
    L = (i-1)*width;
    for j = K:K:width
        pixel = L + j;
        G5 = img_flattened(pixel)*filter(2,2);
        G6 = img_flattened(pixel+1)*filter(2,3);
        G4 = img_flattened(pixel-1)*filter(2,1);
        
        G2 = img_flattened(pixel - width)*filter(1,2);
        G3 = img_flattened(pixel+1 - width)*filter(1,3);
        G1 = img_flattened(pixel-1 - width)*filter(1,1);
        
        G8 = img_flattened(pixel + width)*filter(3,2);
        G9 = img_flattened(pixel+1 + width)*filter(3,3);
        G7 = img_flattened(pixel-1 + width)*filter(3,1);
        
        G = G1 + G2 + G3 + G4 + G5 + G6 + G7 + G8 + G9;
        img_downsampled(i/K,j/K) = G;
    end
end
img_downsampled1 = uint8(img_downsampled);

figure;
imshow(img)

figure;
imshow(img_downsampled1)
%%
fileID = fopen('flattened_img_512_tree.txt','w');
fprintf(fileID,'%d\n',img_flattened);
%%
img_downsampled1 = reshape(img_downsampled1',[1,256*256]);
fileID = fopen('downsampled.txt','w');
fprintf(fileID,'%d\n',img_downsampled1);
