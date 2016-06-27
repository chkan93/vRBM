N = 80;
load ./mat_data/criticality.mat

for i = 1:length(critorder)
    export_data(strcat('generated_data/', 'critorder.',num2str(i),'.',num2str(N),'.txt'), ...
        generate_criticality(critorder{i}, N),  0);
end