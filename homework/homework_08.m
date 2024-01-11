%% 1) Nonlinear Systems of Equations

%c)

% Starting point
initialGuess = [15 ; 15 ; 15];
lengthVector = 3;

% Define system of nonlinear equations
syms x y z;
nonlinearEqs = [2*x - 3*y + z - 4; 2*x + y - z + 4; x.^2 + y.^2 + z.^2 - 4];

% Run algorithm
[solMatrix, resultErr, resultRes] = nm(9, initialGuess, nonlinearEqs, lengthVector);
solMatrix
resultErr
resultRes

% We can see that using Newton's Method with our starting point converges
% to the solution [-2/3 ; -4/3 ; 4/3] because in the solMatrix we
% are approaching the vector [-0.666 ; -1.333; 1.333]. Also, the
% resultErr vector shows that our relative error gets smaller with each 
% iteration approaching 0.

%%%% FUNCTION DEFINITIONS %%%%

% Code for Newton's Method for vector root-finding
function [out, error, residual] = nm(nMax, xn, equations, lengthVector)
    
    % Two solutions
    solOne = [-2/3 ; -4/3 ; 4/3];
    solTwo = [-6/7 ; -12/7 ; 4/7];
   
    % Outputs
    format compact;
    out = zeros(lengthVector, nMax);
    error = zeros(nMax, 1);
    residual = zeros(nMax, 1);
    
    syms x y z;
    jac = jacobian(equations);

    for i = 1:nMax
        nJac = double(subs(jac, [x; y; z], xn)); % Calc Jacobian at xn
        bigF =  double(subs(equations, [x; y; z], xn)); % Calc vector F at xn
        [L, U] = lu(nJac); % Calc vn using LU decomposition
        vn = U \ (L \ bigF);

        % Compute the error and residual
        errorVector = solOne - xn;
        residualVector = bigF - (nJac * xn);
        relativeError = norm(errorVector, Inf) ./ norm(solOne, Inf);
        relativeResidual = norm(residualVector, Inf) ./ norm(bigF, Inf);
        conditionNumber = cond(nJac, Inf);
     
        % Report Iterates
        fprintf('Iteration %d:\n',i);
        display(xn);
        display(nJac);
        display(bigF);
        display(vn);
        display(relativeError);
        display(relativeResidual);
        display(conditionNumber);
        fprintf('\n');
        
        % Finish loop
        out(:, i) = xn;
        error(i) = relativeError;
        residual(i) = relativeResidual;
        xn = xn - vn;
    end
end
    
