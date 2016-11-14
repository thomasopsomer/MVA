function Y = label_noise(Y, alpha)

    f = zeros(length(Y),1);
    f(randperm(length(Y),alpha)) = 1;


    Yo = Y;

    Yo(f & Y==1) = 2;
    Yo(f & Y==2) = 1;

    Y = Yo;
