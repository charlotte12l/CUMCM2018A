%% III. II,IV层厚度的最优化之求解Tmax和t_44
%环境温度80℃
%总时间 30分钟
%II层：0.6-25mm IV层：0.6-6.4mm I+III层：4.2mm
%% 初始条件设置
Te=80;    %环境温度
total_time = 1800;     %总时间
dt = 0.0025;
dx = 0.0001;
c1 = 1.98499*10^(-7);
c2 = 2.043973*10^(-7);
c3 = 1.761611*10^(-7);
c4 = 1.5478*10^(-6);
r1 = c1*dt/(dx^2);
r2 = c2*dt/(dx^2);
r3 = c3*dt/(dx^2);
r4 = c4*dt/(dx^2);
s1 = 1-2*r1;
s2=1-2*r2;
s3=1-2*r3;
s4=1-2*r4;
k1=0.082;
k2=0.37;
k3=0.045;
k4=0.028;
L1=1:20;       %单位mm
L2=1:6;        %单位mm
%结果
Tmax=zeros(20,6);
t_44=zeros(20,6);
%% a为间隔
for u=1:20
    for v=1:6
        L0 = 0.0042+(u+v)*0.001;       %总的厚度，单位m
        num1 = L0/dx;
        num2 = total_time/dt;
        m = round(num1+1);
        n = num2+1;
        T = zeros(n,m);     %下标从1开始,时间*长度
        T(:,1) = Te;        %所有的时间，初始位置温度
        T(:,m) = 37;        %所有时间，最左侧温度
        T(1,2:m) = 37;      %时间为0时，除0处所有点的温度
        boundary1 = 7,boundary2 = (0.6+u)*10+1,boundary3 = (4.2+u)*10+1;
        for j=2:n         %时间
            for i=2:(m-1)       %长度
                if i<boundary1
                   T(j,i)=s1*T(j-1,i)+r1*(T(j-1,i-1)+T(j-1,i+1));
                end
                if i>boundary1 & i<boundary2
                   T(j,i)=s2*T(j-1,i)+r2*(T(j-1,i-1)+T(j-1,i+1));
                end
                if i>boundary2 & i<boundary3
                   T(j,i)=s3*T(j-1,i)+r3*(T(j-1,i-1)+T(j-1,i+1));
                end
                if i>boundary3
                   T(j,i)=s4*T(j-1,i)+r4*(T(j-1,i-1)+T(j-1,i+1));
                end
            end
            %计算边界的数值
            T(j,boundary1) = (k1*T(j,boundary1-1)+k2*T(j,boundary1+1))/(k1+k2);
            T(j,boundary2) = (k2*T(j,boundary2-1)+k3*T(j,boundary2+1))/(k3+k2);
            T(j,boundary3) = (k3*T(j,boundary3-1)+k4*T(j,boundary3+1))/(k3+k4);
        end
        %皮肤外侧的位置
        skin_pos = round((L0-0.0022)/dx+1);
        for k=1:n
            if T(k,skin_pos)>=44
               time=(n-k)/400/60;      %单位分钟
               t_44(u,v)=time;
               break;
            end
        end
        Tmax(u,v)=T(n,skin_pos);
    end
end
