% This function calculates both resistance networks based on the thickness 
% of the absorber and the thickness of the wall.

% Inputs:
%   L_abs: thickness of absorber in m
%   L_wall: thickness of walls in m
%   k_wall: conductivity of walls in W/m*K

% Outputs:
%   C_ins: heat capacity of inside air in J/K
%   C_abs: heat capacity of absorber in J/K
%   R_1: thermal resistance for heat transfer from absorber to inside air
%   R_2: thermal resistance for heat transer from inside air to outside air

function [C_ins,C_abs,R_1,R_2] = cons(L_abs,L_wall,k_wall)

    R_cond = @(L,k,A) L/(k*A);
    R_conv = @(h,A) 1/(h*A);

    h_ins = 15; % heat transfer coefficient of indoor surfaces in W/m2*K
    h_out = 30; % heat transfer coefficient of outdoor surfaces in W/m2*K

    A_abs = 2*(5*5.1)+4*(5*L_abs); % surface area of absorber in m2 

    A_wind = 5*2.6; % surface area of window in m2 
	h_wind = 0.7; % heat transfer coefficient of window in W/m2*K

    A_wall = 5*(0.2+5.1+3+5.1+0.4); % surface area of inside walls in m2

    R_conv_abs = R_conv(h_ins,A_abs); % thermal resistance for heat convecting from absorber to inside air
    
    R_1 = R_conv_abs;

    R_conv_wind_ins = R_conv(h_ins,A_wind); % thermal resistance for heat convecting from inside air to window
    R_conv_wind = R_conv(h_wind,A_wind); % thermal resistance for heat convecting through window 
    R_conv_wind_out = R_conv(h_out,A_wind); % thermal resistance for heat convecting from window to outside air
    R_wind = R_conv_wind_ins+R_conv_wind+R_conv_wind_out;

    R_conv_wall_ins = R_conv(h_ins,A_wall); % thermal resistance for heat convecting from inside air to walls
    R_cond_wall = R_cond(L_wall,k_wall,A_wall); % thermal resistance for heat conducting through walls
    R_conv_wall_out = R_conv(h_out,A_wall); % thermal resistance for heat convecting from walls to outside air
    R_wall = R_conv_wall_ins+R_cond_wall+R_conv_wall_out;

    R_2 = 1/(1/R_wind+1/R_wall);

    d_ins = 1.2754; % density of inside air in kg/m3
    v_ins = 5*5.1*3; % volume of inside air in m3
    m_ins = d_ins*v_ins; % mass of inside air in kg
    c_ins = 1003.5; % specific heat of inside air in J/kg*K
    C_ins = m_ins*c_ins; % heat capacity of inside air in J/K

    d_abs = 3000; % density of absorber in kg/m3
    v_abs = 5*5.1*L_abs; % volume of absorber in m3
    m_abs = d_abs*v_abs; % mass of absorber in kg
    c_abs = 800; % specific heat of absorber in J/kg*K
    C_abs = m_abs*c_abs; % heat capacity of absorber in J/K

end
