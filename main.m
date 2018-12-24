%% 网络参数初始化
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

%% 稳态概率
alpha=0.1;
beta=0.9;
A=[alpha,beta-1;1,1];B=[0;1];
x=inv(A)*B; %x(0)为状态为0的概率，x(1)为状态为1的概率

%% 仿真程序参数初始化
total_times=100;%仿真次数
PDR=zeros(1,total_times);

%% 
for k=1:total_times
    SFs=10000;  %总的帧数
    reward=zeros(1,Nu); %奖励初始化
    user_state=zeros(1,Nu); %用户状态（1-有数据包传输，0-无数据包传输）
    ans_transmission_success=0;
    b=0;N=0;
    % 按稳态概率在用户中随机生成数据包
    for i=1:Nu
        p(i)=rand(1);
        if p(i)>x(1)
            user_state(i)=1;
            N=N+1;
        else
            user_state(i)=0;
         
        end
    end
    %users的奖励从大到小
    for i=1:Nu
        dis(i)=unidrnd(50)/10;%用户在半径为5的园内均匀分布
        reward(i)=(exp((-dis(i)^(-zeta))/SNR));
        [C,index]=sort(reward,'descend'); %C矩阵：奖励从大到小排列，index：对应指标集
    end
    %第一个SF内的传输情况
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

%% 计算包传率
total_PDR=0;
for k=1:total_times
    total_PDR= PDR(k)+total_PDR;
end
average_PDR=total_PDR/total_times;  %仿真100次的数据包传率





