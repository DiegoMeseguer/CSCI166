%% 5) Cancellation Errors from a class example

% a)

domain = linspace(-5*10^-5, 5*10^-5,1000);
f = domain - sin(domain);
g = (domain.^3)/6 - (domain.^5)/120;
 
plot(domain, f, domain, g, "LineWidth", 2);
title("Graph A")
legend("f(x)", "g(x)");
figure()

% b)

domain = linspace(-5*10^-8, 5*10^-8,1000);
f = domain - sin(domain);
g = (domain.^3)/6 - (domain.^5)/120;

plot(domain, f, domain, g, "LineWidth", 2);
title("Graph B")
legend("f(x)", "g(x)");
figure()

% c)

domain = linspace(-4, 4, 1000);
f = domain - sin(domain);
g = (domain.^3)/6 - (domain.^5)/120;

plot(domain, f, domain, g, "LineWidth", 2);
title("Graph C")
legend("f(x)", "g(x)");
figure()


% In Graph A both f(x) and g(x) are good representations and there are no
% issues with cancellation error. In Graph B we start to get values
% that are much closer to 0 and we notice that f(x) loses precision
% when x is close to 0 and g(x) is a much better approximation.
% In graph C we can see that both are doing fine near 0 but
% g(x), which is only useful near 0, stops being accurate as we go to
% larger postive and negative numbers.