function [x, val] = gaMichEval(x, options)
    % Avalia a aptidão de uma trajetória baseada em múltiplos critérios
    % Entrada:
    %   - x: vetor de índices representando a trajetória
    %   - options: parâmetros adicionais para a personalização da avaliação (não utilizados neste caso)
    % Saída:
    %   - x: a trajetória original (não alterada)
    %   - val: aptidão da trajetória (fitness)
    
    % Configuração da arena
    gridSize = 9;  % Dimensão da matriz de landmarks
    distanceWeight = 10; % Peso para distância total percorrida
    landmarksWeight = 1; % Peso para número de landmarks visitados
    penaltyWeight = 5;   % Peso para penalizações de trajetórias inválidas
    maxDist = sqrt(2*(gridSize-1)^2) * 0.5; % Distância máxima possível entre dois pontos
    
    % Inicializa valores
    totalDistance = 0;  % Distância total percorrida
    penalty = 0;        % Penalidades acumuladas

    % Verifica se a trajetória é válida e calcula as distâncias
    for i = 1:length(x) - 1
        current = x(i);
        next = x(i + 1);

        % Converte os índices para coordenadas (linha, coluna)
        [currRow, currCol] = ind2sub([gridSize, gridSize], current);
        [nextRow, nextCol] = ind2sub([gridSize, gridSize], next);

        % Verifica movimentos inválidos (ex.: movimentos para trás ou fora do grid)
        if nextCol < currCol || abs(nextRow - currRow) > 1 || abs(nextCol - currCol) > 1
            penalty = penalty + penaltyWeight; % Penaliza movimentos inválidos
        end

        % Calcula a distância Euclidiana entre os landmarks
        distance = sqrt((nextRow - currRow)^2 + (nextCol - currCol)^2) * 0.5; % 0.5 é o espaçamento
        totalDistance = totalDistance + distance;

        % Penaliza loops (visitar o mesmo landmark mais de uma vez)
        if ismember(next, x(1:i))
            penalty = penalty + penaltyWeight; % Penaliza visitas redundantes
        end
    end

    % Calcula o número de landmarks visitados
    numLandmarks = length(x);

    % Normalização da distância
    normalizedDistance = totalDistance / maxDist; % Distância normalizada para evitar valores grandes

    % Função de aptidão com múltiplos critérios
    % Val = -(peso_distancia * distância_total + peso_landmarks * landmarks + penalidades)
    val = -(distanceWeight * normalizedDistance + landmarksWeight * numLandmarks + penalty);
    
    % Se a aptidão estiver muito negativa (indicando um erro ou trajetória inválida), a pontuação é normalizada
    if val < -1000
        val = -1000; % Definir um limite inferior para valores extremos
    end
end
