%% Example script of generating PRMS noise in real-time
%  - PRMS Pseudo Random m-Sequences
%  - Approach based on m-sequence shift registers

%% PRMS intialisation
% Desired base the resolution of the noise
% it has to be a prime number 3,5,7,11,13....
base = 7;
% desired sequence length 
length = 5000; 
% calculate necessary value of shift registers
m = ceil(log(length)/log(base));
% find desired primitive polynomial
% the good practise is to save the primitive polynomial weights, because it
% may take some time to search. 
p_weigths = prim_poly_search(base, m, 1);


%% Iterative generation of the PRMS
% Random init shift register 
register = randi([1 base-1],[m 1]);
prms = [];
for i = 1:base^m
  % shift operation
  prms(i)=rem(p_weigths*register+base,base);
  % updating the register
  register=[prms(i); register(1:m-1)];
end

%% Plotting of obtained results
figure(1)
subplot(2,1,1)
plot(prms)
subplot(2,1,2)
hist(prms,base)




