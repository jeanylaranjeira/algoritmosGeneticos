function trajectory = generate_random_trajectory(startPoint, endPoint, gridSize, obstacles)
    % Gera uma trajetória aleatória válida entre o ponto inicial e final,
    % movendo apenas para frente, lado ou diagonal para frente, evitando obstáculos.
    % A trajetória deve sempre se mover para o ponto mais próximo do objetivo,
    % e nunca para uma posição de landmark menor do que a posição atual.
    % 
    % Parâmetros:
    %   startPoint - índice do ponto inicial.
    %   endPoint - índice do ponto final.
    %   gridSize - dimensão da matriz (grade).
    %   obstacles - vetor com os índices dos landmarks que representam obstáculos.
    %
    % Saída:
    %   trajectory - vetor com a trajetória gerada.

    trajectory = startPoint;
    [currentRow, currentCol] = ind2sub([gridSize, gridSize], startPoint);
    [endRow, endCol] = ind2sub([gridSize, gridSize], endPoint);

    while currentRow ~= endRow || currentCol ~= endCol
        % Determinar movimentos possíveis (frente, lado ou diagonal)
        possibleMoves = [];

        % Movimento para frente (mesma linha, próxima coluna)
        if currentCol < endCol
            nextCol = currentCol + 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], currentRow, nextCol)];
        end

        % Movimento diagonal para frente (para cima e para baixo)
        if currentCol < endCol && currentRow > 1
            nextRow = currentRow - 1;
            nextCol = currentCol + 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], nextRow, nextCol)];
        end
        if currentCol < endCol && currentRow < gridSize
            nextRow = currentRow + 1;
            nextCol = currentCol + 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], nextRow, nextCol)];
        end

        % Movimento lateral (mesma coluna, próxima linha)
        if currentRow > 1
            nextRow = currentRow - 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], nextRow, currentCol)];
        end
        if currentRow < gridSize
            nextRow = currentRow + 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], nextRow, currentCol)];
        end

        % Remover movimentos inválidos (obstáculos e duplicatas)
        possibleMoves = unique(possibleMoves);
        possibleMoves = setdiff(possibleMoves, obstacles);

        % Garantir que os movimentos vão em direção ao destino e não para posições menores
        validMoves = [];
        for move = possibleMoves'
            [moveRow, moveCol] = ind2sub([gridSize, gridSize], move);
            % Garante que o movimento sempre leva para frente ou para lados
            if (moveRow >= currentRow && moveCol >= currentCol) % Nunca para trás
                validMoves = [validMoves; move];
            end
        end

        if isempty(validMoves)
            % Se não houver movimentos válidos, a trajetória falhou
            error('Trajetória inválida: não há movimentos válidos disponíveis.');
        end

        % Escolher um próximo passo aleatório válido
        nextStep = validMoves(randi(length(validMoves)));
        trajectory = [trajectory, nextStep];
        [currentRow, currentCol] = ind2sub([gridSize, gridSize], nextStep);
    end
end
