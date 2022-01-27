%% Plot RGB
folder_name = 'C:\Users\shita\Box\Simulation\OSU-DSPG\particleTest\MeshStudyDataOutput\';
for i = 1:50
    V = csvread([folder_name 'Voltage_Sampling_Case_' num2str(i) '.csv']);
    Grid = GetGridValues(thruster_data, sim_data);
    % Contour Display for electric potential
    Nx = size(V, 1);
    Ny = size(V,2);
    x = (1:Nx);
    y = (1:Ny);
    
    contour_range_V = -1501:0.5:1501;
    figure(1) = contour(x,y,V, contour_range_V,'linewidth',0.5);
    axis([min(x) max(x) min(y) max(y)]);
    colorbar('location','eastoutside','fontsize',14);
    xlabel('x-axis in mesh nodes','fontsize',14);
    ylabel('y-axis in mesh nodes','fontsize',14);
    title('Electric Potential distribution, V(x,y) in volts','fontsize',14);
    h1=gca;
    set(h1,'fontsize',14);
    fh1 = figure(1); 
    set(fh1, 'color', 'white')

end