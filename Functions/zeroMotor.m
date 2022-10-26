function [] = zeroMotor(m)
    pause("on")
    start(m);
    m.Speed = 5;
    last = readRotation(m);

    while (last - readRotation(m) > 5)
        pause(1);
    end

    stop(m);
    resetRotation(m);
    pause("off")
end
