function remaining_no_particles = CalculateParticles(NPos_x, NPos_y,  thruster_data, cell_grids)


%% Inputs
%NPos_x,NPos_y - full trajectories of all particles
%grids - number of grids = n 
%apts - number of apertures = m
apts = thruster_data.Apt_nos;
grids = thruster_data.Grid_nos;
%cell_grids - a nxm cell full of 1x4 columns of the points that make up
        %each grid 
        %For example: 
        %                 grid 1        grid 2
        % Aperture 1 {[X1;Y1;X2;Y2],[X3;Y3;X4;Y4];
        % Aperture 2  [X1;Y1;X2;Y2],[X3;Y3;X4;Y4]}


% %% Plot everything (comment this out if you don't want to plot
% subplot(1,2,1)
% for o = 1:size(NPos_x,1)
%     plot(NPos_x(o,:),NPos_y(o,:),'-')
%     hold on
% end
% hold on
total_particals = size(NPos_x,1);
remaining_no_particles = 0;

%% Remove trajectories that go into the grids
% gridsX, gridsY
%NPos_x, NPos_y
%Create a function
%It will mostly go into accel grid
%check x coord first - If x is within range, then check y data
%Stop it comepletely if it enters the grid

    for n = 1:apts %Number of grids
        for m = 1:grids %number of apertures

            %Find the coordinates for the grids
            gridsX1 = cell_grids{m}(n,1);                               %X1
            gridsY1 = cell_grids{m}(n,2);                               %Y1
            gridsX2 = cell_grids{m}(n,3);                               %X2
            gridsY2 = cell_grids{m}(n,4);                               %Y2
            gridsX3 = cell_grids{m}(n+1,1);                             %X3
            gridsX4 = cell_grids{m}(n+1,3);                             %X4

            for i = 1:size(NPos_x,1)%Run through the number of particles

                run = 1; %Enter the while loop
                j=1;  %Start with the first positon of the particle
                while run == 1 && j < size(NPos_x,2)%Run as long as the particle stays outside of the grids

                    if NPos_x(i,j) > gridsY1 && NPos_x(i,j) < gridsY2 && NPos_y(i,j) < gridsX2  && NPos_y(i,j) > gridsX1 %Compare first grid values
                        for k = j:size(NPos_x,2)
                            %Make the rest of the values in the array zero
                            NPos_x(i,k) = 0;
                            NPos_y(i,k) = 0;
                        end
                        run = 0; %End the while loop once the particle enters the grids
                        remaining_no_particles = remaining_no_particles + 1;
                    elseif NPos_x(i,j) > gridsY1 && NPos_x(i,j) < gridsY2 && NPos_y(i,j) > gridsX3 && NPos_y(i,j) < gridsX4
                        for k = j:size(NPos_x,2)
                            %Make the rest of the values in the array zero
                            NPos_x(i,k) = 0;
                            NPos_y(i,k) = 0;
                        end
                        run = 0; %End the while loop once the particle enters the grids
                        remaining_no_particles = remaining_no_particles + 1;
                    end
                    j = j+1;
                    
                end
                
            end
        end
    end
remaining_no_particles = total_particals - remaining_no_particles;
end