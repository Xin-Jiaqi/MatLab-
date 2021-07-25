clear
A=0.1;%力幅

k=6;

l=1;%绳长
x0=l/k+l/9;%施力点位置
%Hz=50;%交变电流频率
%omega=2*pi*Hz;
lambda=0.52*10^(-3)/0.9902;%线密度
F=100;%张力
a=sqrt(F/lambda);%波速
omega0=pi*a/l;%基频
omega=pi+k*omega0;
b=0.1;%空气摩擦系数

omegak=sqrt(k^2*omega0^2-b^2/4);
omega=sqrt(omegak^2+b*omegak);

% tfinal=2*abs(pi/(omega-k*omega0));%观测时间
tfinal=abs(pi/(omega-k*omega0))/100;
dt=0.01;%时间步长
dx=0.01;%质元长度

pic_num = 1;
% M=moviein(tfinal/dt);
x=0:dx:l;
fig = figure;
level=zeros(1,length(x))+abs(2*A*sin(k*pi*x0/l)/(lambda*l*(2*b*omegak+b^2)));

for t=0:dt:tfinal
    U=zeros(1,length(x));%每一时刻的质元排列
    for n=1:100
        omegan=sqrt(n^2*omega0^2-b^2/4);
        U=U+2*A*sin(n*pi*x0/l)/(lambda*l*(b^2+omega^2-omegan^2+b^2*omegan^2/...
            (omega^2-omegan^2)))*sin(omega*t)*sin(n*pi*x/l);
    end
    plot(x,U,'k',x,level,'r',x,-level,'r');
    axis([0,1,-0.5,0.5])
    xlabel('琴弦质元分布x/m')
    ylabel('振动幅度U/m')
        title([num2str(k) '次泛音共振'],'Fontsize',20)
    text(.02,.35,['有阻尼时振幅不再趋于无穷，为'...
        num2str(abs(2*A*sin(k*pi*x0/l)/(lambda*l*(2*b*omegak+b^2)))),'m'],'Fontsize',16)
%     title(['$\omega\approx $'  num2str(k)  '$\omega_0$'],'interpreter','latex','Fontsize',20)
%     text(.2 ,-0.2,['驻波频率' num2str(2*pi*((omega+omega0*k)/2)) 'Hz'],'Fontsize',16)
%     title('k=4时，外力作用在琴弦4等分处时，泛音消失','Fontsize',20)

    drawnow
    M=getframe(fig);
    C{pic_num}=frame2im(M);
    pic_num = pic_num + 1;
end

for idx=1:pic_num
    [B,map]=rgb2ind(C{idx},256);
    if idx == 1
        imwrite(B,map,'testOne.gif','gif', 'Loopcount',inf,'DelayTime',0.06);
    else
        imwrite(B,map,'testOne.gif','gif','WriteMode','append','DelayTime',0.06);
    end
end