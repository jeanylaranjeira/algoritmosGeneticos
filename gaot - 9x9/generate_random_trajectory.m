function trajectory = generate_random_trajectory(startPoint, endPoint, gridSize, obstacles)
    % Gera uma trajet�ria aleat�ria v�lida entre o ponto inicial e final,
    % movendo apenas para frente, lado ou diagonal para frente, evitando obst�culos.
    % A trajet�ria deve sempre se mover para o ponto mais pr�ximo do objetivo,
    % e nunca para uma posi��o de landmark menor do que a posi��o atual.
    % 
    % Par�metros:
    %   startPoint - �ndice do ponto inicial.
    %   endPoint - �ndice do ponto final.
    %   gridSize - dimens�o da matriz (grade).
    %   obstacles - vetor com os �ndices dos landmarks que representam obst�culos.
    %
    % Sa�da:
    %   trajectory - vetor com a trajet�ria gerada.

    trajectory = startPoint;
    [currentRow, currentCol] = ind2sub([gridSize, gridSize], startPoint);
    [endRow, endCol] = ind2sub([gridSize, gridSize], endPoint);

    while currentRow ~= endRow || currentCol ~= endCol
        % Determinar movimentos poss�veis (frente, lado ou diagonal)
        possibleMoves = [];

        % Movimento para frente (mesma linha, pr�xima coluna)
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

        % Movimento lateral (mesma coluna, pr�xima linha)
        if currentRow > 1
            nextRow = currentRow - 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], nextRow, currentCol)];
        end
        if currentRow < gridSize
            nextRow = currentRow + 1;
            possibleMoves = [possibleMoves; sub2ind([gridSize, gridSize], nextRow, currentCol)];
        end

        % Remover movimentos inv�lidos (obst�culos e duplicatas)
        possibleMoves = unique(possibleMoves);
        possibleMoves = setdiff(possibleMoves, obstacles);

        % Garantir que os movimentos v�o em dire��o ao destino e n�o para posi��es menores
        validMoves = [];
        for move = possibleMoves'
            [moveRow, moveCol] = ind2sub([gridSize, gridSize], move);
            % Garante que o movimento sempre leva para frente ou para lados
            if (moveRow >= currentRow && moveCol >= currentCol) % Nunca para tr�s
                validMoves = [validMoves; move];
            end
        end

        if isempty(validMoves)
            % Se n�o houver movimentos v�lidos, a trajet�ria falhou
            error('Trajet�ria inv�lida: n�o h� movimentos v�lidos dispon�veis.');
        end

        % Escolher um pr�ximo passo aleat�rio v�lido
        nextStep = validMoves(randi(length(validMoves)));
        trajectory = [trajectory, nextStep];
        [currentRow, currentCol] = ind2sub([gridSize, gridSize], nextStep);
    end
end
