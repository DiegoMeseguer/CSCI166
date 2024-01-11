%% 3) Rootfinding and Optimization

% a) We can use a rootfinding method like bisection to find a root of
%    the derivative of f(x). With this root then we can draw a number
%    line and use the first derivative test to classify the critical
%    point as a local max, local min or neither.

% b) 

% Define f(x) = ln(x) - sin(x) and its derivative
syms x;
f = log(x) - sin(x);
derivative = diff(f);

% Evaluate the derivate at the bounds 4 and 6;
a = 4;
b = 6;
temp = subs(derivative, x, a);
leftBound = double(temp);
leftBound
temp = subs(derivative, x, b);
rightBound = double(temp); 
rightBound
% Because 1/x - cos(x) is continuous on the interval [4,6] and because
% f'(4) = 0.9036 and f'(6) = -0.7935 by the IVT we know that the
% derivative has at least one root in this interval.
% Furthermore, since the derivative is positive on the left side 
% of the critical point and negative on the right side we know that
% this is a local maximum of our function.
% Finally, if we plot the derivative on the interval [4,6]
% we can see that it only changes sign once so this local max is a 
% unique maximum of f(x) in this interval.

% Plot of f(x) on the interval [4,6]
hold on;
grid on;
domain = linspace(4,6,400);
temp = subs(f, x, domain);
y = double(temp);
plot(domain, y, "LineWidth", 2);

% Plot of f'(x) on the interval [4,6]
temp = subs(derivative, x ,domain);
z = double(temp);
plot(domain, z, "LineWidth", 2);
title("Function vs Derivative on interval [4,6]")
legend("f(x)", "f'(x)");
figure()

% c)

% Bisection Method

rootApproxBisection = bisection(12, a, b, @test_function);
rootApproxBisection

% Method of False Position

rootApproxFalse = false_position(12, a, b, @test_function);
rootApproxFalse

% d)

% Since the actual root is at x ≈ 4.91718592528713... the method of
% False Position would be the best estimate since we have 
% x = 4.91718... This would be the best estimate for the maximum
% of f(x).

% e)

iterationNumber = [1:12]';
bisectionVals = bisection_table(12, a, b, @test_function);
falsePositionVals = false_position_table(12, a, b, @test_function);

approxTable = table(iterationNumber, bisectionVals, falsePositionVals);
approxTable.Properties.VariableNames = ["Iteration n", "Bisection", "False Position"];
approxTable

bisectionErrors = absolute_error_table(bisectionVals);
falsePositionErrors = absolute_error_table(falsePositionVals);

errorTable = table(iterationNumber, bisectionErrors, falsePositionErrors);
errorTable.Properties.VariableNames = ["Iteration n", "Bisection", "False Position"];
errorTable

% f)

bisectionLogs = log(bisectionErrors);
falsePositionLogs = log(falsePositionErrors);
plot(bisectionErrors, bisectionLogs, falsePositionErrors, falsePositionLogs, "LineWidth", 2);
title("Log of the Absolute Error for the two methods");
legend("Bisection", "False Position");
grid on;

%%%% FUNCTION DEFINITIONS %%%%

% Code for the Bisection method
function out = bisection(nMax, left, right, funcIn)    
    for i = 1:nMax
        out = (left + right) / 2;
        if sign(funcIn(out)) == 0
            return
        elseif sign(funcIn(out)) == sign(funcIn(left))
            left = out;
        else
            right = out;
        end
    end
end

% Code for False Position method
function out = false_position(nMax, left, right, funcIn)
    for i = 1:nMax
        out = right - ((funcIn(right) * (right - left))/(funcIn(right) - funcIn(left)));
        if sign(funcIn(out)) == 0
            return
        elseif sign(funcIn(out)) == sign(funcIn(left))
            left = out;
        else
            right = out;
        end
    end
end

% Code to generate Bisection table
function out = bisection_table(nMax, left, right, funcIn)
    out = zeros(nMax, 1);

    for i = 1:nMax
        temp = (left + right) / 2;
        out(i) = temp;
        if sign(funcIn(temp)) == 0
            return
        elseif sign(funcIn(temp)) == sign(funcIn(left))
            left = temp;
        else
            right = temp;
        end
    end
end

% Code to generate False Position table
function out = false_position_table(nMax, left, right, funcIn)

    out = zeros(nMax, 1);

    for i = 1:nMax
        temp = right - ((funcIn(right) * (right - left))/(funcIn(right) - funcIn(left)));
        out(i) = temp;
        if sign(funcIn(temp)) == 0
            return
        elseif sign(funcIn(temp)) == sign(funcIn(left))
            left = temp;
        else
            right = temp;
        end
    end
end

% Code to generate Absolute Error table
function out = absolute_error_table(array)
    out = zeros(size(array));
    for i = 1:length(array)
        out(i) = abs(array(i) - 4.9171859252871323);
    end
end

function out = test_function(x)
    out = 1/x - cos(x);
end

