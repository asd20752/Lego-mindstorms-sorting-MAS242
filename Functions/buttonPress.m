function btn = buttonPress (myev3) 
    pressed = 0;
    holding = 0;
    button = 'none';
    while (pressed == 0 || holding == 1)
        if(readButton(myev3, 'center'))
            pressed = 1;
            holding = 1;
            button = 'center';
        
        elseif(readButton(myev3, 'up'))
            pressed = 1;
            holding = 1;
            button = 'up';
        
        elseif(readButton(myev3, 'down'))
            pressed = 1;
            holding = 1;
            button = 'down';
        
        elseif(readButton(myev3, 'left'))
            pressed = 1;
            holding = 1;
            button = 'left';

        elseif(readButton(myev3, 'right'))
            pressed = 1;
            holding = 1;
            button = 'right';
        else
            holding = 0;
        end
    end
    btn = button;
end