function [Ie, Ie_size, code_table] = Huffman_encoder(Is, L, C)
  
  [GC, GR] = groupcounts(image(:));
  P = GC ./ sum(GC);
  [P, index] = sort(P);