function [] = moveDegrees(m, degrees, speed)
    running = 1;
        start(m);
    degrees
    startRotation = readRotation(m);
    if(startRotation > degrees)
        rotation = 0;
        m.Speed = speed * -1;
    else 
        rotation = 1;
        m.Speed = speed;
    end

    while (running)
        current = readRotation(m);
        if(current < degrees && rotation == 0)
            stop(m);
            running = 0;
        elseif (current > degrees && rotation == 1)
            stop(m);
            running = 0;
        end
        %if (between(current, degrees, 1))
        %    stop(m);
        %    running = 0;
        %elseif (current > degrees)
        %    m.Speed = speed * -1;
        %elseif (current < degrees)
        %    m.Speed = speed;
        %end

    end

end
