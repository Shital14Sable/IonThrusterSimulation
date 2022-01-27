function FigH = plot_fig_for_paper(Ex, Ey) %, thruster_data, Grid,  NPos_x, NPos_y, folder_name, Test_no
    Nx = size(Ex,1);
    Ny  = size(Ex,2);

    x = (1:Ny);
    y = (1:Nx);
    close all


    % Electric field Magnitude
    E = sqrt(Ex.^2+Ey.^2);
    disp('3');

    % Display for electric field Lines
    figure(2)
    contourf(x,y,E,'linewidth',1);
    hold on, quiver(x,y,Ex,Ey,1)
    title('Electric field Lines, E (x,y) in V/m','fontsize',10);
    axis([min(x) max(x) min(y) max(y)]);
    colorbar('location','eastoutside','fontsize',10);
    xlabel('x-axis in no of mesh','fontsize',10);
    ylabel('y-axis in no of mesh ','fontsize',10);
    h3=gca;
    set(h3,'fontsize',14);
    FigH = figure(2);
    set(FigH, 'color', 'white')

%     apts = thruster_data.Apt_nos;
%     grids = thruster_data.Grid_nos;
% 
%     % Quiver Display for electric field Lines
%     FigH = figure;
%     contour(x,y,E,'linewidth',0.5);
%     hold on, quiver(x,y,Ex,Ey,15)
%     %title('Electric field Lines, E (x,y) in V/m','fontsize',14);
%     axis([min(x) max(x) min(y) max(y)]);
%     % colorbar('location','eastoutside','fontsize',14);
%     % xlabel('x-axis','fontsize',14);
%     % ylabel('y-axis','fontsize',14);
%     h3=gca;
%     set(h3,'fontsize',14);
%     V = csvread([folder_name 'Voltage_Sampling_Case_' num2str(Test_no) '.csv']);
%     FigH = heatmap(V,'Colormap',jet);
%     Ax = gca;
%     Ax.GridVisible = 'off';
%     Ax.ColorLimits = [-1000 1000];
%     Ax.Title = ['Heatmap of Voltage Itr ' num2str(Test_no)];

    
%     saveas(FigH,[folder_name '\Test' num2str(Test_no) '_Sim_image_for_paper' '.png']);
%     close all
%     
%     new_img = imread([folder_name '\Test' num2str(Test_no) '_Sim_image_for_paper' '.png']);
%     imshow(new_img);
%     hold on ;

%     [NPos_x, NPos_y] = Remove_Paths_In_Grids(NPos_x,NPos_y,grids,apts,Grid);
%     
%     for s = 1:size(NPos_x,1)
%         [pos_cellX{s}, pos_cellY{s}] = Post_process(NPos_x(s,:), NPos_y(s,:));
%     end
%     
%     for i = 1:size(NPos_x,1)
%         plot(pos_cellX{i}, pos_cellY{i}, 'LineWidth',2, 'Color', '#D95319')
%     end
%     
%     Ax.XDisplayLabels = nan(size(Ax.XDisplayData));
%     Ax.YDisplayLabels = nan(size(Ax.YDisplayData));

%     saveas(FigH,[folder_name '\Test' num2str(Test_no) '_Sim_image_for_paper' '.png']);
%     close all
end
