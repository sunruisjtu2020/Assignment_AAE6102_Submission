function plotVelocity(navSolutions)
t = navSolutions.localTime - navSolutions.localTime(1);
figure;
plot(t, navSolutions.velX);
hold on;
plot(t, navSolutions.velY);
hold on;
plot(t, navSolutions.velZ);
legend('V_X', 'V_Y', 'V_Z');
title('Velocity');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
end