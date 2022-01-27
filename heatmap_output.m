clc
clear all


user_pc = 'shita';
case_nos = [2629,2697,2991,2508,2643,2654];
% case_nos = [351];
for itr = 1:21
    close all
    mesh_itr = case_nos(itr);
    tic
    
    
%     test_case_path = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\ExistingThrusters\'];
%      folder_name = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\June16\Examplefiles_VoltageMatrix\'];
     thruster_test = ['C:\Users\' user_pc '\Box\Simulation\OSU-DSPG\particleTest\LHS Sampling\Sampling_Cases\Prototype_Engine_2\' 'Sampling_case_' num2str(mesh_itr)];
     folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\Prototype_engine_test\';
%      V = csvread([folder_name '\Vol25K' 'RIT_XT' '.csv']);
    V = csvread([folder_name '\Voltage_Sampling_Case_'  num2str(mesh_itr) '.csv']);
%     Ex = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ex.csv']);
%     Ey = csvread([folder_name '\Test_conv' num2str(mesh_itr) 'Ey.csv']);
%     E = sqrt(Ex.^2 + Ey.^2);
     thrstr_data = access_data(thruster_test);
    sim_data = SimulationData;
    sim_const = Simulation_constants;
    sim_data.res = 100;

    %% Optimixzation Loop
%     thruster_test = 'RIT_XT';
%     thruster_test_path = [test_case_path  thruster_test];
%     thrstr_data = access_data(thruster_test_path);
    %% Set up grid Data
    apts = thrstr_data.Apt_nos;
    grids = thrstr_data.Grid_nos;
    voltage = thrstr_data.Voltage;
    gridThick = thrstr_data.GridThick; %mm
    AptDiam = thrstr_data.AptDiam; %mm
    Gap = thrstr_data.Gap; %mm
    
    %% Set up simulation data
    res = sim_data.res; % How much 1 mm is converted into.
    Test = sim_data.Test_no;
    lengthX = 15;
    lengthY = 15;
    Nx = lengthX *res;
    Ny = lengthY *res;
    
    %% Get grid points
    Grid = Grid_pnt_Calc(apts,grids,gridThick,AptDiam,Gap,lengthX,lengthY,res, voltage, Test);
    
    for cv = 1:apts
        pt1 = [Grid{1}(cv,2),Grid{1}(cv,3)+1];
        pt2 = [Grid{1}(cv,2),Grid{1}(cv+1,1)-1];
        [xn(cv,:),yn(cv,:)] = CircleSegment(pt1,pt2);
    end
    
    % Create a Overlay Matrix
%     O_m = zeros(Nx,Ny);
%     for r = 1:grids
%         for s = 1:apts+1
%             O_m(Grid{r}(s,1):Grid{r}(s,3), Grid{r}(s,2):Grid{r}(s,4)) = Grid{r}(s,5); % defines the potential on the grid
%         end
%     end
%     
%     for p = 1:apts+1
%         for w = 1:Grid{1}(1,3)
%             O_m(Grid{1}(p,1):ceil(Grid{1}(p,3)), 1:Grid{1}(1,2)) = 0 ; %Defines the potential behind the Grid
%         end
%     end
%     
%     
%     for h = 1:size(xn,1)
%         for vr = 1:size(xn,2)
%             O_m(yn(h,vr), 1:xn(h,vr)) = 0;  %Defines the potential at Sheath
%         end
%     end
% %     
% %     tm = (O_m ~= 0);
% %     V(tm) = 0;

    %%
    x = (1:Nx);
    y = (1:Ny); 
    
    
%         out_folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\Aug3\50K\';
%    Contour Display for electric potential
%     figure(1)
    
%     contour(x,y,V,10000,'linewidth',0.5);
%     axis([min(x) max(x) min(y) max(y)]);
%     colorbar('location','eastoutside','fontsize',14);
%     xlabel('x-axis in mesh nodes','fontsize',14);
%     ylabel('y-axis in mesh nodes','fontsize',14);
%     title('Electric Potential distribution','fontsize',13);
%     h1=gca;
%     set(h1,'fontsize',14);
%     fh1 = figure(1); 
%     set(fh1, 'color', 'white')
%     saveas(fh1,[folder_name '\Images_for_report\Electric_potential_image_' num2str(i) '.png']);
%     %% 
%     
%       figure(2)
%      h = heatmap(O_m, 'GridVisible','off', 'Colormap',parula, 'Title', ['Grid Configuration ' num2str(mesh_itr)]); 
%     Ax = gca;
%     Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%     Ax.YDisplayLabels = nan(size(Ax.YDisplayData));



    
    figure(3)
    h = mesh(V);
    colorbar('location','eastoutside','fontsize',14);
    xlabel('x-axis in mesh nodes','fontsize',14);
    ylabel('y-axis in mesh nodes','fontsize',14);
    title(['Voltage distribution '  num2str(mesh_itr)],'fontsize',14);
    view(0,90)
    saveas(h,[folder_name '\Voltage_Configuration_' num2str(mesh_itr) '.png']);

    toc
    clearvars -except itr user_pc case_nos
end