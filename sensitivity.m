function s = sensitivity(d)

d = [d,100] ; %100 is the thickness of water containing biomaterial
nbio1 = 1.33;
nbio2 = 1.335;
%wavelength in nanometers;
lambda = 633;

% All this work is done for P polarization.

%the initial medium is glass, refractive index of glass at this wavelength
n1 = 1.7230;
%final medium is taken to be air
n2= 1;
%refractive index of gold at this wavelength
n(1) = 0.1726 + i*3.4218;
%n(1) = 0.75+i*3.9; % this one is for aluminium
% refractive index of silicon at this wavelength. Note that we have to plug
% in wavelength in micrometers instead of nanometers so we are dividing every lambda by
% 1000. 
A = 3.44904; A1 = 2271.88813; A2 = 3.39538; t1 = 0.058304; t2 = 0.30384;
n(2) = A+A1*exp(-lambda/(1000*t1))+A2*exp(-lambda/(1000*t2));
%refractive index of graphene 
n(3) = 3+i*5.446*lambda/3000;

theta = (0:0.001:90)*pi/180;

    for j=1:length(theta) %this for loop is for obtaining R as a function of theta.
            [R1(j),r1(j),T1(j),t1(j)] = nosheen(n1,n2,[n,nbio1],d,theta(j),lambda, 0); %this 0 in the end is to set polarization to be p.
            [R2(j),r2(j),T2(j),t2(j)] = nosheen(n1,n2,[n,nbio2],d,theta(j),lambda, 0);
    end

[rmini, u] = min(R1); 
 thetaMini(1) = theta(u);
 [rmini, u] = min(R2); 
 thetaMini(2) = theta(u);

 deltaTheta = (thetaMini(2)-thetaMini(1))*180/pi;
 
 s = deltaTheta/0.005;
end