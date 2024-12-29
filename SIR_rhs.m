function dX = SIR_rhs(t,X,p)

%  dS/dt = -aSI
%  dI/dt = aSI-bI
dX   =[-p(1)*X(1)*X(2);
      p(1)*X(1)*X(2)-p(2)*X(2)];
end