%% III. �Ŵ��㷨Ѱ�����ź��
% population_size: ������Ⱥ��С
% chromosome_size: ����Ⱦɫ�峤��
% generation: �����������
% cross_rate: ���뽻�����
% mutate_rate: ����������
function ga()
population_size=100;        
generation=500;      
cross_rate=0.3;      
mutate_rate=0.05;       
chromosome_size=50;
iter=1; 
%% ���ɳ�ʼ��Ⱥ
population_ini=init(population_size,chromosome_size); 
[m,n]=size(population_ini);
%% ��������ͼ
%������Χ���˴�Ϊ����������II���IV��ĺ��
xmin=20;
xmax=25;
ymin=5;
ymax=6.4;
[x,y]=meshgrid(xmin:0.1:xmax,ymin:0.1:ymax);
x_mesh=x;
y_mesh=y;
z_mesh=target(x,y);
figure(1);
mesh(x_mesh,y_mesh,-z_mesh);%������άͼ��
hold on;
grid on;
%% ������Ӧ�ȣ���������ʼ��Ⱥͼ��
x=trans2to10(population_ini(:,1:25),xmin,xmax);
y=trans2to10(population_ini(:,26:50),ymin,ymax);
fit_func=target(x,y);
plot3(x,y,-fit_func,'k*');
title('Ⱦɫ��ĳ�ʼλ��');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
   
%ѭ������
fitness_average=[];
vx=[];
while iter<=generation
    iter=iter+1;
    pop_temp=roulette(population_ini,fit_func);
    % �������
    population_ini=crossover(pop_temp,cross_rate);
    % �������
    M=rand(m,n)<=mutate_rate;
    population_ini=population_ini-2.*(population_ini.*M)+M;
    x=trans2to10(population_ini(:,1:25),xmin,xmax);
    y=trans2to10(population_ini(:,26:50),ymin,ymax);
    fit_func=target(x,y);
    [best_fitness,best_individual]=max(fit_func);    
    population_ini(1,:)=population_ini(best_individual,:);
    fit_mean=mean(fit_func);    
    vx=[vx best_fitness];
    fitness_average=[fitness_average fit_mean];
end
%% �������ʾ
disp(sprintf('���Ž�[x,f(x)]:[%.4f,%.4f,%.4f]',x(best_individual),y(best_individual),-best_fitness));
figure(2);
mesh(x_mesh,y_mesh,-z_mesh);
hold on;
grid on;
plot3(x,y,-fit_func,'r*');
title('Ⱦɫ�������λ��');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');

figure(3);
plot(-vx);
title('������Ӧ����ƽ����Ӧ�ȵ�ͼ��');
xlabel('����');
ylabel('��Ӧ��');
hold on;
plot(-fitness_average,'r');
hold off;
end
