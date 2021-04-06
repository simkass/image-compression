function Ie = RLE_encoder(Is)

    % Source image dimensions
    Is_dim = size(Is);
    L = Is_dim(1, 1);
    C = Is_dim(1, 2);

    % Reshape image into a 1D array
    Is_1D = reshape(Is, L * C, 1);

    Ie = zeros(1, 2);

    rep = 1;

    j = 1;

    for i = 1:L * C

        if i == L * C || Is_1D(i, :) ~= Is_1D(i + 1, :)
            Ie(j, 1) = Is_1D(i, :);
            Ie(j, 2) = rep;
            Ie = cat(1, Ie, zeros(1, 2));
            j = j + 1;
            rep = 1;
        else
            rep = rep + 1;
        end

    end
