function [pop] = initializega(num, bounds, evalFN, evalOps, options)
    % Inicializa a popula��o com trajet�rias v�lidas
    % num: N�mero de indiv�duos na popula��o
    % bounds: Limites do problema (ponto inicial e ponto final)
    % evalFN: Nome da fun��o de avalia��o
    % evalOps: Op��es adicionais para a fun��o de avalia��o
    % options: N�o utilizado neste caso
    
    % Configura��es iniciais
    startPoint = bounds(1);  % Ponto inicial
    endPoint = bounds(2);    % Ponto final
    gridSize = 9;           % Dimens�o do grid (20x20, ajust�vel conforme necessidade)
    obstacles = [21,22,30,31,51,52,60,61]; % Landmarks com obst�culos

    % Inicializa a popula��o
    pop = zeros(num, gridSize * gridSize);  % Inicializa��o de indiv�duos com o m�ximo de tamanho poss�vel

    % Gera cada indiv�duo da popula��o
    for i = 1:num
        % Gera uma trajet�ria aleat�ria v�lida
        trajectory = generate_random_trajectory(startPoint, endPoint, gridSize, obstacles);

        % Ajusta o tamanho da trajet�ria
        lenTrajectory = length(trajectory);  % Comprimento da trajet�ria gerada
        if lenTrajectory > gridSize^2
            % Caso a trajet�ria exceda o tamanho m�ximo, ajuste
            trajectory = trajectory(1:gridSize^2);
        elseif lenTrajectory < gridSize^2
            % Preenche com zeros at� o tamanho m�ximo
            trajectory = [trajectory, zeros(1, gridSize^2 - lenTrajectory)];
        end

        % Armazena a trajet�ria gerada
        pop(i, 1:length(trajectory)) = trajectory;

        % Avalia a aptid�o para a solu��o gerada
        [~, val] = feval(evalFN, trajectory(trajectory > 0), evalOps);  % Remove zeros antes da avalia��o
        pop(i, end) = val;  % Armazena o valor de aptid�o na �ltima coluna
    end
end
