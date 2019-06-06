function inipob = init(P, AST, AT)
v1 = 1:P;
s1 = size(AST, 1);
%Inicio del algoritmo de busqueda greedy para la generacion de una
%poblacion inicial.
inipob = [];
for i = 1:P
    col = AST(:, i);
    vec = i;
    vec2 = v1;
    col = nonzeros(col);
    while size(vec, 1) < size(col, 1)
        m = setdiff(vec2, vec);
        colp = col(m);
        [mt, id] = min(colp);
        id = m(id);
        vec = [vec; id];
    end
    inipob = [inipob, vec];
end
% 2 permutaciones mas para que sea par al dividir entre 2
perm1 = vec(randperm(length(vec)));
perm2 = vec(randperm(length(vec)));
inipob = [inipob, perm1, perm2];
end