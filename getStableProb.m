function x = getStableProb(alpha, beta)
    %% 生成稳态Markov
    A=[alpha,beta-1;1,1];
    B=[0;1];
    x=inv(A)*B; %x(1)为状态为0的概率，x(2)为状态为1的概率
end