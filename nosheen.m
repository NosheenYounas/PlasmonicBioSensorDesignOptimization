% this function computes the transmission and reflection of light incident
% on a stack of multiple layers. The formulas are based on BYU Optics
% Chapter 4.7

function [R, r, T, t] = nosheen(n1,n2,n,d,theta,lambda, polarization)
%the required inputs are refractive indices, thicknesses, angle of
%incidence and wavelenght of light. n1 and n2 are refractive indices of the
%initial and final medium. for P polarization put polarzation=0 otherwise
%give a non zero number for S polarization.

%now we need cos(theta) for all interfaces. from snell's law we know
%n1sin(theta1) = n2sin(theta2). We also know that cos(theta)^2 =
%1-sin(theta)^2.

    c = sqrt(1-(n1*sin(theta)./n).^2);
% so now we have an array or vector 'c' which contains cosine of all the
% angles inside all layers.

% in computing beta we have used the fact that K = 2pi/lambda and for K
% inside a medium K = n K0 where n is the refractive index of medium and K0
% is the wave vector in free space. Therefore K = n*2pi/lambda
beta = n.*2*pi/lambda.*d.*c;  

%Now creating M matrix
m = zeros(2,2); %this is a 2x2 matrix of zeros, we will fill it up in loop and use it.
M = eye(2,2); % this is 2x2 identity matrix. 
if polarization==0
    for j=1:length(d)
        m(1,1) = cos(beta(j));
        m(1,2) = -i*sin(beta(j))*c(j)/n(j);
        m(2,1) = -i*n(j)*sin(beta(j))/c(j);
        m(2,2) = cos(beta(j));
        M = M*m;
    end
else
    for j=1:length(d)
        m(1,1) = cos(beta(j));
        m(1,2) = -i*sin(beta(j))/(c(j)*n(j));
        m(2,1) = -i*n(j)*sin(beta(j))*c(j);
        m(2,2) = cos(beta(j));
        M = M*m;
    end
end
% At this stage we have M which is product of all m's.
%now we need A. 
if polarization==0
     A = (1/(2*n1*cos(theta)))*[[n1, cos(theta)];[n1, -cos(theta)]]*M*[[sqrt(1-(n1*sin(theta)/n2)^2), 0];[n2, 0]];
else
     A = (1/(2*n1*cos(theta)))*[[n1*cos(theta),1];[n1*cos(theta), -1]]*M*[[1,0];[n2*sqrt(1-(n1*sin(theta)/n2)^2),0]];
end
%now we can get our required quantities. 
t = 1/A(1,1);
r =A(2,1)/A(1,1);
R = r*conj(r);
T = t*conj(t);

end
