function distribution = particle_distribution(NPos_x,NPos_y,grids,apts,cell_grids)

[NPos_x,NPos_y] = Remove_Paths_In_Grids(NPos_x,NPos_y,grids,apts,cell_grids);
% NPos_x = round(NPos_x);
% NPos_y = round(NPos_y);
m = grids; %Number of grids
distribution = zeros(15,1);
% count_particles = struct('X_position','0', 'Y_position','0', 'particle_no','0');
sim_data = SimulationData;
sim_data.res = 100;
mesh_size = sim_data.res;
part_no = 1;
count_particles = [];

for n = 1:apts %number of apertures
    %Find the coordinates for the grids
    gridsX1 = cell_grids{m}(n,1);                               %X1
    gridsY1 = cell_grids{m}(n,2);                               %Y1
    gridsX2 = cell_grids{m}(n,3);                               %X2
    gridsY2 = cell_grids{m}(n,4);                               %Y2
    gridsX3 = cell_grids{m}(n+1,1);                             %X3
    gridsX4 = cell_grids{m}(n+1,3);                             %X4
    
    local_particle = zeros(1,2);
    for m = 1:size(NPos_x,1)%Run through the number of particles
        local_row_x = NPos_x(m, :);
        local_row_y = NPos_y(m, :);
        indiii = find(local_row_x > (gridsY2 + (3*mesh_size)));
        if  ~isempty(indiii)
            indiii = indiii(1,1);
            %                 local_particle = struct;
            local_particle(1,1) = local_row_x(1, indiii);
            local_particle(1,2) = local_row_y(1, indiii);
            local_particle(1,3)= part_no;
            count_particles = [count_particles; local_particle];
            part_no = part_no + 1;
        end
    end
end

if isempty(count_particles)
    distribution = 0;
else
    for ecc = 1:15
        study_col = count_particles(:,2);
        study_col = study_col(study_col > (ecc-1)*100);
        if isempty(study_col)
            continue
        else
            study_col = study_col(study_col<= ecc*100);
        end
        distribution(ecc,1) = size(study_col,1)/(100*100);
    end
end

end