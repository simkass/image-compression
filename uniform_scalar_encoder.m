function [Ie, Ie_size, dictionnary] = uniform_scalar_encoder(Is, L, C, nb_codewords)
    % Parameters
    min_value = 0;
    max_value = 255;

    % Calculating the size of every codeword interval
    interval_range = (max_value - min_value) / nb_codewords;

    % Upper limits of the intervals
    upper_limits = zeros(1, nb_codewords);
    % Dictionnary of values and codewords
    dictionnary = zeros(1, nb_codewords);
    
    % Building dictionnary
    for i=1:nb_codewords
        upper_limits(1, i) = i * interval_range;
    
        % Median value of the interval
        value = ((i - 1) * interval_range) + interval_range / 2;
    
        % Building dictionnary
        dictionnary(1, i) = value;
    end

    % Encoded image
    Ie = zeros(L, C);

    % Encoding the image
    for i=1:L
        for j=1:C
            % Interval index value
            codeword = 0;
            while Is(i, j) > upper_limits(1, codeword + 1)
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
