%% �������
function v=crossover(pop_temp,cross_rate)
[N,L]=size(pop_temp);
C(:,1)=rand(N,1)<=cross_rate;
I=find(C(:,1)==1);
%������Խ��н������
for i=1:2:size(I)           
    if i>=size(I)       
        break;
    end
    %�ҵ������
    site=fix(1+L*rand(1));    
    temp=pop_temp(I(i,1),:);     
    pop_temp(I(i,1),site:end)=pop_temp(I(i+1,1),site:end);
    pop_temp(I(i+1,1),site:end)=temp(:,site:end);
end
v=pop_temp;
end        