%SUCCESS = xlswrite('C:\Users\asus\Desktop\result.xlsx',newT,'');
new = zeros(271,153);
for i=1:271
    j=1+(i-1)*20;
    new(i,:)=newT(j,:);
end
load('new.mat')
y=1:271;
x=1:153;
[X, Y] = meshgrid(x,y);
surf(X, Y, new)
title('�¶ȷֲ�')
xlabel('����/0.1mm')
ylabel('ʱ��/s')
zlabel('�¶�/��')
colorbar