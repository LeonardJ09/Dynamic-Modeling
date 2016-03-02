for k=1:20
% Number of simulations
T = 30;
 
%initial values of the population
S0 = 29;
I0 = 1;
R0 = 0;
 
% probability of an infected individual having sex during any individual encounter with anyone in the susceptible group 
p = 0.05;
 
indexoftimeT = T +1;
 
% values of the susceptible population will be stored in S
S = zeros (1, indexoftimeT);
S(1) = S0;
 
% values of the infected population will be stored in I
I1 = zeros(1,indexoftimeT);
I1(1) = I0;

I2 = zeros(1, indexoftimeT);
I3 = zeros(1, indexoftimeT);
I4 = zeros(1, indexoftimeT);
I5 = zeros(1, indexoftimeT);
I6 = zeros(1, indexoftimeT);

I = zeros (1, indexoftimeT);
I(1) = I1(1);

%values of the total number of infected people at each time step 
Total = zeros(1, indexoftimeT);
Total(1) = I(1);

 
% values of the binomially distributed random variables through each
% timestep
N = 30;	
 
% establish a for loop to develop new values in each time step 
for n = 2:indexoftimeT
    Y = n;
    X(n) = binornd(S(n-1), (1-(1-p)^I(n-1)));
    S(n) = S(n-1)-X(n)+I6(n-1);
    I1(n) = X(n);
    I2(n) = I1(n-1);
    I3(n) = I2(n-1);
    I4(n) = I3(n-1);
    I5(n) = I4(n-1);
    I6(n) = I5(n-1);
    I(n) = I1(n) + I2(n) + I3(n) + I4(n) + I5(n) + I6(n);
    Total(n) = Total(n-1)+I1(n);
    if I(n) == 0
       break
    end
end
 
for j = Y:indexoftimeT
    S(j) = S(Y-1);
    Total(j) = Total (Y-1);
    I(j) = I(Y-1);
end

h=figure;
plot(0:T, S,'--', 0:T, I, '-') 
saveas(h,sprintf('FIG%d.png',k)); % will create FIG1, FIG2,...
end