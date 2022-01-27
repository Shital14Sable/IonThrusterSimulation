clc
clear


%% Defining the simulation data:
sim_data = SimulationData;
sim_const = Simulation_constants;

i = 1772;

res = sim_data.res; % How much 1 mm is converted into.
Test = sim_data.Test_no;
lengthX = 15;
lengthY = 15;
Nx = lengthX *res;
Ny = lengthY *res;
folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\';
V = csvread([folder_name 'Voltage_Sampling_Case_' num2str(i) '.csv']);

Ex = csvread([folder_name 'Test_conv' num2str(i) 'Ex' '.csv']);
Ey = csvread([folder_name 'Test_conv' num2str(i) 'Ex' '.csv']);

E = (Ex.^2 + Ey.^2);

x = (1:Nx);
y = (1:Ny); 
%    Contour Display for electric potential
figure(1)

contour(x,y,E,5000,'linewidth',0.5);
axis([min(x) max(x) min(y) max(y)]);
colorbar('location','eastoutside','fontsize',14);
xlabel('x-axis in mesh nodes','fontsize',14);
ylabel('y-axis in mesh nodes','fontsize',14);
title('Electric Potential distribution','fontsize',13);
h1=gca;
set(h1,'fontsize',14);
fh1 = figure(1); 
set(fh1, 'color', 'white')