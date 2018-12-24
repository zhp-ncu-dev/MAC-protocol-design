%% ���������ʼ��
SPs=4;
rk=4;
Tf=16;
Lp=12;
Ts=12;
Np=1;
gama=0.8;
zeta=3;
SNR=20;
Nu=32;

%% ��̬����
alpha=0.1;
beta=0.9;
A=[alpha,beta-1;1,1];B=[0;1];
x=inv(A)*B; %x(0)Ϊ״̬Ϊ0�ĸ��ʣ�x(1)Ϊ״̬Ϊ1�ĸ���

%% ������������ʼ��
total_times=100;%�������
PDR=zeros(1,total_times);

%% 
for k=1:total_times
    SFs=10000;  %�ܵ�֡��
    reward=zeros(1,Nu); %������ʼ��
    user_state=zeros(1,Nu); %�û�״̬��1-�����ݰ����䣬0-�����ݰ����䣩
    ans_transmission_success=0;
    b=0;N=0;
    % ����̬�������û�������������ݰ�
    for i=1:Nu
        p(i)=rand(1);
        if p(i)>x(1)
            user_state(i)=1;
            N=N+1;
        else
            user_state(i)=0;
         
        end
    end
    %users�Ľ����Ӵ�С
    for i=1:Nu
        dis(i)=unidrnd(50)/10;%�û��ڰ뾶Ϊ5��԰�ھ��ȷֲ�
        reward(i)=(exp((-dis(i)^(-zeta))/SNR));
        [C,index]=sort(reward,'descend'); %C���󣺽����Ӵ�С���У�index����Ӧָ�꼯
    end
    %��һ��SF�ڵĴ������
    for j=1:Nu
        i=index(j);
        if b<Tf*Ts-Np*Lp-1
            if  user_state(i)==1
                b=b+Np*Lp+1;
                ans_transmission_success=ans_transmission_success+Np*reward(i);
                user_state_mark(i)=1;
            else
                b=b+1;
                user_state_mark(i)=0;
            end
        else
            user_state_mark(i)=-2;   
        end
    end
    PDR(k)= ans_transmission_success/N;
end

%% ���������
total_PDR=0;
for k=1:total_times
    total_PDR= PDR(k)+total_PDR;
end
average_PDR=total_PDR/total_times;  %����100�ε����ݰ�����





