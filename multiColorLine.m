function multiColorLine(pos_cellX, pos_cellY,Vx_new,cmap, folder_name, mesh_itr)

for m = 1:2:size(pos_cellX,2)
    x_in = pos_cellX{m};
    y_in = pos_cellY{m};
    [x, y] = data_sorting(x_in, y_in);
    c = Vx_new(1:size(x_in,2));
    

    numPoints = numel(x);
    if nargin < 4
        cmap = spring;
    end

    cn = (c - min(c))/(max(c) - min(c));
    cn = ceil(cn* size(cmap,1));
    cn = max(cn,1);
    figure(10)
    set(gca,'Color','None')
    
    num1 = 50;
    for i = 1:numPoints-num1
        FigH = line(x(i:i+num1), y(i:i+num1), 'color', cmap(cn(i), :), 'linewidth', 0.5);
        hold on
    end

end
    title(['Trajectoy Map of Example ' num2str(mesh_itr)], 'fontsize',12);
    colorbar('location','eastoutside','fontsize',12);
    xlabel('X Co-ordinates','fontsize',12);
    ylabel('Y Co-ordinates','fontsize',12);
    caxis([min(min(Vx_new)) max(max(Vx_new))])
saveas(FigH,[folder_name 'Test' num2str(mesh_itr) '_trajectory_image' '.png']);