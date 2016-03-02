Cost = zeros(10,1000)+5000 ;
MeanCost= zeros(1,10);
TreeDeathTotal = zeros(10,1000);
MeanDeath = zeros(1,10);

for w = [.05,.1,.15,.2,.25,.3,.35,.4,.45,.5]            
x = (w)*(20);


for o = 1:1000    
    
%m is the number of time steps
m = 30;

% define the square of the initial forest
n = 51;
%define the number of adults at the beginning of a life cycle and spread
%from tree to tree. the tree that is selected is chosen at random
AB = zeros(n,n,m);
t = [1:10];
t1 = randsample(3:(n-2),1);
t2 = randsample(3:(n-1),1);
b = randsample(t,1);
AB(t1,t2,1) = b;

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


%this is the matrix for the life state of the tree, 0 for dead and 1 for
%alive 
TreeStatus = ones(n,n,m);



%these are the parameters for the normal distribution for eggs laying.
%Females can lay 40-70 eggs, so asexual populations can produce 20-35 eggs,
%with the average at 27.5, and the std at 2.5
mu = 27.5; %mean
sigma = 2.5; %std. deviation

TreeStatusTreatment = zeros(n,n);


% m = a full year of lifecycle change
for P = 1:m 
    
%this is under the assumption that 15% of the trees within the affected
%area are injected with insecticide, chosen randomly based on which ones
%are alive

% run for [.05, .1, .15, .2, .25, .3, .35, .4, .45, .5], this value is
% equal to w


if P==4
    RowDistance = zeros(n,n);
    ColumnDistance = zeros(n,n);
    for i = 3:(n-2)
        for j = 3:(n-2)
             if AB(i,j,P) > 0
                 RowDistance(i,j) = i - t1;
                 ColumnDistance(i,j) = j - t2;
             end
        end
    end
    x1 = min(min(RowDistance));
    x2 = max(max(RowDistance));
    y1 = min(min(ColumnDistance));
    y2 = max(max(ColumnDistance));
    p = [x1+t1:x2+t1];
    q = [y1+t2:y2+t2];
    for i = (x1+t1):(x2+t1)
        for j = (y1+t2):(y2+t2)
            if sum(sum(TreeStatusTreatment))==floor(((x2-x1).*(y2-y1)*w))
                break
            end
        p1 = randsample(p,1);
        q1 = randsample(q,1);
        if TreeStatus(p1,q1,P) == 1;
            TreeStatusTreatment(p1,q1) = 1;
        end
        if TreeStatus(p1,q1,P) == 0;
            continue
        end
    end
    end
end          

if P == 4
    for i = 3:(n-2)
        for j = 3:(n-2)
            if TreeStatusTreatment(i,j) == 1;
                AB(i,j,P) = 0;
            end
        end
    end
