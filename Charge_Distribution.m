clc 
clear all

%-------------------------------------------------------------------------%
%                           LOADING THE INPUT FILES
%-------------------------------------------------------------------------%
folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\';
thruster_test = ['C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\16June\Sampling_Case_' num2str(1)];
%-------------------------------------------------------------------------%

V = csvread([folder_name 'Voltage_Sampling_Case_' num2str(1) '.csv']);
thruster_data = access_data(thruster_test);

sim_data = SimulationData;

Grid = GetGridValues(thruster_data, sim_data);

Nx = size(V, 1);
Ny = size(V, 2);
cd_mat = zeros(Nx, Ny);

%-------------------------------------------------------------------------%
pt1 = [Grid{1}(1,2),Grid{1}(1,3)+1];
pt2 = [Grid{1}(1,2),Grid{1}(1+1,1)-1];
[xn(1,:),yn(1,:)] = CircleSegment(pt1,pt2);


size_mat = size(yn, 2);



%-------------------------------------------------------------------------%
res = sim_data.res;
Node_factor = 1e-3 / res;
%-------------------------------------------------------------------------%

tar_bm_crt = 0.001; %Ampere
beam_current = sum(cd_mat(:, end));
sim_const = Simulation_constants;
Clmb_chrg = sim_const.e_charge;
del_x = sim_data.lengthX / Nx; %m
del_y = del_x; %m
A_cell = del_x * del_y; %m*m

%-------------------------------------------------------------------------%
sim_const = Simulation_constants;
qi = sim_const.qi;
e_charge = sim_const.e_charge;
del_t = sim_data.del_t;
eps = sim_const.eps;
m_Xe = sim_const.m_Xe; %kg
f_bohm = sim_const.f_bohm;
% v_bohm = f_bohm * sqrt(100* 1.60217662e-19 *3/(100 * 2.18017e-25));
v_bohm = sim_const.v_bohm;
Vx_in = v_bohm;
Vy_in = 0;

%-------------------------------------------------------------------------%
mesh_itr = 1;
%-------------------------------------------------------------------------%
%% Read The Data
NPos_x = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'NPos_x.csv']);  % Reads the generated Trajectory matrix of a given name
NPos_y = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'NPos_y.csv']);  % Reads the generated Trajectory matrix of a given name
time_step = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'TimeStep.csv']);  % Reads the generated Time Step matrix of a given name
Vx_new = csvread([folder_name '\Test' num2str(mesh_itr) 'Vx.csv']);  % Reads the generated Velocity matrix of a given name
Ex = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ex.csv']);  % Reads the generated Velocity matrix of a given name
Ey = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ey.csv']);  % Reads the generated Velocity matrix of a given name
%-------------------------------------------------------------------------%
a = 0;
b = 0;
c = 0;
d = 0;
std_time_step = 1e-10;
for p = 1: size(yn, 2)
    x = NPos_x(p,:);
    y = NPos_y(p,:);
    del_t = time_step(p,:);
    Vx = Vx_new(p,:);
    logInd = del_t ~= 0;
    x = x(logInd);
    y = y(logInd);
    del_t = del_t(logInd);
    Vx = Vx(logInd);
    for m = 1:size(x,2)
        x2 = ceil(x(m));
        y2 = floor(y(m));
        x3 = ceil(x(m));
        y3 = floor(y(m));
        i = ceil(y(m));
        j = ceil(x(m));
        if i == 0 || j == 0
            break
        elseif i > Ny || j > Nx
            break
        end
        cd_mat(i,j) = cd_mat(i, j) + (100 * Clmb_chrg/A_cell) - (a + b + c + d);
        J_part =  cd_mat(i, j) / del_t(m);
        a = cd_mat(i, j) + (qi * J_part * (del_t(m)) * 10^-16 * (x2- x(m))*(y2-y(m))/(A_cell * del_x * del_y))
        b = cd_mat(i, j) + abs((qi * J_part * (del_t(m)) * 10^-16 * (x3- x(m))*(y3-y(m))/(A_cell * del_x * del_y)));
        c = cd_mat(i, j) + abs((qi * J_part * (del_t(m)) * 10^-16 * (x2- x(m))*(y3-y(m))/(A_cell * del_x * del_y)));
        d = cd_mat(i, j) + abs((qi * J_part * (del_t(m)) * 10^-16 * (x3- x(m))*(y2-y(m))/(A_cell * del_x * del_y)));
        cd_mat(i, j) = a + b + c + d;
        beam_current = beam_current + (cd_mat(i, end-1) * Vx(end));
    end
    
end

%-------------------------------------------------------------------------%
%                       Writing Output File
%-------------------------------------------------------------------------%
%writematrix(cd_mat, [folder_name '\Test' num2str(Test) '_Chrg_distrb_Mat.csv'])  % writes the generated Charge distribution matrix to a given name
%-------------------------------------------------------------------------%

%         y1 = yn(1,p);
%         x1 = xn(1,p);
%         Vx_in = v_bohm;
%         Vy_in = 0;
%         [x, y, Vx_new, Vy_new,  del_t] = Path_Calculation(x1, y1, Ex, Ey, sim_data);
