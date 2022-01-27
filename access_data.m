function thruster_values = access_data(thruster_name)
    data_file = [thruster_name '.txt'];
    fid = fopen(data_file,'rt');
    if fid < 0
        error(['Error opening the file' thruster_name '.txt'])
    end
    % Read file as a string for each line
    
    sngl_line = fgets(fid);
    data_t{1} = sngl_line;
    
    i = 2;
    sngl_line = fgets(fid);
    while ischar(sngl_line)
        data_t{i} = extractNumFromStr(sngl_line);
        sngl_line = fgets(fid);
        i = i+1;
    end
    fclose(fid);
    thruster_values = Thruster_Data;
    thruster_values.Name = data_t{2};
    thruster_values.Grid_nos = data_t{2};
    thruster_values.Apt_nos = data_t{3};
    thruster_values.Voltage = data_t{4};
    thruster_values.GridThick = data_t{5};
    thruster_values.AptDiam = data_t{6};
    thruster_values.Gap = data_t{7};
    thruster_values.m_dot = data_t{8};
    thruster_values.total_apts = data_t{9};
end 
