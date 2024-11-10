function vase(fig, r, R, n, N, h)
%VASE Draws a vase
%   r = small radius
%   R = big radius
%   n = number of sides
%   N = number of vase slices
%   h = total height

hp = h / N;     % height of each slice

hold(fig, "on");

for i = 0:(N-1)
    k = mod(i, 3);

    if k == 0
        vv = [R R];
    elseif k == 1
        vv = [R r];
    elseif k == 2
        vv = [r R];
    end

    [xp, yp, zp] = cylinder(vv, n);
    zp = (zp + i) * hp;
    surf(fig, xp, yp, zp);
end

hold(fig, "off");

end

