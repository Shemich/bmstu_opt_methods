function lab2_final()

    function y = myFunctionPlot(x)
        function y = sh_func(x)
            y = sinh((3*x.^4 - x + sqrt(17) - 3)/2);
        end

        function y = sin_func(x)
            y = sin((nthroot(5,3)*x.^3 - nthroot(5,3)*x + 1 - 2*nthroot(5,3))/(-x.^3 + x + 2));
        end

        y = sh_func(x) + sin_func(x);
    end
    
    function y = myFunction(x)
        N = N + 1;
        function y = sh_func(x)
            y = sinh((3*x.^4 - x + sqrt(17) - 3)/2);
        end

        function y = sin_func(x)
            y = sin((nthroot(5,3)*x.^3 - nthroot(5,3)*x + 1 - 2*nthroot(5,3))/(-x.^3 + x + 2));
        end

        y = sh_func(x) + sin_func(x);
    end

    global N;
    N = 0;
    print_intermediate = 1; % Вкл отображение отрезков
    print_iter = 1; % Вкл последовательности отрезков
    iter = 1;
    
    a = 0;
    b = 1;
    eps = power(10, -2);

    % τ=(√5-1)/2
    tau = (sqrt(5)-1)/2;
    L = b - a;

    x1 = b - L * tau;
    x2 = a + L * tau;

    f1 = myFunction(x1);
    f2 = myFunction(x2);

    x_vals = [a, b]; % Сохраняем значения для графика
    f_vals = [myFunctionPlot(a), myFunctionPlot(b)];

    while(1)
        if L > 2*eps
            if (print_iter)
                fprintf('A%d=%7.5f, B%d=%7.5f, x1=%7.5f, x2=%7.5f\n', iter, a, iter, b, x1, x2);
            end
            iter = iter + 1;
            if f1 <= f2
               b = x2;
               L = b - a;
               x2 = x1;
               f2 = f1;
               x1 = b - L*tau;
               f1 = myFunction(x1);
            else
               a = x1;
               L = b - a;
               x1 = x2;
               f1 = f2;
               x2 = a + L*tau;
               f2 = myFunction(x2);
            end
            % Сохраняем значения для графика
            x_vals = [x_vals, a, b];
            f_vals = [f_vals, myFunctionPlot(a), myFunctionPlot(b)];
        else
            x_ = (a + b)/2;
            f_ = myFunction(x_);
            fprintf('\nВывод:\n');
            fprintf("x* = %f\nf* = %f\n", x_, f_);

            % Вывод графика целевой функции и отрезков
            figure;
            x_range = linspace(-0.2, 1.2, 400);
            y_range = arrayfun(@myFunctionPlot, x_range);
            plot(x_range, y_range, 'b');
            hold on;
            if print_intermediate
                for idx=1:length(x_vals)
                    plot(x_vals(1:idx), f_vals(1:idx), 'ro');
                    pause(0.5);
                    hold on;
                end
            end
            plot(x_, f_, 'go'); % Добавляем точку минимума
            xlabel('x');
            ylabel('f(x)');
            title('График целевой функции и отрезков');
            if print_intermediate
                legend('Целевая функция', 'Точки отрезков', 'Точка минимума', 'Location', 'best');
            else
                legend('Целевая функция', 'Точка минимума', 'Location', 'best');
            end
            grid on;
            hold off;
            break;
        end
    end
    % Вывод количества вычислений
    fprintf('\nN = %d\n', N);
end
