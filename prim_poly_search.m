function weights = prim_poly_search(base, p_len, number, init_weight)
%% 
% Simple primitive polinomial search algorthm
%
% The algorithm initialises a simple shift register with the size of uniqueLenght
% and searches the polynomial values which will have no repetitions of the
% initial register value for the full length of the sequence: base^uLen - 1;
%
%
% base - number of values of the sequence - dictionary length
% p_len - length of the unique sequence window
% startWeight - the weight to start iterative search 
%               default is [0 0 ... 0]
% number - number of polinomials to find, if the user does not need all of
% them.
% 
%

% length of the full sequence
length=base^p_len-1;
% polynomial value
p=zeros(1,p_len);
weights = p;


% if initial weights provided start searching from it
loop_init = 0;
if nargin == 4
    p = init_weight; 
    for l = 0: p_len -1
       loop_init =  loop_init + p(p_len - l)*base^l; 
    end 
end

% if number not provided find all the possible combinations
count = 0;
if nargin < 3
    number = inf;
end

% iterative search
for n = loop_init:base^p_len
    % update polynomial value
    for ind = 0: p_len-1
       p(p_len - ind) =  mod(floor(n*base^(-ind)),base);
    end        
    % intial register value
    register = ones(p_len,1);
    reg_init = register;
    % shifting 
    clear o ms
    for o = 1:p_len
      % shift operation
      ms(o)=rem(p*register+base,base);
      % updating the register
      register=[ms(o); register(1:p_len-1)];
    end
    reg_start = register;
    for o = p_len+1:length
      % shift operation
      ms(o)=rem(p*register+base,base);
      % updating the register
      register=[ms(o); register(1:p_len-1)];
      % check if repetition or if register all zeros
      if register == reg_start
         break;
      end
      if register == reg_init
         break;
      end
    end
    % if full sequence found
    if o == length 
       weights = [weights; p]; 
       % counting number of polynomials found
       count = count + 1; 
    end
    % if enough polynomials found done
    if count >= number
       break;  
    end
    clear o ms  i
end
weights = weights(2:end,:);
end