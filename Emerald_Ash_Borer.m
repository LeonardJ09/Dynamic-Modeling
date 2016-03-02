%m is the number of time steps
m = 100;

% define the square of the initial forest
n = 49;
%define the number of adults at the beginning of a life cycle and spread
%from tree to tree
AB = zeros(n,n,m);
AB(((n-1)/2)+1,((n-1)/2)+1,1) = 8;

%define the number of adults that end up at a tree, and are about to mate
AD = zeros(n,n,m);

%F is the designation for the tree number and the number of adults
%currently on the tree

% number of active larva on a tree
AL = zeros(n,n,m);

%number of inactive larva on a tree
IAL = zeros(n,n,m);

%G is the ratio of male vs. female gender

%D is the surival rate of active larvae after being laid
D = .6;

%Z is the survival rate of the inactive larva during the winter, or 99.5
%percent per week, with 24 weeks
Z = (.995)^24;

%the forest that will determine if a tree dies is based off of carrying
%capactities for the age of the trees (10-20, 20-40, 40-75, 75+), and these
%three ages are assumed to be evenly distributed throughout the forest. The
%ages of the trees detemrine what the carrying capacity of the tree, but
%the unit increment of is 50 larva/m^2. So the older the tree, the larger
%the tree, and the more toal larva is takes to kill the tree.
%CarryingCapcity(1,1) = larval carrying capacity for ash trees that are
%10-20yrs
%CarryingCapcity(1,2) = larval carrying capacity for ash trees that are
%20-40yrs
%CarryingCapcity(1,3) = larval carrying capacity for ash trees that are
%40-75yrs
%CarryingCapcity(1,4) = larval carrying capacity for ash trees that are
%75+ yrs
CarryingCapacity = [65, 481, 1084, 1284];
replacement = true;
TreeLarvalCapacity = zeros(n,n);
for i = 1:n
    for j= 1:n
        TreeLarvalCapacity(i,j)= randsample(CarryingCapacity, 1, replacement);
    end
end


%these are the parameters for the normal distribution for eggs laying.
%Females can lay 40-70 eggs, so asexual populations can produce 20-35 eggs,
%with the average at 27.5, and the std at 2.5
mu = 15; %mean
sigma = 1; %std. deviation


% m = a full year of lifecycle change
for P = 1:m
             
    
% change in adult population per tree    
    for i = 2:(n-1)
        for j = 2:(n-1)
            if TreeLarvalCapacity(i,j) == 0;
                AD(i,j,P) = 0;
                continue 
            end
          AD(i,j,P) = ((AB(i-1,j-1,P) + AB(i-1,j,P) + AB(i-1,j+1,P) +AB(i,j-1,P)+ AB(i,j+1,P) +AB(i+1,j-1,P) +AB(i+1,j,P) +AB(i+1,j+1,P))/8);
        end
    end
    
    %the gender of the beetles is being taken as asexual. Each beetle on a
    %tree can produce half the number of the typical female to compensate
    %for the asexual egg production
    
 

    % establish the number of eggs that are lain per female, per tree, based on
    % the total population, and fraction that are females
    for i = 2:(n-1)
        for j = 2:(n-1)
          %figure out the number of active larva that will be laid in each
         %tree. The number of adults on a tree, times a production value
         %for the adults on that tree, times the survival rate of the larva
         %in the active stage
         Eggs = normrnd(mu,sigma);
         AL(i,j,P) = AD(i,j,P)*Eggs*D;
        end
    end
    
   %determine if the number of larva will kill the tree, and kill the tree
   %if so
   for i = 1:n
       for j = 1:n
           if AL(i,j,P)>TreeLarvalCapacity(i,j)
               TreeLarvalCapacity(i,j) = 0;
               AL(i,j,P) = 0;
           end
       end
   end
 
   
    for i = 2:(n-1)
        for j = 2:(n-1)
          % this is the number of inactive larva per tree that make it
         % through the winter
         IAL(i,j,P) = AL(i,j,P)*Z;
        end
    end

    for i = 2:(n-1)
     for j = 2:(n-1)
         % the number of inactive larva that survive transition into the new
         % generation, and emerge as adults
            AB(i,j,P+1) = (IAL(i,j,P));
     end
    end

end

%cut off the outside ring of trees that act as the border, and track the
%populations of the stages of larva over time
FinalAB = AB(2:n-1,2:n-1,1:P);
FinalABLast = FinalAB(:,:,P);
FinalAD = AD(2:n-1,2:n-1,1:P);
FinalADLast = FinalAD(:,:,P);
FinalAL = AL(2:n-1,2:n-1,1:P);
FinalALLast = FinalAL(:,:,P);
FinalIAL = IAL(2:n-1,2:n-1,1:P);
FinalIALLast = FinalIAL(:,:,P);

%this will turn the 3D matricies, into contour plots that are displayed at
%each timestep

vidObj1 = VideoWriter('Adult Beginning Emerald Ash Borers.avi');
vidObj1.FrameRate=2;
open(vidObj1);
for i=1:P
  %take the intermediate cntour plots, then Add to Movie:
  contourf(FinalAB(:,:,i));
  f = getframe;
  writeVideo(vidObj1,f);
end
close(vidObj1);

vidObj2 = VideoWriter('Adult Destination Emerald Ash Borers.avi');
vidObj2.FrameRate=2;
open(vidObj2);
for i=1:P
   %take the intermediate cntour plots, then Add to Movie:
  contourf(FinalAD(:,:,i));
  f = getframe;
  writeVideo(vidObj2,f);
end
close(vidObj2);

vidObj3 = VideoWriter('Active Larva Emerald Ash Borers.avi');
vidObj3.FrameRate=2;
open(vidObj3);
for i=1:P
   %take the intermediate cntour plots, then Add to Movie:
  contourf(FinalAL(:,:,i));
  f = getframe;
  writeVideo(vidObj3,f);
end
close(vidObj3);

vidObj4 = VideoWriter('Inactive Larva Emerald Ash Borers.avi');
vidObj4.FrameRate=2;
open(vidObj4);
for i=1:P
   %take the intermediate cntour plots, then Add to Movie:
  contourf(FinalIAL(:,:,i));
  f = getframe;
  writeVideo(vidObj4,f);
end
close(vidObj4);
