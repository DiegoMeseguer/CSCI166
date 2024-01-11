%% 3)

% c)

fixedPoint = 1/2;
pZero = 1/5;

% Define g(x)
syms x;
f = 2 * x * (1 - x);
g = matlabFunction(f);


% Do the test
result = fpTable(20, pZero, g);
error = absoluteError(result, fixedPoint);
final = linearConvergence(error);
final2 = quadraticConvergence(error);




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

function out = linearConvergence(array)
    out = zeros(size(array));
    out(1) = NaN;   % We can't compare p_0 with p_-1
    for i = 2:length(array)
        out(i) = array(i)/array(i-1);
    end
end

function out = quadraticConvergence(array)
    out = zeros(size(array));
    out(1) = NaN;
    for i = 2:length(array)
        out(i) = array(i)/((array(i-1)).^2);
    end
end

% Code to generate absolute error e_n
function out = absoluteError(array, realValue)
    out = zeros(size(array));
    for i = 1:length(array)
        out(i) = abs(array(i) - realValue);
    end
end


