% Configura��o
gridSize = 20;  % Dimens�o do grid
numLandmarks = gridSize^2;

% Exemplos de trajet�rias
traj1 = [1, 10, 19, 28, 37, 46, 55, 64, 73];  % Trajet�ria v�lida
traj2 = [1, 12, 23, 34, 45, 56, 67, 78, 81];  % Trajet�ria inv�lida

% Avalia��o
[~, fitness1] = JeanygaMichEval(traj1, []);
[~, fitness2] = JeanygaMichEval(traj2, []);

disp('Trajet�ria 1 (V�lida):');
disp(traj1);
disp(['Fitness: ', num2str(fitness1)]);

disp('Trajet�ria 2 (Inv�lida):');
disp(traj2);
disp(['Fitness: ', num2str(fitness2)]);
