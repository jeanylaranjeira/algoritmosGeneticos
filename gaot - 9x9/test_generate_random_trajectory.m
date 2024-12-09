% Par�metros do teste
gridSize = 9;
startPoint = 1;
endPoint = 81;

% Gerar uma trajet�ria aleat�ria
trajectory = generate_random_trajectory(startPoint, endPoint, gridSize);

% Exibir a trajet�ria gerada
disp('Trajet�ria gerada:');
disp(trajectory);

% Verificar a validade da trajet�ria
[xCoord, yCoord] = ind2sub([gridSize, gridSize], trajectory);
figure;
plot(xCoord, yCoord, 'b-o', 'LineWidth', 2);
hold on;
scatter(xCoord, yCoord, 'r', 'filled');
title('Trajet�ria Gerada');
xlabel('X (coluna)');
ylabel('Y (linha)');
grid on;
