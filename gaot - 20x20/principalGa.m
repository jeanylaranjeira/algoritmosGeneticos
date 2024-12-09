% Script principal para rodar o algoritmo genético (GA) com trajetórias de landmarks
clear; clc;

% Configurações gerais
numGenerations = 100;      % Número de gerações aumentadas
populationSize = 200;      % Tamanho da população
mutationRate = 0.1;        % Taxa de mutação aumentada
crossoverRate = 0.5;       % Taxa de crossover
numLandmarks = 400;         % Número total de landmarks (20x20)

% Limites de cada variável (índices dos landmarks)
bounds = [1 numLandmarks]; % Índices válidos para landmarks

% Opções do GA
gaOpts = [1e-6 0 1];       % [precisão, binário/float, exibição]

% Inicialização da população
startPop = initializega(populationSize, bounds, 'gaMichEval', [], gaOpts);

% Separar trajetórias e aptidões
trajectories = startPop(:, 1:end-1); % Exclui a última coluna (aptidão)
fitnessValues = startPop(:, end);    % Última coluna contém os valores de aptidão

% Configurações dos operadores do GA
xFns = 'simpleXover';        % Operador de crossover
xOpts = [crossoverRate];     % Taxa de crossover
mFns = 'binaryMutation';     % Operador de mutação
mOpts = [mutationRate];      % Taxa de mutação
termFns = 'maxGenTerm';      % Critério de término
termOps = [numGenerations];  % Número de gerações
selectFn = 'roulette';       % Método de seleção
selectOps = [];              % Sem parâmetros adicionais para seleção

% Inicia o cronômetro para a execução do GA
tic;

% Executar o GA
[x, endPop, bestPop, trace] = ga(bounds, 'gaMichEval', [], ...
    startPop, gaOpts, termFns, termOps, selectFn, selectOps, ...
    xFns, xOpts, mFns, mOpts);

% Imprime o tempo de execução
tempoExecucaoGA = toc;
disp(['Tempo de execução do Algoritmo Genético: ', num2str(tempoExecucaoGA), ' segundos']);

pause

% Exibir a melhor solução encontrada
disp('Melhor solucaoo encontrada:');
bestTrajectory = x(:, 1:end-1);  % Melhor trajetória
cleanedTrajectory = bestTrajectory(bestTrajectory > 0); % Remove zeros
disp('Trajetoria (sequencia de landmarks):');
disp(cleanedTrajectory);

pause

% Avaliar a aptidão da melhor trajetória
[~, fitnessValue] = gaMichEval(cleanedTrajectory, []);
disp('Valor da aptidão da melhor solução:');
disp(-1 / fitnessValue); % Remove negatividade da aptidão
pause

% Número de landmarks visitados
numLandmarksVisited = length(cleanedTrajectory);
disp('Número de landmarks visitados:');
disp(numLandmarksVisited);

pause

% Gráfico da trajetória da melhor solução
gridSize = 20;  % Dimensão da matriz de landmarks
[xCoord, yCoord] = ind2sub([gridSize, gridSize], cleanedTrajectory); % Coordenadas (x, y)

figure;
plot(xCoord, yCoord, 'b-o', 'LineWidth', 2);
hold on;
scatter(xCoord, yCoord, 'r', 'filled'); % Posição dos pontos
title('Melhor Trajetória Encontrada');
xlabel('X (coluna)');
ylabel('Y (linha)');
grid on;

% Pausa para visualização da trajetória e número de landmarks
pause;

% Gráfico da evolução da aptidão ao longo das gerações
figure;
plot(trace(:, 1), trace(:, 2), 'b-', 'LineWidth', 2); % Melhor aptidão
hold on;
plot(trace(:, 1), trace(:, 3), 'r--', 'LineWidth', 2); % Aptidão média
title('Evolução da Aptidão ao Longo das Gerações');
xlabel('Geração');
ylabel('Aptidão');
legend('Melhor Aptidão', 'Aptidão Média');
grid on;

% Distribuição Inicial das Trajetórias
figure;
hold on;
for i = 1:size(trajectories, 1)
    traj = trajectories(i, trajectories(i, :) > 0); % Remover zeros
    [xCoord, yCoord] = ind2sub([gridSize, gridSize], traj);
    plot(xCoord, yCoord, '-o', 'LineWidth', 1);
end
title('Trajetórias Iniciais');
xlabel('X (coluna)');
ylabel('Y (linha)');
grid on;

% Comparação: Trajetória Inicial x Trajetória Final
figure;
% Trajetória inicial
initialBest = trajectories(1, trajectories(1, :) > 0); % Exemplo: melhor inicial
[xInitial, yInitial] = ind2sub([gridSize, gridSize], initialBest);
plot(xInitial, yInitial, 'g--o', 'LineWidth', 2); % Verde para inicial
hold on;

% Trajetória final
[xFinal, yFinal] = ind2sub([gridSize, gridSize], bestTrajectory(bestTrajectory > 0));
plot(xFinal, yFinal, 'b-o', 'LineWidth', 2); % Azul para final

title('Comparação: Trajetória Inicial x Trajetória Final');
xlabel('X (coluna)');
ylabel('Y (linha)');
legend('Trajetória Inicial', 'Trajetória Final');
grid on;

% Mapa de Calor de Visitação
heatmap = zeros(gridSize);
for i = 1:size(trajectories, 1)
    traj = trajectories(i, trajectories(i, :) > 0);
    [x, y] = ind2sub([gridSize, gridSize], traj);
    for j = 1:length(x)
        heatmap(x(j), y(j)) = heatmap(x(j), y(j)) + 1;
    end
end
figure;
imagesc(heatmap);
colorbar;
title('Mapa de Calor de Visitação');
xlabel('X (coluna)');
ylabel('Y (linha)');

% Histograma de Comprimento das Trajetórias
lengths = arrayfun(@(i) sum(trajectories(i, :) > 0), 1:size(trajectories, 1));
figure;
histogram(lengths, 'BinWidth', 1);
title('Histograma de Comprimento das Trajetórias');
xlabel('Comprimento da Trajetória');
ylabel('Frequência');
grid on;
