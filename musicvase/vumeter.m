function vumeter(y, fs)
    
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
    fig = figure;
    zlim([0, 10]);
    
    figPos = get(fig, 'Position');
    figPos(4) = figPos(4) * 1.5;
    set(fig, 'Position', figPos);
    
    rmsValues = rmsValues / max(rmsValues);
    
    figure(fig);
    player = audioplayer(y, fs);
    play(player);
    
    view(az, el);
    
    for i = 1:noFrame
        if isplaying(player)
            val = round(rmsValues(i) * 10);
            
            cla;
            
            az = mod(az + 2, 360);
            view(az, el);
            vase(0.75, 1, 8, val, val);
            pause(frLen * 0.9);
        else
            break;
        end
    end
end