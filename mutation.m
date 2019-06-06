function mutated = mutation(crossed, prob)
sp = size(crossed, 2);
sc = size(crossed, 1);
for i = 1:sp
    r0 = rand(1);
    if r0 > prob
        r1 = randi([2, sc-1]);
        r2 = randi([2, sc-1]);
        while r1 > r2
            r2 = randi([2, sc-1]);
        end
        r3 = randi(sc);
        while r3 <= r2 && r3 >= r1
            r3 = randi(sc);
        end
        if r3 < r1
            pos = crossed(r3:r1-1, i);
            mut = crossed(r1:r2, i);
            sm  = size(mut, 1);
            crossed(r3:r3+sm-1, i) = mut;
            crossed(r3+sm:r2, i) = pos;
        elseif r3 > r2
            pos = crossed(r2+1:r3, i);
            mut = crossed(r1:r2, i);
            sm  = size(mut, 1);
            crossed(r3-sm+1:r3, i) = mut;
            crossed(r1:r3-sm, i) = pos;
        end
    end
end
mutated = crossed;
end