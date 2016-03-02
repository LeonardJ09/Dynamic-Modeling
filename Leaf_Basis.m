%this section of the code will define all the matrices that are important
%for the inputs, states, and outputs for the leaf, veins, etc.

%this represents the growth of the leaf, an is the linear funciton that
%represents the growth in the size of the midrib

%t is the number of timesteps
t = 32;

x = [1:32];
%y is the multiplicative growth factor at that timestep
y = x;
%floor((-32./(x))+33);

%this is the area over which we are concerned with growth, which should be
%sufficiently large enough to allow for enough growth timesteps, but also small enough where
%the infantcy of the leaf can still be seen.

%these are the dimensions of the leaf matrix, or the area over which the leaf
%will grow
nWidth = 1701;
nHeight = 2501;
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
SubVeinsLobe1Left = zeros(nHeight,nWidth,t);
SubVeinsLobe1Right = zeros(nHeight,nWidth,t);
SubVeinsLobe2Left = zeros(nHeight,nWidth,t);
SubVeinsLobe2Right = zeros(nHeight,nWidth,t);
SubVeinsLobe3Left = zeros(nHeight,nWidth,t);
SubVeinsLobe3Right = zeros(nHeight,nWidth,t);
SubVeinsLobe4Left = zeros(nHeight,nWidth,t);
SubVeinsLobe4Right = zeros(nHeight,nWidth,t);
SubVeinsLobe5Left = zeros(nHeight,nWidth,t);
SubVeinsLobe5Right = zeros(nHeight,nWidth,t);
SubVeinsTotal = zeros(nHeight,nWidth,t);

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
    for j = (Middlej-8*y(u)-1):(Middlej)
        Lobe1LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 1 left subveins to their new location
