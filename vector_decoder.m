function Id = vector_decoder(Ie, L, C, dictionary)
    % Get group size from dict
    group_size = size(dictionary, 2);
    
    % Initial decoded image
    Id = zeros(L * C / group_size, group_size);
    
    % Match encoded values with dictionary values
    for i = 1:size(Ie, 1)
        Id(i, :) = dictionary(Ie(i, 1), :);
    end
    
    % Reconstruct image
    Id = reshape(Id.', [L, C]).';
    Id = uint8(Id);