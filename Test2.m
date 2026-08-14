thirty_mph = readtable('30mph.csv');
forty_mph = readtable('40mph.csv');
fifty_mph = readtable('50mph.csv');
fiftyfive_mph = readtable('55mph.csv');
sixty_mph = readtable('60mph.csv');
seventy_mph = readtable('70mph.csv');

figure
plot(thirty_mph.Time, thirty_mph.AVz, '-', 'DisplayName', '30mph')
hold on
plot(forty_mph.Time, forty_mph.AVz, '-', 'DisplayName', '40mph')
plot(fifty_mph.Time, fifty_mph.AVz, '-', 'DisplayName', '50mph')
plot(fiftyfive_mph.Time, fiftyfive_mph.AVz, '-', 'DisplayName', '55mph')
plot(sixty_mph.Time, sixty_mph.AVz, '-', 'DisplayName', '60mph')
plot(seventy_mph.Time, seventy_mph.AVz, '-', 'DisplayName', '70mph')
xlabel('Time (s)')
ylabel('Yaw rate (deg/s)')
legend('Location', 'best')
title('Test 3 Yaw rate vs time')
grid on


speeds_mph = [30 40 50 55 60 70];
overshoot_pct = zeros(size(speeds_mph));
peakVal = zeros(size(speeds_mph));
plateauVal = zeros(size(speeds_mph));

for i = 1:length(speeds_mph)
    fname = sprintf('%dmph.csv', speeds_mph(i));
    T = readtable(fname);
    yaw = T.AVz;

    % Find all real peaks, take the LAST one (final valid event)
    [pks, locs] = findpeaks(yaw, 'MinPeakProminence', 3);
    lastPeakIdx = locs(end);
    peakVal(i) = yaw(lastPeakIdx);

    % Plateau = average of the tail end of the file (after settling)
    plateauVal(i) = mean(yaw(end-50:end));

    % Overshoot as % above the plateau
    overshoot_pct(i) = 100 * (peakVal(i) - plateauVal(i)) / plateauVal(i);
end

resultsTable = table(speeds_mph', peakVal', plateauVal', overshoot_pct', ...
    'VariableNames', {'Speed_mph','Peak','Plateau','OvershootPct'})

figure
plot(speeds_mph, overshoot_pct, '-o', 'LineWidth', 1.5)
xlabel('Speed (mph)')
ylabel('Overshoot (% above plateau)')
title('Step-Steer Overshoot vs Speed')
grid on

saveas(gcf, 'deliverable7_stepsteer_response.png')
saveas(gcf, 'deliverable8_stability_margin.png')