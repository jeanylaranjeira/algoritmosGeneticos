function test_population()
    % Testa a geração de uma população inicial com trajetórias válidas
bounds = [1, 400];  % Do landmark 1 ao 81
populationSize = 100;  % Número de indivíduos na população
evalFN = 'JeanygaMichEval';  % Nome da função de avaliação
evalOps = [];  % Opções adicionais para a função de avaliação
options = [];  % Opções adicionais (não utilizado)

% Gera a população inicial
pop = initializega(populationSize, bounds, evalFN, evalOps, options);

% Exibe a população inicial
disp('População Inicial:');
for i = 1:populationSize
    trajectory = pop(i, 1:end-1);  % Trajetória (exclui o fitness)
    fitness = pop(i, end);         % Valor de aptidão

    % Remove zeros da trajetória para melhor visualização
    trajectory = trajectory(trajectory > 0);

    disp(['Indivíduo ', num2str(i), ':']);
    disp(['Trajetória: ', num2str(trajectory)]);
    disp(['Fitness: ', num2str(fitness)]);
    disp('-----------------------------');
end

