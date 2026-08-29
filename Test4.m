%% === Test 4: Yaw Control via CarSim-Simulink Co-Simulation ===
%  DLC @ 120 km/h, Low Mu Surface — B-Class Sports Car
%  Sweep of Control Gain: 0, 0.31, 0.70, 0.72, 0.74

gains = [0 0.31 0.70 0.72 0.74];
files = {'zero.csv', 'point31.csv', 'point7.csv', 'point72.csv', 'point74.csv'};

peakYaw = zeros(size(gains));

%% === Deliverable 11: Trajectory (X vs Y) — All Gains Overlaid ===
figure
hold on
for i = 1:length(files)
    T = readtable(files{i});
    plot(T.Xo, T.Yo, 'LineWidth', 1.2, 'DisplayName', sprintf('Gain = %.2f', gains(i)))
end
xlabel('X Position (m)')
ylabel('Y Position (m)')
title('Vehicle Trajectory vs Yaw Control Gain — DLC @ 120 km/h, Low Mu')
legend('Location', 'best')
axis equal
grid on
saveas(gcf, 'deliverable11_trajectory_vs_gain.png')

%% === Deliverable 12: Yaw Rate vs Time — All Gains Overlaid ===
figure
hold on
for i = 1:length(files)
    T = readtable(files{i});
    plot(T.Time, T.AVz, 'LineWidth', 1.2, 'DisplayName', sprintf('Gain = %.2f', gains(i)))
    peakYaw(i) = max(abs(T.AVz));
end
xlabel('Time (s)')
ylabel('Yaw Rate (deg/s)')
title('Yaw Rate vs Time — Effect of Control Gain')
legend('Location', 'best')
grid on
saveas(gcf, 'deliverable12_yawrate_vs_gain.png')

%% === Deliverable 13: Peak Yaw Rate vs Gain (Summary) ===
figure
plot(gains, peakYaw, '-o', 'LineWidth', 1.5, 'MarkerSize', 8)
xlabel('Yaw Control Gain')
ylabel('Peak |Yaw Rate| (deg/s)')
title('Controller Effectiveness vs Gain — Diminishing Returns Above ~0.72')
grid on
saveas(gcf, 'deliverable13_gain_sensitivity.png')

%% === Summary Table ===
resultsTable = table(gains', peakYaw', ...
    'VariableNames', {'ControlGain', 'PeakYawRate_degps'})