% Parâmetros
gridSize = 20;
startPoint = 1; % Início
endPoint = 400; % Fim
obstacles = [56,57,58,59,65,66,67,68,69,70,76,77,78,79,85,86,87,88,89,90,96,97,98,99,105,106,107,108,109,110,116,117,118,119,125,126,127,128,129,130,136,137,138,139,145,146,147,148,149,150,156,157,158,159,231,232,233,234,235,236,237,251,252,256,254,255,256,257,271,272,276,274,275,276,277,282,283,284,285,291,292,296,294,295,296,297,302,303,304,305,311,312,313,314,315,316,317,322,323,324,325,342,343,344,345]; % Landmarks com obstáculos


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
