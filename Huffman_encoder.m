function [Ie, Ie_size, coding_table] = Huffman_encoder(Is, L, C)
    Ie = {};
    Ie_size = 0;
    
    % Get probability of occurence of each unique value in the image
    [GC, GR] = groupcounts(Is(:));
    P = GC ./ sum(GC);
    [P, index] = sort(P);

    % Initialize coding table
    coding_table = cell(size(index, 1), 2);

    for i = 1:size(index, 1)
        coding_table{i, 1} = GR(index(i, 1), 1);
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
        coding_table{i, 2} = codes{i};
    end

    %-----------------------------
    %------ CODE THE IMAGE -------
    %-----------------------------

    % Values of the coding table
    values = cell2mat(coding_table(:, 1));

    for i = 1:L

        for j = 1:C
            % Find index in coding table
            idx = find(values == Is(i, j));
            % Extraire le code correspondant
            Ie(i, j) = coding_table(idx, 2);
            
            % Update the size of the encoded image
            Ie_size = Ie_size + size(coding_table{idx, 2}, 2);
        end

    end

    % Add coding table to the total size
    for i=1:size(coding_table, 1)
        Ie_size = Ie_size + 8 + size(coding_table{i, 2}, 2);
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
