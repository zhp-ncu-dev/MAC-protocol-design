function userState = getInitUserState(Nu, x)
%% 按稳态概率在用户中随机生成数据包
    p = rand(1, Nu);
    userState = ( p > x(1) );
end