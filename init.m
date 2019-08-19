%% 初始化种群
% population_size: 输入种群大小
% chromosome_size: 输入染色体长度
function v=init(population_size,chromosome_size)
v=round(rand(population_size,chromosome_size));
end
%%
