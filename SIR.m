%% this is for the S, I and R model
%  dS/dt = -aSI
%  dI/dt = aSI-bI
%  R(t) = N-S(t)-I(t)
% The data we have is from English medical journal
% march 4, 1978; data for influenzia

clc; clear all;

t = [0,3,4,5,6,7,8,9,10,11,12,13,14]';
S_data = [762,740,650,400,250,120,80,50,20,18,15,13,10]';
I_data = [1,20,80,220,300,260,240,190,120,80,20,5,2]';
N = 763;

%yvec=[S_data;I_data]; 
%tvec=zeros(size(yvec)); tvec(1:length(t))=t;


p = [.002; 0.4]; %p=(a,b,I_0,S_0)

p_optS = nlinfit(t,S_data,@SIR_fn_S,p);
model_optS = feval(@SIR_fn_S,p_optS,t);

figure;plot(t,model_optS,t,S_data,'x')

p_optI = nlinfit(t,I_data,@SIR_fn_I,p);
model_optI = feval(@SIR_fn_I,p_optI,t);
figure;plot(t,model_optI,t,I_data,'x',t,S_data,'x',t,feval(@SIR_fn_S,p_optI,t))

%% now trying to get both involved in optimization
% yvec = [S_data;I_data];
% tvec = [t;t];
% p_opt = nlinfit(tvec,yvec,@SIR_fn,p);
% model_optI = feval(@SIR_fn_I,p_optI,t);
% model_optS = feval(@SIR_fn_S,p_optS,t);
% figure;plot(t,model_optS,t,S_data,'x')
% figure;plot(t,model_optI,t,I_data,'x')