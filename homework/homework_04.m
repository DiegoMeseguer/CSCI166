%% 1) Finding Roots - Newton's Method

% a)

pZero = 0;
root = 1/3;

% Define the polynomial f(x)
f = [27 162 -180 62 -7];

% Make table to determine order of convergence
% The colums of the table
nVals = [0:9]';
pVals = nmTable(10, pZero, f);
eVals = absoluteError(pVals, root);
linearConv = linearConvergence(eVals);
quadraticConv = quadraticConvergence(eVals);
cubicConv = cubicConvergence(eVals);
 
myTable01 = table(nVals, pVals, eVals, linearConv, quadraticConv, cubicConv);
myTable01.Properties.VariableNames = ["n", "p_n", "e_n", "e_n/e_n-1", "e_n/(e_n-1)^2", "e_n/(e_n-1)^3"];
myTable01

% i) The order of convergence is 1 because we can see in the
% table that e_n/(e_n-1) is approaching 0.6666 so it's converging
% to 2/3 while the quadratic and cubic columns just get bigger.

% ii) The asymptotic error constant would be 2/3 as that is the value
% that we seem to approach as n goes to infinity.

% iii) I would expect the bisection method to converge slower than
% Newton's Method since we started close to the root and we were
% able to approximate it very quickly.

% b)

% Make table to determine order of convergence of modfied from of NM
% The colums of the table
nVals = [0:9]';
pVals = nmModifiedTable(10, pZero, f);
eVals = absoluteError(pVals, root);
linearConv = linearConvergence(eVals);
quadraticConv = quadraticConvergence(eVals);
cubicConv = cubicConvergence(eVals);

myTable02 = table(nVals, pVals, eVals, linearConv, quadraticConv, cubicConv);
myTable02.Properties.VariableNames = ["n", "p_n", "e_n", "e_n/e_n-1", "e_n/(e_n-1)^2", "e_n/(e_n-1)^3"];
myTable02

% We can see that this modification to NM works and we were able to
% approximate the root much faster. The order of convergence
% would be quadratic since we are being much more faster than linear
% which was our previous order withouth the modification.

%%%% FUNCTION DEFINITIONS %%%%

% Code for Newton's Method
function out = nm(nMax, pn, funcIn)
    derivative = polyder(funcIn);
    for i = 1:nMax
        out = pn - (polyval(funcIn,pn))/(polyval(derivative,pn));
        pn = out;
    end
end

% Code to generate Newton's Method Table
function out = nmTable(nMax, pn, funcIn)

    out = zeros(nMax, 1);

    derivative = polyder(funcIn);
    for i = 1:nMax
        temp = pn - (polyval(funcIn,pn))/(polyval(derivative,pn));
        out(i) = temp;
        pn = temp;
    end
end

% Code to generate Modified Newton's Method Table
function out = nmModifiedTable(nMax, pn, funcIn)

    out = zeros(nMax, 1);

    derivative = polyder(funcIn);
    for i = 1:nMax
        temp = pn - 3*((polyval(funcIn,pn))/(polyval(derivative,pn)));
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

function out = cubicConvergence(array)
    out = zeros(size(array));
    out(1) = NaN;
    for i = 2:length(array)
        out(i) = array(i)/((array(i-1)).^3);
    end
end

