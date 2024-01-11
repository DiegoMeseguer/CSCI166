%% 1) Richardson Extrapolation Formulas

% c)

% Define f(x)
syms x;
g = x * (exp(1) .^ (-x .^ 2)) ;
f = matlabFunction(g);

% Calculate Romberg R_2(1
result = romberg_r2(f, 0, 1, 1);
result

%%%% FUNCTION DEFINITIONS %%%%

% Trapezoidal Rule
function out = trap(inFunc, lo, hi, h)
    n = (hi - lo) / h;
    temp = 0;
    counter = 0;

    for i = 0:n
        if i == 0 || i == n
            temp = temp + (h/2 * inFunc(counter));
            counter = counter + h;
        else
            temp = temp + (h * inFunc(counter));
            counter = counter + h;
        end
    end

    out = temp;
end

% Romberg R_2(h)
function out = romberg_r2(inFunc, lo, hi, h)
    out = ((-1/80) * romberg_r1(inFunc, lo, hi, h)) + ((81/80) * romberg_r1(inFunc, lo, hi, h/3));
end

% Romberg R_1(h)
function out = romberg_r1(inFunc, lo, hi, h)
    out = ((-1/8) * trap(inFunc, lo, hi, h)) + ((9/8) * trap(inFunc, lo, hi, h/3));
end 
   
