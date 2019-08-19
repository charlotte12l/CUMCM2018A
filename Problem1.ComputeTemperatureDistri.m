%% I. ��ַ������¶ȷֲ�
%���ȵ�λͳһΪ��
%ʱ�䵥λͳһΪ��
L0 = 0.0152;              %֯���ܺ��
total_time = 5400;        %������ʱ��
dt = 0.0025;
dx = 0.0001;
num1 = L0/dx;
num2 = total_time/dt;
%% II. ϵ���ļ���
%ϵ����c = k/�ܶ�/����
c1 = 1.98499*10^(-7);
c2 = 2.043973*10^(-7);
c3 = 1.761611*10^(-7);
c4 = 1.5478*10^(-6);
r1 = c1*dt/(dx^2);
r2 = c2*dt/(dx^2);
r3 = c3*dt/(dx^2);
r4 = c4*dt/(dx^2);
s1 = 1-2*r1;
s2 = 1-2*r2;
s3 = 1-2*r3;
s4 = 1-2*r4;
k1 = 0.082;
k2 = 0.37;
k3 = 0.045;
k4 = 0.028;
T = zeros(153,2160001);     %�±��1��ʼ
T(:,1) = 37;
T(153,:) = 37;
T(1,2:2160001) = 75;
%����֯��ı߽�
boundary1 = 7,boundary2 = 67,boundary3 = 103;
%% III. ���������¶�
for j=2:num2+1         %ʱ��
    for i=2:num1       %����
        if i<boundary1
           T(i,j)=s1*T(i,j-1)+r1*(T(i-1,j-1)+T(i+1,j-1));
        end
        if i>boundary1 & i<boundary2
           T(i,j)=s2*T(i,j-1)+r2*(T(i-1,j-1)+T(i+1,j-1));
        end
        if i>boundary2 & i<boundary3
           T(i,j)=s3*T(i,j-1)+r3*(T(i-1,j-1)+T(i+1,j-1));
        end
        if i>boundary3
           T(i,j)=s4*T(i,j-1)+r4*(T(i-1,j-1)+T(i+1,j-1));
        end
    end
    %����߽����ֵ
    T(boundary1,j) = (k1*T(boundary1-1,j)+k2*T(boundary1+1,j))/(k1+k2);
    T(boundary2,j) = (k2*T(boundary2-1,j)+k3*T(boundary2+1,j))/(k3+k2);
    T(boundary3,j) = (k3*T(boundary3-1,j)+k4*T(boundary3+1,j))/(k3+k4);
end
T=T';
