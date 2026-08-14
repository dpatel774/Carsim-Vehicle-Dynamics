%% === Load Test 1/2: Constant-Radius + Grip-Limit Speed Sweep ===
speeds_km_h = [20 30 40 50 60 70 80 90 100];
Ay_avg = zeros(size(speeds_km_h));
Steer_avg = zeros(size(speeds_km_h));

for i = 1:length(speeds_km_h)
    fname = sprintf('%dkm_h.csv', speeds_km_h(i));
    T = readtable(fname);
    n = height(T);
    steadyRows = round(n/2):n;
    Ay_avg(i) = mean(T.Ay(steadyRows), 'omitnan');
    Steer_avg(i) = mean(T.Steer_SW(steadyRows), 'omitnan');
end

linear_idx = 1:7;      % 20-80 kph
gripLimit_idx = 8:9;   % 90-100 kph

%% === Deliverable #5: Handling Diagram ===
figure
plot(Ay_avg(linear_idx), Steer_avg(linear_idx), '-o', 'DisplayName', 'Linear Region (20-80 km/h)')
hold on
plot(Ay_avg(gripLimit_idx), Steer_avg(gripLimit_idx), '-o', 'MarkerSize', 10, 'DisplayName', 'Grip-Limited (90-100 km/h)')
xlabel('Lateral Acceleration A_y (g)')
ylabel('Steering Wheel Angle (deg)')
title('Handling Diagram: Steering Angle vs Lateral Acceleration')
legend('Location', 'best')
grid on

%% === Deliverable #6: Understeer Gradient ===
p = polyfit(Ay_avg(linear_idx), Steer_avg(linear_idx), 1);
K_gradient = p(1);
fprintf('Understeer Gradient K = %.2f deg/g\n', K_gradient);

figure
plot(Ay_avg(linear_idx), Steer_avg(linear_idx), 'o', 'DisplayName', 'Data')
hold on
Ay_fit = linspace(min(Ay_avg(linear_idx)), max(Ay_avg(linear_idx)), 50);
Steer_fit = polyval(p, Ay_fit);
plot(Ay_fit, Steer_fit, '-', 'DisplayName', sprintf('Fit: K = %.2f deg/g', K_gradient))
xlabel('Lateral Acceleration A_y (g)')
ylabel('Steering Wheel Angle (deg)')
title('Understeer Gradient Fit')
legend('Location', 'best')
grid on

%% === Deliverable #9: Grip Ceiling — Front/Rear Tire Force vs Slip Angle ===
angles = [39.8 42 45 48];
files = {'100km_h.csv', '100km_h42deg.csv', '100km_h45deg.csv', '100km_h48deg.csv'};

Fy_L1_avg = zeros(size(angles));  Alpha_L1_avg = zeros(size(angles));  % front
Fy_L2_avg = zeros(size(angles));  Alpha_L2_avg = zeros(size(angles));  % rear

for i = 1:length(angles)
    T = readtable(files{i});
    n = height(T);
    steadyRows = round(n/2):n;

    Fy_L1_avg(i) = mean(T.Fy_L1(steadyRows), 'omitnan');
    Alpha_L1_avg(i) = mean(T.Alpha_L1(steadyRows), 'omitnan');

    Fy_L2_avg(i) = mean(T.Fy_L2(steadyRows), 'omitnan');
    Alpha_L2_avg(i) = mean(T.Alpha_L2(steadyRows), 'omitnan');
end

figure
plot(Alpha_L1_avg, Fy_L1_avg, '-o')
xlabel('Slip Angle (deg)')
ylabel('Front-Left Lateral Force F_y (N)')
title('Front Tire Force vs Slip Angle — Angle Sweep')
grid on

figure
plot(Alpha_L2_avg, Fy_L2_avg, '-o')
xlabel('Slip Angle (deg)')
ylabel('Rear-Left Lateral Force F_y (N)')
title('Rear Tire Force vs Slip Angle — Angle Sweep')
grid on

% Re-run or click back to each figure, then:
saveas(figure(1), 'deliverable5_handling_diagram.png')
saveas(figure(2), 'deliverable6_understeer_gradient.png')
saveas(figure(3), 'deliverable9a_front_tire_ceiling.png')
saveas(figure(4), 'deliverable9b_rear_tire_still_climbing.png')