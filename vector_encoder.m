function [Ie, Ie_size, dictionary] = vector_encoder(Is, L, C, group_size, dict_size, lbg_iterations)
    % Group image in vectors of size group_size
    I_grouped = reshape(Is.', [group_size, C * L / group_size]).';
    Ig_size = size(I_grouped, 1);

    % Get unique groups of values
    I_grouped_unique = unique(I_grouped, 'rows');
    Igu_size = size(I_grouped_unique, 1);

    % Initial dictionary
    dict_size = min(dict_size, Ig_size); % Dict can't be bigger than I_grouped
    dictionary = zeros(dict_size, group_size);

    % Build dict out of unique groups from source image
    for i = 1:dict_size
        dictionary(i, :) = I_grouped_unique(i * floor(Igu_size / dict_size), :);
    end

    %---------------------
    % LBG ITERATIONS
    %---------------------
    for i = 1:lbg_iterations + 1
        %---------------------
        % ASSOCIATION
        %---------------------

        % Initial vector encoding
        Ie = zeros(Ig_size, 1);

        % Table of associated groups of values for every dictionary value
        Pa{dict_size, 1} = [];

	    % For every group of values in the source image
        for j = 1:Ig_size
            % Group of value j
            P = I_grouped(j, :);

            % Euclidian distance table
            euc_dist = zeros(dict_size, 1);
            
            % For every group of values in the dictionary
            for f = 1:dict_size
                % f dictionnary value
                D = dictionary(f, :);

                % Calculate Euclidian distance
                euc_dist(f, 1) = sqrt(sum((double(P) - D).^2));
            end

            % index of closest dictionary value for encoded image
            [M, I] = min(euc_dist);
            Ie(j, 1) = I;

            % Add P to corresponding group in Pa table
            Pa{I} = [Pa{I}; {I_grouped(j, :)}];
        end
        %---------------------
        % UPDATE DICT
        %---------------------
        if (i <= lbg_iterations)
            for j = 1:dict_size
                % Update dict value i with mean of associated pairs of values
                dictionary(j, :) = mean(cell2mat(Pa{j}), 1);
            end
        end

        % Reset Pa
        Pa = {};
    end 
    
    % Dictionary disk size
    dict_value_size = 8 * group_size;
    dict_total_size = dict_size * dict_value_size;
    
    % Encoded image size
    encoded_value_size = size(dec2bin(dict_size), 2);
    Ie_size = size(Ie, 1) * size(Ie, 2) * encoded_value_size + dict_total_size;