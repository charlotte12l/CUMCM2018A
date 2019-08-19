%% III. 遗传算法寻找最优厚度
% population_size: 输入种群大小
% chromosome_size: 输入染色体长度
% generation: 输入迭代次数
% cross_rate: 输入交叉概率
% mutate_rate: 输入变异概率
function ga()
population_size=100;        
generation=500;      
cross_rate=0.3;      
mutate_rate=0.05;       
chromosome_size=50;
iter=1; 
%% 生成初始种群
population_ini=init(population_size,chromosome_size); 
[m,n]=size(population_ini);
%% 画出网格图
%变量范围，此处为两个变量：II层和IV层的厚度
xmin=20;
xmax=25;
ymin=5;
ymax=6.4;
[x,y]=meshgrid(xmin:0.1:xmax,ymin:0.1:ymax);
x_mesh=x;
y_mesh=y;
z_mesh=target(x,y);
figure(1);
mesh(x_mesh,y_mesh,-z_mesh);%画出三维图形
hold on;
grid on;
%% 计算适应度，并画出初始种群图形
x=trans2to10(population_ini(:,1:25),xmin,xmax);
y=trans2to10(population_ini(:,26:50),ymin,ymax);
fit_func=target(x,y);
plot3(x,y,-fit_func,'k*');
title('染色体的初始位置');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
   
%循环操作
fitness_average=[];
vx=[];
while iter<=generation
    iter=iter+1;
    pop_temp=roulette(population_ini,fit_func);
    % 交叉操作
    population_ini=crossover(pop_temp,cross_rate);
    % 变异操作
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
%% 结果的显示
disp(sprintf('最优解[x,f(x)]:[%.4f,%.4f,%.4f]',x(best_individual),y(best_individual),-best_fitness));
figure(2);
mesh(x_mesh,y_mesh,-z_mesh);
hold on;
grid on;
plot3(x,y,-fit_func,'r*');
title('染色体的最终位置');
xlabel('x');
ylabel('y');
zlabel('f(x,y)');

figure(3);
plot(-vx);
title('最优适应度与平均适应度的图像');
xlabel('代数');
ylabel('适应度');
hold on;
plot(-fitness_average,'r');
hold off;
end
