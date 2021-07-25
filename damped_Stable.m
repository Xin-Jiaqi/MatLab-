pic_num = 1;
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
    axis([0,1,-0.5,0.5]);
    xlabel('琴弦质元分布x/m')
    ylabel('振动幅度U/m')
    title([num2str(k) '次泛音共振'],'Fontsize',20)
    text(.02,.27,['有阻尼时振幅不再趋于无穷，为'...
        num2str(abs(2*A*sin(k*pi*x0/l)/(lambda*l*(2*b*omegak+b^2)))),'m'],'Fontsize',16)
    drawnow
    M=getframe(fig);
    C{pic_num}=frame2im(M);
    pic_num = pic_num + 1;
end

for idx=1:pic_num
    [B,map]=rgb2ind(C{idx},256);
    if idx == 1
        imwrite(B,map,'test1.gif','gif', 'Loopcount',inf,'DelayTime',0.06);
    else
        imwrite(B,map,'test1.gif','gif','WriteMode','append','DelayTime',0.06);
    end
end