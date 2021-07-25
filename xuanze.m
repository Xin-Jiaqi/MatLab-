A=300;a=10;l=1;omega=50;x0=0.3;
x=[0:0.01:l];
for i=1:5000
    y=zeros(1,101);
    for k=1:100
        y=y+A*omega*sin(k*pi*x0/l)/(l*(omega^2-k^2*pi^2*a^2/l^2))...
            *(sin(omega*i/500)/omega+l*sin(k*pi*a*i/(500*l))/(k*pi*a))...
            /(k*pi*a/(omega*l)-omega*l/(k*pi*a))*sin(k*pi*x/l);
    end
    plot(x,y);grid on;axis([0,1,-2,2])
    pause(0.01);
end