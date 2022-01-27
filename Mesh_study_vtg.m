clc
clear all

%% Voltage Matrix Generation
itrerations_values = 50:50:50000;
for itr = 816:900
%     case_nos = [351];
%     case_nos = [854,624,351,514,402];
%     i = case_nos(itr);
    i = itr;
    %     %% Make sure code is starting
    %     t = now;
    %     d = datetime(t,'ConvertFrom','datenum');
    %     writematrix(d,'ITSTARTED!')
    %% Folder name:
    sim_data = SimulationData;
    Test_no = sim_data.Test_no;
    sim_data.Itr_no = itrerations_values(itr);
    sim_data.res = 100;
%     test_case_path = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\ExistingThrusters\';

    % Path of the grid configuration information
    test_case_path = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\Iterations_Study\';
    sim_const = Simulation_constants;
%     sim_data.lengthX = 10;
%     sim_data.lengthY = 10;
    
    %% Optimixzation Loop
    tStart = tic;
     thruster_test = ['Sampling_Case_' num2str(1)];
%      thruster_test = 'RIT_XT';
     
    thruster_test_path = [test_case_path  thruster_test];
    thruster_data = access_data(thruster_test_path);
%      thruster_data.Gap(2) = 0.25;
    [V, O_m, Grid] = Voltage_Matrix_Generation_conv(thruster_data, sim_data, i);
    %     writematrix(V, ['C:\Users\shita\Box\DSPG_HPC\Topology_generation_Cluster\Test_output_files\Voltage_HPC_new_test' num2str(i) '.csv']);
    
    % Path for the storage for output files
    output_folder_path = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\Iterations_Study\' ;
    writematrix(V, [output_folder_path 'Voltage_' 'Sampling_Case_' num2str(i) '.csv']);
    writematrix(toc, [output_folder_path 'Voltage_' 'Sampling_Case_' num2str(i) '.txt']);
    toc
    clearvars -except i itrerations_values
end
