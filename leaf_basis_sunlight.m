%this section of the code will define all the matrices that are important
%for the inputs, states, and outputs for the leaf, veins, etc.

%this represents the growth of the leaf, an is the linear funciton that
%represents the growth in the size of the midrib

%t is the number of timesteps
t = 32;

%this is the multiplicative factor that increases the length of j based on
%the sunlight 
m = [1,1.0714,1.1429,1.2143,1.2857,1.3571,1.4286,1.5];

x = [1:32];
%y is the multiplicative growth factor at that timestep
y = x;
y2 = x*m(8);
y1 = floor(y2);
%floor((-32./(x))+33);

%this is the area over which we are concerned with growth, which should be
%sufficiently large enough to allow for enough growth timesteps, but also small enough where
%the infantcy of the leaf can still be seen.

%these are the dimensions of the leaf matrix, or the area over which the leaf
%will grow
nWidth = 2501;
nHeight = 2701;
Leaf = zeros(nHeight,nWidth,t);

%this will show the placement of the midrib, major veins, and minor veins
Veins = zeros(nHeight,nWidth,t);
Nutrients = zeros(nHeight,nWidth,t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%this is the code that will define the shape of the leaf at its intial
%stage. In its infancy, the leaf must have a midrib, and a vein running
%down all of its lobes. These initial veins are then used to create new
%veins as the leaf grows 

Middlei = (((nHeight-1)/2)+1);
Middlej = (((nWidth-1)/2)+1);

%these are the intial matrices that define the major veins that reside inside the lobes
Lobe1LeftVein = zeros(nHeight,nWidth,t);
Lobe1RightVein = zeros(nHeight,nWidth,t);
Lobe2LeftVein = zeros(nHeight,nWidth,t);
Lobe2RightVein = zeros(nHeight,nWidth,t);
Lobe3LeftVein = zeros(nHeight,nWidth,t);
Lobe3RightVein = zeros(nHeight,nWidth,t);
Lobe4LeftVein = zeros(nHeight,nWidth,t);
Lobe4RightVein = zeros(nHeight,nWidth,t);
Lobe5LeftVein = zeros(nHeight,nWidth,t);
Lobe5RightVein = zeros(nHeight,nWidth,t);
ApexVein = zeros(nHeight,nWidth,t);

%these are the lobe matricies
Lobe1Left = zeros(nHeight,nWidth,t);
Lobe1Right = zeros(nHeight,nWidth,t);
Lobe2Left = zeros(nHeight,nWidth,t);
Lobe2Right = zeros(nHeight,nWidth,t);
Lobe3Left = zeros(nHeight,nWidth,t);
Lobe3Right = zeros(nHeight,nWidth,t);
Lobe4Left= zeros(nHeight,nWidth,t);
Lobe4Right = zeros(nHeight,nWidth,t);
Lobe5Left = zeros(nHeight,nWidth,t);
Lobe5Right = zeros(nHeight,nWidth,t);
Apex = zeros(nHeight,nWidth,t);


for u = 1:t
%this is the midrib
for i = (Middlei-33*y(u)):(Middlei+39*y(u)-1)
    for j = (Middlej-1):(Middlej+1)
        Veins(i,j,u) = 1;
    end
end

%this will define the major veins inside the lobes

%lobe 1 left major vein
for i = (Middlei-33*y(u)+(3*y(u)-1)):(Middlei-33*y(u)+(3*y(u)))
    for j = (Middlej-8*y1(u)-1):(Middlej)
        Lobe1LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end


%lobe 1 right major vein
for i = (Middlei-33*y(u)+(3*y(u)-1)):(Middlei-33*y(u)+(3*y(u)))
    for j = (Middlej):(Middlej+8*y1(u)+1)
        Lobe1RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end


%lobe 2 left major vein
for i = (Middlei-25*y(u)+(5*y(u)-1)):(Middlei-25*y(u)+(5*y(u)))
    for j = (Middlej-14*y1(u)-1):(Middlej)
        Lobe2LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 2 right major vein
for i = (Middlei-25*y(u)+(5*y(u)-1)):(Middlei-25*y(u)+(5*y(u)))
    for j = (Middlej):(Middlej+14*y1(u)+1)
        Lobe2RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end     


%lobe 3 left major vein
for i = (Middlei-13*y(u)+(9*y(u)-1)):(Middlei-13*y(u)+(9*y(u)))
    for j = (Middlej-24*y1(u)-1):(Middlej)
        Lobe3LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 3 right major vein
for i = (Middlei-13*y(u)+(9*y(u)-1)):(Middlei-13*y(u)+(9*y(u)))
    for j = (Middlej):(Middlej+24*y1(u)+1)
        Lobe3RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end


%lobe 4 left major vein
for i = (Middlei+7*y(u)+(7*y(u)-1)):(Middlei+7*y(u)+(7*y(u)))
    for j = (Middlej-20*y1(u)-1):(Middlej)
        Lobe4LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 4 right major vein
for i = (Middlei+7*y(u)+(7*y(u)-1)):(Middlei+7*y(u)+(7*y(u)))
    for j = (Middlej):(Middlej+20*y1(u)+1)
        Lobe4RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 5 left major vein
for i = (Middlei+23*y(u)+(5*y(u)-1)):(Middlei+23*y(u)+(5*y(u)))
    for j = (Middlej-12*y1(u)-1):(Middlej)
        Lobe5LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 5 right major vein
for i = (Middlei+23*y(u)+(5*y(u)-1)):(Middlei+23*y(u)+(5*y(u)))
    for j = (Middlej):(Middlej+12*y1(u)+1)
        Lobe5RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%loops to define the area of the lobes

%lobe 1 left body (main)
for i = (Middlei-33*y(u)):(Middlei-27*y(u)-1)
    for j = (Middlej-6*y1(u)-1):(Middlej)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 left body (point)
for i = (Middlei-31*y(u)):(Middlei-29*y(u)-1)
    for j = (Middlej-8*y1(u)-1):(Middlej-6*y1(u)-2)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 left  body (upper lobe joint)
for i = (Middlei-27*y(u)):(Middlei-26*y(u)-1)
    for j = (Middlej-2*y1(u)-1):(Middlej)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%

%lobe 1 right body (main)
for i = (Middlei-33*y(u)):(Middlei-27*y(u)-1)
    for j = (Middlej):(Middlej+6*y1(u)+1)
        Lobe1Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 right body (point)
for i = (Middlei-31*y(u)):(Middlei-29*y(u)-1)
    for j = (Middlej+6*y1(u)+2):(Middlej+8*y1(u)+1)
        Lobe1Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 right  body (upper lobe joint)
for i = (Middlei-27*y(u)):(Middlei-26*y(u)-1)
    for j = (Middlej):(Middlej+2*y1(u)+1)
        Lobe1Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lobe 2 left body (lower lobe joint)
for i = (Middlei-26*y(u)):(Middlei-25*y(u)-1)
    for j = (Middlej-2*y1(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 left body (main)
for i = (Middlei-25*y(u)):(Middlei-15*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 left body (point)
for i = (Middlei-23*y(u)):(Middlei-17*y(u)-1)
    for j = (Middlej-12*y1(u)-1):(Middlej-10*y1(u)-2)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-21*y(u)):(Middlei-19*y(u)-1)
    for j = (Middlej-14*y1(u)-1):(Middlej-12*y1(u)-2)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 left body (upper lobe joint)
for i = (Middlei-15*y(u)):(Middlei-14*y(u)-1)
    for j = (Middlej-6*y1(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%

%lobe 2 right body (lower lobe joint)
for i = (Middlei-26*y(u)):(Middlei-25*y(u)-1)
    for j = (Middlej):(Middlej+2*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 right body (main)
for i = (Middlei-25*y(u)):(Middlei-15*y(u)-1)
    for j = (Middlej):(Middlej+10*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 right body (point)
for i = (Middlei-23*y(u)):(Middlei-17*y(u)-1)
    for j = (Middlej+10*y1(u)+2):(Middlej+12*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-21*y(u)):(Middlei-19*y(u)-1)
    for j = (Middlej+12*y1(u)+2):(Middlej+14*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 right  body (upper lobe joint)
for i = (Middlei-15*y(u)):(Middlei-14*y(u)-1)
    for j = (Middlej):(Middlej+6*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lobe 3 left body (lower lobe joint)
for i = (Middlei-14*y(u)):(Middlei-13*y(u)-1)
    for j = (Middlej-6*y1(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 left body (main)
for i = (Middlei-13*y(u)):(Middlei+5*y(u)-1)
    for j = (Middlej-16*y1(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 body (point)
for i = (Middlei-11*y(u)):(Middlei+3*y(u)-1)
    for j = (Middlej-18*y1(u)-1):(Middlej-16*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-9*y(u)):(Middlei+y(u)-1)
    for j = (Middlej-20*y1(u)-1):(Middlej-18*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-7*y(u)):(Middlei-1*y(u)-1)
    for j = (Middlej-22*y1(u)-1):(Middlej-20*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-5*y(u)):(Middlei-3*y(u)-1)
    for j = (Middlej-24*y1(u)-1):(Middlej-22*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 left body (upper lobe joint)
for i = (Middlei+5*y(u)):(Middlei+6*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%
%lobe 3 right body (lower lobe joint)
for i = (Middlei-14*y(u)):(Middlei-13*y(u)-1)
    for j = (Middlej):(Middlej+6*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (main)
for i = (Middlei-13*y(u)):(Middlei+5*y(u)-1)
    for j = (Middlej):(Middlej+16*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (point)
for i = (Middlei-11*y(u)):(Middlei+3*y(u)-1)
    for j = (Middlej+16*y1(u)+2):(Middlej+18*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-9*y(u)):(Middlei+y(u)+1)
    for j = (Middlej+18*y1(u)+2):(Middlej+20*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-7*y(u)):(Middlei-y(u)-1)
    for j = (Middlej+20*y1(u)+2):(Middlej+22*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-5*y(u)):(Middlei-3*y(u)-1)
    for j = (Middlej+22*y1(u)+2):(Middlej+24*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (upper lobe joint)
for i = (Middlei+5*y(u)):(Middlei+6*y(u)-1)
    for j = (Middlej):(Middlej+10*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lobe 4 Left body (lower lobe joint)
for i = (Middlei+6*y(u)):(Middlei+7*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left body (main)
for i = (Middlei+7*y(u)):(Middlei+21*y(u)-1)
    for j = (Middlej-14*y1(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left point
for i = (Middlei+9*y(u)):(Middlei+19*y(u)-1)
    for j = (Middlej-16*y1(u)-1):(Middlej-14*y1(u)-1)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+11*y(u)):(Middlei+17*y(u)-1)
    for j = (Middlej-18*y1(u)-1):(Middlej-16*y1(u)-2)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+13*y(u)):(Middlei+15*y(u)-1)
    for j = (Middlej-20*y1(u)-1):(Middlej-18*y1(u)-2)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left body (upper lobe joint)
for i = (Middlei+21*y(u)):(Middlei+22*y(u)-1)
    for j = (Middlej-4*y1(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%
%lobe 4 Right body (lower lobe joint)
for i = (Middlei+6*y(u)):(Middlei+7*y(u)-1)
    for j = (Middlej):(Middlej+10*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 Right body (main)
for i = (Middlei+7*y(u)):(Middlei+21*y(u)-1)
    for j = (Middlej):(Middlej+14*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 Right point
for i = (Middlei+9*y(u)):(Middlei+19*y(u)-1)
    for j = (Middlej+14*y1(u)+2):(Middlej+16*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+11*y(u)):(Middlei+17*y(u)-1)
    for j = (Middlej+16*y1(u)+2):(Middlej+18*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+13*y(u)):(Middlei+15*y(u)-1)
    for j = (Middlej+18*y1(u)+2):(Middlej+20*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 body (upper lobe joint)
for i = (Middlei+21*y(u)):(Middlei+22*y(u)-1)
    for j = (Middlej):(Middlej+4*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%
%lobe 5 left body (lower lobe joint)
for i = (Middlei+22*u):(Middlei+23*y(u)-1)
    for j = (Middlej-4*y1(u)-1):(Middlej)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 left body (main)
for i = (Middlei+23*y(u)):(Middlei+33*y(u)-1)
    for j = (Middlej-8*y1(u)-1):(Middlej)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 left body (point)
for i = (Middlei+25*y(u)):(Middlei+31*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej-8*y1(u)-2)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+27*y(u)):(Middlei+29*y(u)-1)
    for j = (Middlej-12*y1(u)-1):(Middlej-10*y1(u)-2)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%lobe 5 right body (lower lobe joint)
for i = (Middlei+22*u):(Middlei+23*y(u)-1)
    for j = (Middlej):(Middlej+4*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 right body (main)
for i = (Middlei+23*y(u)):(Middlei+33*y(u)-1)
    for j = (Middlej):(Middlej+8*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 right body (ponit)
for i = (Middlei+25*y(u)):(Middlei+31*y(u)-1)
    for j = (Middlej+8*y1(u)+2):(Middlej+10*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+27*y(u)):(Middlei+29*y(u)-1)
    for j = (Middlej+10*y1(u)+2):(Middlej+12*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%
%Apex left body (main)
for i = (Middlei+33*y(u)):(Middlei+37*y(u)-1)
    for j = (Middlej-2*y1(u)-1):(Middlej)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%Apex right body (main)
for i = (Middlei+33*y(u)):(Middlei+37*y(u)-1)
    for j = (Middlej):(Middlej+2*y1(u)+1)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%Apex point
for i = (Middlei+37*y(u)):(Middlei+39*y(u)-1)
    for j = (Middlej-y1(u)-1):(Middlej+y1(u)+1)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
end
contourf(Leaf(:,:,32)-Veins(:,:,32))
of the leaf matrix, or the area over which the leaf
%will grow
nWidth = 2501;
nHeight = 2701;
Leaf = zeros(nHeight,nWidth,t);

%this will show the placement of the midrib, major veins, and minor veins
Veins = zeros(nHeight,nWidth,t);
Nutrients = zeros(nHeight,nWidth,t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%this is the conditioning matrix for sunlight
Sunlight = rand(nHeight,nWidth,t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%this is the code that will define the shape of the leaf at its intial
%stage. In its infancy, the leaf must have a midrib, and a vein running
%down all of its lobes. These initial veins are then used to create new
%veins as the leaf grows 

Middlei = (((nHeight-1)/2)+1);
Middlej = (((nWidth-1)/2)+1);

%these are the intial matrices that define the major veins that reside inside the lobes
Lobe1LeftVein = zeros(nHeight,nWidth,t);
Lobe1RightVein = zeros(nHeight,nWidth,t);
Lobe2LeftVein = zeros(nHeight,nWidth,t);
Lobe2RightVein = zeros(nHeight,nWidth,t);
Lobe3LeftVein = zeros(nHeight,nWidth,t);
Lobe3RightVein = zeros(nHeight,nWidth,t);
Lobe4LeftVein = zeros(nHeight,nWidth,t);
Lobe4RightVein = zeros(nHeight,nWidth,t);
Lobe5LeftVein = zeros(nHeight,nWidth,t);
Lobe5RightVein = zeros(nHeight,nWidth,t);
ApexVein = zeros(nHeight,nWidth,t);

%these are the lobe matricies
Lobe1Left = zeros(nHeight,nWidth,t);
Lobe1Right = zeros(nHeight,nWidth,t);
Lobe2Left = zeros(nHeight,nWidth,t);
Lobe2Right = zeros(nHeight,nWidth,t);
Lobe3Left = zeros(nHeight,nWidth,t);
Lobe3Right = zeros(nHeight,nWidth,t);
Lobe4Left= zeros(nHeight,nWidth,t);
Lobe4Right = zeros(nHeight,nWidth,t);
Lobe5Left = zeros(nHeight,nWidth,t);
Lobe5Right = zeros(nHeight,nWidth,t);
Apex = zeros(nHeight,nWidth,t);


for u = 32
%this is the midrib
for i = (Middlei-33*y(u)):(Middlei+39*y(u)-1)
    for j = (Middlej-1):(Middlej+1)
        Veins(i,j,u) = 1;
    end
end

%this will define the major veins inside the lobes

%lobe 1 left major vein
for i = (Middlei-33*y(u)+(3*y(u)-1)):(Middlei-33*y(u)+(3*y(u)))
    for j = (Middlej-8*y1(u)-1):(Middlej)
        Lobe1LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end


%lobe 1 right major vein
for i = (Middlei-33*y(u)+(3*y(u)-1)):(Middlei-33*y(u)+(3*y(u)))
    for j = (Middlej):(Middlej+8*y1(u)+1)
        Lobe2RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end


%lobe 2 left major vein
for i = (Middlei-25*y(u)+(5*y(u)-1)):(Middlei-25*y(u)+(5*y(u)))
    for j = (Middlej-14*y1(u)-1):(Middlej)
        Lobe2LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 2 right major vein
for i = (Middlei-25*y(u)+(5*y(u)-1)):(Middlei-25*y(u)+(5*y(u)))
    for j = (Middlej):(Middlej+14*y1(u)+1)
        Lobe2RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end     


%lobe 3 left major vein
for i = (Middlei-13*y(u)+(9*y(u)-1)):(Middlei-13*y(u)+(9*y(u)))
    for j = (Middlej-24*y1(u)-1):(Middlej)
        Lobe3LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 3 right major vein
for i = (Middlei-13*y(u)+(9*y(u)-1)):(Middlei-13*y(u)+(9*y(u)))
    for j = (Middlej):(Middlej+24*y1(u)+1)
        Lobe3RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end


%lobe 4 left major vein
for i = (Middlei+7*y(u)+(7*y(u)-1)):(Middlei+7*y(u)+(7*y(u)))
    for j = (Middlej-20*y1(u)-1):(Middlej)
        Lobe4LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 4 right major vein
for i = (Middlei+7*y(u)+(7*y(u)-1)):(Middlei+7*y(u)+(7*y(u)))
    for j = (Middlej):(Middlej+20*y1(u)+1)
        Lobe4RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 5 left major vein
for i = (Middlei+23*y(u)+(5*y(u)-1)):(Middlei+23*y(u)+(5*y(u)))
    for j = (Middlej-12*y1(u)-1):(Middlej)
        Lobe5LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

%lobe 5 right major vein
for i = (Middlei+23*y(u)+(5*y(u)-1)):(Middlei+23*y(u)+(5*y(u)))
    for j = (Middlej):(Middlej+12*y1(u)+1)
        Lobe5RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%loops to define the area of the lobes

%lobe 1 left body (main)
for i = (Middlei-33*y(u)):(Middlei-27*y(u)-1)
    for j = (Middlej-6*y1(u)-1):(Middlej)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 left body (point)
for i = (Middlei-31*y(u)):(Middlei-29*y(u)-1)
    for j = (Middlej-8*y1(u)-1):(Middlej-6*y1(u)-2)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 left  body (upper lobe joint)
for i = (Middlei-27*y(u)):(Middlei-26*y(u)-1)
    for j = (Middlej-2*y1(u)-1):(Middlej)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%

%lobe 1 right body (main)
for i = (Middlei-33*y(u)):(Middlei-27*y(u)-1)
    for j = (Middlej):(Middlej+6*y1(u)+1)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 right body (point)
for i = (Middlei-31*y(u)):(Middlei-29*y(u)-1)
    for j = (Middlej+6*y1(u)+2):(Middlej+8*y1(u)+1)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 right  body (upper lobe joint)
for i = (Middlei-27*y(u)):(Middlei-26*y(u)-1)
    for j = (Middlej):(Middlej+2*y1(u)+1)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lobe 2 left body (lower lobe joint)
for i = (Middlei-26*y(u)):(Middlei-25*y(u)-1)
    for j = (Middlej-2*y1(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 left body (main)
for i = (Middlei-25*y(u)):(Middlei-15*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 left body (point)
for i = (Middlei-23*y(u)):(Middlei-17*y(u)-1)
    for j = (Middlej-12*y1(u)-1):(Middlej-10*y1(u)-2)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-21*y(u)):(Middlei-19*y(u)-1)
    for j = (Middlej-14*y1(u)-1):(Middlej-12*y1(u)-2)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 left body (upper lobe joint)
for i = (Middlei-15*y(u)):(Middlei-14*y(u)-1)
    for j = (Middlej-6*y1(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%

%lobe 2 right body (lower lobe joint)
for i = (Middlei-26*y(u)):(Middlei-25*y(u)-1)
    for j = (Middlej):(Middlej+2*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 right body (main)
for i = (Middlei-25*y(u)):(Middlei-15*y(u)-1)
    for j = (Middlej):(Middlej+10*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 right body (point)
for i = (Middlei-23*y(u)):(Middlei-17*y(u)-1)
    for j = (Middlej+10*y1(u)+2):(Middlej+12*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-21*y(u)):(Middlei-19*y(u)-1)
    for j = (Middlej+12*y1(u)+2):(Middlej+14*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 right  body (upper lobe joint)
for i = (Middlei-15*y(u)):(Middlei-14*y(u)-1)
    for j = (Middlej):(Middlej+6*y1(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lobe 3 left body (lower lobe joint)
for i = (Middlei-14*y(u)):(Middlei-13*y(u)-1)
    for j = (Middlej-6*y1(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 left body (main)
for i = (Middlei-13*y(u)):(Middlei+5*y(u)-1)
    for j = (Middlej-16*y1(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 body (point)
for i = (Middlei-11*y(u)):(Middlei+3*y(u)-1)
    for j = (Middlej-18*y1(u)-1):(Middlej-16*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-9*y(u)):(Middlei+y(u)-1)
    for j = (Middlej-20*y1(u)-1):(Middlej-18*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-7*y(u)):(Middlei-1*y(u)-1)
    for j = (Middlej-22*y1(u)-1):(Middlej-20*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-5*y(u)):(Middlei-3*y(u)-1)
    for j = (Middlej-24*y1(u)-1):(Middlej-22*y1(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 left body (upper lobe joint)
for i = (Middlei+5*y(u)):(Middlei+6*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%
%lobe 3 right body (lower lobe joint)
for i = (Middlei-14*y(u)):(Middlei-13*y(u)-1)
    for j = (Middlej):(Middlej+6*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (main)
for i = (Middlei-13*y(u)):(Middlei+5*y(u)-1)
    for j = (Middlej):(Middlej+16*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (point)
for i = (Middlei-11*y(u)):(Middlei+3*y(u)-1)
    for j = (Middlej+16*y1(u)+2):(Middlej+18*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-9*y(u)):(Middlei+y(u)+1)
    for j = (Middlej+18*y1(u)+2):(Middlej+20*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-7*y(u)):(Middlei-y(u)-1)
    for j = (Middlej+20*y1(u)+2):(Middlej+22*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-5*y(u)):(Middlei-3*y(u)-1)
    for j = (Middlej+22*y1(u)+2):(Middlej+24*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (upper lobe joint)
for i = (Middlei+5*y(u)):(Middlei+6*y(u)-1)
    for j = (Middlej):(Middlej+10*y1(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lobe 4 Left body (lower lobe joint)
for i = (Middlei+6*y(u)):(Middlei+7*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left body (main)
for i = (Middlei+7*y(u)):(Middlei+21*y(u)-1)
    for j = (Middlej-14*y1(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left point
for i = (Middlei+9*y(u)):(Middlei+19*y(u)-1)
    for j = (Middlej-16*y1(u)-1):(Middlej-14*y1(u)-1)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+11*y(u)):(Middlei+17*y(u)-1)
    for j = (Middlej-18*y1(u)-1):(Middlej-16*y1(u)-2)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+13*y(u)):(Middlei+15*y(u)-1)
    for j = (Middlej-20*y1(u)-1):(Middlej-18*y1(u)-2)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left body (upper lobe joint)
for i = (Middlei+21*y(u)):(Middlei+22*y(u)-1)
    for j = (Middlej-4*y1(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%
%lobe 4 Right body (lower lobe joint)
for i = (Middlei+6*y(u)):(Middlei+7*y(u)-1)
    for j = (Middlej):(Middlej+10*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 Right body (main)
for i = (Middlei+7*y(u)):(Middlei+21*y(u)-1)
    for j = (Middlej):(Middlej+14*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 Right point
for i = (Middlei+9*y(u)):(Middlei+19*y(u)-1)
    for j = (Middlej+14*y1(u)+2):(Middlej+16*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+11*y(u)):(Middlei+17*y(u)-1)
    for j = (Middlej+16*y1(u)+2):(Middlej+18*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+13*y(u)):(Middlei+15*y(u)-1)
    for j = (Middlej+18*y1(u)+2):(Middlej+20*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 body (upper lobe joint)
for i = (Middlei+21*y(u)):(Middlei+22*y(u)-1)
    for j = (Middlej):(Middlej+4*y1(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%
%lobe 5 left body (lower lobe joint)
for i = (Middlei+22*u):(Middlei+23*y(u)-1)
    for j = (Middlej-4*y1(u)-1):(Middlej)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 left body (main)
for i = (Middlei+23*y(u)):(Middlei+33*y(u)-1)
    for j = (Middlej-8*y1(u)-1):(Middlej)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 left body (point)
for i = (Middlei+25*y(u)):(Middlei+31*y(u)-1)
    for j = (Middlej-10*y1(u)-1):(Middlej-8*y1(u)-2)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+27*y(u)):(Middlei+29*y(u)-1)
    for j = (Middlej-12*y1(u)-1):(Middlej-10*y1(u)-2)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%lobe 5 right body (lower lobe joint)
for i = (Middlei+22*u):(Middlei+23*y(u)-1)
    for j = (Middlej):(Middlej+4*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 right body (main)
for i = (Middlei+23*y(u)):(Middlei+33*y(u)-1)
    for j = (Middlej):(Middlej+8*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 right body (ponit)
for i = (Middlei+25*y(u)):(Middlei+31*y(u)-1)
    for j = (Middlej+8*y1(u)+2):(Middlej+10*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+27*y(u)):(Middlei+29*y(u)-1)
    for j = (Middlej+10*y1(u)+2):(Middlej+12*y1(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%
%Apex left body (main)
for i = (Middlei+33*y(u)):(Middlei+37*y(u)-1)
    for j = (Middlej-2*y1(u)-1):(Middlej)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%Apex right body (main)
for i = (Middlei+33*y(u)):(Middlei+37*y(u)-1)
    for j = (Middlej):(Middlej+2*y1(u)+1)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%Apex point
for i = (Middlei+37*y(u)):(Middlei+39*y(u)-1)
    for j = (Middlej-y1(u)-1):(Middlej+y1(u)+1)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
end


vidObj1 = VideoWriter('Leaf Growth (30)');
vidObj1.FrameRate=8;
open(vidObj1);
for i=1:t
  %take the intermediate cntour plots, then Add to Movie:
  contourf(Leaf(:,:,i)-Veins(:,:,i));
  f = getframe;
  writeVideo(vidObj1,f);
end
close(vidObj1);

x = [1:32];
y = (-32./x)+33;
figure
plot(x,y,':');
title('Multiplicative Growth Ratio Over Time')
xlabel('Time')
ylabel('Ratio')
legend('y = (-32/x) + 33')

