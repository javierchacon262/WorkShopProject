function EVAL = evalEn(CR, AST, AT)
s1 = size(CR, 1); %Tamaño del cromosoma
EVAL = [];
for j = 1:s1
    if j == 1
        EVAL = [EVAL, [AST(1, CR(j)); AT(CR(j))]];
    else
        EVAL = [EVAL, [AST(CR(j-1), CR(j)); AT(CR(j))]];
    end
end
end