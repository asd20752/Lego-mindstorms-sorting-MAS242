function [] = moveDegrees(m, degrees, speed, ratio)
    running = 1;
        start(m);

    while (running)
        current = readRotation(m);
        if (between(current, degrees, 2))
            stop(m);
            running = 0;
        elseif (current > degrees)
            m.Speed = speed * -1;
        elseif (current < degrees)
            m.Speed = speed;
        end

    end

end
