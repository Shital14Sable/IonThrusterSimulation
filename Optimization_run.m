% function Optimization_run(m)
%This code will optimize the specs for the grid
clc
clear
%% Make sure code is starting
% t = now;
% d = datetime(t,'ConvertFrom','datenum');
% writematrix(d,'ITSTARTED!')
%% Folder name:
% sim_data = SimulationData;
% Test_no = sim_data.Test_no;
%folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\';
%sim_const = Simulation_constants;

%% Initialize Data set to record
% test_case_path = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\16June\';
% thruster_test = [test_case_path 'Sampling_Case_' num2str(1)];
% thruster_data = access_data(thruster_test);
% data_record = struct(thruster_data); % Make Data Record

%% Optimixzation Loop




%% Combining two Structs
% data_record = merge_structs(struct(thruster_data), struct(sim_const), struct(sim_data));
% data_record.thrust = 0;
% data_record.case_no = 0;

for i = 1
    % Path of the grid configuration information
    test_case_path =  'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\Existing Thru\';
    data_record = load('Prototype_engine_test.mat');
    data_record = data_record.data_record;
%     particle_distribution = load('Particle_Distribution_ISD.mat');
%     particle_distribution = particle_distribution.particle_distribution;
    sim_data = SimulationData;
    sim_data.res = 100;
    Test_no = sim_data.Test_no;
    tStart = tic;
    thuster_test = ['Sampling_Case_' num2str(1)];
    thruster_test_path = [test_case_path thuster_test];
    thruster_data = access_data(thruster_test_path);
    thruster_data.m_dot = 2.375e-9;
    
        % Path for the storage for output files
    output_folder_path = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\Prototype_engine_test\';
%   [folder_name 'Voltage_Conv'  num2str(i) '.csv'];
    sim_const = Simulation_constants;
    if isfile([output_folder_path 'Voltage_Sampling_Case_' num2str(i) '.csv'])
        V = csvread([output_folder_path 'Voltage_Sampling_Case_' num2str(i) '.csv']);
    else
        continue
    end
    
    Grid = GetGridValues(thruster_data, sim_data);
    
    [NPos_x, NPos_y, ~, Vel_x, Ex, Ey]  = Primary_Trajectory_Generation(V, sim_data, thruster_data, output_folder_path, Grid, i);
    

    %% Thrust Calculation
    
    [figure_m, distribution] = plot_fig(Ex, Ey, thruster_data, Grid, NPos_x, NPos_y, output_folder_path, i);
%     local_distribution = struct('Distribution_Matrix', distribution, 'Case_no', i);
%     particle_distribution = [particle_distribution , local_distribution]; 
%     save('Particle_Distribution_ISD', 'particle_distribution');
    [thrust_total, ~] = Thrust_Calculation(Vel_x, NPos_x, thruster_data, output_folder_path, Grid, Test_no, sim_data);
%     thrust_total =  thrust_total * thruster_data.total_apts;
    combined_struct = merge_structs(struct(thruster_data), struct(sim_const), struct(sim_data));
    combined_struct.case_no = i;
    combined_struct.thrust = thrust_total;
  %  remaining_no_particles = CalculateParticles(NPos_x, NPos_y,  thruster_data, Grid);
    
    data_record = [data_record, combined_struct];
    tEnd = toc(tStart);
    save('Prototype_engine_test', 'data_record');
%     writematrix(tEnd, [output_folder_path 'Time_trajectory_mapping_' num2str(i)]);
    close all hidden
    clearvars -except i
    i
end


%% Make sure the code finished
%writematrix(thrust_record, [output_folder_path 'Thrust_data_new.csv']);

%writematrix(grid_data, [output_folder_path 'Grid_data_new.csv']);
% t = now;
% d = datetime(t,'ConvertFrom','datenum');
% writematrix(d,'ITWORKED!')
  