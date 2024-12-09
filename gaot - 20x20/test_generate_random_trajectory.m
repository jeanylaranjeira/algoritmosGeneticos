% Parâmetros do teste
gridSize = 9;
startPoint = 1;
endPoint = 81;

% Gerar uma trajetória aleatória
trajectory = generate_random_trajectory(startPoint, endPoint, gridSize);

% Exibir a trajetória gerada
disp('Trajetória gerada:');
disp(trajectory);

% Verificar a validade da trajetória
[xCoord, yCoord] = ind2sub([gridSize, gridSize], trajectory);
figure;
plot(xCoord, yCoord, 'b-o', 'LineWidth', 2);
hold on;
scatter(xCoord, yCoord, 'r', 'filled');
title('Trajetória Gerada');
xlabel('X (coluna)');
ylabel('Y (linha)');
grid on;
