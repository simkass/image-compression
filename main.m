% Lossy and lossless image compression techniques
% Author: Simon Kassab

Is = imread("images/image3.bmp");
figure, imshow(Is, [0, 255]);

%Is = [12 12 10; 40 20 200; 25 40 150];

% Source image dimensions
Is_dim = size(Is);
L = Is_dim(1, 1);
C = Is_dim(1, 2);

% Source image disk size
Is_size = L * C * 8;

% Choose compression algorithm
% Lossless: RLE or Huffman
% Lossy:
compression_algorithm = "Huffman";

switch compression_algorithm
    case "RLE"
        [Ie, Ie_size] = RLE_encoder(Is, L, C);
        Id = RLE_decoder(Ie, L, C);
    case "Huffman"
        [Ie, Ie_size, code_table] = Huffman_encoder(Is, L, C)
    otherwise
        disp('Compression algorithm not valid')
end

% Compression Rate
compression_rate = Ie_size / Is_size;
