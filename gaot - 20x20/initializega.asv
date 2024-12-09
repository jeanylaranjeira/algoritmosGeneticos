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
    gridSize = 20;           % Dimensão do grid (20x20, ajustável conforme necessidade)
    obstacles = [56,57,58,59,65,66,67,68,69,70,76,77,78,79,85,86,87,88,89,90,96,97,98,99,105,106,107,108,109,110,116,117,118,119,125,126,127,128,129,130,136,137,138,139,145,146,147,148,149,150,156,157,158,159,231,232,233,234,235,236,237,251,252,256,254,255,256,257,271,272,276,274,275,276,277,282,283,284,285,291,292,296,294,295,296,297,302,303,304,305,311,312,313,314,315,316,317,322,323,324,325,342,343,344,345]; % Landmarks com obstáculos

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
