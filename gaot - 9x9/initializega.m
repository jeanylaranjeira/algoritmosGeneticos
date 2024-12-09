function [pop] = initializega(num, bounds, evalFN, evalOps, options)
    % Inicializa a população com trajetórias válidas
    % num: Número de indivíduos na população
    % bounds: Limites do problema (ponto inicial e ponto final)
    % evalFN: Nome da função de avaliação
    % evalOps: Opções adicionais para a função de avaliação
    % options: Não utilizado neste caso
    
    % Configurações iniciais
    startPoint = bounds(1);  % Ponto inicial
    endPoint = bounds(2);    % Ponto final
    gridSize = 9;           % Dimensão do grid (20x20, ajustável conforme necessidade)
    obstacles = [21,22,30,31,51,52,60,61]; % Landmarks com obstáculos

    % Inicializa a população
    pop = zeros(num, gridSize * gridSize);  % Inicialização de indivíduos com o máximo de tamanho possível

    % Gera cada indivíduo da população
    for i = 1:num
        % Gera uma trajetória aleatória válida
        trajectory = generate_random_trajectory(startPoint, endPoint, gridSize, obstacles);

        % Ajusta o tamanho da trajetória
        lenTrajectory = length(trajectory);  % Comprimento da trajetória gerada
        if lenTrajectory > gridSize^2
            % Caso a trajetória exceda o tamanho máximo, ajuste
            trajectory = trajectory(1:gridSize^2);
        elseif lenTrajectory < gridSize^2
            % Preenche com zeros até o tamanho máximo
            trajectory = [trajectory, zeros(1, gridSize^2 - lenTrajectory)];
        end

        % Armazena a trajetória gerada
        pop(i, 1:length(trajectory)) = trajectory;

        % Avalia a aptidão para a solução gerada
        [~, val] = feval(evalFN, trajectory(trajectory > 0), evalOps);  % Remove zeros antes da avaliação
        pop(i, end) = val;  % Armazena o valor de aptidão na última coluna
    end
end
