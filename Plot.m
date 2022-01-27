clc 
clear


load('Test') %Variable number for the test iteration'

thruster_test = 'RIT_XT';
folder_name = ['C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\Topology_Generation_Data\Test_Data\' thruster_test]; %change the location according to where you are running the test
% SG_data = round(table2array(readtable([folder_name '\Test' num2str(Test) '_Grid_points.xlsx'], 'Sheet', 1, 'Range','C1:G3'))); 
% pt1 = [SG_data(1,2),SG_data(1,3)+1];
% pt2 = [SG_data(1,2),SG_data(2,1)-1];
% 
% [h,xn,yn] = CircleSegment(pt1,pt2);
% size_mat = size(yn, 2);


V = csvread([folder_name '\Test' num2str(Test) '_VtgDistMat.csv']);
NPos_x = csvread([folder_name '\Test' num2str(Test) 'NPos_x.csv']);  
% NPos_x = reshape(NPos_x,[size(NPos_x,1)/size_mat, size_mat])'; 
NPos_y = csvread([folder_name '\Test' num2str(Test) 'NPos_y.csv']);
% NPos_y = reshape(NPos_y,[size(NPos_y,1)/size_mat, size_mat])';
NPos_x = NPos_x(:,1:300);
NPos_y = NPos_y(:,1:300);
% size1 = 6*10e-3/size(V, 1); % this variable is needed for interpolation, it is the grid size (e.g. 0.1 m)

Nx = size(V,1);
Ny  = size(V,2);
Ex = csvread([folder_name '\Test' num2str(Test) 'Ex.csv']);
Ey = csvread([folder_name '\Test' num2str(Test) 'Ey.csv']);

%%
apts = 5;
grids = 3;

%%
for k = 1:grids
    Grid{k} = round(table2array(readtable([folder_name '\Test' num2str(Test) 'Gridvals.xls'], 'Sheet', k)));
end


[NPos_x,NPos_y] = Remove_Paths_In_Grids(NPos_x,NPos_y,grids,apts,Grid);

%%

p_dim = size(NPos_x, 1);
pos_cellX = {};
pos_cellY = {};

for s = 1:p_dim
    [pos_cellX{s}, pos_cellY{s}] = Post_process(NPos_x(s,:), NPos_y(s,:));
end



% Electric field Magnitude

E = sqrt(Ex.^2+Ey.^2);
 
x = (1:Ny);
y = (1:Nx);

% Quiver Display for electric field Lines
figure(1)
contour(x,y,E,'linewidth',0.5);
hold on, quiver(x,y,Ex,Ey,2)
%title('Electric field Lines, E (x,y) in V/m','fontsize',14);
axis([min(x) max(x) min(y) max(y)]);
% colorbar('location','eastoutside','fontsize',14);
% xlabel('x-axis','fontsize',14);
% ylabel('y-axis','fontsize',14);
h3=gca;
set(h3,'fontsize',14);


if isfolder(folder_name)
    writematrix(Ex, [folder_name '\Test' num2str(Test) 'Ex.csv'])
    writematrix(Ey, [folder_name '\Test' num2str(Test) 'Ey.csv'])
    writematrix(NPos_x, [folder_name '\Test' num2str(Test) 'NPos_x.csv'])  % writes the generated Trajectory matrix to a given name
    writematrix(NPos_y, [folder_name '\Test' num2str(Test) 'NPos_y.csv'])  % writes the generated Trajectory matrix to a given name
    writematrix(time_step, [folder_name '\Test' num2str(Test) 'TimeStep.csv'])  % writes the generated Time Step matrix to a given name
    writematrix(Vx_new, [folder_name '\Test' num2str(Test) 'Vx.csv'])  % writes the generated Velocity matrix to a given name
else
    mkdir(fullfile(folder_name))
    writematrix(Ex, [folder_name '\Test' num2str(Test) 'Ex.csv'])
    writematrix(Ey, [folder_name '\Test' num2str(Test) 'Ey.csv'])
    writematrix(NPos_x, [folder_name '\Test' num2str(Test) 'NPos_x.csv']) % writes the generated Trajectory matrix to a given name
    writematrix(NPos_y, [folder_name '\Test' num2str(Test) 'NPos_y.csv'])  % writes the generated Trajectory matrix to a given name
    writematrix(time_step, [folder_name '\Test' num2str(Test) 'TimeStep.csv'])  % writes the generated Time Step matrix to a given name
    writematrix(Vx_new, [folder_name '\Test' num2str(Test) 'Vx.csv'])  % writes the generated Velocity matrix to a given name
end

