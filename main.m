 addpath("./Functions");
% [Blue-S Yellow-S Red-S Blue-L Yellow-L Red-L]
% colors = ["green" "red" "yellow"];
bins = [0 0 0 0 0 0];
totalBlocksSorted = 0;

if (exist('myev3', 'var') == 0)
    myev3 = legoev3('USB');
end

drumMotor = motor(myev3, 'D');
vibrateMotor = motor(myev3, 'C');
feedKickerMotor = motor(myev3, 'B');
drumKickerMotor = motor(myev3, 'A');

sensorColor = colorSensor(myev3, 1);
%lightSensor = colorSensor(myev3, '2');

%zeroMotor(drumMotor);
%vibrate(vibrateMotor);

selected = 8;

while (1)
    clearLCD(myev3);
    writeLCD(myev3, 'X', selected, 1);
    % The blocks avalible
    writeLCD(myev3, 'Small - Green', 1, 3);
    writeLCD(myev3, 'Small - Red', 2, 3);
    writeLCD(myev3, 'Small - Yellow', 3, 3);
    writeLCD(myev3, 'Large - Green', 4, 3);
    writeLCD(myev3, 'Large - Red', 5, 3);
    writeLCD(myev3, 'Large - Yellow', 6, 3);
    writeLCD(myev3, 'Push out', 7, 3);
    writeLCD(myev3, 'Sort', 8, 3);
    writeLCD(myev3, 'Reset', 9, 3);
    % % Write color
    % writeLCD(myev3, colors(1), 1, 11);
    % writeLCD(myev3, colors(1), 2, 11);
    % writeLCD(myev3, colors(2), 3, 11);
    % writeLCD(myev3, colors(2), 4, 11);
    % writeLCD(myev3, colors(3), 5, 11);
    % writeLCD(myev3, colors(3), 6, 11);
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
            readRotation(drumMotor)
        end

    elseif (buttonPressed == "down")

        if (selected < 9)
            selected = selected + 1;
            readRotation(drumMotor)
        end

    elseif (buttonPressed == "center")
        selected

        if (selected <= 6)
            moveToStorage(selected, drumMotor, 0)
            moveDegrees(drumKickerMotor, 70, 100);
            moveDegrees(drumKickerMotor, 0, 50);
            bins(selected) = bins(selected) -1;
            %Kick out block manualy
        elseif (selected == 7)
            moveDegrees(drumKickerMotor, 70, 70);
            moveDegrees(drumKickerMotor, 0, 50);
            % Sorting
        elseif (selected == 8)
            % moveDegrees (drumKickerMotor, 90, 15);
            % vibrate(vibrateMotor);
            start(vibrateMotor);
            vibrateMotor.Speed = 80;
            sorting = 1;
            feedKickerMotor.Speed = 20;

            while (sorting)
                feedKickerMotor.Speed = 20;
                start(vibrateMotor);
                start(feedKickerMotor);
                sensing = 1;
                sensingStartTime = getTime();
                sensedColor = 'none';
                % 0: Small, 1: large
                sensedSize = 0;
                inside = 0;

                while (sensing)
                    if(readButton(myev3, 'center'))
                        stop(drumMotor);
                        stop(feedKickerMotor);
                        stop(vibrateMotor);
                        stop(drumKickerMotor);
                        sensing = 0;
                        sorting = 0;
                    end
                    kickRotation = mod(readRotation(feedKickerMotor), 360);

                    if (kickRotation < 300 && kickRotation > 60)
                        inside = 1;
                    end

                    if (kickRotation > 300 && inside)
                        stop(feedKickerMotor);
                    end

                    if (timeBetween(getTime(), sensingStartTime) > 5)
                        sensing = 0;
                    end

                    curCol = readColor(sensorColor);

                    if (curCol == "red" || curCol == "green" || curCol == "yellow")
                        sensedColor = curCol;
                        sensedSize = 1;
                    else
                        sensedSize = 0;

                    end

                    deltaTime = timeBetween(sensingStartTime, getTime());
                end

                clearLCD(myev3);
                writeLCD(myev3, num2str(totalBlocksSorted), 3, 4);
                writeLCD(myev3, sensedColor, 6, 3);

                if (sensedSize == 0)
                    writeLCD(myev3, 'Small', 7, 3);
                else
                    writeLCD(myev3, 'Large', 7, 3);
                end

                % Turn drum to the drum corresponding to the seen block
                % [Blue-S Yellow-S Red-S Blue-L Yellow-L Red-L]
                if (sensedColor == "red" || sensedColor == "green" || sensedColor == "yellow")
                    stop(vibrateMotor);
                    switch sensedColor
                        case 'green'

                            if (sensedSize == 0)
                                moveToStorage(1, drumMotor, 1);
                                bins(1) = bins(1) +1;
                            else
                                moveToStorage(4, drumMotor, 1);
                                bins(4) = bins(4) +1;
                            end

                        case 'red'

                            if (sensedSize == 0)
                                moveToStorage(2, drumMotor, 1);
                                bins(2) = bins(2) +1;
                            else
                                moveToStorage(5, drumMotor, 1);
                                bins(5) = bins(5) +1;
                            end

                        case 'yellow'

                            if (sensedSize == 0)
                                moveToStorage(3, drumMotor, 1);
                                bins(3) = bins(3) +1;
                            else
                                moveToStorage(6, drumMotor, 1);
                                bins(6) = bins(6) +1;
                            end

                    end

                    totalBlocksSorted = totalBlocksSorted +1;
                end

                if (totalBlocksSorted > 10)
                    start(feedKickerMotor);
                    rotating = 1;
                    while(rotating)
                        kickRotation = mod(readRotation(feedKickerMotor), 360);

                        if (kickRotation < 300 && kickRotation > 60)
                            rotating = 0;
                        end
                    end
                    stop(vibrateMotor);
                    sorting = 0;
                end

            end

        elseif (selected == 9)
            moveDegrees(drumMotor, 0, 50);
            % moveDegrees(feedKickerMotor, 0, 20);
            moveDegrees(drumKickerMotor, 0, 20);
        end

    end

end
