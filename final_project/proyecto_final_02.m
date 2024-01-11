% b) Modify the Digit-by-digit Method to count 
%    how many times the digit 8 occurs in the 
%    first 30 decimal digits of the sqrt(2)

format long g;

eMax = 29;
nMax = 29;

[result, resultCounter] = square_root(2, 8, eMax, nMax);
resultCounter % 4

%%%% FUNCTION DEFINITIONS %%%%

% Code for digit-by-digit square root method that also counts
function [root, finalCounter] = square_root(square, target, eMax, nMax)

    counter = 0; % initialize counter

    % STEP 00 - if square is 0, root is 0
    if square == 0
        root = 0;
        return;
    end

    % STEP 0 - Check if the square has a fractional part,
    % multiply it by 10^eMax if it has.
    isFractional = 0;
    if mod(square, 1) ~= 0
        square = square * (10 .^ eMax);
        isFractional = 1;
    end

    % STEP 1 - Pairing
    getNumberOfDigits = floor(log10(square)) + 1;
    pairedDigits = zeros(ceil(getNumberOfDigits ./ 2), 1);

    % Fill the pairedDigits vector with the groups of digits
    for i = 1:length(pairedDigits)
        pairedDigits(i) = mod(square, 100); % store the rightmost two digits
        square  = (square - pairedDigits(i)) / 100; % go for next group
    end

    pairedDigits = flip(pairedDigits); % leftmost group must be first

    % STEP 2 - Initial Guess
    % Use trial and error to find largest digit whose square is less than or
    % equal to the leftmost group of digit/s.
    for i = 0:9
        if i .^ 2 <= pairedDigits(1)
            guess = i;
        end
    end

    if guess == target
        counter = counter + 1;
    end

    % STEP 3 - Set p: the "current partial square root", 
    % Square p and subtract it from the leftmost group and save the remainder
    % in the variable r.
    p = guess;
    r = pairedDigits(1) - p .^ 2;

    % Run steps 4, 5 and 6 inside a loop
    % STEP 4 - Bring down the next two digits and update r
    % STEP 5 - Use trial and error to find d, which is the next digit of p.
    % To find d, find the greatest digit d such that ((2p)|d) * d ≤ r.
    % STEP 6 - Update r by subtracting ((2p)|d) * d, then update the
    % "current partial square root" p with d.
    for i=2:length(pairedDigits)
        r = (100 * r) + pairedDigits(i); % update r with next two digits

        for j = 0:9 % use trial and error to find d
            if ((20 * p) + j) * j <= r
                d = j;
            end
        end

        if d == target
            counter = counter + 1;
        end

        r = r - (((20 * p) + d) * d); % update r
        p = (10 * p) + d; % obtain new approximation of square root
    end
    
    % STEP 7 - If we have a non-perfect integer square, then
    % continue the algorithm by bringing down 00s each iteration,
    % nMax sets the desired precision.
    if (r ~= 0) && (isFractional == 0)
        for i = 1:nMax
            r = (100 * r);
    
            for j = 0:9 % use trial and error to find d
                if ((20 * p) + j) * j <= r
                    d = j;
                end
            end

            if d == target
                counter = counter + 1;
            end

            r = r - (((20 * p) + d) * d); % update r
            p = (10 * p) + d; % obtain new approximation of square root
        end
        p = p ./ (10 .^ nMax); % put decimal point in the square root
    end

    % STEP 8 - Check if we need to put decimal point
    if isFractional == 1
        p = p ./ (10 ^ (eMax ./ 2)); % put decimal point in the square root
    end

    root = p;
    finalCounter = counter;

end

