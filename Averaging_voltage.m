folder_name = 'C:\Users\shita\Box\DSPG_HPC\Topology_generation_Cluster\Output_Files\';
avg_1 = [];
for i = 1:250
     V = csvread([folder_name 'Voltage_Conv'  num2str(i) '.csv']);
     avg_Vm = mean(V, 'All');
     avg_1 = [avg_1; avg_Vm];
end