%establish the epsilon that will be used as the criteria for the acceptance
    %of p and q
    P = zeros(1,1000000);
    Q = zeros(1,1000000);
    
     %index the number of boys that were in bed during those times
    B = [1,3,8,28,75,221,291,255,235,190,125,70,28,12,5];

    % Number of simulations
    T = 14;
 
    %initial values of the population
    S0 = 763;
    I0 = 1;
    R0 = 0;
    
    
    indexoftimeT = T +1;
 
    % values of the susceptible population will be stored in S
    S = zeros (1, indexoftimeT);
    S(1) = S0;
 
    % values of the infected population will be stored in I
    I = zeros (1, indexoftimeT);
    I(1) = I0;
 
    % values of the recovered population will be stored in R
    R = zeros (1, indexoftimeT);
    R(1) = R0;
    
    E = 1500;
    
for k = 1:10^6
 
    % parameters 
    p(k) = rand;
    q(k) = normrnd(.5,0.125);

    if q(k) <0 || q(k)>1
        q(k) = normrnd(.5,0.125);
        if q(k)>0 && q(k)<1
         break
        end
    end
 
    % establish a for loop to develop new values in each time step 
    for n = 2:indexoftimeT
        Y(n) = binornd(I(n-1), q(k));
        X(n) = binornd(S(n-1), (1-(1-p(k))^I(n-1)));
        S(n) = S(n-1)-X(n);
        I(n) = I(n-1)+X(n)-Y(n);
        R(n) = R(n-1)+Y(n);
    end

    if ((sum((I-B).^2))^.5)<E
        P(k) = p(k);
        Q(k) = q(k);
    end

end

%check how many values were accepted to ensure the acceptance rate is
%between 1 and 5 percent (acceptance was 36170)
A = nnz(P)

D = P(P~=0);
F = Q(Q~=0);

%find the mean of both the distributions (both are roughly centered around
%.5)
U = mean(D);
O = mean(F);

%create bar graphs for the distibutions 
binranges = 0:.01:1;
[bincounts] = histc(D,binranges);
g=figure;
bar(binranges,bincounts,'histc')
title('Distibution of the Posterior Probabiity of Infection')
xlabel('Value of p')
ylabel('Frequency')

%create bar graphs for the distibutions 
binranges = 0:.01:1;
[bincounts] = histc(F,binranges);
g=figure;
bar(binranges,bincounts,'histc')
title('Distibution of the Posterior Probabiity of Recovery')
xlabel('Value of q')
ylabel('Frequency')


 
