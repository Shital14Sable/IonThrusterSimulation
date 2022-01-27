clc
clear all

%% Include the function line

%% Input Parameters for Modifiation

% No of Particles
no_of_particles = 50;

% Input mass flow rate
mass_flow_rate = 2.375e-9;

%% Variable Langmuir sheth

% No. of Iterations for convergence
no_of_iterations = 50000;

%% User Name 
user_name = 'shita';
tic
%% Voltage Matrix Generation

for itr = 1:1406
    i = itr;
        %% Folder name:
    sim_data = SimulationData;
    Test_no = sim_data.Test_no;
    sim_data.Itr_no = no_of_iterations;
    sim_data.res = 100;
    
    test_case_path = ['C:\Users\' user_name '\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\ExistingThrusters\'];
    sim_const = Simulation_constants;
    sim_const.qi = no_of_particles;
    
    tStart = tic;
%     thruster_test = ['Sampling_Case_' num2str(i)];
    thruster_test ='RIT_XT';
    thruster_test_path = [test_case_path  thruster_test];
    thruster_data = access_data(thruster_test_path);
    
    [V, O_m, Grid] = Voltage_Matrix_Generation_conv(thruster_data, sim_data, i);
    output_folder_path = ['C:\Users\' user_name '\Box\Simulation\Integrated Code\OutputFiles\Prototype_engine_test\'];
%     writematrix(V, [output_folder_path 'Voltage_' thruster_test '.csv']);
    toc
    %% Optimixzation Loop
    data_record = load('Prototype_engine_test.mat');
    data_record = data_record.data_record;
    thruster_data.m_dot = mass_flow_rate;
    
    [NPos_x, NPos_y, ~, Vel_x, Ex, Ey]  = Primary_Trajectory_Generation(V, sim_data, thruster_data, output_folder_path, Grid, i);

    %% Thrust Calculation
    figure_m = plot_fig(Ex, Ey, thruster_data, Grid, NPos_x, NPos_y, output_folder_path, i);
    [thrust_total, ~] = Thrust_Calculation(Vel_x, NPos_x, thruster_data, output_folder_path, Grid, Test_no, sim_data);
%     thrust_total =  thrust_total * thruster_data.total_apts;
    combined_struct = merge_structs(struct(thruster_data), struct(sim_const), struct(sim_data));
    combined_struct.case_no = num2str(i);
    combined_struct.thrust = thrust_total;
    
    %% Calculate the number of particles that crossed the second grid:
  %  remaining_no_particles = CalculateParticles(NPos_x, NPos_y);

    %% Save the Data to a struct
    data_record = [data_record, combined_struct];
    save('Prototype_engine_test', 'data_record');
    close all hidden
    %% Time required for the loop
    toc
    
    %% Clear Memeory
    clearvars -except i
end