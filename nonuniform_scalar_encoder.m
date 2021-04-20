function [Ie, Ie_size, dictionnary] = nonuniform_scalar_encoder(Is, L, C, nb_codewords)
    % Lower limits using the Lloyd-Max Algorithm
    [lower_limits, dictionnary] = lloyds(Is(:), nb_codewords);

    % Encoder
    Ie = zeros(L, C);
    for i=1:L
        for j=1:C
            % Interval index value
            codeword = 0;
            % If the value is higher than the lower limit, increment codeword
            while nb_codewords - 1 > codeword && Is(i, j) > lower_limits(codeword + 1, 1)
                codeword = codeword + 1;
            end
            Ie(i, j) = codeword;
        end
    end

    % Size of a codeword
    codeword_size = size(dec2bin(nb_codewords), 2);
    % Total size of encoded image
    Ie_size = codeword_size * L * C;
    % Adding the size of the dictionnary (8 bits for the value + the size of the codewords)
    Ie_size = Ie_size + size(dictionnary, 2) * (8 + codeword_size);