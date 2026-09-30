theta = 52.5; % Angle from the x-axis
omega = 2.6615 * 10^-6; % Angular frequency of the moon's counter-clockwise rotations
init_pos = [0,3.7];
init_vel = 0.0066 * [cosd(theta), sind(theta)];
moon_pos = @(t) 222*[cos(omega*t), sin(omega*t)]; % Moon is in circular motion about the Earth's centre
t = linspace(0, 200000, 20000); % dt = 10
[tout, pos] = simulate_rocket_improved_euler(init_pos, init_vel, moon_pos, t); % Finding the rocket's trajectory
hold on % Plotting all on one graph
th = 0:pi/50:2*pi; % One revolution of the circles and their resolution
xunit_E = 3.7 * cos(th);
yunit_E = 3.7 * sin(th);
sz = size(tout);
f = @(V, i) V(1, i); % Defining a lambda function so that it becomes easier to obtain elements from other evaluations of lambda functions with an array output type
xunit_M = cos(th) + f(moon_pos(tout(1,sz(1,2))),1);
yunit_M = sin(th) + f(moon_pos(tout(1,sz(1,2))),2); % Finiding the moon's final position
plot(xunit_E, yunit_E); % Circle representing the Earth
plot(xunit_M, yunit_M); % Circle representing the Moon in it's final position
plot(pos(:,1), pos(:,2)) % Rocket's trajectory
axis equal % Setting axes to an equal scale
xlabel("Distance from Earth (Moon-radii)")
ylabel("Distance from Earth (Moon-radii)")
title("Rocket launched from y-axis at an angle of 52.5 degrees from x-axis for an orbiting moon")
hold off
