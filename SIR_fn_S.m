function X = SIR_fn_S(p,tvec)
[t,Xsoln] = ode23(@(t,Xsoln) SIR_rhs(t,Xsoln,p(1:2)),tvec,[762, 1]);

X = Xsoln(:,1);
end