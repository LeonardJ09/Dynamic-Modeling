% enter the temperatures in Kelvin 
T = [253.15, 273.15, 313.15, 373.15, 473.15, 573.15, 673.15, 773.15, 1273.15];

%enter the data for the given viscosities
V = [1.63, 1.71, 1.87, 2.17, 2.53, 2.98, 3.32, 3.64, 5.04];

%the new model uses the values of T^1.5/V
TV = (T.^1.5)./V;

%define the polynomial fit with degree 1 because the model is of degree 1
p = polyfit(T, TV, 1)

c = 1/p(1);
s = p(2)/p(1);

%generalize the function to predict new viscosities, PV
PV = (c*T.^(3/2))./(T+s);

figure
plot(T,PV, ':', T, V, '+') %plot
title('Polyfit Estimation of Viscosity') %title
xlabel('Temperature (Kelvin)') % x-axis label
ylabel('Viscosity (Ns/m^2)') % y-axis label
