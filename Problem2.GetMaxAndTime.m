%% III. II,IV���ȵ����Ż�֮���Tmax��t_44
%�����¶�80��
%��ʱ�� 30����
%II�㣺0.6-25mm IV�㣺0.6-6.4mm I+III�㣺4.2mm
%% ��ʼ��������
Te=80;    %�����¶�
total_time = 1800;     %��ʱ��
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
L1=1:20;       %��λmm
L2=1:6;        %��λmm
%���
Tmax=zeros(20,6);
t_44=zeros(20,6);
%% aΪ���
for u=1:20
    for v=1:6
        L0 = 0.0042+(u+v)*0.001;       %�ܵĺ�ȣ���λm
        num1 = L0/dx;
        num2 = total_time/dt;
        m = round(num1+1);
        n = num2+1;
        T = zeros(n,m);     %�±��1��ʼ,ʱ��*����
        T(:,1) = Te;        %���е�ʱ�䣬��ʼλ���¶�
        T(:,m) = 37;        %����ʱ�䣬������¶�
        T(1,2:m) = 37;      %ʱ��Ϊ0ʱ����0�����е���¶�
        boundary1 = 7,boundary2 = (0.6+u)*10+1,boundary3 = (4.2+u)*10+1;
        for j=2:n         %ʱ��
            for i=2:(m-1)       %����
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
            %����߽����ֵ
            T(j,boundary1) = (k1*T(j,boundary1-1)+k2*T(j,boundary1+1))/(k1+k2);
            T(j,boundary2) = (k2*T(j,boundary2-1)+k3*T(j,boundary2+1))/(k3+k2);
            T(j,boundary3) = (k3*T(j,boundary3-1)+k4*T(j,boundary3+1))/(k3+k4);
        end
        %Ƥ������λ��
        skin_pos = round((L0-0.0022)/dx+1);
        for k=1:n
            if T(k,skin_pos)>=44
               time=(n-k)/400/60;      %��λ����
               t_44(u,v)=time;
               break;
            end
        end
        Tmax(u,v)=T(n,skin_pos);
    end
end
