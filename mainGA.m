clc
clear all
% for our approach in implementing the genetic algorithm we are going to
% reproduce the maximum change in resonance angle as shown in the table 2
% of sensors and actuators paper. therefore the thickness of gold can only
% be [50,40,35,30], for silicon [0,5,7] and for graphene [1:15]*0.34;
% Each chromosom will only have thicknesses of gold, silicon and graphene
% precisely in this order.

%creating popultion.
pop =16; %total number of individuals.

dGold = randsample([35:0.5:55],pop,1);
dSilicon = randsample([1:0.5:10],pop,1);
dGraphene = randsample([(1:15)*0.34],pop,1);

dpop = [ones(1,pop); dGold; dSilicon; dGraphene]';
% each row of this matrix is an individual specified by its senisitivity, gold, silicon and graphene respectively. (we will compute
%sensitivity properly but for now I have places 1 for sensitivity for every individual.


%% Fitness



for j = 1:pop
    dpop(j,1) = sensitivity(dpop(j,2:4));
end


%now sorting the population in ascending order of the sensitivity.
dpop = sortrows(dpop,1);

history(:,:,:,:,1) = dpop;
%% This is the main loop we are going to do 10 iterations
for m = 1:10
            %% Mating
            %we will discard the first half of this population. which means we will
            %create new population and replace the first half of old ones with new ones
            newdpop = dpop(floor(pop/2)+1:end,:);


            %creating new population, we need to select sets of two people each such
            %that no single person is in more than one sets.

            np = length(newdpop(:,1)); % number of parents
            pselect = randperm(np); % a randam permutation of parent candidates

            children = [];
            for k = 2 : 2 : floor(np/2)*2
                couple = pselect(k-1:k); % couple has the indices of parents in newdpop. couple(1) is the first parent and couple(2) is the second parent
                [x,y] = crossover(newdpop(couple(1),:), newdpop(couple(2),:));
                children = [children;x;y];
            end




            %% Mutations
            % now we have children but we need to introduce mutation in these children.
            mutation = 0.05; %probability of mutation. it is usually kept at very low
                for j = 1:length(children(:,1))

                    if rand<mutation
                    children(j,2) = randsample([50,40,35,30],1); %a random mutation in gold gene
                    end

                    if rand<mutation
                        children(j,3) = randsample([0,5,7],1); %a random mutation in silicon gene
                    end

                    if rand<mutation
                        children(j,4) = randsample([(1:15)*0.34],1); %a random mutation in graphene gene
                    end

                end

            % now childern have mutation as well as gene crossover and are ready to be
            % used. 


            %% New population and progress
            dpop = [newdpop;children];

            % computing fitness again
            for j = 1:pop
                dpop(j,1) = sensitivity(dpop(j,2:4));
            end


            %now sorting the population in ascending order of the sensitivity.
            dpop = sortrows(dpop,1);
%             dpop((end-4):end,:)

            history(:,:,:,:,m+1) = dpop;
             dpop(end,1)
end
% dpop(end,:)


