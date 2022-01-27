function Grid_values = GetGridValues(thrstr_data, sim_data)
apts = thrstr_data.Apt_nos;
grids = thrstr_data.Grid_nos;
voltage = thrstr_data.Voltage;
gridThick = thrstr_data.GridThick; %mm
AptDiam = thrstr_data.AptDiam; %mm
Gap = thrstr_data.Gap; %mm

res = sim_data.res; % How much 1 mm is converted into. 
Test = sim_data.Test_no;
lengthX = sim_data.lengthX;
lengthY = sim_data.lengthY;

%% Get grid points
Grid_values = Grid_pnt_Calc(apts,grids,gridThick,AptDiam,Gap,lengthX,lengthY,res, voltage, Test);
end
