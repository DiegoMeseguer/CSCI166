%% 3) Homework Assignment

% a) Implement the digit-by-digit algorithm, make sure it works for
% numbers with a fractional part and non-perfect roots.

test = 10000;

% STEP 1 - Pairing
getNumberOfDigits = floor(log10(test)) + 1;
pairedDigits = zeros(ceil(getNumberOfDigits ./ 2), 1);

% Fill the pairedDigits vector with the groups of digits
for i = 1:length(pairedDigits)
    pairedDigits(i) = mod(test, 100); % store the rightmost two digits
    test  = (test - pairedDigits(i)) / 100; % go for next group
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

% STEP 3 - Set p: the "current partial square root", 
% Square p and subtract it from the leftmost group and save the remainder
% in the variable r.
p = guess;
r = pairedDigits(1) - p .^ 2;

% Run steps 4, 5 and 6 inside a loop, the square root will be in p
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

    r = r - (((20 * p) + d) * d); % update r
    p = (10 * p) + d; % obtain new approximation of square root
end


