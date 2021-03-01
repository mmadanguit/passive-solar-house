% This function will output the average temperature for each wall and
% absorber thickness. 

% Inputs:
%   L_abs_range: ranges of thicknesses of absorber in m
%   L_wall_range: ranges of thicknesses of walls in m
%   k_wall: conductivity of walls in W/m*K

% Outputs:
%   L_sweep: matrix containing thickness of absorber, thickness of walls, and corresponding T_avg 
%   L_abs_optimal: optimal thickness of absorber in m
%   L_wall_optimal: optimal thickness of wall in m
%   T_optimal: temperature at optimal 

function [L_sweep,L_abs_optimal,L_wall_optimal] = optimal(L_abs_range,L_wall_range,k_wall)
    
    L_sweep = zeros(size(L_abs_range,2)*size(L_wall_range,2),3); % Initialize output matrix
    i = 1; % Initialize row value 
    
    T_optimal = 20; % Optimal indoor temperature in Celsius
    d_optimal = 10; % Initialize optimal difference between optimal and indoor temperature
    
    t_span = 7*24*60*60; % Calculate temperatures over a period of 7 days
    
    for L_abs = L_abs_range % Sweep through absorbers thickness values
        for L_wall = L_wall_range % Sweep through wall thickness values
            
            L_sweep(i,1) = L_abs; % Store absorber thickness value
            L_sweep(i,2) = L_wall; % Store wall thickness value
            
            [t,T,T_avg] = temp(L_abs,L_wall,k_wall,t_span); % Calculate indoor temperature given thickness values
            L_sweep(i,3) = T_avg; % Store average temperature value

            if abs(T(end,1)-T(50,1)) < 1 % Determine if fluctuation has normalized within time period
                d = abs(T_avg-T_optimal); % Calculate difference between optimal and average temperature
                if d < d_optimal % Check if current difference is better than stored difference
                    L_abs_optimal = L_abs; % Store optimal absorber thickness
                    L_wall_optimal = L_wall; % Store optimal wall thickness
                    d_optimal = d; % Set optimal difference
                end 
            end
            
            i = i+1; 
            
        end
    end
end