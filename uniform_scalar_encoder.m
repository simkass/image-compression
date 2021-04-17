function [Ie, Ie_size] = uniform_scalar_encoder(Is, L, C, nb_codewords)
    % Parameters
    min_value = min(Is(:));
    max_value = max(Is(:));

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