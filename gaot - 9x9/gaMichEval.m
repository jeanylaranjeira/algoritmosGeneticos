function [x, val] = gaMichEval(x, options)
    % Avalia a aptid�o de uma trajet�ria baseada em m�ltiplos crit�rios
    % Entrada:
    %   - x: vetor de �ndices representando a trajet�ria
    %   - options: par�metros adicionais para a personaliza��o da avalia��o (n�o utilizados neste caso)
    % Sa�da:
    %   - x: a trajet�ria original (n�o alterada)
    %   - val: aptid�o da trajet�ria (fitness)
    
    % Configura��o da arena
    gridSize = 9;  % Dimens�o da matriz de landmarks
    distanceWeight = 10; % Peso para dist�ncia total percorrida
    landmarksWeight = 1; % Peso para n�mero de landmarks visitados
    penaltyWeight = 5;   % Peso para penaliza��es de trajet�rias inv�lidas
    maxDist = sqrt(2*(gridSize-1)^2) * 0.5; % Dist�ncia m�xima poss�vel entre dois pontos
    
    % Inicializa valores
    totalDistance = 0;  % Dist�ncia total percorrida
    penalty = 0;        % Penalidades acumuladas

    % Verifica se a trajet�ria � v�lida e calcula as dist�ncias
    for i = 1:length(x) - 1
        current = x(i);
        next = x(i + 1);

        % Converte os �ndices para coordenadas (linha, coluna)
        [currRow, currCol] = ind2sub([gridSize, gridSize], current);
        [nextRow, nextCol] = ind2sub([gridSize, gridSize], next);

        % Verifica movimentos inv�lidos (ex.: movimentos para tr�s ou fora do grid)
        if nextCol < currCol || abs(nextRow - currRow) > 1 || abs(nextCol - currCol) > 1
            penalty = penalty + penaltyWeight; % Penaliza movimentos inv�lidos
        end

        % Calcula a dist�ncia Euclidiana entre os landmarks
        distance = sqrt((nextRow - currRow)^2 + (nextCol - currCol)^2) * 0.5; % 0.5 � o espa�amento
        totalDistance = totalDistance + distance;

        % Penaliza loops (visitar o mesmo landmark mais de uma vez)
        if ismember(next, x(1:i))
            penalty = penalty + penaltyWeight; % Penaliza visitas redundantes
        end
    end

    % Calcula o n�mero de landmarks visitados
    numLandmarks = length(x);

    % Normaliza��o da dist�ncia
    normalizedDistance = totalDistance / maxDist; % Dist�ncia normalizada para evitar valores grandes

    % Fun��o de aptid�o com m�ltiplos crit�rios
    % Val = -(peso_distancia * dist�ncia_total + peso_landmarks * landmarks + penalidades)
    val = -(distanceWeight * normalizedDistance + landmarksWeight * numLandmarks + penalty);
    
    % Se a aptid�o estiver muito negativa (indicando um erro ou trajet�ria inv�lida), a pontua��o � normalizada
    if val < -1000
        val = -1000; % Definir um limite inferior para valores extremos
    end
end
