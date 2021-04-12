function [Ie, Ie_size] = RLE_encoder(Is, L, C)

    % Reshape image into a 1D array
    Is_1D = reshape(Is', L * C, 1);

    % Array of encoded values
    Ie = zeros(1, 2);

    % Initialize number of repetitions
    rep = 1;
    max_rep = 7;

    % Index of encoded values
    j = 1;

    for i = 1:L * C
        % if reached end of values, if next value is different than current value
        % or if rep has reached max_rep
        if i == L * C || Is_1D(i, :) ~= Is_1D(i + 1, :) || rep >= max_rep
            % Add value and repetitions in encoded values array
            Ie(j, 1) = Is_1D(i, :);
            Ie(j, 2) = rep;

            % Increase size of encoded values array
            Ie = cat(1, Ie, zeros(1, 2));
            j = j + 1;

            % Reset repetitions
            rep = 1;
        else
            % Increment repetitions
            rep = rep + 1;
        end

    end

    % Encoded image size
    Ie_size = size(Ie, 1) * 11;