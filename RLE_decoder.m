function Id = RLE_decoder(Ie, L, C)
    % 1D Array holding the decoded values
    Id_1D = zeros(L * C, 1);
    
    % Current index of 1D array
    Id_1D_index = 0;

    % Iterate through all encoded values
    for i = 1:size(Ie, 1)

        % Loop for the amount of repetitions
        for j = 1:Ie(i, 2)
            % Copy the value
            Id_1D(Id_1D_index + j, 1) = Ie(i, 1);
        end

        % Increment index by number of repetitions
        Id_1D_index = Id_1D_index + Ie(i, 2);
    end

    % Reshape decoded image back to original dimensions
    Id = reshape(Id_1D, L, C)';
