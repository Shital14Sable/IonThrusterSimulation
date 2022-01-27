clc
clear all

user_pc = 'shita';
case_nos = [2603,2991,2697,2629,153,3032];
for itr = 1:6
    close all
    mesh_itr = case_nos(itr);
    folder_name = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\Prototype_engine_test\'];
    thruster_test = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\Prototype_Engine_2\' 'Sampling_case_' num2str(mesh_itr)];
    thruster_data = access_data(thruster_test);
    sim_data = SimulationData;
    Grid = GetGridValues(thruster_data, sim_data);
    %% Read The Data
    NPos_x = csvread([folder_name '\Test_conv_' num2str(mesh_itr) 'NPos_x.csv']);  % Reads the generated Trajectory matrix of a given name
    NPos_y = csvread([folder_name  '\Test_conv_' num2str(mesh_itr) 'NPos_y.csv']);  % Reads the generated Trajectory matrix of a given name
%     time_step = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'TimeStep.csv']);  % Reads the generated Time Step matrix of a given name
    Vx_new = csvread([folder_name '\Test_conv_' num2str(mesh_itr) 'Vx.csv']);  % Reads the generated Velocity matrix of a given name
%     Ex = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ex.csv']);  % Reads the generated Velocity matrix of a given name
%     Ey = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ey.csv']);  % Reads the generated Velocity matrix of a given name
    %Plot and save the figure
%     figure_m = plot_fig_for_paper(Ex, Ey); %, thruster_data, Grid, NPos_x, NPos_y, folder_name, mesh_itr

    apts = thruster_data.Apt_nos;
    grids = thruster_data.Grid_nos;


    % Plot and save the trajectories
%     [NPos_x, NPos_y] = Remove_Paths_In_Grids(NPos_x,NPos_y,grids,apts,Grid);
    
    s = 1;
    st = ceil(5*s + 1);
    while st < size(NPos_x,1)
        [pos_cellX{s}, pos_cellY{s}] = Post_process(NPos_x(st,:), NPos_y(st,:));
        s = s+1;
        st = 5*s + 1;
    end
    
%     out_folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudy\Image_Generation\';
    
    cmap = jet;
    multiColorLine(pos_cellX, pos_cellY,Vx_new,cmap, folder_name, mesh_itr)
end