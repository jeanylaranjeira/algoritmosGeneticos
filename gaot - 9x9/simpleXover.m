function [c1, c2] = simpleXover(p1, p2, bounds, Ops)
% Aplica crossover de um ponto simples e repara permutações inválidas
    numVars = length(p1);
    cPoint = randi([1 numVars - 1]);  % Define ponto de corte

    % Realiza crossover
    c1 = [p1(1:cPoint), p2(cPoint+1:end)];
    c2 = [p2(1:cPoint), p1(cPoint+1:end)];

    % Repara as permutações
    c1 = repairPermutation(c1);
    c2 = repairPermutation(c2);
end

function sol = repairPermutation(sol)
% Repara permutações inválidas (removendo duplicatas e completando ausentes)
    [~, uniqueIdx] = unique(sol, 'stable');
    duplicates = setdiff(1:length(sol), uniqueIdx);
    missing = setdiff(1:length(sol), sol);

    for i = 1:length(duplicates)
        sol(duplicates(i)) = missing(i);
    end
end
