addpath("./Functions");
% [Blue-S Yellow-S Red-S Blue-L Yellow-L Red-L]
bins = [0 0 0 0 0 0];

if (exist('myev3', 'var') == 0)
    myev3 = legoev3("USB");
end

drumMotor = motor(myev3, 'D');
%vibrateMotor = motor(myev3, 'B');
%feedKickerMotor = motor(myev3, 'C');
drumKickerMotor = motor(myev3, 'A');

%sensorColor = colorSensor(myev3, '1');
%lightSensor = colorSensor(myev3, '2');

%zeroMotor(drumMotor)33;
%vibrate(vibrateMotor);

selected = 1;

while (1)
    clearLCD(myev3);
    writeLCD(myev3, 'X', selected, 1);
    % The blocks avalible
    writeLCD(myev3, 'Large - Red', 1, 3);
    writeLCD(myev3, 'Small - Red', 2, 3);
    writeLCD(myev3, 'Large - Green', 3, 3);
    writeLCD(myev3, 'Small - Green', 4, 3);
    writeLCD(myev3, 'Large - Yellow', 5, 3);
    writeLCD(myev3, 'Small - Yellow', 6, 3);
    writeLCD(myev3, 'Push out', 7, 3);
    writeLCD(myev3, 'Move 90deg', 8, 3);
    writeLCD(myev3, 'Move -90deg', 9, 3);
    % Amount of blocks avalible
    writeLCD(myev3, num2str(bins(1)), 1, 19);
    writeLCD(myev3, num2str(bins(2)), 2, 19);
    writeLCD(myev3, num2str(bins(3)), 3, 19);
    writeLCD(myev3, num2str(bins(4)), 4, 19);
    writeLCD(myev3, num2str(bins(5)), 5, 19);
    writeLCD(myev3, num2str(bins(6)), 6, 19);

    buttonPressed = buttonPress(myev3);

    if (buttonPressed == "up")
        if (selected > 1)
            selected = selected - 1;
        end

    elseif (buttonPressed == "down")
        if (selected < 9)
            selected = selected + 1;
        end

    elseif (buttonPressed == "center")
        selected

        if (selected <= 6)
            moveToStorage(selected, drumMotor)
        elseif (selected == 7)
            
            moveDegrees(drumKickerMotor, 35, 10);
            
            moveDegrees(drumKickerMotor, 14, 60);
        elseif (selected == 8)
            moveDegrees (drumKickerMotor, 90, 15);
        elseif (selected == 9)
            moveDegrees (drumKickerMotor, -90, 15);
        end

    end

end

%switch(buttonPressed)

%end
