%% 1) Order of convergence of a sequence

format long;

%%%% First Sequence %%%%

pZero = 1;

% The colums of the table
nVals = [0:6]';
pVals = first_sequence(pZero);
eVals = absolute_error(pVals);
linearConv = linear_convergence(eVals);
quadraticConv = quadratic_convergence(eVals);
cubicConv = cubic_convergence(eVals);

myTable01 = table(nVals, pVals, eVals, linearConv, quadraticConv, cubicConv);
myTable01.Properties.VariableNames = ["n", "p_n", "e_n", "e_n/e_n-1", "e_n/(e_n-1)^2", "e_n/(e_n-1)^3"];
myTable01

%%%% Second Sequence %%%%

pZero = 1;

% The colums of the table
nVals = [0:6]';
pVals = second_sequence(pZero);
eVals = absolute_error(pVals);
linearConv = linear_convergence(eVals);
quadraticConv = quadratic_convergence(eVals);
cubicConv = cubic_convergence(eVals);

myTable02 = table(nVals, pVals, eVals, linearConv, quadraticConv, cubicConv);
myTable02.Properties.VariableNames = ["n", "p_n", "e_n", "e_n/e_n-1", "e_n/(e_n-1)^2", "e_n/(e_n-1)^3"];
myTable02

% We can see that for the first sequence in myTable01 e_n/(e_n-1)^2 is
% approaching a constant as it takes values like 0.214285, 0.223404 and
% 0.223364. This would suggest that we have quadratic convergence.

% We can see that for the second sequence in myTable02 e_n/(e_n-1)^3 is
% approaching a constant as it takes values like 0.0588235 and 0.0500259.
% This would suggest that we have cubic convergence.

%%%% FUNCTION DEFINITIONS %%%%

% Generates the first sequence p_n
function out = first_sequence(initVal)
    out = zeros(7,1);
    temp = initVal;
    out(1) = initVal;
    for i = 2:7
        temp = 1/2 * (temp + (5 * 1/temp));
        out(i) = temp;
    end
end

% Generates the second sequence p_n
function out = second_sequence(initVal)
    out = zeros(7,1);
    temp = initVal;
    out(1) = initVal;
    for i = 2:7
        temp = (temp.^3 + (15 * temp))/((3 * (temp.^2)) + 5);
        out(i) = temp;
    end
end

% Generates the absolute error of p_n
function out = absolute_error(array)
    out = zeros(size(array));
    for i = 1:length(array)
        out(i) = abs(array(i) - sqrt(5));
    end
end

function out = linear_convergence(array)
    out = zeros(size(array));
    out(1) = NaN;   % We can't compare p_0 with p_-1
    for i = 2:length(array)
        out(i) = array(i)/array(i-1);
    end
end

function out = quadratic_convergence(array)
    out = zeros(size(array));
    out(1) = NaN;
    for i = 2:length(array)
        out(i) = array(i)/((array(i-1)).^2);
    end
end

function out = cubic_convergence(array)
    out = zeros(size(array));
    out(1) = NaN;
    for i = 2:length(array)
        out(i) = array(i)/((array(i-1)).^3);
    end
end
