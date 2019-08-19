%% в╙бжел
function pop_temp=roulette(population_ini,fit)
N=size(population_ini); 
fitmin=abs(min(fit));
fit=fitmin+fit;
S=sum(fit);
for i=1:N
    SI=S*rand(1);
    for j=1:N
        if SI<=sum(fit(1:j)) 
            pop_temp(i,:)=population_ini(j,:);
            break
        end
    end
end
end