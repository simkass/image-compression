% Lossy and lossless image compression techniques
% Author: Simon Kassab

Is = imread("images/image1.bmp");
figure, imshow(Is, [0, 255]);

Is = [12 12 10; 40 20 200; 25 40 150];

% Source image dimensions
Is_dim = size(Is);
L = Is_dim(1, 1);
C = Is_dim(1, 2);

% Source image size
Is_size = L * C * 8;

Ie = RLE_encoder(Is, L, C);
Id = RLE_decoder(Ie, L, C);

% Encoded image size
Ie_size = size(Ie, 1) * 11;
compression_rate = Ie_size / Is_size;