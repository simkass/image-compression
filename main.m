% Lossy and lossless image compression techniques
% Author: Simon Kassab
close all

Is = imread("images/image2.bmp");
Is = rgb2gray(Is);
figure, imshow(Is, [0, 255]);

% Simpler image for rapid testing
%Is = [12 12 10; 40 20 200; 25 40 150];

% Source image dimensions
Is_dim = size(Is);
L = Is_dim(1, 1);
C = Is_dim(1, 2);

% Source image disk size
Is_size = L * C * 8;

% Choose compression algorithm
% Lossless: RLE or Huffman
% Lossy: Uniform Scalar, Non Uniform Scalar or Vector
compression_algorithm = "Vector";

switch compression_algorithm
    case "RLE"
        [Ie, Ie_size] = RLE_encoder(Is, L, C);
        Id = RLE_decoder(Ie, L, C);
    case "Huffman"
        [Ie, Ie_size, coding_table] = Huffman_encoder(Is, L, C);
        Id = Huffman_decoder(Ie, coding_table, L, C);
    case "Uniform Scalar"
        [Ie, Ie_size, dictionary] = uniform_scalar_encoder(Is, L, C, 16);
        Id = scalar_decoder(Ie, L, C, dictionary);
        PSNR = calculate_PSNR(Is, Id, L, C);
    case "Non Uniform Scalar"
        [Ie, Ie_size, dictionary] = nonuniform_scalar_encoder(Is, L, C, 16);
        Id = scalar_decoder(Ie, L, C, dictionary');
        PSNR = calculate_PSNR(Is, Id, L, C);
    case "Vector"
        [Ie, Ie_size, dictionary] = vector_encoder(Is, L, C, 2, 32, 4);
        Id = vector_decoder(Ie, L, C, dictionary);
        PSNR = calculate_PSNR(Is, Id, L, C);
    otherwise
        disp('Specified compression algorithm not valid')
end

figure, imshow(Id, [0, 255]);

% Compression Rate
compression_rate = Ie_size / Is_size;
