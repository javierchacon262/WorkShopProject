function ts = objfunc(OG, vecF, vecE, CR, vecS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Acomodar tiempos por productos para sumar luego comparando entre fabricas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 0;
L = 1;
scr = size(vecS, 2);
sf = size(vecF, 2);
vecP = [];
for i = 1:scr
    vecf_i = [];
    for j = 1:vecS(i)
        for k = 1:sf
            if ismember(OG.orden(1, L), vecF(k).orden(1, :))
                vecf_i = [vecf_i, [k; OG.orden(:, L)]];
            end
        end
        L = L + 1;
    end
    vecf.i = vecf_i;
    vecP = [vecP; vecf];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculo de tiempos de fabricacion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tk = [];                                    %vector de tiempos general
for i = 1:scr                               %para cada producto i
    tr = vecP(i).i;                         %vector de trabajos por producto, incluyendo numero de fabrica, numero de trabajo y tiempo del trabajo
    sp = size(tr, 2);                       %cantidad de trabajos por producto
    tp = [];                                %vector de tiempos por producto  
    for j = 1:sp                            %para cada trabajo j de mi producto i
        vect = vecF(tr(1, j)).orden;        %orden de los trabajos para la fabrica del trabajo tr(2, j)
        idx = find(vect(1, :) == tr(2, j)); %indice de mi trabajo actual en el vector de la fabrica correspondiente
        if idx == 1                         %si mi indice es igual a 1
            t1 = vect(2, idx);              %t1 igual al tiempo del trabajo y ya
        else                                %caso contrario
            t1 = sum(vect(2, 1:idx));       %sumar todos los tiempos de trabajos anteriores al tiempo de mi trabajo actual en t1
        end
        tp = [tp, t1];                      %guardar el tiempo en el vector por producto
    end
    tk = [tk, max(tp)];                     %elegir el maximo de los tiempos por producto y guardarlo en el vector general
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculo de tiempos totales incluyendo ensambles y fabricas
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:scr
    if i == 1
        ts = tk(i) + sum(vecE(:, i));
    else
        if ts >= tk(i)
            ts = ts + sum(vecE(:, i));
        elseif ts < tk(i)
            tm = tk(i) - ts;
            if vecE(1, i) > tm
                ts = tk(i) + sum(vecE(:, i)) - tm;
            elseif tm >= vecE(1, i)
                ts = tk(i) + vecE(2, i);
            end
        end
    end
end
end