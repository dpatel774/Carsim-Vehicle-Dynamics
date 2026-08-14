% Load the file
data = readtable('test4.csv');

% Trim to the active driving window
moving = data.Vx > 5; % raise from 1 to 5 km/h — cuts the noisy tail more aggressively
data_trimmed = data(moving, :);


% Tire force curves
figure
plot(data_trimmed.Kappa_L1, data_trimmed.Fx_L1, '.', 'DisplayName', 'Front Left')
hold on
plot(data_trimmed.Kappa_R1, data_trimmed.Fx_R1, '.', 'DisplayName', 'Front Right')
plot(data_trimmed.Kappa_L2, data_trimmed.Fx_L2, '.', 'DisplayName', 'Rear Left')
plot(data_trimmed.Kappa_R2, data_trimmed.Fx_R2, '.', 'DisplayName', 'Rear Right')
xlabel('Slip Ratio (\kappa)')
ylabel('Longitudinal Force F_x (N)')
title('Tire Force Curve: F_x vs Slip Ratio (Brake-in-Turn)')
legend('Location', 'best')
grid on

figure
plot(data_trimmed.Alpha_L1, data_trimmed.Fy_L1, '.', 'DisplayName', 'Front Left')
hold on
plot(data_trimmed.Alpha_R1, data_trimmed.Fy_R1, '.', 'DisplayName', 'Front Right')
plot(data_trimmed.Alpha_L2, data_trimmed.Fy_L2, '.', 'DisplayName', 'Rear Left')
plot(data_trimmed.Alpha_R2, data_trimmed.Fy_R2, '.', 'DisplayName', 'Rear Right')
xlabel('Slip Angle (\alpha, deg)')
ylabel('Lateral Force F_y (N)')
title('Tire Force Curve: F_y vs Slip Angle (Brake-in-Turn)')
legend('Location', 'best')
grid on

% Compute resultant force magnitude for each tire
F_resultant_L1 = sqrt(data_trimmed.Fx_L1.^2 + data_trimmed.Fy_L1.^2);
F_resultant_R1 = sqrt(data_trimmed.Fx_R1.^2 + data_trimmed.Fy_R1.^2);
F_resultant_L2 = sqrt(data_trimmed.Fx_L2.^2 + data_trimmed.Fy_L2.^2);
F_resultant_R2 = sqrt(data_trimmed.Fx_R2.^2 + data_trimmed.Fy_R2.^2);
figure
plot(data_trimmed.Fz_L1, F_resultant_L1, '.', 'DisplayName', 'Front Left')
hold on
plot(data_trimmed.Fz_R1, F_resultant_R1, '.', 'DisplayName', 'Front Right')
plot(data_trimmed.Fz_L2, F_resultant_L2, '.', 'DisplayName', 'Rear Left')
plot(data_trimmed.Fz_R2, F_resultant_R2, '.', 'DisplayName', 'Rear Right')
xlabel('Normal Load F_z (N)')
ylabel('Resultant Tire Force (N)')
title('Load Sensitivity: Tire Force vs Normal Load')
legend('Location', 'best')
grid on

figure

subplot(2,1,1)
plot(data_trimmed.Time, data_trimmed.Kappa_L1, 'DisplayName', 'FL')
hold on
plot(data_trimmed.Time, data_trimmed.Kappa_R1, 'DisplayName', 'FR')
plot(data_trimmed.Time, data_trimmed.Kappa_L2, 'DisplayName', 'RL')
plot(data_trimmed.Time, data_trimmed.Kappa_R2, 'DisplayName', 'RR')
ylabel('Slip Ratio (\kappa)')
title('Slip Ratio vs Time — All Tires')
legend('Location', 'best')
grid on

subplot(2,1,2)
plot(data_trimmed.Time, data_trimmed.Fx_L1, 'DisplayName', 'FL')
hold on
plot(data_trimmed.Time, data_trimmed.Fx_R1, 'DisplayName', 'FR')
plot(data_trimmed.Time, data_trimmed.Fx_L2, 'DisplayName', 'RL')
plot(data_trimmed.Time, data_trimmed.Fx_R2, 'DisplayName', 'RR')
xlabel('Time (s)')
ylabel('Longitudinal Force F_x (N)')
legend('Location', 'best')
grid on

figure
plot(data_trimmed.Fy_L1, data_trimmed.Fx_L1, '-', 'DisplayName', 'Front Left')
hold on
plot(data_trimmed.Fy_R1, data_trimmed.Fx_R1, '-', 'DisplayName', 'Front Right')
plot(data_trimmed.Fy_L2, data_trimmed.Fx_L2, '-', 'DisplayName', 'Rear Left')
plot(data_trimmed.Fy_R2, data_trimmed.Fx_R2, '-', 'DisplayName', 'Rear Right')
xlabel('Lateral Force F_y (N)')
ylabel('Longitudinal Force F_x (N)')
title('Friction Ellipse (Dry Surface)')
legend('Location', 'best')
axis equal
grid on

figure
plot(data_trimmed.Time, -data_trimmed.Fz_R1)
xlabel('Time (s)')
ylabel('Front-Right Normal Load (N)')
title('FR Load vs Time — check against dip timestamps')

saveas(gcf, 'deliverable1a_Fx_vs_Kappa.png')
saveas(gcf, 'deliverable1b_Fy_vs_Alpha.png')
saveas(gcf, 'deliverable2_load_sensitivity.png')
saveas(gcf, 'deliverable3_slip_ratio_analysis.png')
saveas(gcf, 'deliverable4_friction_ellipse.png')