function test_population()
    % Testa a gera��o de uma popula��o inicial com trajet�rias v�lidas
bounds = [1, 400];  % Do landmark 1 ao 81
populationSize = 100;  % N�mero de indiv�duos na popula��o
evalFN = 'JeanygaMichEval';  % Nome da fun��o de avalia��o
evalOps = [];  % Op��es adicionais para a fun��o de avalia��o
options = [];  % Op��es adicionais (n�o utilizado)

% Gera a popula��o inicial
pop = initializega(populationSize, bounds, evalFN, evalOps, options);

% Exibe a popula��o inicial
disp('Popula��o Inicial:');
for i = 1:populationSize
    trajectory = pop(i, 1:end-1);  % Trajet�ria (exclui o fitness)
    fitness = pop(i, end);         % Valor de aptid�o

    % Remove zeros da trajet�ria para melhor visualiza��o
    trajectory = trajectory(trajectory > 0);

    disp(['Indiv�duo ', num2str(i), ':']);
    disp(['Trajet�ria: ', num2str(trajectory)]);
    disp(['Fitness: ', num2str(fitness)]);
    disp('-----------------------------');
end

