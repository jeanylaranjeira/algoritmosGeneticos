function [mutant] = binaryMutation(parent, bounds, Ops)
% Troca dois landmarks aleatórios na sequência
    mutationRate = Ops(2);
    numVars = length(parent);

    if rand < mutationRate
        % Seleciona dois índices aleatórios
        idx = randperm(numVars, 2);
        % Realiza a troca
        temp = parent(idx(1));
        parent(idx(1)) = parent(idx(2));
        parent(idx(2)) = temp;
    end

    mutant = parent;
end
