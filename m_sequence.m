function ms = m_sequence(base, m)
% Function generating full m sequence with desired base
%   Function first searches the primitive polynomial and afterwards
%   generates appropriate m sequence with length base^m-1

    % primitive polynomial weigths
    weights = prim_poly_search(base, m, 1, randi([0 base-1],[m 1])');
    % full m-sequence length
    length = base^m -1;

    %inti register 
    register = randi([1 base-1],[m 1]);
    %% shifting the register
    ms = [];
    for i = 1:length
      % shift operation
      ms(i)=rem(weights*register+base,base);
      % updating the register
      register=[ms(i); register(1:m-1)];
    end
    
end

