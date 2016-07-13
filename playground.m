% %%% test 64bit sigmoid
% sum = uint64(2^63);
% scale = 2^60;
% s = limitbit(logisticXX(-1/scale, 'PLAN'), 0, 1/scale) * (scale-1);
% fprintf('\n\n\n')
% fprintf('# %d => %d\n', -1, uint64(s));
% 
% for i=0:63
%     s = limitbit(logisticXX(double(sum)/scale, 'PLAN'), 0, 1/scale) * (scale-1);
%     fprintf('# %d => %d\n', uint64(sum), uint64(s));
%     sum = uint64(sum/2)-1;
% end

importdata ./mat_data/power_stat_3.sum.csv

d = ans;

power_data_info = cell(1, 156);
for i=2:length(d.textdata)
    x.adder = d.textdata{i, 2};
    cid = d.data(i-1, 2);
    if cid > 5
        cid = 0;
    end
    x.cid = cid;
    x.cnum = d.data(i-1, 1);
    
   x.power = d.data(i-1,5);
   x.power_with_clocknet = d.data(i-1,4);
   x.slack = d.data(i-1, 3);
    power_data_info{i-1} = x;
end

save('./generated_data/power.mat','power_data_info','-v7.3')