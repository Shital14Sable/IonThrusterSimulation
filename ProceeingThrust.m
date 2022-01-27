% Processing Thrust Data
clc
clear all
thrust_data= zeros(1,800);
test_case_path = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\';
data_collect = [];
thruster_data_record = load('C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudy\All_thruster_data.mat ');
thruster_data_record = thruster_data_record.data_record;
sim_const = Simulation_constants;
avg_velocity_data = zeros(1,800);
sim_data = SimulationData;
qi = sim_const.qi;
qi_const = 3^(log10(qi));


for i = 201:1000
   % sim_data.res = 500;
    thruster_test =  ['C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\16June\Sampling_Case_' num2str(i)];
    thruster_data = access_data(thruster_test);
    thrust_data(i-200) = thruster_data_record(i+1).thrust;
    data_set = zero_padding(thruster_data);
    data_collect = [data_collect; data_set];
end

thrust_data = thrust_data*81.01;
thrust_data = 2.93e-10*(thrust_data/1.4744e-10);