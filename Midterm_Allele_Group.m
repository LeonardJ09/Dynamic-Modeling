for u = 1:10
%define the population size
N = 10;

% define the starting values of the allele groups 
a0 = 5;
b0 = 5;

%define the number of time steps
t = 50;

%define the vector spaces that will hold the runing values of a and b 
a = zeros(1,t);
b = zeros(1,t);

%define the intial values of the vector spaces
a(1) = a0;
b(1) = b0;

for k = 2:t
    H = k;
    %probability during the current time step an a group will be selected and die 
    p1 = a(k-1)/N;
    %selection of the one that dies depends on a bernoulli trial and will equal either 0 or 1 
    X(k) = binornd(1, p1);
    %if an a doesnt die, then a b dies
    if X(k) == 0
        b(k) = b(k-1)-1;
        % the population size has decreased in b(k), the selection of
        % reproduction must begin, and the p must be updated with the new
        % population
        p2 = a(k-1)/(N-1);
        %selection of the one that reproduces depends on a  bernoulli trial
        %and will equal either 0 or 1
        Y(k) = binornd(1, p2);
        %if b reproduces, then a doesnt
        if Y(k) == 0
            % the a population is the same, and the b population increases
            % by 1
            a(k) = a(k-1);
            b(k) = b(k)+1;
        end
        if Y(k) == 1
            %the a population increases, and the b population stays the
            %same
            a(k) = a(k-1)+1;
            b(k)=b(k);
        end
    end
    %if an a dies, then a b doesnt die
    if X(k) == 1 
        a(k) = a(k-1)-1;
        % the population size has decreased in a(k), the selection of
        % reproduction must begin, and the p must be updated
        p2 = a(k)/(N-1);
        %selection of the one that reproduces depends on a  bernoulli trial
        %and will equal either 0 or 1
        Y(k) = binornd(1, p2);
        %if b reproduces, then a doesnt
        if Y(k) == 0
            % the a population is the same, and b population increases by 1
            a(k) = a(k);
            b(k) = b(k)+1;
        end
        if Y(k) == 1
            %the a population increases, and the b population stays the
            %same
            a(k) = a(k)+1;
            b(k)=b(k-1);
        end
    end
    %if the a population maxes out, or the a population dies out, end the
    %trials and make the values flatline
    if a(k)==N || a(k) == 0
        break
    end
end

%keep the values of a and b constant when they reach stasis
for j = (H+1):t
    a(j) = a(H);
    b(j) = b(H);
end

%create the matrix that will hold the ending values of a through all the
%simulations 

Total(u,:) = a(1,:);
end

%plot the data together to show the different paths the process could take
h=figure;
plot(1:t, Total(1,:), '--g', 1:t, Total(2,:),':g', 1:t, Total(3,:),'+g', 1:t, Total(4,:),'*g', 1:t, Total(5,:),'--r', 1:t, Total(6,:), ':r', 1:t, Total(7,:), '+r', 1:t, Total(8,:),'*r', 1:t, Total(9,:),'--b', 1:t, Total(10,:), ':b') 


