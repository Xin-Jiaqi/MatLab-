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
    plot(x,U,'k')
    axis([0,1,-0.5,0.5])
    xlabel('琴弦质元分布x/m')
    ylabel('振动幅度U/m')
    title(['琴弦拍频振幅变化周期为' num2str(abs(pi/(omega-k*omega0))) 's'],'Fontsize',20)

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

    
    