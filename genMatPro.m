function mat = genMatPro(CR, ASIG, ST, PT)
P = size(ASIG, 2);                              %Numero de productos
M = size(ST, 3);                                %Numero de maquinas
F = size(ST, 4);                                %Numero de fabricas
matGP = [];                                     %Matriz grande de tiempos
vecSize = zeros(1, P);                          %Vector de Numero de trabajos por producto
for i = 1:P                                     %Para cada producto
    idx = find(ASIG(:, CR(i)));                 %Indices de los trabajos para el producto CR(i)
    sidx = size(idx, 1);                        %Tamaño del vector de indices
    matPP = zeros(2*M, sidx, F);                %Matriz pequeña de tiempos de trabajos
    for j = 1:F                                 %Para cada fabrica
        if i == 1                               %Si es el primer producto del cromosoma
            matTA = ST(1, idx, :, j);           %Matriz de tiempos de alistamiento por producto
        else                                    %Caso contrario    
            matTA = ST(CR(i-1)+1, idx, :, j);   %Matriz de tiempos de alistamiento por producto
        end
        matTA = matTA(:)';                      %Arreglar forma de la matriz
        matTA = reshape(matTA, sidx, M)';
        matTP = PT(idx, :, j)';                 %Matriz de tiempos de procesamiento por producto
        matPP(:, :, j) = [matTA; matTP];        %Matriz total, alistamiento + procesamiento
    end
    matGP = [matGP, matPP];                     %Agregar a la matriz grande
    vecSize(i) = sidx;                          %Agregar numero de trabajos del producto i
end
mat.matGP = matGP;
mat.vecSize = vecSize;
end