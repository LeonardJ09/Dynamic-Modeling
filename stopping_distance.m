% define the matrix that will hold the values of the speed
S0 = [20:5:85];
S = S0.*(5280/3600);

% define the matrix that will hold the values of the lower measurements
DL = [40, 53, 69, 86, 108, 132, 160, 193, 228, 268, 314, 366, 422];

% define the matrix that will hold the values of the middle measurements
DM = [42, 56, 73.5, 91.5, 116, 142.5, 173, 209.5, 248, 292.5, 343, 401, 469];

% define the matrix that will hold the values of the upper measurements
DH = [44, 59, 78, 97, 124, 153, 186, 226, 268, 317, 372, 436, 506];

% define the matrix that will hold the values of the predicted lower
% measurements
PDL = zeros(1, length(S));

% define the matrix that will hold the values of the predicted middle
% measurements
PDM = zeros(1, length(S));

% define the matrix that will hold the values of the predicted higher
% measurements
PDH = zeros(1, length(S));

%the time it takes to hit the breaks will be taken to equal .5 seconds to
%simplify the model and get a general understanding of how the model works,
%from this we can determine a value of t that is based on the deceleration
%rate, B
t0 = .5;

%the general formula for the value of t that relates t to B is t = S/2B

%establish the matrix that will hold the deceleration constant for the
%lower values
B1 = zeros(1,length(S));
B2 = zeros(1,length(S));
B3 = zeros(1,length(S));
for i = 1:length(S)
    B1(i) = (S(i)^2)./(4*(DL(i)-S(i)*t0));
    B2(i) = (S(i)^2)./(4*(DM(i)-S(i)*t0));
    B3(i) = (S(i)^2)./(4*(DH(i)-S(i)*t0));
end

%find the average value of the recorded deceleration constants to find the
%modeled value
B1A = mean(B1);
B2A = mean(B2);
B3A = mean(B3);
for j = 1:length(S)
    PDL(j) = S(j)*t0 + ((S(j).^2)./(4*B1A));
    PDM(j) = S(j)*t0 + ((S(j).^2)./(4*B2A));
    PDH(j) = S(j)*t0 + ((S(j).^2)./(4*B3A));
end

plot(S, DL, S, DM, S, DH, S, PDL, S, PDM, S, PDH)
plot(S,DL,S,PDL)
plot(S,DM,S,PDM)
plot(S,DH,S,PDH)

PL = (85)*(5280/3600)*(.5)+((((85)*(5280/3600))^2)/(4*B1A))
PM = (85)*(5280/3600)*(.5)+((((85)*(5280/3600))^2)/(4*B2A))
PH = (85)*(5280/3600)*(.5)+((((85)*(5280/3600))^2)/(4*B3A))
    