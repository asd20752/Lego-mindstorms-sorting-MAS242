% Degrees used in this function is 360/6=60

function [] = moveToStorage(bin, m, hopper)
    if (hopper == 1)
        hopperOffset = 600;
    else
        hopperOffset = 0;
    end
    ratio = 40;
    binDeg = 360/6;
    endPosition = (bin -1) * binDeg * ratio + hopperOffset;
    moveDegrees(m, endPosition, 50);
    
end     
