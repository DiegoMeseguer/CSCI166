%% 2) Numerical Differentiation Formula

% c)

% Create table to compare h and error
[resultApprox, h] = diff_approx_ln(2);
error = absolute_error(resultApprox);
 
myTable = table(h, resultApprox, error);
myTable.Properties.VariableNames = ["h", "Difference Approximation", "Error"];
myTable

% We can see in the table that each time that the value of h decreases
% by a factor of 10, our error also decreases by a factor of 10. This
% confirms the first-order approximation that we got.

%%%% FUNCTION DEFINITIONS %%%%

% Code for difference approximation for the first derivative
function [fPrime, hValues] = diff_approx_ln(x) % returns two 6x1 col vectors

    h = 0.1;
    fPrime = zeros(6, 1);
    hValues = zeros(6, 1);

    for i = 1:6
        hValues(i) = h;
        fPrime(i) = (log(x + 2*h) - log(x - h)) ./ (3*h);
        h = h ./ 10;
    end
end

% Generates the absolute error table
function out = absolute_error(array) % returns a 6x1 col vec

    out = zeros(size(array)); % also 6x1 in this case
    syms x;
    lnx = diff(log(x)); % use Matlab built-in diff func
    ln = matlabFunction(lnx);

    for i = 1:length(array)
        out(i) = abs(array(i) - ln(2));
    end
end
