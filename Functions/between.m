function bool = between(valueInput, expected, margin)

    if (expected + margin / 2 > valueInput && expected - margin / 2 < valueInput)
        bool = true;
    else
        bool = false;
    end

end
