%����ͬ��ȴ��¶ȵķֲ�ͼ��
new_one = zeros(5401,8);
a=[1 21 41 61 81 101 121 141]
for i=1:8
    new_one(:,i)=result(:,a(i));
    plot(0:5400,new_one(:,i))
    hold on
end

    