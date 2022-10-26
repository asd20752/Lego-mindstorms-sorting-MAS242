function [] = vibrate(m, state)

    if (state == "on")
        m.Speed = 50;
        start(m);
    else
        stop(m)
    end

end
