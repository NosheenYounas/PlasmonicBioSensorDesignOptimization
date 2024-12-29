function [x,y]= crossover(a,b)
% a and b are parents they have [sensitivity, gold, silicon, graphene]
% x and y are children and they have [1,gold, silicon, graphene]
%first child
x(1)=1; % to make it look like parent i have placed 1 in the place of sensitivity. we will calculate sensitivty properly afterwards.
if rand >0.5       %gene 1 i.e. gold thickness
    x(2) = a(2);
else
    x(2) = b(2);
end

if rand >0.5       %gene 2 i.e Silicon thickness
    x(3) = a(3);
else
    x(3) = b(3);
end

if rand >0.5         % gene 3 i.e. graphene thickness
    x(4) = a(4);
else
    x(4) = b(4);
end

%%%%%%%%%%%%%%%%%%%%%%%
% second child
y(1)=1;
if rand >0.5
    y(2) = a(2);
else
    y(2) = b(2);
end

if rand >0.5
    y(3) = a(3);
else
    y(3) = b(3);
end

if rand >0.5
    y(4) = a(4);
else
    y(4) = b(4);
end

end