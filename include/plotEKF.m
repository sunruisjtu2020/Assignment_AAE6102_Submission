function plotEKF(navSolutions)
    t = navSolutions.localTime - navSolutions.localTime(1);
    x = navSolutions.X_ekf;
    y = navSolutions.Y_ekf;
    z = navSolutions.Z_ekf;
    vx = navSolutions.velX_ekf;
    vy = navSolutions.velY_ekf;
    vz = navSolutions.velZ_ekf;

    figure;
    subplot(4, 1, 1);
    plot(t, x);
    
    xlabel('Time (s)');
    ylabel('Position (m)');
    title('Position X (ECEF)');
    subplot(4, 1, 2);
    plot(t, y);
    xlabel('Time (s)');
    ylabel('Position (m)');
    title('Position Y (ECEF)');
    subplot(4, 1, 3);
    plot(t, z);
    xlabel('Time (s)');
    ylabel('Position (m)');
    title('Position Z (ECEF)');
    subplot(4, 1, 4);
    plot(t, vx); hold on;
    plot(t, vy); hold on;
    plot(t, vz);
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
    title('Velocity (ECEF)');
    legend('V_x', 'V_y', 'V_z');
end