clc;
function [y_interp, error] = interpolacionLineal(x, y, x_interp)

% Inicialización
y_interp = zeros(size(x_interp));
error = zeros(size(x_interp));

% Calcular el valor real para el cálculo del error
y_real = log(x_interp); % Asumiendo que la función real es ln(x)

% Iterar sobre cada punto a interpolar
for i = 1:length(x_interp)
    % Manejar los casos fuera del rango de x
    if x_interp(i) < min(x)
        % Si está por debajo del mínimo de x, usar el primer intervalo
        x1 = x(1);
        y1 = y(1);
        x2 = x(2);
        y2 = y(2);
        y_interp(i) = y1 + (x_interp(i) - x1) * (y2 - y1) / (x2 - x1);

    elseif x_interp(i) > max(x)
        % Si está por encima del máximo de x, usar el último intervalo
        x1 = x(end-1);
        y1 = y(end-1);
        x2 = x(end);
        y2 = y(end);
        y_interp(i) = y1 + (x_interp(i) - x1) * (y2 - y1) / (x2 - x1);

    else
        % Encontrar los dos puntos más cercanos en x
        [~, idx] = min(abs(x - x_interp(i)));

        % Si el punto a interpolar coincide con un nodo, usar el valor conocido
        if any(x == x_interp(i))
            y_interp(i) = y(x == x_interp(i));
        else
            % Determinar los nodos a usar para la interpolación
            if x_interp(i) < x(idx)
                x1 = x(idx-1);
                y1 = y(idx-1);
                x2 = x(idx);
                y2 = y(idx);
            else
                x1 = x(idx);
                y1 = y(idx);
                x2 = x(idx+1);
                y2 = y(idx+1);
            end

            % Interpolación lineal
            y_interp(i) = y1 + (x_interp(i) - x1) * (y2 - y1) / (x2 - x1);
        end
    end
    % Calcular el error
    error(i) = abs(((y_interp(i) - y_real(i))/y_real(i))*100);
end
end

% Ejemplo de uso:
% Definir los nodos (puntos conocidos)
x = [1, 4];
y = [log(1), log(4)]; % Usar log(1) y log(4) para los valores de y

% Punto donde se quiere interpolar (ln(2))
x_interp = 2;

% Realizar la interpolación
[y_interp, error] = interpolacionLineal(x, y, x_interp);

% Mostrar los resultados en la consola
fprintf('Resultados de la Interpolación Lineal para ln(2):\n');
fprintf('x = %.2f, y_interp (ln(2)) = %.4f, Error porcentual = %.4f\n', x_interp, y_interp, error);
