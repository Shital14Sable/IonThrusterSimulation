function merged_structs = merge_structs(data_record, sim_const, sim_data)
data_record_t = struct2table(data_record);
sim_const_t = struct2table(sim_const);
sim_data_t = struct2table(sim_data);

merge_tables = [data_record_t, sim_const_t, sim_data_t];

merged_structs = table2struct(merge_tables);