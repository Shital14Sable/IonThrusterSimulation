function data_record = save_loop_data(sim_data, thruster_data, sim_const, data_record)
sim_data = struct(sim_data);
thruster_data = struct(thruster_data);
sim_const = struct(sim_const);

data_record = [data_record, thruster_data];

end