clear
clc
format short

%% Determine Community water requirement

Number_of_people = 5187;
Number_of_beds = 5;
Area_of_clinic_ground_floor = 250;

L_per_day_for_people = 3.5;
L_per_bed = 271;
L_per_m2 = 2.48;

Total_L_per_day_for_people = (Number_of_people)*(L_per_day_for_people);
L_per_day_for_bed = (Number_of_beds)*(L_per_bed);
L_per_day_for_clinic = (Area_of_clinic_ground_floor)*(L_per_m2) ;

Total_water_requirement = (Total_L_per_day_for_people)+(L_per_day_for_bed)+(L_per_day_for_clinic);



disp('Volume of water required per day is: (L/day)')
disp(Total_water_requirement)
%% Water Flow rate
Q_s = ((Total_water_requirement/24)*4)/14400; 

Q_m = Q_s/1000;

disp('Flow rate is: (L/s)')
disp(Q_s)

disp('Flow rate is: (m3/s)')
disp(Q_m)
%% Select pipe material
%Pipe material:Commercial Steel
%Pipe nomimal size:DN100
%Pipe schedule:40

Wall_thickness = 6.02/1000;
Outer_Diameter = 114.3/1000;
Inner_Diameter = (Outer_Diameter) - (2*Wall_thickness);

disp('Pipe internal diameter,ID1 is: (m)')
disp(Inner_Diameter)
%% Area of DN100 pipe
Area = (pi*(Inner_Diameter^2))/4;

disp('Area of DN100 pipe is: (m2)')
disp(Area)
%% Velocity of water in pipe
velocity = Q_m/Area;

disp('Velocity of water in pipe is: (m/s)')
disp(velocity)
%% Reynolds Number
rho = 998;
mu = 8.9e-4;

Re = ((rho)*(velocity)*(Inner_Diameter))/mu;

disp('Renolds number is: ')
disp(Re)
%% Friction Factor
Surface_Roughness = 0.09/1000;

if Re > 2000 %check if Re indicates turbulent flow
    %Use Haaland Correlation
    f = (1/(-1.8*log10(6.9/Re+(((Surface_Roughness)/(Inner_Diameter))/3.7)^1.11)))^2;
else
    %If Laminar flow, use Darcy equation
    f = 64/Re;
end

disp('Friction factor is: ')
disp(f)
%% Total Length for DN100 Pipe
L1 = 2.5+5+16+8+20+80+10+8+1+2.5+0.05;

disp('Total DN100 pipe length,L1 is: (m) ')
disp(L1)
%% Pipe loss for DN100 section
g=9.81;

pipe_loss=(f*L1*(velocity^2))/(2*(Inner_Diameter)*g);

disp('pipe loss_100 is: (m) ')
disp(pipe_loss)
%% Reduced pipe diameter
%Pipe 2 material:Commercial Steel
%Pipe 2 nomimal size:DN65
%Pipe 2 schedule:40

Wall_thickness2 = 5.16/1000;
Outer_Diameter2 = 73/1000;
Inner_Diameter_2 = (Outer_Diameter2) - (2*Wall_thickness2);

disp('Reduced pipe diameter,ID2 is: (m)')
disp(Inner_Diameter_2)
%% Fittings
D1 = Inner_Diameter;
D2 = Inner_Diameter_2;

Number_of_entrance = 1;
Number_of_90_Elbow = 3;
Number_of_Ball_valve = 5;
Number_of_Reducer = 1;

K_value_for_entrance = 0.75 ;
K_value_for_90_Elbow = 0.75 ;
K_value_for_Ball_valve = 9.87 ;
K_value_for_Reducer = (0.6+(0.48*f))*((D1/D2)^2)*(((D1/D2)^2)-1);

Total_K_for_entrance = (Number_of_entrance)*(K_value_for_entrance) ;
Total_K_for_90_Elbow = (Number_of_90_Elbow)*(K_value_for_90_Elbow);
Total_K_for_Ball_valve = (Number_of_Ball_valve)*(K_value_for_Ball_valve);
Total_K_for_Reducer = (Number_of_Reducer)*(K_value_for_Reducer);

Total_K1 = (Total_K_for_entrance)+(Total_K_for_90_Elbow)+(Total_K_for_Ball_valve)+(Total_K_for_Reducer);

fitting_loss=((velocity^2)*(Total_K1))/(2*g);

disp('K value for reducer is : ')
disp(K_value_for_Reducer)
disp('Total K1 value is : ')
disp(Total_K1)
disp('fitting loss_100 is : (m) ')
disp(fitting_loss)
