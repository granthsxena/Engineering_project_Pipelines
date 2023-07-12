clear
clc

LT = 2.7;

h0 = 10.5;

h1 = 2;

rho = 998;

mu = 8.9e-4;

g =9.81;

Length = 1.35+5+6.25+4+4.7+5.7+0.5;

K = (5*0.75)+(1)+(1)+(0.75);

Q = 9/60000;

Wall_thickness = 5.49/1000;
Outer_Diameter = 88.9/1000;
Inner_Diameter = (Outer_Diameter) - (2*Wall_thickness)

Hydro = ((h0-h1)*rho*g)

Hydro_kPa = ((h0-h1)*rho*g)/1000

Area = (pi*(Inner_Diameter^2))/4

v = Q/Area

Velocity_loss = ((rho*(v)^2)/2)

Velocity_loss_kPa = ((rho*(v)^2)/2)/1000

Re = ((rho)*(v)*(Inner_Diameter))/mu

Surface_Roughness = 0.045/1000;

if Re > 2000 %check if Re indicates turbulent flow
    %Use Haaland Correlation
    f = (1/(-1.8*log10(6.9/Re+(((Surface_Roughness)/(Inner_Diameter))/3.7)^1.11)))^2
else
    %If Laminar flow, use Darcy equation
    f = 64/Re
end

pipeloss_m = ((f*Length*(v^2))/(2*Inner_Diameter*g));

pipeloss_kPa = ((rho*f*Length*(v^2))/(2*Inner_Diameter))/1000

fitting_loss_m = (((v^2)*K)/(2*g));

fitting_loss_kPa = ((rho*(v^2)*K)/(2))/1000

lv_g_m  = ((f*Length*(v^2))/(2*Inner_Diameter*g))  + (((v^2)*K)/(2*g))

P1_Pa = Hydro - Velocity_loss - (rho*(lv_g_m*g))+101325

P1_kPa = P1_Pa/1000

gauge_P_kPa = (P1_Pa -101325)/1000




