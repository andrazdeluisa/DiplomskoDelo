function B = matrika_bcm(kd,kv,n)
    % vrne 2n*2n blocno matriko sistema dif. enacb za dvostransko kontrolo
    % kd proporcionalno ojacanje
    % kv diferencialno ojacanje
    
    M = [0 1; -kd -kv];
    N = [0 0; kd kv];

    F = kron(eye(n),M);
    G = kron(eye(n-1),N);
    G(2*(n-1),1) = kd;
    G(2*(n-1),2) = kv;
    G1 = [zeros(2,2*(n-1));G];
    G2 = 0.5.*[G1 zeros(2*n,2)];
    H = kron(eye(n-1),N);
    H(2,2*(n-1)-1) = kd;
    H(2,2*(n-1)) = kv;
    H1 = [H;zeros(2,2*(n-1))];
    H2 = 0.5.*[zeros(2*n,2) H1];

    B = F + H2 + G2;
end