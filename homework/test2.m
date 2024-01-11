%% 2) Fixed Point Iterations

% b)

fixedPoint = 0.7390851332;
pZero = 1/2;

% Define g(x) = cos(x)
syms x;
f = cos(x);
g = matlabFunction(f);

% Generate table
nVals = [0:31]';
pVals = fpTable(32, pZero, g);
eVals = absoluteError(pVals, fixedPoint);

myTable = table(nVals, pVals, eVals);
myTable.Properties.VariableNames = ["n", "p_n", "e_n"];
myTable


% I needed 32 iterations to approximate the fixed point to
% within an absolute error of 1 x 10^-7

%%%% FUNCTION DEFINITIONS %%%%

% Code for fixed point iteration scheme
function out = fp(nMax, pn, funcIn)
    for i = 1:nMax
        out = funcIn(pn);
        pn = out;
    end
end

% Code for fixed point iteration scheme table
function out = fpTable(nMax, pn, funcIn)

    out = zeros(nMax, 1);

    for i = 1:nMax
        temp = funcIn(pn);
        out(i) = temp;
        pn = temp;
    end
end

% Code to generate absolute error e_n
function out = absoluteError(array, realValue)
    out = zeros(size(array));
    for i = 1:length(array)
        out(i) = abs(array(i) - realValue);
    end
end




