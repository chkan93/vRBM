%%% test 64bit sigmoid
sum = uint64(2^63);
scale = 2^60;
s = limitbit(logisticXX(-1/scale, 'PLAN'), 0, 1/scale) * (scale-1);
fprintf('\n\n\n')
fprintf('# %d => %d\n', -1, uint64(s));

for i=0:63
    s = limitbit(logisticXX(double(sum)/scale, 'PLAN'), 0, 1/scale) * (scale-1);
    fprintf('# %d => %d\n', uint64(sum), uint64(s));
    sum = uint64(sum/2)-1;
end