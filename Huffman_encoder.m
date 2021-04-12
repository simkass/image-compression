function [Ie, Ie_size, code_table] = Huffman_encoder(Is, L, C)

    % Get probability of occurence of each unique value in the image
    %[GC, GR, P] = groupcounts(Is(:));
    GR = histc(Is(:), 1:255);
    P = GR ./ (L * C)
    [P, index] = sort(P);

    % Initialize coding table
    code_table = cell(size(index, 1), 2);

    for i = 1:size(index, 1)
        code_table{i, 1} = GR(index(i, 1), 1);
    end

    % Initialize Huffman Tree
    HT = cell(length(P), 1);

    %-----------------------------
    %- CREATING THE HUFFMAN TREE -
    %-----------------------------

    % Fill the tree with values of 1 to 256
    for i = 1:length(P)
        HT{i} = i;
    end

    % Build the tree until there is only two branches left
    while size(HT) - 2
        % Update probability order
        [P, i] = sort(P);

        % Update tree structure according to new probability order
        HT = HT(i);

        % Combine branch 1 and 2 into branch 2
        HT{2} = {HT{1}, HT{2}};

        % Delete branch 1
        HT(1) = [];

        % Update probabilities
        P(2) = P(1) + P(2);
        P(1) = [];
    end

    %-----------------------------
    %---- CREATING THE CODES -----
    %-----------------------------

    % Initialize codes
    global codes
    codes = cell(length(P), 1);

    % Calling recursive function (see below)
    get_codes(HT, []);

    % Adding codes to coding table
    for i = 1:size(codes, 1)
        code_table{i, 2} = codes{i};
    end

    %-----------------------------
    %------ CODE THE IMAGE -------
    %-----------------------------

    % Values of the coding table
    values = cell2mat(code_table(:, 1));

    for i = 1:L

        for j = 1:C
            % Find index in coding table
            idx = find(values == Is(i, j));
            % Extraire le code correspondant
            Ie(i, j) = code_table(idx, 2);
        end

    end

    function get_codes(branch, code)
        global codes
        % If the branch is a cell, we call the function again
        % if not, we go inside the terminal branch and add the code
        if isa(branch, 'cell')
            get_codes(branch{1}, [code 0]);
            get_codes(branch{2}, [code 1]);
        else
            % Adding code if not a cell
            codes{branch} = code;
        end

    end
