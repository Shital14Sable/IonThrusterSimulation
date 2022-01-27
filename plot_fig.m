function [FigH, distribution] = plot_fig(Ex, Ey, thruster_data, Grid,  NPos_x, NPos_y, folder_name, Test_no)
    Nx = size(Ex,1);
    Ny  = size(Ex,2);
    E = sqrt(Ex.^2+Ey.^2);

    x = (1:Ny);
    y = (1:Nx);
    
    apts = thruster_data.Apt_nos;
    grids = thruster_data.Grid_nos;

%   Quiver Display for electric field Lines
     FigH = figure;
    contour(x,y,E,'linewidth',0.5);
    hold on, quiver(x,y,Ex,Ey,2)
    title(['Trajectoy Map of Example ' num2str(Test_no)], 'fontsize',12);
    colorbar('location','eastoutside','fontsize',12);
    xlabel('X Co-ordinates','fontsize',12);
    ylabel('Y Co-ordinates','fontsize',12);
    caxis([min(min(E)) max(max(E))])
    %title('Electric field Lines, E (x,y) in V/m','fontsize',14);
    axis([min(x) max(x) min(y) max(y)]);
    % colorbar('location','eastoutside','fontsize',14);
    % xlabel('x-axis','fontsize',14);
    % ylabel('y-axis','fontsize',14);
    h3=gca;
    set(h3,'fontsize',14);

    [NPos_x, NPos_y] = Remove_Paths_In_Grids(NPos_x,NPos_y,grids,apts,Grid);
    distribution = particle_distribution(NPos_x,NPos_y,grids,apts,Grid);
    
    for s = 1:size(NPos_x,1)
        [pos_cellX{s}, pos_cellY{s}] = Post_process(NPos_x(s,:), NPos_y(s,:));
    end
    
    for i = 1:size(NPos_x,1)
        plot(pos_cellX{i}, pos_cellY{i},'Color', 'r')
    end
    
    hold off
    
    saveas(FigH,[folder_name '\Test' num2str(Test_no) '_Sim_image' '.png']);
    
    close all
end
