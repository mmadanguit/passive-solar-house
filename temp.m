% This function calculates the average inside temperature over some period
% of time. 

% Inputs:
%   L_abs: thickness of absorber in m
%   L_wall: thickness of walls in m
%   k_wall: conductivity of walls in W/m*K
%   t_span: time span in s

% Outputs:
%   t: double containing time in s
%   T: double containing temperatures of inside air and absorber in Celsius
%   T_avg: average temperature of inside air in Celsius 

function [t,T,T_avg] = temp(L_abs,L_wall,k_wall,t_span)
    
    [C_ins,C_abs,R_1,R_2] = cons(L_abs,L_wall,k_wall); % calculate constants for ODEs
    T_out = @(t) -3+6*sin((2*pi*t)/(24*60*60)+3*pi/4); % model outdoor temperature as a sinusoidal wave
    A_wind = 5*2.6; % surface area of window in m2 
    Q_sun = @(t) (-361*cos(pi*t/(12*3600))+224*cos(pi*t/(6*3600))+210)*A_wind; % calculate Qin due to solar flux
    
    f = @(t,T) [(1/C_ins)*((T(2)-T(1))/R_1-(T(1)-T_out(t))/R_2); (1/C_abs)*(Q_sun(t)-(T(2)-T_out(t))/(R_1+R_2))]; % our system of ODEs
    
    [t,T] = ode45(f,[0 t_span],[0 23]); % calculate temperatures over 7 day period with initial conditions at 0 degrees Celsius
    
    T_avg = mean(T(:,1)); % calculate average temperature of inside air over 7 day period
    
end
