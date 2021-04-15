function Id = Huffman_decoder(Ie, coding_table, L, C)
    Id = zeros(L, C);
    for i=1:L
        for j=1:C
            for k=1:size(coding_table, 1)
                if isequal(coding_table{k, 2}, Ie{i, j})
                    Id(i, j) = coding_table{k, 1};
                end
            end
        end
    end
