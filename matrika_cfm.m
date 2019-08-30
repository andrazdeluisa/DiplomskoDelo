function A = matrika_cfm(kd,kv,n)
    % vrne 2n*2n blocno matriko sistema dif. enacb za enostransko kontrolo
    % kd proporcionalno ojacanje
    % kv diferencialno ojacanje
    
    M = [0 1; -kd -kv];
    N = [0 0; kd kv];

    F = kron(eye(n),M);
    P = kron(eye(n-1),N);
    P1 = [zeros(2,2*(n-1)); P];
    P2 = [P1 zeros(2*n,2)];
    P2(2,2*n-1) = kd;
    P2(2,2*n) = kv;

    A = F + P2;
end

