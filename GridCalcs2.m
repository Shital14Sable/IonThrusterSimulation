function grid_points = GridCalcs(apts,grids,gridThick,AptDiam,Gap,lengthX, lengthY,res, voltage, folder_name, Test)
%This function takes in specs for ion accelerator grids and apts
%And spits out the points where the apts and grids are located


%% X direction

m = 1; %Counter for the grids
x(1) = Gap(1).*res; %The first value is equal to the gap thickness
for i = 1:grids*2-1
 
    if mod(i,2)==1 %If we just added a gap, then add a grid thickness
        x(i+1) = x(i)+(gridThick(m)).*res;
        m = m+1;
    else %If we just added a grid thickness, then add a gap thickness
        x(i+1) = x(i)+(Gap(m)).*res;
    end
end

%% Y direction

%Find the y coordinates
for n = 1:grids
    %Calculate how much space is used by the apertures
    %Use this to find the grid height
    gridHeight1 = (lengthY-(AptDiam(n)*apts))./(apts); %length of the X direction - the gap length / the number of grids
    gridHeight2 = (lengthY-(AptDiam(n)*apts))./(2*apts);
    y(n,1) = 1;
    y(n,2) = (gridHeight2).*res;
    for j = 3:(apts+1)*2
        
    if mod(j,2)==1 %If we just added a grid height, add an apt diameter

        y(n, j) = y(n,j-1)+ (AptDiam(n)).*res;
    else %If we just added an apt diameter, add a grid height
        if j == (apts+1)*2
            y(n,j) = y(n,j-1) + (gridHeight2).*res;
        else
            y(n,j) = y(n,j-1) + (gridHeight1).*res;
        end
    end
    end
end
%% output: Each grid has its own sheet
%This function also outputs a .xls file
%Each grid has its own sheet of coordinates
%Each row is the coordinates for one square
%The number of rows is the number of squares per grid
%The number of sheets is the number of grids
% x = flip(x);
% y = flip(y);
grid_points = {};

for g = 1:grids %amount of sheets
    sheet = g;

    %Titles for the columns
    names = {'X1','Y1','X2','Y2','voltage'};
    
    X1 = ones(apts+1,1).*x(2*g-1);                        %Column 1
    Y1 = y(g,1:2:end)';                                    %Column 2
    X2 = ones(apts+1,1).*x(2*g);                          %Column 3
    Y2 = y(g,2:2:end)';                                    %Column 4
    V  = ones(apts+1,1).*voltage(g);                      %Column 5
    
    
    %Create a table of the values
    %Tab = table(X1,Y1,X2,Y2,V,'VariableNames',names);
    Tab = [Y1,X1,Y2,X2,V];
    %Write the table to the .xls file
    writematrix(Tab,[folder_name '\Test' num2str(Test) 'Gridvals.xls'],'Sheet',sheet)
    grid_points{g} = Tab;
end



