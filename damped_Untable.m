for t=0:dt:tfinal
    U=zeros(1,length(x));%每一时刻的质元排列
    for n=1:100
        omegan=sqrt(n^2*omega0^2-b^2/4);
        U=U+2*A*omega*sin(n*pi*x0/l)/(lambda*l*(b*omega^2+(omega^2-omegan^2)^2/b))...
            *(-(omega^2-omegan^2)/(b*omega)*sin(omega*t)+...
            (omega^2-omegan^2+b/2)/(b*omegan)*exp(-b*t/2)*sin(omegan*t))*sin(n*pi*x/l);
    end
    plot(x,U);axis([0,1,-200,200])
    pause(0.01);
end