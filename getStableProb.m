function x = getStableProb(alpha, beta)
    %% ������̬Markov
    A=[alpha,beta-1;1,1];
    B=[0;1];
    x=inv(A)*B; %x(1)Ϊ״̬Ϊ0�ĸ��ʣ�x(2)Ϊ״̬Ϊ1�ĸ���
end