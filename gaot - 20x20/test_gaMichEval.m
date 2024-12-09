% Configuração
gridSize = 20;  % Dimensão do grid
numLandmarks = gridSize^2;

% Exemplos de trajetórias
traj1 = [1, 10, 19, 28, 37, 46, 55, 64, 73];  % Trajetória válida
traj2 = [1, 12, 23, 34, 45, 56, 67, 78, 81];  % Trajetória inválida

% Avaliação
[~, fitness1] = JeanygaMichEval(traj1, []);
[~, fitness2] = JeanygaMichEval(traj2, []);

disp('Trajetória 1 (Válida):');
disp(traj1);
disp(['Fitness: ', num2str(fitness1)]);

disp('Trajetória 2 (Inválida):');
disp(traj2);
disp(['Fitness: ', num2str(fitness2)]);
