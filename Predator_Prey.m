%define the constant parameters
r = 1.5;
q = 0.02;
k = 100;
c = 1.5;

%define the intial vectorspace
N1 = 45;
N = zeros(1,1000);
N(1) = N1;
P1 = .45;
P = zeros(1,1000);
P(1) = P1;

%define the equations
for t = 2:length(N)
    N(t) = N(t-1)+r*N(t-1)*(1-N(t-1)/k)-c*N(t-1).*P(t-1);
    P(t) = q*N(t-1).*P(t-1);
end

%plot the data 
figure
plot(1:t, N, ':', 1:t, P, '+')
title('Predator Prey Population Oscillation (Carrying Capacity <k')
xlabel('Time Since Outbreak Began (Days)')
ylabel('Number of Boys in Bed')
legend('Prey','Predator')