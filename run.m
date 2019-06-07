clc
clear
close all
dbstop if error
%Carga de parametros iniciales
iter = 100;
probC = 0.2;
probM = 0.95;
%Instancia:
load('N100P30F4M10_1.mat');
%Generar poblacion inicial
inipob = init(P, AST, AT);
sp = size(inipob, 2);
vecGen = [];
vecFab = [];
for i = 1:iter
    disp(i)
    vecmsp = [];
    matF = [];
    for j = 1:sp
        [vecF, OG, vecS] = evalPro(inipob(:, j), ASIG, ST, PT);
        vecE = evalEn(inipob(:, j), AST, AT);
        mkspn = objfunc(OG, vecF, vecE, inipob(:, j), vecS);
        vecmsp = [vecmsp, mkspn];
        matF = [matF; vecF];
    end
    inipob = [inipob; vecmsp];
    sc = size(inipob, 1);
    [minv, idx] = sortrows(inipob', sc, 'ascend');
    minCr = minv(1, :)';
    minF = matF(idx(1), :);
    vecGen = [vecGen, minCr];
    vecFab = [vecFab; minF];
    selected = selection(inipob);
    crossed = crossover(selected, probC);
    mutated = mutation(crossed, probM);
    inipob = mutated;
    sp = size(inipob, 2);
end
vecmsp = [];
for j = 1:sp
    [vecF, OG, vecS] = evalPro(inipob(:, j), ASIG, ST, PT);
    vecE = evalEn(inipob(:, j), AST, AT);
    mkspn = objfunc(OG, vecF, vecE, inipob(:, j), vecS);
    vecmsp = [vecmsp, mkspn];
end
inipob = [inipob; vecmsp];
sc = size(inipob, 1);
[minv, idx] = sortrows(inipob', sc, 'ascend');
minCr = minv(1, :)';
minF = matF(idx(1), :);
vecGen = [vecGen, minCr];
vecFab = [vecFab; minF];
xr = 1:sp;
xr2 = 1:iter+1;
figure
subplot(1, 2, 1)
scatter(xr, vecmsp)
title('Resultados')
xlabel('cromosomas')
ylabel('makespan')
subplot(1, 2, 2)
scatter(xr2, vecGen(end, :))
title('Mejor Resultado por Generacion')
xlabel('Generaciones')
ylabel('Mejor MakeSpan')
%Nicolas es marico