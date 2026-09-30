theta = 50.5; % Angle from the x-axis
init_pos = [3.7,0];
init_vel = 0.0066 * [cosd(theta), sind(theta)];
moon_pos = @(t) [0, 222]; % Moon is stationary since there is no dependence on t
t = linspace(0, 200000, 20000); % dt = 10
[tout, pos] = simulate_rocket_euler(init_pos, init_vel, moon_pos, t); % Finding the rocket's trajectory
hold on % Plotting all on one graph
th = 0:pi/50:2*pi; % One revolution of the circles and their resolution
xunit_E = 3.7 * cos(th);
yunit_E = 3.7 * sin(th);
xunit_M = cos(th);
yunit_M = sin(th) + 222;
plot(xunit_E, yunit_E); % Circle representing the Earth
plot(xunit_M, yunit_M); % Circle representing the Moon
plot(pos(:,1), pos(:,2)) % Rocket's trajectory
axis equal % Setting axes to an equal scale
xlabel("Distance from Earth (Moon-radii)")
ylabel("Distance from Earth (Moon-radii)")
title("Rocket launched from x-axis at an angle of 50.5 degrees from x-axis for a stationary moon")
hold off
