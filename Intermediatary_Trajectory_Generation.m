function [NPos_x, NPos_y, time_step, Vx_new, Ex, Ey] = Intermediatary_Trajectory_Generation(V, sim_data, thrstr_data, Grid)

%% LOADING THE INPUT FILES: Simulation Data
res = sim_data.res; % How much 1 mm is converted into. 
Test = sim_data.Test_no;
Nj = sim_data.Prtcl_steps;
%Variable number for the test iteration

%%                          LOADING THE INPUT FILES: Thruster Data
apts = thrstr_data.Apt_nos;


%%                      Calculating the Electric Potential Values
% V = csvread([folder_name '\Test' num2str(Test) '_VtgDistMat.csv']);
Node_factor = 1e-3 / res;
Nx = size(V,1);
Ny  = size(V,2);
Ex = zeros(Nx,Ny);
Ey = zeros(Nx,Ny);

for i = 3:Nx-2
    for j = 3:Ny-2
    Ex(i,j) = -(-V(i, j+2) + 8*V(i,j+1) - 8*V(i,j-1) + V(i,j-2))/(12*Node_factor);
    Ey(i,j) = -(-V(i+2, j) + 8*V(i+1,j) - 8*V(i-1,j) + V(i-2,j))/(12*Node_factor);
    end
end

%%                      Setting up the Initial Position of the particle

for i = 1:apts
    pt1 = [Grid{1}(i,2),Grid{1}(i,3)+1];
    pt2 = [Grid{1}(i,2),Grid{1}(i+1,1)-1];
    [xn(i,:),yn(i,:)] = CircleSegment(pt1,pt2);
end

no_partcls = apts * size(yn, 2);


%%                      Setting up Simulation Matrices
NPos_x = zeros(no_partcls ,Nj); % X position matrix to multiple trajectories
NPos_y = zeros(no_partcls ,Nj); % Y position matrix to multiple trajectories
time_step = zeros(no_partcls ,Nj);
Vx_new = zeros(no_partcls ,Nj);
Vy_new = zeros(no_partcls ,Nj);



part_no = 1;  %particle number
for g = 1:apts
    for itr = 1:size(yn, 2)
        [NPos_x(part_no,:), NPos_y(part_no ,:), Vx_new(part_no, :), Vy_new(part_no, :),  time_step(part_no,:)] = Path_Calculation(xn(g,itr), yn(g,itr), Ex, Ey, sim_data);
        part_no = part_no + 1;
    end
end