end

    
% change in adult population per tree    
    for i = 3:(n-2)
        for j = 3:(n-2)
            if TreeStatus(i,j,P) == 0;
                AD(i,j,P) = 0;
                continue 
            end
          AD(i,j,P) = (((AB(i-1,j-1,P)/(TreeStatus(i-2,j-2,P)+TreeStatus(i-2,j-1,P)+TreeStatus(i-2,j,P)+TreeStatus(i-1,j-2,P)+TreeStatus(i-1,j,P)+TreeStatus(i,j-2,P)+TreeStatus(i,j-1,P)+TreeStatus(i,j,P))) + (AB(i-1,j,P)/(TreeStatus(i-2,j-1,P)+TreeStatus(i-2,j,P)+TreeStatus(i-2,j+1,P)+TreeStatus(i-1,j-1,P)+TreeStatus(i-1,j+1,P)+TreeStatus(i,j-1,P)+TreeStatus(i,j,P)+TreeStatus(i,j+1,P))) + (AB(i-1,j+1,P)/(TreeStatus(i-2,j,P)+TreeStatus(i-2,j+1,P)+TreeStatus(i-2,j+2,P)+TreeStatus(i-1,j,P)+TreeStatus(i-1,j+2,P)+TreeStatus(i,j,P)+TreeStatus(i,j+1,P)+TreeStatus(i,j+2,P))) + (AB(i,j-1,P)/(TreeStatus(i-1,j-2,P)+TreeStatus(i-1,j-1,P)+TreeStatus(i-1,j,P)+TreeStatus(i,j-2,P)+TreeStatus(i,j,P)+TreeStatus(i+1,j-2,P)+TreeStatus(i+1,j-1,P)+TreeStatus(i+1,j,P))) + (AB(i,j+1,P)/(TreeStatus(i-1,j,P)+TreeStatus(i-1,j+1,P)+TreeStatus(i-1,j+2,P)+TreeStatus(i,j,P)+TreeStatus(i,j+2,P)+TreeStatus(i+1,j,P)+TreeStatus(i+1,j+1,P)+TreeStatus(i+1,j+2,P))) + (AB(i+1,j+1,P)/(TreeStatus(i,j,P)+TreeStatus(i,j+1,P)+TreeStatus(i,j+2,P)+TreeStatus(i+1,j,P)+TreeStatus(i+1,j+2,P)+TreeStatus(i+2,j,P)+TreeStatus(i+2,j+1,P)+TreeStatus(i+2,j+2,P))) + (AB(i+1,j,P)/(TreeStatus(i,j-1,P)+TreeStatus(i,j-1,P)+TreeStatus(i,j,P)+TreeStatus(i+1,j-2,P)+TreeStatus(i+1,j,P)+TreeStatus(i+2,j-2,P)+TreeStatus(i+2,j-1,P)+TreeStatus(i+2,j,P))) + (AB(i+1,j-1,P)/(TreeStatus(i,j-2,P)+TreeStatus(i,j-1,P)+TreeStatus(i,j,P)+TreeStatus(i+1,j-2,P)+TreeStatus(i+1,j,P)+TreeStatus(i+2,j-2,P)+TreeStatus(i+2,j-1,P)+TreeStatus(i+2,j,P)))));
        end
    end
    
     if P == 4
        for i = 3:(n-2)
            for j = 3:(n-2)
                if TreeStatusTreatment(i,j) == 1;
                    AD(i,j,P) = 0;
                end
            end
        end
     end
    
    if P == 5
        for i = 3:(n-2)
            for j = 3:(n-2)
                if TreeStatusTreatment(i,j) == 1;
                    AD(i,j,P) = 0;
                end
            end
        end
    end
    
    
    %the gender of the beetles is being taken as asexual. Each beetle on a
    %tree can produce half the number of the typical female to compensate
    %for the asexual egg production
    
 

    % establish the number of eggs that are lain per female, per tree, based on
    % the total population, and fraction that are females
    for i = 3:(n-2)
        for j = 3:(n-2)
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
           if AL(i,j,P)>=TreeLarvalCapacity(i,j)
               TreeStatus(i,j,P) = 0;
               AL(i,j,P) = 0;
           end
       end
   end
 
   
    for i = 3:(n-2)
        for j = 3:(n-2)
          % this is the number of inactive larva per tree that make it
         % through the winter
         IAL(i,j,P) = AL(i,j,P)*Z;
        end
    end

    for i = 3:(n-2)
     for j = 3:(n-2)
         % the number of inactive larva that survive transition into the new
         % generation, and emerge as adults
            AB(i,j,P+1) = (IAL(i,j,P));
     end
    end
    
    %define the forest for the new timestep
     for i = 3:(n-1)
        for j = 3:(n-1)
            if TreeStatus(i,j,P) == 0;
                TreeStatus(i,j,P+1) = 0;
            end
        end
     end
     if sum(sum(AB(:,:,P+1)))==0;
        break 
     end
end

TreeDeathTotal((x),o) = ((n)^2)- sum(sum(TreeStatus(:,:,P)));


    for i = 3:(n-2)
        for j = 3:(n-2)
            if TreeStatusTreatment(i,j) == 1;
                if TreeLarvalCapacity(i,j) == 65;
                    Cost(x,o) = 96 + Cost(x,o);
                end
                if TreeLarvalCapacity(i,j) == 481;
                    Cost(x,o) = 224 + Cost(x,o);
                end
                if TreeLarvalCapacity(i,j) == 1084;
                    Cost(x,o) = 384 + Cost(x,o);
                end
                if TreeLarvalCapacity(i,j) == 1824;
                    Cost(x,o) = 544 + Cost(x,o);
                end
            end
        end
    end


end

MeanDeath(1,x) = mean(TreeDeathTotal((x),:));

MeanCost(1,x) = mean(Cost(x,:));
end