% Lossy and lossless image compression techniques
% Author: Simon Kassab

Is = imread("images/image1.bmp");
figure, imshow(Is, [0, 255]);

Ie = RLE_encoder(Is)