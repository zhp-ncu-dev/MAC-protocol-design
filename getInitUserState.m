function userState = getInitUserState(Nu, x)
%% ����̬�������û�������������ݰ�
    p = rand(1, Nu);
    userState = ( p > x(1) );
end