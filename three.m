%plot(result1,result2,'r')
%title('计算与实验数据对比图')
%hold on
%plot(result1,result3,'b')
%mse = (result3-result2).^2;
%plot(result1,mse)
%title('均方误差')
x=1.1:0.1:1.5;
y=3.1:0.1:3.5;
% [x_new,y_new]=meshgrid(x,y);
% 构造坐标矩阵
x_new=repmat(x,5,1);
y_new=repmat(y',1,5);
