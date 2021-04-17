function Id = uniform_scalar_decoder(Ie, L, C)
    Id = zeros(L, C);
    for i=1:L
        for j=1:C
            codeword = Ie(i, j);
            Id(i, j) = dictionnary(1, codeword + 1);
        end
    end