% Par�metros
gridSize = 9;
startPoint = 1; % In�cio
endPoint = gridSize * gridSize; % Fim
obstacles = [21,22,30,31,51,52,60,61]; % Landmarks com obst�culos


% Gerar a trajet�ria
trajectory = generate_random_trajectory(startPoint, endPoint, gridSize, obstacles);

% Exibir a trajet�ria
disp('Trajet�ria gerada:');
disp(trajectory);

% Verificar a validade da trajet�ria
[xCoord, yCoord] = ind2sub([gridSize, gridSize], trajectory);
figure;
plot(xCoord, yCoord, 'b-o', 'LineWidth', 2);
hold on;
scatter(xCoord, yCoord, 'r', 'filled');
title('Trajet�ria Gerada (Evitando Obst�culos e Movimentos para Tr�s)');
xlabel('X (coluna)');
ylabel('Y (linha)');
grid on;
