function [vecF, OG, vecS] = evalPro(CR, ASIG, ST, PT)
%Generar Matriz de evaluacion por trabajos de productos en fabricas
mat = genMatPro(CR, ASIG, ST, PT);
%Asignacion a las fabricas, algoritmo de ranking
matGP = mat.matGP;
vecS = mat.vecSize;
[vecF, OG] = rank(matGP);
end