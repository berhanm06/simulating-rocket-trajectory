function [ tout , pos ] = simulate_rocket_euler ( init_pos , init_vel , moon_pos , t)
% Author: Berhan Merha-Tsidk , Date: 05/03/2025
% 
% Simulate the rocket trajectory with the Earth and Moon influence. The coordinate
% used in this function is centred at Earth’s centre (i.e. Earth centre at (0,0) )
% and scaled in Moon−radius.
% 
% The simulation uses the euler method and finishes when it simulates for the whole t, or the rocket landed
% on the Moon.
% 
% Input:
% ∗ init_pos: 2−elements vector (x, y) indicating the initial position of the rocket.
% ∗ init_vel: 2−elements vector (vx, vy) of the initial velocity of the rocket.
% ∗ moon_pos: a function that receives time, t, and return a 2−elements vector (x, y)
% (see hint) indicating the Moon position relative to Earth.
% ∗ t: an N−elements vector of the time step where the position of the rocket will be
% returned.
%
% Output:
% ∗ tout: an M−elements vector of the time step where the position is described,
% if the rocket does not land on the Moon, M = N.
% ∗ pos: (M x 2) matrix indicating the positions of the rocket as function of time,
% with the first column is x and the second column is y.
% 
% Example use:
% >> init_pos = [0, 3.7];
% >> init_vel = 0.0066 * [cosd(89.9), sind(89.9)];
% >> moon_pos = @(t) [0, 222];
% >> t = linspace(0, 10000, 1000);
% >> [tout, pos] = simulate_rocket(init_pos, init_vel, moon_pos, t);
% >> plot(pos(:,1), pos(:,2));
M_M = 1;
M_E = 83.3;
R_M = 1;
R_E = 3.7;
G = 9.63 * 10^-7; % Defining the gravitational constant and the masses and radii of the earth and moon in units of moon radius and mass
x = init_pos(1,1);
y = init_pos(1,2);
vx = init_vel(1,1);
vy = init_vel(1,2); % Assigning initial positions and velocities
f = @(V, i) V(1, i); % Defining a lambda function so that it becomes easier to obtain elements from other evaluations of lambda functions with an array output type
ax = @(x, y, t) -G * M_E * ((x^2+y^2)^(-3/2)) * x - G * M_M * (norm([x, y] - moon_pos(t))^-3) * (x-f(moon_pos(t), 1));
ay = @(x, y, t) -G * M_E * ((x^2+y^2)^(-3/2)) * y - G * M_M * (norm([x, y] - moon_pos(t))^-3) * (y-f(moon_pos(t), 2)); % Defining lambda function for acceleration in the x/y direction using Newton's law of gravitation
sz = size(t);
for i = 1:sz(1,2) % Repeating this procedure to find the position of the rocket with discrete steps in time
    if norm([x, y] - moon_pos(t(1,i))) < R_M 
        break
    end
    if x^2 + y^2 < R_E % Checking if the rocket collides with the earth/moon's surface
        break
    end
    pos(i, 1) = x;
    pos(i, 2) = y; % Adding the current position to the pos array, which holds the rocket's positions at every step in time
    if i > sz(1,2)-1 % Checking if the time is outside of the region which is given in the function input, t
        break
    end
    dt = t(1,i+1) - t(1,i); % Defining the discrete change in time
    vx = vx + dt * ax(x,y,t(1,i));
    vy = vy + dt * ay(x,y,t(1,i));
    x = x + dt * vx;
    y = y + dt * vy; % Integrating twice using euler's method
    tout(1,i) = t(1,i); % Adding the current time to the tout array, which holds each time in which the rocket hasn't collided with earth/moon's surface
end
end
