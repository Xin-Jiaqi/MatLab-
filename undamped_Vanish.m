clear
A=0.1;%力幅

k=6;

l=1;%绳长
x0=2*l/k;%施力点位置
%Hz=50;%交变电流频率
%omega=2*pi*Hz;
lambda=0.52*10^(-3)/0.9902;%线密度
F=100;%张力
a=sqrt(F/lambda);%波速
omega0=pi*a/l;%基频
omega=pi+k*omega0;
b=0.1;%空气摩擦系数

% omegak=sqrt(k^2*omega0^2-b^2/4);
% omega=sqrt(omegak^2+b*omegak);

tfinal=2*abs(pi/(omega-k*omega0));%观测时间
% tfinal=abs(pi/(omega-k*omega0))/100;
dt=0.01;%时间步长
dx=0.01;%质元长度

pic_num = 1;
% M=moviein(tfinal/dt);
x=0:dx:l;
fig = figure;
for t=0:dt:tfinal
    U=zeros(1,length(x));%每一时刻的质元排列
    for n=1:100
        U=U+2*A*sin(n*pi*x0/l)*omega/(lambda*(n^2*omega0^2-omega^2))*(sin(omega*t)...
            /omega-sin(omega0*n*t)/(n*omega0))*sin(n*pi*x/l);
    end
    plot(x,U,'k',x0/2,0,'k*',2*x0/2,0,'ko',3*x0/2,0,'k*',4*x0/2,0,'k*',5*x0/2,0,'k*')
    axis([0,1,-0.5,0.5])
    xlabel('琴弦质元分布x/m')
    ylabel('振动幅度U/m')
%     title(['$\omega\approx $'  num2str(k)  '$\omega_0$'],'interpreter','latex','Fontsize',20)
%     text(.2 ,-0.2,['驻波频率' num2str(2*pi*((omega+omega0*k)/2)) 'Hz'],'Fontsize',16)
    title('k=6时，外力作用在琴弦3等分处时，泛音消失','Fontsize',20)
    text(x0/3*2,-0.06,'外力作用点','Fontsize',16)

    drawnow
    M=getframe(fig);
    C{pic_num}=frame2im(M);
    pic_num = pic_num + 1;
end

for idx=1:pic_num
    [B,map]=rgb2ind(C{idx},256);
    if idx == 1
        imwrite(B,map,'test.gif','gif', 'Loopcount',inf,'DelayTime',0.06);
    else
        imwrite(B,map,'test.gif','gif','WriteMode','append','DelayTime',0.06);
    end
end

    
    