%%将染色体转换至十进制的数值
function x=trans2to10(v,xymin,xymax)
v=fliplr(v); 
[s,c]=size(v); 
aux=0:1:c-1;   
aux=ones(s,1)*aux;
x1=sum((v.*2.^aux)');
x=xymin+(xymax-xymin)*x1./(2^c-1);
%由于数据是经过插值拟合得到的，因此四舍五入保留两位小数
for i=1:s
    x(i)=roundn(x(i),-2);
end
end
%%
