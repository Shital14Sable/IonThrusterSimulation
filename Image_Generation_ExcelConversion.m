clc
clear all

user_pc = 'shita';
for mesh_itr = 1772
    folder_name = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\'];
    disp('1');
    thruster_test = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\16June\Sampling_Case_' num2str(mesh_itr)];
    thruster_data = access_data(thruster_test);
    sim_data = SimulationData;
    Grid = GetGridValues(thruster_data, sim_data);
    
    %% Read The Data
    NPos_x = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'NPos_x.csv']);  % Reads the generated Trajectory matrix of a given name
    NPos_y = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'NPos_y.csv']);  % Reads the generated Trajectory matrix of a given name
    %     time_step = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'TimeStep.csv']);  % Reads the generated Time Step matrix of a given name
    Vx_new = csvread([folder_name '\Test' num2str(mesh_itr) 'Vx.csv']);  % Reads the generated Velocity matrix of a given name
    %     Ex = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ex.csv']);  % Reads the generated Velocity matrix of a given name
    %     Ey = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ey.csv']);  % Reads the generated Velocity matrix of a given name
    disp('2');
    
    %Plot and save the figure
    %     figure_m = plot_fig_for_paper(Ex, Ey); %, thruster_data, Grid, NPos_x, NPos_y, folder_name, mesh_itr
    
    apts = thruster_data.Apt_nos;
    grids = thruster_data.Grid_nos;
    
    
    % Plot and save the trajectories
    [NPos_x, NPos_y] = Remove_Paths_In_Grids(NPos_x,NPos_y,grids,apts,Grid);
    
    for s = 1:size(NPos_x,1)
        [pos_cellX{s}, pos_cellY{s}] = Post_process(NPos_x(s,:), NPos_y(s,:));
    end
    
    all_x = [];
    all_y = [];
    t = 1;
    pt = 10*t + 1;
    while pt < size(NPos_x,1)
        A =  pos_cellX{10*t + 1};
        [A, d1] = get_unique_values(A);
        A = A(1:20:end);
        
        B =  pos_cellY{10*t + 1};
        B = B(d1);
        B = B(1:20:end);

        all_x = [all_x A];
        all_y = [all_y B];
        t = t + 1;
        pt = 10*t + 1;
    end
end
all_xy = [all_x' all_y'];

output_folder = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\Images_for_report\CSV_Data';

writematrix(all_xy, [output_folder '\Test_conv_' num2str(mesh_itr) 'All_xy.csv']) % writes the generated Trajectory matrix to a given name
