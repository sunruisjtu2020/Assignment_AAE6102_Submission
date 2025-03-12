function plotPosition(navSolutions, settings)
% plot llh position
la = navSolutions.latitude;
lo = navSolutions.longitude;
gtla = settings.truePosition.latitude;
gtlo = settings.truePosition.longitude;

figure;
plot(lo, la, 'b.');
hold on;
plot(gtlo, gtla, 'm+', 'LineWidth', 1.5);
hold on;
plot(mean(lo), mean(la), 'r+', 'LineWidth', 1.5);
xlabel('longitude (degree)');
ylabel('latitude (degree)');
title('Position');
legend('Data', 'Ground Truth', 'Average');

end