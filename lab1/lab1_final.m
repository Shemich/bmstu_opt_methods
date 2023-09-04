function lab1_final()

function y = myFunction(x)
    N = N + 1; % Increase the computation counter
    function y = sh_func(x)
        y = sinh((3*x.^4 - x + sqrt(17) - 3)/2);
    end

    function y = sin_func(x)
        y = sin((nthroot(5,3)*x.^3 - nthroot(5,3)*x + 1 - 2*nthroot(5,3))/(-x.^3 + x + 2));
    end
    
    y = sh_func(x) + sin_func(x);
end
clc;

a = 0;
b = 1;
eps = power(10, -2);
turn_points = 1;
print_iter = 1;

% Инициализация счетчика вычислений
global N; % Declare N as a global variable
N = 0;

% Шаг1. Выбрать начальный шаг sh=(b-a)/4. Положить x0=a. Вычислить F(x0).
sh = (b - a) / 4;
x0 = a;
F0 = myFunction(x0);
iter = 1;

% Создание массивов для хранения последовательности точек
X_sequence = [];
F_sequence = [];


while(1)
    if (print_iter)
        fprintf('x%d=%f, f%d=%f\n', iter, x0, iter, F0);
        % Добавление точки в последовательность
        X_sequence = [X_sequence x0];
        F_sequence = [F_sequence F0];
        iter = iter + 1;
    end
    
    % Шаг2. Положить x1=x0+sh. Вычислить F(x1).
    x1 = x0 + sh;
    F1 = myFunction(x1);
    
    % Шаг3. Сравнить F(x0) и F(x1). Если F(x0)>F(x1), то перейти к шагу 4, иначе -- к шагу 5.
    if F0 > F1
        % Шаг4. Положить x0=x1 и F(x0)=F(x1). Проверить условие принадлежности x0 интервалу [a,b]. Если a < x0 < b, то перейти к шагу 2, иначе -- к шагу 5.
        x0 = x1; 
        F0 = F1;
        if x0 > a && x0 < b
            continue;
        end
    end
    % Шаг5. Проверка на окончание поиска: если |sh| <= eps, то вычисления завершить, полагая x=x0, F=F(x0), иначе -- перейти к шагу 6.
    if abs(sh) <= eps
        xm = x0; 
        Fm = F0;
        fprintf('\nx = %f\n', xm);
        fprintf('F = %f\n', Fm);
        break; 
    end
    % Шаг6. Изменить направление поиска: положить x0=x1, F(x0)=F(x1), sh=-sh/4. Перейти к шагу 2.
    x0 = x1;
    F0 = F1;
    sh = -sh / 4;
    continue;
end

% Вывод количества вычислений
fprintf('\nN = %d\n', N);

% График целевой функции
x = a:0.01:b;
y = myFunction(x);
figure;
plot(x, y);
hold on;

% График последовательности точек
if turn_points == 1
    plot(X_sequence, F_sequence, 'ro');
    hold on;
end

% График найденной точки минимума
plot(xm, Fm, 'g*', 'MarkerSize', 10);

xlabel('x');
ylabel('f(x)');
if turn_points == 1
    legend('Целевая функция', 'Последовательность точек', 'Точка минимума');
else
    legend('Целевая функция', 'Точка минимума');
end
title('График целевой функции и последовательности точек');

end
