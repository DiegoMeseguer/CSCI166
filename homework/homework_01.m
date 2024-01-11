%% 1) Plotting

range = linspace(0,pi);
y = sin(range);
plot(range, y)
%% 2) Linear Algebra

% a)

A = [1 2 ; 3 -1];
B = [1 2 0 ; 3 -1 -1];
x = [4 ; -2];

A
B
x

% b)

product_01 = A * B;
product_02 = A * x;
product_03 = B' * x;

product_01
product_02
product_03

%% 3) Programming Loops

% a)

matrix_a = zeros(10,12);
for i = 1:10
    for j = 1:12
        if rem(i+j,2) == 0
            matrix_a(i,j) = i + j;
        else
            matrix_a(i,j) = i - (2 * j);
        end
    end
end

matrix_a

% b)

matrix_b = 1:100;
for j = 2:100
    matrix_b(j) = (3 * matrix_b(j-1)) / (matrix_b(j-1)^2 + 1);
end

matrix_b = matrix_b';

matrix_b
%% 4) Displaying Results in a Table

values = [1  0.1 0.01  0.001 0.0001];
values = values';

y = ones(1,5);
for i = 1:5
    y(i) = sin(values(i))/values(i);
end
y = y';

z = ones(1,5);
for j = 1:5
    z(j) = abs(sin(values(j))/values(j) - 1);
end
z = z';

format long;

my_table = table(values, y, z);

my_table.Properties.VariableNames = ["x", "f(x)", "e(x)"];
my_table.Properties.RowNames = ["1", "2", "3", "4", "5"];

my_table














