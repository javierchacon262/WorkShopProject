function selected = selection(POB)
s1 = size(POB, 2); %Tamaño de la poblacion
selected = []; %Crear matriz de seleccionados
for i = 1:s1 %Hasta la mitad
    r1 = randi(s1);
    r2 = randi(s1);
    while r2 == r1
        r2 = randi(s1);
    end
    if POB(end, r1) > POB(end, r2) %Comparacion de cromosomas
        selected = [selected, POB(:, r2)]; %Asignacion 1
    else
        selected = [selected, POB(:, r1)]; %Asignacion 2
    end
end
end