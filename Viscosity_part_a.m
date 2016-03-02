% enter the temperatures in Kelvin 
T = [253.15, 273.15, 313.15, 373.15, 473.15, 573.15, 673.15, 773.15, 1273.15];

%enter the data for the given viscosities
V = [1.63, 1.71, 1.87, 2.17, 2.53, 2.98, 3.32, 3.64, 5.04];

%in order to do the fmin search, the two constants must be in the same
%vector, but different indicies, s = s(1), c = s(2)

%establish the function that will find the proportionality constant
phi = @(s) (sum(log(V)-((log(s(2))+1.5*log(T))-log(T+s(1)))).^2);

% find the value that minimizes s
[s,fval]=fminsearch(phi,[25,0.12])

c = s(2);
s = s(1);

%generalize the function to predict new viscosities, PV
PV = (c*T.^(3/2))./(T+s);

figure
plot(T,PV, ':', T, V, '+') %plot
title('Least Squares Distance Estimation of Viscosity') %title
xlabel('Temperature (Kelvin)') % x-axis label
ylabel('Viscosity (Ns/m^2)') % y-axis label
