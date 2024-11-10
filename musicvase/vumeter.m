function vumeter(y, fs, fig)
    
    frLen = 0.05;
    az = 0;
    el = 10;
    
    frSize = round(frLen * fs);
    noFrame = floor(length(y) / frSize);
    
    rmsValues = zeros(1, noFrame);
    for i = 1:noFrame
        startIdx = (i - 1) * frSize + 1;
        endIdx = min(i * frSize, length(y));
        window = y(startIdx:endIdx, :);
    
        rmsValues(i) = sqrt(mean(window .^ 2, 'all'));
    end
    
    % figure settings
    zlim(fig, [0, 10]);
    
    rmsValues = rmsValues / max(rmsValues);
    
    player = audioplayer(y, fs);
    play(player);
    
    view(fig, az, el);
    
    for i = 1:noFrame
        if isplaying(player)
            val = round(rmsValues(i) * 10);
            cla(fig);
            
            az = mod(az + 2, 360);
            view(fig, az, el);
            vase(fig, 0.75, 1, 8, val, val);
            pause(frLen * 0.9);
        elseif stop == 1
            break;
        else
            break;
        end
    end
end