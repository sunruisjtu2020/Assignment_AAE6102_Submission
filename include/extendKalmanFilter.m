function [X1, P1] = extendKalmanFilter(satpos, satvel, codephases, dopplers, X, P, Q, settings)

c  = settings.c;
dt = settings.navSolPeriod / 1000;

F = eye(8);
F(1,4) = dt;
F(2,5) = dt;
F(3,6) = dt;
F(7,8) = dt;

x_pred = F * X;
P_pred = F * P * F' + Q;

R_rho = 1e3;
R_dop = 1e4;

N = size(codephases, 2);
H = zeros(N*2, size(X, 1));
h = zeros(N*2, 1);
Z = zeros(N*2, 1);

for i = 1:N
    Xs = satpos(1, i);
    Ys = satpos(2, i);
    Zs = satpos(3, i);
    Vxs = satvel(1, i);
    Vys = satvel(2, i);
    Vzs = satvel(3, i);

    dx = Xs - x_pred(1);
    dy = Ys - x_pred(2);
    dz = Zs - x_pred(3);

    rho_dot = [dx dy dz]';
    rho = norm(rho_dot);
    travelTime = rho / c;

    dvx = Vxs - x_pred(4);
    dvy = Vys - x_pred(5);
    dvz = Vzs - x_pred(6);

    v_dot = [dvx, dvy, dvz]';
    
    rot_x = e_r_corr(travelTime, satpos(:, i));
    Xs = rot_x(1);
    Ys = rot_x(2);
    Zs = rot_x(3);
    dx = Xs - x_pred(1);
    dy = Ys - x_pred(2);
    dz = Zs - x_pred(3);
    rho_dot = [dx, dy, dz]';
    rho = norm(rho_dot);

    H(i,:) = [-dx / rho, -dy / rho, -dz / rho, 0, 0, 0, 1, 0];
    Z(i) = codephases(i);
    h(i) = rho + x_pred(7);

    if i > length(dopplers)
        disp('Doppler measurement exceed.');
    else
        H(N+i, :) = [0, 0, 0, -dx / rho, -dy / rho, -dz / rho, 0, 1];
        vel       = dot(rho_dot, v_dot) / rho;
        h(N+i)    = vel + x_pred(8);
        Z(N+i)    = dopplers(i);
    end

end

R = diag([ones(1, N) * R_rho, ones(1, N) * R_dop]);
r = Z - h;
S = H * P_pred * H' + R;
K = P_pred * H' / S;

X1 = x_pred + (K * r);
I = eye(size(X, 1));
P1 = (I - K * H) * P_pred * (I - K * H)' + K * R * K';

end