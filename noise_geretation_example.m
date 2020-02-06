%% Example script of generating using PRMS as uniform distribution noise 
%  - generating gaussina noise using Box-Muller method
%  - Approach based on m-sequence shift registers

%% PRMS intialisation
% Desired base the resolution of the noise
% it has to be a prime number 3,5,7,11,13....
base = 23;
% desired sequence length 
length = 5000; 
% calculate necessary value of shift registers
m = ceil(log(length)/log(base));
% for Box-Muller method we need two uniform random variables
p_weigths = prim_poly_search(base, m, 2);

%% Gaussian noise params
sigma= 0.5;
mu = 5;


%% Iterative generation 
% Random init shift register 
register1 = randi([1 base-1],[m 1]);
register2 = randi([1 base-1],[m 1]);
clear U1 U2 prms1 prms2 n_gaus
for i = 1:base^m
  % shift operation
  prms1(i)=rem(p_weigths(1,:)*register1+base,base);
  prms2(i)=rem(p_weigths(2,:)*register1+base,base);
  % updating the register
  register1=[prms1(i); register1(1:m-1)];
  register2=[prms2(i); register2(1:m-1)];
  % noise scaling 
  U1(i) = (prms1(i)+0.5)/(base);
  U2(i) = (prms2(i)+0.5)/(base);
  
  % Box Muller 
  n_gaus(i) = sigma*sqrt(-2*log(U1(i)))*cos(2*pi*U2(i)) + mu;
end



%% Plotting of obtained results
figure(1)
subplot(3,1,1)
plot(U1)
subplot(3,1,2)
plot(U2)
subplot(3,1,3)
plot(n_gaus)

figure(2)
subplot(3,1,1)
hist(U1,base)
subplot(3,1,2)
hist(U2,base)
subplot(3,1,3)
hist(n_gaus,2*base)




