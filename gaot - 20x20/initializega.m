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
    gridSize = 20;           % Dimens�o do grid (20x20, ajust�vel conforme necessidade)
    obstacles = [56,57,58,59,65,66,67,68,69,70,76,77,78,79,85,86,87,88,89,90,96,97,98,99,105,106,107,108,109,110,116,117,118,119,125,126,127,128,129,130,136,137,138,139,145,146,147,148,149,150,156,157,158,159,231,232,233,234,235,236,237,251,252,256,254,255,256,257,271,272,276,274,275,276,277,282,283,284,285,291,292,296,294,295,296,297,302,303,304,305,311,312,313,314,315,316,317,322,323,324,325,342,343,344,345]; % Landmarks com obst�culos

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
