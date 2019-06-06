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
for i = 1:iter
    disp(i)
    vecmsp = [];
    for j = 1:sp
        [vecF, OG, vecS] = evalPro(inipob(:, j), ASIG, ST, PT);
        vecE = evalEn(inipob(:, j), AST, AT);
        mkspn = objfunc(OG, vecF, vecE, inipob(:, j), vecS);
        vecmsp = [vecmsp, mkspn];
    end
    inipob = [inipob; vecmsp];
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
xr = 1:sp;
figure
scatter(xr, vecmsp)
title('Resultados')
xlabel('cromosomas')
ylabel('makespan')
