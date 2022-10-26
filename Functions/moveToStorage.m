% Degrees used in this function is 360/6=60

function [] = moveToStorage(bin, m)
    firstDegrees = 0;
    binDeg = 360/6;
    endPosition = bin * binDeg + firstDegrees;
    moveDegrees(m, endPosition, 30, 3,333);

end
