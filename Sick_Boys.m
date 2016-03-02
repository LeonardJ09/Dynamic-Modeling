%index of the number of days
T = linspace(1,14,14);

%index the number of boys that were in bed during those times
B = [3,8,28,75,221,291,255,235,190,125,70,28,12,5];

%plot the data 
figure
plot(T, B, '+')
title('Number of Boys in Bed During Outbreak Period')
xlabel('Time Since Outbreak Began (Days)')
ylabel('Number of Boys in Bed')

%it will be assumed that the number of infected boys is the number of boys
%that are currently bed ridden, with I(0) = 1
I = [1,3,8,28,75,221,291,255,235,190,125,70,28,12,5];

%it will be assumed that the number of susceptible boys is the total number
%minus the number that are bed ridden 
G = zeros(1,14);
for u = 1:14
    G(u) = 763-B(u);
end

S = [762,G];

%define the vector space, and the funciton/loops that will determine the
%values for beta at each timestep
beta = zeros(1,14);
for i = 1:14
    beta(i) = -(S(i+1)-S(i))./(S(i).*I(i));
end

%plot the data 
figure
plot(T, beta, ':')
title('Values of Beta According to the Data')
xlabel('Time Since Outbreak Began (Days)')
ylabel('Value of Beta')

%find the average for beta using the mean function
betaAVG = mean(beta)

%the value of betaAVG = 6.6719e-04

%define the vector space, and the function/loops that will determine the
%values for the gamma at each time step 
%the average value of gamma will be used to find the time step values of
%gamma
gamma = zeros(1,14);
for u = 1:14
    gamma(u) = (I(u+1)-I(u)-betaAVG*S(u)*I(u))/(-I(u));
end

gammaAVG = mean(gamma);

% the value of gammaAVG = -0.0771

%plot the data 
figure
plot(T, gamma, '-')
title('Values of Gamma According to the Data')
xlabel('Time Since Outbreak Began (Days)')
ylabel('Value of Gamma')

%using the data and the model, find the optimal value for beta, with the
%starting point of beta = .00066719
phi = @(b) (sum((S(i+1)-S(i))-(-b.*S(i).*I(i))).^2);

% find the value that minimizes b
[b,fval]=fminsearch(phi,.00066719)


%using the value of b above, find the optimal value for gamma, with the
%starting point of gamma = 0.0771
zhi = @(g) (sum((I(i+1)-I(i))-((b.*S(i).*I(i))-g.*I(i))).^2);

% find the value that minimizes g
[g,fval]=fminsearch(zhi,.0771)

%find the change in the number of susceptible boys in the data, as well as
%the change in the number of infected boys
changeS = zeros(1,14);
changeI = zeros(1,14);
for k = 1:14
    changeS(k) = S(k+1)-S(k);
    changeI(k) = I(k+1)-I(k);
end

%find the change in the number of susceptible boys in the model, as well as
%the change in the number of infected boys in the model
changeSM = zeros(1,14);
changeIM = zeros(1,14);
for y = 1:14
    changeSM(y) = b.*S(y).*I(y);
    changeIM(y) = -b.*S(y).*I(y)-g.*I(y);
end

%plot the data 
figure
plot(T, changeS,':', T, changeSM, '-')
title('Change in Susceptible Population (Model vs. Data)')
xlabel('Time Since Outbreak Began (Days)')
ylabel('Change in Susceptible Boys')

%plot the data 
figure
plot(T, changeI,':', T, changeIM, '-')
title('Change in Infected Population (Model vs. Data)')
xlabel('Time Since Outbreak Began (Days)')
ylabel('Number in Infected Boys')

