testvalue=zeros(1,10);%����ÿ�ηֻ�����ֵ
Tmax=zeros(1,10);     %����ÿ��ѭ��ʱTmax�¶�
t44=zeros(1,10);      %����ÿ��ѭ��ʱt44ʱ��
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
k1 = 0.082;
k2=0.37;
k3=0.045;
k4=0.028;
total_time = 3600;
flag=1;
amin=6;    %���ַ������½磬��ʼΪ0.6mm
amax=250;  %���ַ������Ͻ磬��ʼΪ25mm
count=1;

while flag==1
a=round((amin+amax)/2);      %ȡ������ֵ��Ϊ�ж�����
L0 = 0.0097+a*0.0001;
num1 = L0/dx;
num2 = total_time/dt;

T = zeros(1440001,98+a);     %�±��1��ʼ
T(:,1) = 65;
T(:,98+a) = 37;
T(1,2:(97+a)) = 37;

boundary1 = 7;boundary2 = 7+a,boundary3 = 43+a;
for j=2:num2+1         %ʱ��
    for i=2:(97+a)       %����
    %����������¶ȷֲ�    
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
    %����߽���¶ȷֲ�
    T(j,boundary1) = (k1*T(j,boundary1-1)+k2*T(j,boundary1+1))/(k1+k2);
    T(j,boundary2) = (k2*T(j,boundary2-1)+k3*T(j,boundary2+1))/(k2+k3);
    T(j,boundary3) = (k3*T(j,boundary3-1)+k4*T(j,boundary3+1))/(k3+k4);
end

testvalue(1,count)=a;

for k=1:1440001
if T(k,75+a)>=44
t44(1,count)=k;
break
end
end

if t44(1,count)==0
    t44(1,count)=1440001;
end
Tmax(1,count)=T(1440001,75+a);
%���·ֻ�����
if (t44(1,count)>1320000)&(Tmax(1,count)<47)
    amax=a;
else amin=a;
end
count=count+1;
%�ж���ֹ����������ѭ��
if (amax-amin)==1
    flag=0;
end

end