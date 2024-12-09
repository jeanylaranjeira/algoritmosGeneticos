function [x, endPop, bPop, traceInfo] = ga(bounds, evalFN, evalOps, startPop, opts, ...
    termFN, termOps, selectFN, selectOps, xOverFNs, xOverOps, mutFNs, mutOps)
% GA: Run a genetic algorithm
% Adjusted to avoid `eval` and ensure compatibility with evaluation functions.

n = nargin;
if n < 2 || n == 6 || n == 10 || n == 12
    disp('Insufficient arguments');
    return;
end
if n < 3
    evalOps = [];
end
if n < 5
    opts = [1e-6 1 0];
end
if isempty(opts)
    opts = [1e-6 1 0];
end

if n < 6
    termOps = [100];
    termFN = 'maxGenTerm';
end
if n < 12
    if opts(2) == 1
        mutFNs = 'binaryMutation';
        mutOps = [0.05];
    else
        mutFNs = 'binaryMutation';
        mutOps = [0.05];
    end
end
if n < 10
    if opts(2) == 1
        xOverFNs = 'simpleXover';
        xOverOps = [0.8];
    else
        xOverFNs = 'simpleXover';
        xOverOps = [0.8];
    end
end
if n < 9
    selectOps = [];
end
if n < 8
    selectFN = 'roulette';
    selectOps = [];
end
if n < 4
    startPop = [];
end
if isempty(startPop)
    startPop = initializega(80, bounds, evalFN, evalOps, opts(1:2));
end

xZomeLength = size(startPop, 2);
numVar = xZomeLength - 1;
popSize = size(startPop, 1);
endPop = zeros(popSize, xZomeLength);
c1 = zeros(1, xZomeLength);
c2 = zeros(1, xZomeLength);
epsilon = opts(1);
oval = max(startPop(:, xZomeLength));
bFoundIn = 1;
done = 0;
gen = 1;
collectTrace = (nargout > 3);
floatGA = opts(2) == 1;
display = opts(3);

while ~done
    % Elitist Model
    [bval, bindx] = max(startPop(:, xZomeLength));
    best = startPop(bindx, :);

    if collectTrace
        traceInfo(gen, 1) = gen;
        traceInfo(gen, 2) = startPop(bindx, xZomeLength);
        traceInfo(gen, 3) = mean(startPop(:, xZomeLength));
        traceInfo(gen, 4) = std(startPop(:, xZomeLength));
    end

    if abs(bval - oval) > epsilon || gen == 1
        if display
            fprintf(1, '\n%d %f\n', gen, bval);
        end
        bPop(bFoundIn, :) = [gen startPop(bindx, :)];
        bFoundIn = bFoundIn + 1;
        oval = bval;
    else
        if display
            fprintf(1, '%d ', gen);
        end
    end

    % Selection
    endPop = feval(selectFN, startPop, [gen selectOps]);

    % Crossover
    for i = 1:size(xOverOps, 1)
        xN = deblank(xOverFNs(i, :));
        for j = 1:xOverOps(i, 1)
            a = round(rand * (popSize - 1) + 1);
            b = round(rand * (popSize - 1) + 1);
            [c1, c2] = feval(xN, endPop(a, :), endPop(b, :), bounds, [gen xOverOps(i, :)]);
            
            % Evaluate offspring
            [~, c1(xZomeLength)] = feval(evalFN, c1(1:numVar), evalOps);
            [~, c2(xZomeLength)] = feval(evalFN, c2(1:numVar), evalOps);

            endPop(a, :) = c1;
            endPop(b, :) = c2;
        end
    end

    % Mutation
    for i = 1:size(mutOps, 1)
        mN = deblank(mutFNs(i, :));
        for j = 1:popSize
            c1 = feval(mN, endPop(j, :), bounds, [gen mutOps(i, :)]);
            
            % Evaluate mutated individual
            [~, c1(xZomeLength)] = feval(evalFN, c1(1:numVar), evalOps);

            endPop(j, :) = c1;
        end
    end

    gen = gen + 1;
    done = feval(termFN, [gen termOps], bPop, endPop);
    startPop = endPop;

    [bval, bindx] = max(startPop(:, xZomeLength));
    startPop(bindx, :) = best;
end

[bval, bindx] = max(startPop(:, xZomeLength));
if display
    fprintf(1, '\n%d %f\n', gen, bval);
end

x = startPop(bindx, :);
bPop(bFoundIn, :) = [gen startPop(bindx, :)];

if collectTrace
    traceInfo(gen, 1) = gen;
    traceInfo(gen, 2) = startPop(bindx, xZomeLength);
    traceInfo(gen, 3) = mean(startPop(:, xZomeLength));
end

end