for i = (Middlei-33*y(u-1)):(Middlei-26*y(u)-1);
    for j = (Middlej-8*y(u-1)-1):(Middlej);
        if SubVeinsLobe1Left (i,j,u-1) == 1;
            s1 = Middlei-33*y(u)+(3*y(u)-1)-i;
            s2 = i-Middlei-33*y(u)+(3*y(u));
            if s2<s1
                SubVeinsLobe1Left(Middlei-33*y(u)+(3*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe1Left(Middlei-33*y(u)+(3*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 1 right major vein
for i = (Middlei-33*y(u)+(3*y(u)-1)):(Middlei-33*y(u)+(3*y(u)))
    for j = (Middlej):(Middlej+8*y(u)+1)
        Lobe2RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 1 right subveins to their new location
for i = (Middlei-33*y(u-1)):(Middlei-26*y(u)-1);
    for j = (Middlej):(Middlej-8*y(u-1)-1);
        if SubVeinsLobe1Right (i,j,u-1) == 1;
            s1 = Middlei-33*y(u)+(3*y(u)-1)-i;
            s2 = i-Middlei-33*y(u)+(3*y(u));
            if s2<s1
                SubVeinsLobe1Right(Middlei-33*y(u)+(3*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe1Right(Middlei-33*y(u)+(3*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end


%lobe 2 left major vein
for i = (Middlei-25*y(u)+(5*y(u)-1)):(Middlei-25*y(u)+(5*y(u)))
    for j = (Middlej-14*y(u)-1):(Middlej)
        Lobe2LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 2 left subveins to their new location
for i = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
    for j = (Middlej-14*y(u)-1):(Middlej);
        if SubVeinsLobe2Left (i,j,u-1) == 1;
            s1 = Middlei-25*y(u)+(5*y(u)-1)-i;
            s2 = i-Middlei-25*y(u)+(5*y(u));
            if s2<s1
                SubVeinsLobe2Left(Middlei-25*y(u)+(5*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe2Left(Middlei-25*y(u)+(5*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 2 right major vein
for i = (Middlei-25*y(u)+(5*y(u)-1)):(Middlei-25*y(u)+(5*y(u)))
    for j = (Middlej):(Middlej+14*y(u)+1)
        Lobe2RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end     

if u>=2
%this moves lobe 2 right subveins to their new location
for i = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
    for j = (Middlej):(Middlej+14*y(u)+1);
        if SubVeinsLobe2Right (i,j,u-1) == 1;
            s1 = Middlei-25*y(u)+(5*y(u)-1)-i;
            s2 = i-Middlei-25*y(u)+(5*y(u));
            if s2<s1
                SubVeinsLobe2Right(Middlei-25*y(u)+(5*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe2Right(Middlei-25*y(u)+(5*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 3 left major vein
for i = (Middlei-13*y(u)+(9*y(u)-1)):(Middlei-13*y(u)+(9*y(u)))
    for j = (Middlej-24*y(u)-1):(Middlej)
        Lobe3LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 3 left subveins to their new location
for i = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
    for j = (Middlej-24*y(u)-1):(Middlej);
        if SubVeinsLobe3Left (i,j,u-1) == 1;
            s1 = Middlei-13*y(u)+(9*y(u)-1)-i;
            s2 = i-Middlei-13*y(u)+(9*y(u));
            if s2<s1
                SubVeinsLobe3Left(Middlei-13*y(u)+(9*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe3Left(Middlei-13*y(u)+(9*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 3 right major vein
for i = (Middlei-13*y(u)+(9*y(u)-1)):(Middlei-13*y(u)+(9*y(u)))
    for j = (Middlej):(Middlej+24*y(u)+1)
        Lobe3RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 3 right subveins to their new location
for i = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
    for j = (Middlej):(Middlej+24*y(u)+1);
        if SubVeinsLobe3Right (i,j,u-1) == 1;
            s1 = Middlei-13*y(u)+(9*y(u)-1)-i;
            s2 = i-Middlei-13*y(u)+(9*y(u));
            if s2<s1
                SubVeinsLobe3Right(Middlei-13*y(u)+(9*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe3Right(Middlei-13*y(u)+(9*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end


%lobe 4 left major vein
for i = (Middlei+7*y(u)+(7*y(u)-1)):(Middlei+7*y(u)+(7*y(u)))
    for j = (Middlej-20*y(u)-1):(Middlej)
        Lobe4LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 4 left subveins to their new location
for i = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
    for j = (Middlej-18*y(u)-1):(Middlej);
        if SubVeinsLobe4Left (i,j,u-1) == 1;
            s1 = Middlei+7*y(u)+(7*y(u)-1)-i;
            s2 = i-Middlei-7*y(u)+(7*y(u));
            if s2<s1
                SubVeinsLobe4Left(Middlei-7*y(u)+(7*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe4Left(Middlei-7*y(u)+(7*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 4 right major vein
for i = (Middlei+7*y(u)+(7*y(u)-1)):(Middlei+7*y(u)+(7*y(u)))
    for j = (Middlej):(Middlej+20*y(u)+1)
        Lobe4RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 4 right subveins to their new location
for i = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
    for j = (Middlej):(Middlej+18*y(u)+1);
        if SubVeinsLobe4Right (i,j,u-1) == 1;
            s1 = Middlei+7*y(u)+(7*y(u)-1)-i;
            s2 = i-Middlei-7*y(u)+(7*y(u));
            if s2<s1
                SubVeinsLobe4Right(Middlei-7*y(u)+(7*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe4Right(Middlei-7*y(u)+(7*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 5 left major vein
for i = (Middlei+23*y(u)+(5*y(u)-1)):(Middlei+23*y(u)+(5*y(u)))
    for j = (Middlej-12*y(u)-1):(Middlej)
        Lobe5LeftVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 5 left subveins to their new location
for i = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
    for j = (Middlej-12*y(u)-1):(Middlej);
        if SubVeinsLobe5Left (i,j,u-1) == 1;
            s1 = Middlei+23*y(u)+(5*y(u)-1)-i;
            s2 = i-Middlei-23*y(u)+(5*y(u));
            if s2<s1
                SubVeinsLobe5Left(Middlei-23*y(u)+(5*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe5Left(Middlei-23*y(u)+(5*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%lobe 5 right major vein
for i = (Middlei+23*y(u)+(5*y(u)-1)):(Middlei+23*y(u)+(5*y(u)))
    for j = (Middlej):(Middlej+12*y(u)+1)
        Lobe5RightVein(i,j,u) = 1;
        Veins(i,j,u) = 1;
    end
end

if u>=2
%this moves lobe 5 left subveins to their new location
for i = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
    for j = (Middlej):(Middlej+12*y(u)+1);
        if SubVeinsLobe5Right (i,j,u-1) == 1;
            s1 = Middlei+23*y(u)+(5*y(u)-1)-i;
            s2 = i-Middlei-23*y(u)+(5*y(u));
            if s2<s1
                SubVeinsLobe5Right(Middlei-23*y(u)+(5*y(u))+s2,j,u)=1;
            end
            if s1<s2
                SubVeinsLobe5Right(Middlei-23*y(u)+(5*y(u)-1)-s1,j,u)=1;
            end
        end
    end
end
end

%this is for the establishment of cells in the leaf with nutrients 
for i = 1:nHeight
    for j = 1:nWidth
        if Veins(i,j,u) == 1||SubVeinsLobe1Left(i,j,u)==1||SubVeinsLobe1Right(i,j,u)==1||SubVeinsLobe2Left(i,j,u)==1||SubVeinsLobe2Right(i,j,u)==1||SubVeinsLobe3Left(i,j,u)==1||SubVeinsLobe3Right(i,j,u)==1||SubVeinsLobe4Left(i,j,u)==1||SubVeinsLobe4Right(i,j,u)==1||SubVeinsLobe5Left(i,j,u)==1||SubVeinsLobe5Right(i,j,u)==1;
            if Leaf(i+1,j,u) ~= 0;
                Nutrients(i+1,j,u) = 1;
            end
            if Leaf(i,j+1,u) ~= 0;
                Nutrients(i,j+1,u) = 1;
            end
            if Leaf(i-1,j,u) ~= 0;
                Nutrients(i-1,j,u) =1;
            end
            if Leaf(i,j-1,u) ~= 0;
                Nutrients(i,j-1,u) = 1;
            end
            if Leaf(i+1,j+1,u) ~= 0;
                Nutrients(i+1,j+1,u) = 1;
            end
            if Leaf(i-1,j-1,u) ~= 0;
                Nutrients(i-1,j-1,u) = 1;
            end
            if Leaf(i+1,j-1,u) ~= 0;
                Nutrients(i+1,j-1,u) = 1;
            end
            if Leaf(i-1,j+1,u) ~= 0;
                Nutrients(i-1,j+1,u) = 1;
            end
            if Leaf(i+2,j,u) ~= 0;
                Nutrients(i+2,j,u) = 1;
            end
            if Leaf(i,j+2,u) ~= 0;
                Nutrients(i,j+2,u) = 1;
            end
            if Leaf(i-2,j,u) ~= 0;
                Nutrients(i-2,j,u) =1;
            end
            if Leaf(i,j-2,u) ~= 0;
                Nutrients(i,j-2,u) = 1;
            end
            if Leaf(i+2,j+2,u) ~= 0;
                Nutrients(i+2,j+2,u) = 1;
            end
            if Leaf(i-2,j-2,u) ~= 0;
                Nutrients(i-2,j-2,u) = 1;
            end
            if Leaf(i+2,j-2,u) ~= 0;
                Nutrients(i+2,j-2,u) = 1;
            end
            if Leaf(i-2,j+2,u) ~= 0;
                Nutrients(i-2,j+2,u) = 1;
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%loops to define the area of the lobes

%lobe 1 left body (main)
for i = (Middlei-33*y(u)):(Middlei-27*y(u)-1)
    for j = (Middlej-6*y(u)-1):(Middlej)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 left body (point)
for i = (Middlei-31*y(u)):(Middlei-29*y(u)-1)
    for j = (Middlej-8*y(u)-1):(Middlej-6*y(u)-2)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 left  body (upper lobe joint)
for i = (Middlei-27*y(u)):(Middlei-26*y(u)-1)
    for j = (Middlej-2*y(u)-1):(Middlej)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%

%lobe 1 right body (main)
for i = (Middlei-33*y(u)):(Middlei-27*y(u)-1)
    for j = (Middlej):(Middlej+6*y(u)+1)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 right body (point)
for i = (Middlei-31*y(u)):(Middlei-29*y(u)-1)
    for j = (Middlej+6*y(u)+2):(Middlej+8*y(u)+1)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 1 right  body (upper lobe joint)
for i = (Middlei-27*y(u)):(Middlei-26*y(u)-1)
    for j = (Middlej):(Middlej+2*y(u)+1)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lobe 2 left body (lower lobe joint)
for i = (Middlei-26*y(u)):(Middlei-25*y(u)-1)
    for j = (Middlej-2*y(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 left body (main)
for i = (Middlei-25*y(u)):(Middlei-15*y(u)-1)
    for j = (Middlej-10*y(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 left body (point)
for i = (Middlei-23*y(u)):(Middlei-17*y(u)-1)
    for j = (Middlej-12*y(u)-1):(Middlej-10*y(u)-2)
        Lobe1Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-21*y(u)):(Middlei-19*y(u)-1)
    for j = (Middlej-14*y(u)-1):(Middlej-12*y(u)-2)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 left body (upper lobe joint)
for i = (Middlei-15*y(u)):(Middlei-14*y(u)-1)
    for j = (Middlej-6*y(u)-1):(Middlej)
        Lobe2Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%

%lobe 2 right body (lower lobe joint)
for i = (Middlei-26*y(u)):(Middlei-25*y(u)-1)
    for j = (Middlej):(Middlej+2*y(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 right body (main)
for i = (Middlei-25*y(u)):(Middlei-15*y(u)-1)
    for j = (Middlej):(Middlej+10*y(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%lobe 2 right body (point)
for i = (Middlei-23*y(u)):(Middlei-17*y(u)-1)
    for j = (Middlej+10*y(u)+2):(Middlej+12*y(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-21*y(u)):(Middlei-19*y(u)-1)
    for j = (Middlej+12*y(u)+2):(Middlej+14*y(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 2 right  body (upper lobe joint)
for i = (Middlei-15*y(u)):(Middlei-14*y(u)-1)
    for j = (Middlej):(Middlej+6*y(u)+1)
        Lobe2Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%lobe 3 left body (lower lobe joint)
for i = (Middlei-14*y(u)):(Middlei-13*y(u)-1)
    for j = (Middlej-6*y(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 left body (main)
for i = (Middlei-13*y(u)):(Middlei+5*y(u)-1)
    for j = (Middlej-16*y(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 body (point)
for i = (Middlei-11*y(u)):(Middlei+3*y(u)-1)
    for j = (Middlej-18*y(u)-1):(Middlej-16*y(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-9*y(u)):(Middlei+y(u)-1)
    for j = (Middlej-20*y(u)-1):(Middlej-18*y(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-7*y(u)):(Middlei-1*y(u)-1)
    for j = (Middlej-22*y(u)-1):(Middlej-20*y(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-5*y(u)):(Middlei-3*y(u)-1)
    for j = (Middlej-24*y(u)-1):(Middlej-22*y(u)-2)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 left body (upper lobe joint)
for i = (Middlei+5*y(u)):(Middlei+6*y(u)-1)
    for j = (Middlej-10*y(u)-1):(Middlej)
        Lobe3Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%
%lobe 3 right body (lower lobe joint)
for i = (Middlei-14*y(u)):(Middlei-13*y(u)-1)
    for j = (Middlej):(Middlej+6*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (main)
for i = (Middlei-13*y(u)):(Middlei+5*y(u)-1)
    for j = (Middlej):(Middlej+16*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (point)
for i = (Middlei-11*y(u)):(Middlei+3*y(u)-1)
    for j = (Middlej+16*y(u)+2):(Middlej+18*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-9*y(u)):(Middlei+y(u)+1)
    for j = (Middlej+18*y(u)+2):(Middlej+20*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-7*y(u)):(Middlei-y(u)-1)
    for j = (Middlej+20*y(u)+2):(Middlej+22*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei-5*y(u)):(Middlei-3*y(u)-1)
    for j = (Middlej+22*y(u)+2):(Middlej+24*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 3 Right body (upper lobe joint)
for i = (Middlei+5*y(u)):(Middlei+6*y(u)-1)
    for j = (Middlej):(Middlej+10*y(u)+1)
        Lobe3Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%lobe 4 Left body (lower lobe joint)
for i = (Middlei+6*y(u)):(Middlei+7*y(u)-1)
    for j = (Middlej-10*y(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left body (main)
for i = (Middlei+7*y(u)):(Middlei+21*y(u)-1)
    for j = (Middlej-14*y(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left point
for i = (Middlei+9*y(u)):(Middlei+19*y(u)-1)
    for j = (Middlej-16*y(u)-1):(Middlej-14*y(u)-1)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+11*y(u)):(Middlei+17*y(u)-1)
    for j = (Middlej-18*y(u)-1):(Middlej-16*y(u)-2)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+13*y(u)):(Middlei+15*y(u)-1)
    for j = (Middlej-20*y(u)-1):(Middlej-18*y(u)-2)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 left body (upper lobe joint)
for i = (Middlei+21*y(u)):(Middlei+22*y(u)-1)
    for j = (Middlej-4*y(u)-1):(Middlej)
        Lobe4Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%
%lobe 4 Right body (lower lobe joint)
for i = (Middlei+6*y(u)):(Middlei+7*y(u)-1)
    for j = (Middlej):(Middlej+10*y(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 Right body (main)
for i = (Middlei+7*y(u)):(Middlei+21*y(u)-1)
    for j = (Middlej):(Middlej+14*y(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 Right point
for i = (Middlei+9*y(u)):(Middlei+19*y(u)-1)
    for j = (Middlej+14*y(u)+2):(Middlej+16*y(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+11*y(u)):(Middlei+17*y(u)-1)
    for j = (Middlej+16*y(u)+2):(Middlej+18*y(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+13*y(u)):(Middlei+15*y(u)-1)
    for j = (Middlej+18*y(u)+2):(Middlej+20*y(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 4 body (upper lobe joint)
for i = (Middlei+21*y(u)):(Middlei+22*y(u)-1)
    for j = (Middlej):(Middlej+4*y(u)+1)
        Lobe4Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%
%lobe 5 left body (lower lobe joint)
for i = (Middlei+22*u):(Middlei+23*y(u)-1)
    for j = (Middlej-4*y(u)-1):(Middlej)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 left body (main)
for i = (Middlei+23*y(u)):(Middlei+33*y(u)-1)
    for j = (Middlej-8*y(u)-1):(Middlej)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 left body (point)
for i = (Middlei+25*y(u)):(Middlei+31*y(u)-1)
    for j = (Middlej-10*y(u)-1):(Middlej-8*y(u)-2)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+27*y(u)):(Middlei+29*y(u)-1)
    for j = (Middlej-12*y(u)-1):(Middlej-10*y(u)-2)
        Lobe5Left(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%
%lobe 5 right body (lower lobe joint)
for i = (Middlei+22*u):(Middlei+23*y(u)-1)
    for j = (Middlej):(Middlej+4*y(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 right body (main)
for i = (Middlei+23*y(u)):(Middlei+33*y(u)-1)
    for j = (Middlej):(Middlej+8*y(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%lobe 5 right body (ponit)
for i = (Middlei+25*y(u)):(Middlei+31*y(u)-1)
    for j = (Middlej+8*y(u)+2):(Middlej+10*y(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
for i = (Middlei+27*y(u)):(Middlei+29*y(u)-1)
    for j = (Middlej+10*y(u)+2):(Middlej+12*y(u)+1)
        Lobe5Right(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%
%Apex left body (main)
for i = (Middlei+33*y(u)):(Middlei+37*y(u)-1)
    for j = (Middlej-2*y(u)-1):(Middlej)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end
%Apex right body (main)
for i = (Middlei+33*y(u)):(Middlei+37*y(u)-1)
    for j = (Middlej):(Middlej+2*y(u)+1)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%Apex point
for i = (Middlei+37*y(u)):(Middlei+39*y(u)-1)
    for j = (Middlej-y(u)-1):(Middlej+y(u)+1)
        Apex(i,j,u) = 1;
        Leaf(i,j,u) = 1;
    end
end

%this will establish which cells in the leaf get veins, and how those veins
%connect to the midrib

%the veins for Lobe 1 left side

%the square area over which the lobe covers
x1 = (Middlei-33*y(u)):(Middlei-26*y(u)-1);
y1 = (Middlej-8*y(u)-1):(Middlej);

%random selection of cells in the area, that are in the leaf
lobe1leftsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e=1:100
    samplex(1,e) = randsample(x1,1);
    sampley(1,e) = randsample(y1,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe1Left(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                   lobe1leftsampled(samplex(1,e),sampley(1,e)) = 1;
                   if sum(sum(lobe1leftsampled(:,:))) == 12;
                       break
                   end
                end
            end
        end
    end
end

for i = (Middlei-33*y(u)):(Middlei-26*y(u)-1);
    for j = (Middlej-8*y(u)-1):(Middlej);
        if lobe1leftsampled(i,j) == 1; 
            i1 = Middlei-33*y(u)+(3*y(u)-1);
            i2 = Middlei-33*y(u)+(3*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe1leftsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe1leftsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei-33*y(u)):(Middlei-26*y(u)-1);
    for j = (Middlej-8*y(u)-1):(Middlej);
        if result(1) == lobe1leftsampled(i,j);
            SubVeinsLobe1Left(i,j,u) = 1;
            i1 = Middlei-33*y(u)+(3*y(u)-1);
            i2 = Middlei-33*y(u)+(3*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe1Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe1Left(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe1leftsampled(i,j);
                SubVeinsLobe1Left(i,j,u) = 1;
                i1 = Middlei-33*y(u)+(3*y(u)-1);
                i2 = Middlei-33*y(u)+(3*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe1Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe1Left(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe1leftsampled(i,j);
            SubVeinsLobe1Left(i,j,u) = 1;
            i1 = Middlei-33*y(u)+(3*y(u)-1);
            i2 = Middlei-33*y(u)+(3*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe1Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe1Left(f,j,u) = 1;
                end
            end
        end
    end
end

%the veins for lobe 1 right side
x2 = (Middlei-33*y(u)):(Middlei-26*y(u)-1);
y2 = (Middlej):(Middlej+8*y(u)+1);

%random selection of cells in the area, that are in the leaf
lobe1rightsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x2,1);
    sampley(1,e) = randsample(y2,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe1Right(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                   lobe1rightsampled(samplex(1,e),sampley(1,e)) = 1;
                   if sum(sum(lobe1rightsampled(:,:)))==12;
                       break
                   end
                end
            end
        end
    end
end

for i = (Middlei-33*y(u)):(Middlei-26*y(u)-1);
    for j = (Middlej):(Middlej+8*y(u)+1);
        if lobe1rightsampled(i,j) == 1; 
            i1 = Middlei-33*y(u)+(3*y(u)-1);
            i2 = Middlei-33*y(u)+(3*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe1rightsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe1rightsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei-33*y(u)):(Middlei-26*y(u)-1);
    for j = (Middlej):(Middlej+8*y(u)+1);
        if result(1) == lobe1rightsampled(i,j);
            SubVeinsLobe1Right(i,j,u) = 1;
            i1 = Middlei-33*y(u)+(3*y(u)-1);
            i2 = Middlei-33*y(u)+(3*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe1Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe1Right(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe1rightsampled(i,j);
                SubVeinsLobe1Right(i,j,u) = 1;
                i1 = Middlei-33*y(u)+(3*y(u)-1);
                i2 = Middlei-33*y(u)+(3*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe1Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe1Right(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe1rightsampled(i,j);
            SubVeinsLobe1Right(i,j,u) = 1;
            i1 = Middlei-33*y(u)+(3*y(u)-1);
            i2 = Middlei-33*y(u)+(3*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe1Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe1Right(f,j,u) = 1;
                end
            end
        end
    end
end

%the veins for lobe 2 left side
x3 = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
y3 = (Middlej-14*y(u)-1):(Middlej);
%random selection of cells in the area, that are in the leaf
lobe2leftsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x3,1);
    sampley(1,e) = randsample(y3,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe2Left(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                   lobe2leftsampled(samplex(1,e),sampley(1,e)) = 1;
                   if sum(sum(lobe2leftsampled(:,:)))==12;
                       break
                   end
                end
            end
        end
    end
end

for i = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
    for j = (Middlej-14*y(u)-1):(Middlej);
        if lobe2leftsampled(i,j) == 1; 
            i1 = Middlei-25*y(u)+(5*y(u)-1);
            i2 = Middlei-25*y(u)+(5*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe2leftsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe2leftsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
    for j = (Middlej-14*y(u)-1):(Middlej);
        if result(1) == lobe2leftsampled(i,j);
            SubVeinsLobe2Left(i,j,u) = 1;
            i1 = Middlei-25*y(u)+(5*y(u)-1);
            i2 = Middlei-25*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe2Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe2Left(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe2leftsampled(i,j);
                SubVeinsLobe2Left(i,j,u) = 1;
                i1 = Middlei-25*y(u)+(5*y(u)-1);
                i2 = Middlei-25*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe2Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe2Left(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe2leftsampled(i,j);
            SubVeinsLobe2Left(i,j,u) = 1;
            i1 = Middlei-25*y(u)+(5*y(u)-1);
            i2 = Middlei-25*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe2Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe2Left(f,j,u) = 1;
                end
            end
        end
    end
end
%veins for the lobe 2 right side
x4 = (Middlei-26*y(u)):(Middlei-14*y(u)-1);
y4 = (Middlej):(Middlej+14*y(u)+1);
%random selection of cells in the area, that are in the leaf
lobe2rightsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x4,1);
    sampley(1,e) = randsample(y4,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe2Right(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                   lobe2rightsampled(samplex(1,e),sampley(1,e)) = 1;
                   if sum(sum(lobe2rightsampled(:,:)))==12;
                       break
                   end
                end
            end
        end
    end
end

for i = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
    for j = (Middlej):(Middlej+14*y(u)+1);
        if lobe2rightsampled(i,j) == 1; 
            i1 = Middlei-25*y(u)+(5*y(u)-1);
            i2 = Middlei-25*y(u)+(5*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe2rightsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe2rightsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei-25*y(u)):(Middlei-14*y(u)-1);
    for j = (Middlej):(Middlej+14*y(u)+1);
        if result(1) == lobe2rightsampled(i,j);
            SubVeinsLobe2Right(i,j,u) = 1;
            i1 = Middlei-25*y(u)+(5*y(u)-1);
            i2 = Middlei-25*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe2Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe2Left(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe2rightsampled(i,j);
                SubVeinsLobe2Right(i,j,u) = 1;
                i1 = Middlei-25*y(u)+(5*y(u)-1);
                i2 = Middlei-25*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe2Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe2Right(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe2rightsampled(i,j);
            SubVeinsLobe2Right(i,j,u) = 1;
            i1 = Middlei-25*y(u)+(5*y(u)-1);
            i2 = Middlei-25*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe2Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe2Right(f,j,u) = 1;
                end
            end
        end
    end
end

%the veins for lobe 3 left side
x5 = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
y5 = (Middlej-24*y(u)-1):(Middlej);
%random selection of cells in the area, that are in the leaf
lobe3leftsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x5,1);
    sampley(1,e) = randsample(y5,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe3Left(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                   lobe3leftsampled(samplex(1,e),sampley(1,e)) = 1;
                   if sum(sum(lobe3leftsampled(:,:))) == 12;
                       break
                   end
                end
            end
        end
    end
end

for i = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
    for j = (Middlej-24*y(u)-1):(Middlej);
        if lobe3leftsampled(i,j) == 1; 
            i1 = Middlei-13*y(u)+(9*y(u)-1);
            i2 = Middlei-13*y(u)+(9*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe3leftsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe3leftsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
    for j = (Middlej-24*y(u)-1):(Middlej);
        if result(1) == lobe3leftsampled(i,j);
            SubVeinsLobe3Left(i,j,u) = 1;
            i1 = Middlei-13*y(u)+(9*y(u)-1);
            i2 = Middlei-13*y(u)+(9*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe3Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe3Left(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe3leftsampled(i,j);
                SubVeinsLobe3Left(i,j,u) = 1;
                i1 = Middlei-13*y(u)+(9*y(u)-1);
                i2 = Middlei-13*y(u)+(9*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe3Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe3Left(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe3leftsampled(i,j);
            SubVeinsLobe3Left(i,j,u) = 1;
            i1 = Middlei-13*y(u)+(9*y(u)-1);
            i2 = Middlei-13*y(u)+(9*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe3Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe3Left(f,j,u) = 1;
                end
            end
        end
    end
end


%the veins for lobe 3 right side
x6 = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
y6 = (Middlej):(Middlej+24*y(u)+1);
%random selection of cells in the area, that are in the leaf
lobe3rightsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x6,1);
    sampley(1,e) = randsample(y6,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe3Right(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                    lobe3rightsampled(samplex(1,e),sampley(1,e)) = 1;
                end
            end
        end
    end
end

for i = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
    for j = (Middlej):(Middlej+24*y(u)+1);
        if lobe3rightsampled(i,j) == 1; 
            i1 = Middlei-13*y(u)+(9*y(u)-1);
            i2 = Middlei-13*y(u)+(9*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe3rightsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe3rightsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei-14*y(u)):(Middlei+6*y(u)-1);
    for j = (Middlej):(Middlej+24*y(u)+1);
        if result(1) == lobe3rightsampled(i,j);
            SubVeinsLobe3Right(i,j,u) = 1;
            i1 = Middlei-13*y(u)+(9*y(u)-1);
            i2 = Middlei-13*y(u)+(9*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe3Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe3Right(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe3rightsampled(i,j);
                SubVeinsLobe3Right(i,j,u) = 1;
                i1 = Middlei-13*y(u)+(9*y(u)-1);
                i2 = Middlei-13*y(u)+(9*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe3Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe3Right(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe3rightsampled(i,j);
            SubVeinsLobe3Right(i,j,u) = 1;
            i1 = Middlei-13*y(u)+(9*y(u)-1);
            i2 = Middlei-13*y(u)+(9*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe3Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe3Right(f,j,u) = 1;
                end
            end
        end
    end
end


%the veins for lobe 4 left side
x7 = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
y7 = (Middlej-18*y(u)-1):(Middlej);
%random selection of cells in the area, that are in the leaf
lobe4leftsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x7,1);
    sampley(1,e) = randsample(y7,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe4Left(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                    lobe4leftsampled(samplex(1,e),sampley(1,e)) = 1;
                    if sum(sum(lobe4leftsampled(:,:)))==12;
                        break
                    end
                end
            end
        end
    end
end

for i = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
    for j = (Middlej-18*y(u)-1):(Middlej);
        if lobe4leftsampled(i,j) == 1; 
            i1 = Middlei+7*y(u)+(7*y(u)-1);
            i2 = Middlei+7*y(u)+(7*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe4leftsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe4leftsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
    for j = (Middlej-18*y(u)-1):(Middlej);
        if result(1) == lobe4leftsampled(i,j);
            SubVeinsLobe4Left(i,j,u) = 1;
            i1 = Middlei+7*y(u)+(7*y(u)-1);
            i2 = Middlei+7*y(u)+(7*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe4Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe4Left(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe4leftsampled(i,j);
                SubVeinsLobe4Left(i,j,u) = 1;
                i1 = Middlei+7*y(u)+(7*y(u)-1);
                i2 = Middlei+7*y(u)+(7*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe4Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe4Left(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe4leftsampled(i,j);
            SubVeinsLobe4Left(i,j,u) = 1;
            i1 = Middlei+7*y(u)+(7*y(u)-1);
            i2 = Middlei+7*y(u)+(7*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe4Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe4Left(f,j,u) = 1;
                end
            end
        end
    end
end

%the veins for lobe 4 right side
x8 = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
y8 = (Middlej):(Middlej+18*y(u)+1);
%random selection of cells in the area, that are in the leaf
lobe4rightsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x8,1);
    sampley(1,e) = randsample(y8,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe4Right(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                    lobe4rightsampled(samplex(1,e),sampley(1,e)) = 1;
                    if sum(sum(lobe4rightsampled(:,:)))==12;
                        break 
                    end
                end
            end
        end
    end
end

for i = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
    for j = (Middlej):(Middlej+18*y(u)+1);
        if lobe4rightsampled(i,j) == 1; 
            i1 = Middlei+7*y(u)+(7*y(u)-1);
            i2 = Middlei+7*y(u)+(7*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe4rightsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe4rightsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei+6*y(u)):(Middlei+22*y(u)-1);
    for j = (Middlej):(Middlej+18*y(u)+1);
        if result(1) == lobe4rightsampled(i,j);
            SubVeinsLobe4Right(i,j,u) = 1;
            i1 = Middlei+7*y(u)+(7*y(u)-1);
            i2 = Middlei+7*y(u)+(7*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe4Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe4Right(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe4rightsampled(i,j);
                SubVeinsLobe4Right(i,j,u) = 1;
                i1 = Middlei+7*y(u)+(7*y(u)-1);
                i2 = Middlei+7*y(u)+(7*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe4Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe4Right(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe4rightsampled(i,j);
            SubVeinsLobe4Right(i,j,u) = 1;
            i1 = Middlei+7*y(u)+(7*y(u)-1);
            i2 = Middlei+7*y(u)+(7*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe4Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe4Right(f,j,u) = 1;
                end
            end
        end
    end
end

%the veins for lobe 5 left side
x9 = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
y9 = (Middlej-12*y(u)-1):(Middlej);
%random selection of cells in the area, that are in the leaf
lobe5leftsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x9,1);
    sampley(1,e) = randsample(y9,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe5Left(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                    lobe5leftsampled(samplex(1,e),sampley(1,e)) = 1;
                    if sum(sum(lobe5leftsampled(:,:)))==12;
                        break
                    end
                end
            end
        end
    end
end

for i = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
    for j = (Middlej-12*y(u)-1):(Middlej);
        if lobe5leftsampled(i,j) == 1; 
            i1 = Middlei+23*y(u)+(5*y(u)-1);
            i2 = Middlei+23*y(u)+(5*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe5leftsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe5leftsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
    for j = (Middlej-12*y(u)-1):(Middlej);
        if result(1) == lobe5leftsampled(i,j);
            SubVeinsLobe5Left(i,j,u) = 1;
            i1 = Middlei+23*y(u)+(5*y(u)-1);
            i2 = Middlei+23*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe5Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe5Left(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe5leftsampled(i,j);
                SubVeinsLobe5Left(i,j,u) = 1;
                i1 = Middlei+23*y(u)+(5*y(u)-1);
                i2 = Middlei+23*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe5Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe5Left(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe5leftsampled(i,j);
            SubVeinsLobe5Left(i,j,u) = 1;
            i1 = Middlei+23*y(u)+(5*y(u)-1);
            i2 = Middlei+23*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe5Left(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe5Left(f,j,u) = 1;
                end
            end
        end
    end
end

%the veins for lobe 5 right side
x10 = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
y10 = (Middlej):(Middlej+12*y(u)+1);
%random selection of cells in the area, that are in the leaf
lobe5rightsampled = zeros(nHeight,nWidth);
samplex = zeros(1,100);
sampley = zeros(1,100);
for e = 1:100
    samplex(1,e) = randsample(x10,1);
    sampley(1,e) = randsample(y10,1);
    if Leaf(samplex(1,e),sampley(1,e),u)==1;
        if Veins(samplex(1,e),sampley(1,e),u) == 0;
            if SubVeinsLobe5Right(samplex(1,e),sampley(1,e),u) == 0;
                if Nutrients(samplex(1,e),sampley(1,e),u) == 0;
                    lobe5rightsampled(samplex(1,e),sampley(1,e)) = 1;
                    if sum(sum(lobe5rightsampled(:,:)))==12;
                        break
                    end
                end
            end
        end
    end
end

for i = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
    for j = (Middlej):(Middlej-12*y(u)-1);
        if lobe5rightsampled(i,j) == 1; 
            i1 = Middlei+23*y(u)+(5*y(u)-1);
            i2 = Middlei+23*y(u)+(5*y(u));
            b1 = abs(i-i1);
            b2 = abs(i-i2);
            xdistance = b1;
            if b2<b1
                xdistance = b2;
            end
            lobe5rightsampled(i,j) = xdistance;
        end
    end
end
Asorted = sort(lobe5rightsampled(:),'descend');
result = Asorted(1:3);
for i = (Middlei+22*y(u)):(Middlei+33*y(u)-1);
    for j = (Middlej):(Middlej-12*y(u)-1);
        if result(1) == lobe5rightsampled(i,j);
            SubVeinsLobe5Right(i,j,u) = 1;
            i1 = Middlei+23*y(u)+(5*y(u)-1);
            i2 = Middlei+23*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe5Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe5Right(f,j,u) = 1;
                end
            end
        end
        if result(2) == lobe5rightsampled(i,j);
                SubVeinsLobe5Right(i,j,u) = 1;
                i1 = Middlei+23*y(u)+(5*y(u)-1);
                i2 = Middlei+23*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe5Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe5Right(f,j,u) = 1;
                end
            end
        end
        if result(3) == lobe5rightsampled(i,j);
            SubVeinsLobe5Right(i,j,u) = 1;
            i1 = Middlei+23*y(u)+(5*y(u)-1);
            i2 = Middlei+23*y(u)+(5*y(u));
            if i>i2
                for g = i2:i
                    SubVeinsLobe5Right(g,j,u) = 1;
                end
            end
            if i<i1
                for f = i:i1
                    SubVeinsLobe5Right(f,j,u) = 1;
                end
            end
        end
    end
end

SubVeinsTotal(:,:,u) = SubVeinsLobe1Left(:,:,u)+SubVeinsLobe1Right(:,:,u)+SubVeinsLobe2Left(:,:,u)+SubVeinsLobe2Right(:,:,u)+SubVeinsLobe3Left(:,:,u)+SubVeinsLobe3Right(:,:,u)+SubVeinsLobe4Left(:,:,u)+SubVeinsLobe4Right(:,:,u)+SubVeinsLobe5Left(:,:,u)+SubVeinsLobe5Right(:,:,u);
end

contourf(SubVeinsTotal)


vidObj1 = VideoWriter('Nutrient Formation');
vidObj1.FrameRate=20;
open(vidObj1);
for i=1:t
  %take the intermediate cntour plots, then Add to Movie:
  contourf(Nutrients(:,:,i));
  f = getframe;
  writeVideo(vidObj1,f);
end
close(vidObj1);

x = [1:32];
y = (-32./x)+33;
plot(x,y,'+');

