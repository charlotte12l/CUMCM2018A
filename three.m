%plot(result1,result2,'r')
%title('������ʵ�����ݶԱ�ͼ')
%hold on
%plot(result1,result3,'b')
%mse = (result3-result2).^2;
%plot(result1,mse)
%title('�������')
x=1.1:0.1:1.5;
y=3.1:0.1:3.5;
% [x_new,y_new]=meshgrid(x,y);
% �����������
x_new=repmat(x,5,1);
y_new=repmat(y',1,5);
