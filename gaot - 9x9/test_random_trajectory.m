% Parâmetros
gridSize = 9;
startPoint = 1; % Início
endPoint = gridSize * gridSize; % Fim
obstacles = [21,22,30,31,51,52,60,61]; % Landmarks com obstáculos


% Gerar a trajetória
trajectory = generate_random_trajectory(startPoint, endPoint, gridSize, obstacles);

% Exibir a trajetória
disp('Trajetória gerada:');
disp(trajectory);

% Verificar a validade da trajetória
[xCoord, yCoord] = ind2sub([gridSize, gridSize], trajectory);
figure;
plot(xCoord, yCoord, 'b-o', 'LineWidth', 2);
hold on;
scatter(xCoord, yCoord, 'r', 'filled');
title('Trajetória Gerada (Evitando Obstáculos e Movimentos para Trás)');
xlabel('X (coluna)');
ylabel('Y (linha)');
grid on;
