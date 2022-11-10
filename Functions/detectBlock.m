function [color] = detectBlock(colorSensor)
    c = readColor(colorSensor);

    if (c == "none")
        color = 0;
    else
        % Change to match a actual neutral value
        if (l > 100)
            size = 2;
        else
            size = 1;
        end

        color = c;
    end

end
