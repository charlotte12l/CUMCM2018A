%%��Ⱦɫ��ת����ʮ���Ƶ���ֵ
function x=trans2to10(v,xymin,xymax)
v=fliplr(v); 
[s,c]=size(v); 
aux=0:1:c-1;   
aux=ones(s,1)*aux;
x1=sum((v.*2.^aux)');
x=xymin+(xymax-xymin)*x1./(2^c-1);
%���������Ǿ�����ֵ��ϵõ��ģ�����������뱣����λС��
for i=1:s
    x(i)=roundn(x(i),-2);
end
end
%%
