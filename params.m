clear
A=5;%力幅

k=5;

l=1;%绳长
x0=l/k+l/9;%施力点位置
%Hz=50;%交变电流频率
%omega=2*pi*Hz;
lambda=0.52*10^(-3)/0.9902;%线密度
F=100;%张力
a=sqrt(F/lambda);%波速
omega0=pi*a/l;%基频
omega=pi/0.5+k*omega0;
b=0.1;%空气摩擦系数

% omegak=sqrt(k^2*omega0^2-b^2/4);
% omega=sqrt(omegak^2+b*omegak);

tfinal=2*abs(pi/(omega-k*omega0));%观测时间
% tfinal=abs(pi/(omega-k*omega0))/100;
dt=0.01;%时间步长
dx=0.01;%质元长度


