function crossed = crossover(selected, prob)
s1 = size(selected, 1); %Tamaño del cromosoma incluido el valor fit
s2 = size(selected, 2); %Tamaño de la poblacion 
sorted = sortrows(selected', s1, 'ascend');
sorted = sorted';
sorted(end, :) = [];
ss = size(sorted, 1); %Tamaño del cromosoma sin valor fit
crossed1 = [];
crossed2 = [];
for i = 1:s2/2
    crossed1 = [crossed1, sorted(:, 1)];
    s3 = size(sorted, 2);
    r1 = randi(s3);
    while r1 == 1
        r1 = randi(s3);
    end
    crossed1 = [crossed1, sorted(:, r1)];
    sorted(:, r1) = [];
    sorted(:, 1) = [];
    
    s4 = size(crossed1, 2); %Tamaño del vector cruzados1
    p1 = crossed1(:, s4-1);
    p2 = crossed1(:, s4);
    h1 = zeros(ss, 1);
    h2 = zeros(ss, 1);
    rp = rand(1);
    if rp > prob
        %La otra parte del cruce
        cont1 = 0;
        cont2 = 0;
        for j = 1:ss
            if p1(j) == p2(j)
                cont1 = cont1 + 1;
            else
                cont2 = cont1;
                cont1 = 0;
                if cont2 >= 2
                    h1(j-cont2:j-1) = p1(j-cont2:j-1);
                    h2(j-cont2:j-1) = p1(j-cont2:j-1);
                    cont2 = 0;
                end
            end
        end
        r1 = randi(ss);
        r2 = randi(ss);
        while r2 < r1
            r2 = randi(ss);
        end
        %Heredar genes de los padres en los cortes aleatorios
        h1(r1:r2) = p1(r1:r2);
        h2(r1:r2) = p2(r1:r2);
        
        %Rellenado hijo 1
        j = 1;
        while nnz(~h1) > 0
            if ~ismember(p2(j), h1)
                k = find(~h1);
                k1 = k(1);
                h1(k1) = p2(j);
            end
            j = j + 1;
        end
        %Rellenado hijo 2
        j = 1;
        while nnz(~h2) > 0
            if ~ismember(p1(j), h2)
                k = find(~h2);
                k2 = k(1);
                h2(k2) = p1(j);
            end
            j = j + 1;
        end
    else
        h1 = p1;
        h2 = p2;
    end
    crossed2 = [crossed2, h1, h2];
end
crossed = crossed2;
end