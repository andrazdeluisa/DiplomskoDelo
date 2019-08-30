function plot_animacija_prometa_hitrosti(Y,T,s)
    % izrise animacijo relativnega stanja v prometu za izbrano kontrolo
    % na x-osi je hitrost vozil, na y-osi cas
    
    temp = size(Y);
    n = temp(2)/2;
    koord = [0 n 0 T(end)];
    
    i=2;
    while i <= length(T)
        % V za relativno stanje (navpicna crta za gibanje z v0)
        V = Y(i-1:i,2:2:end)./s + (0:n-1);           
        plot(V,T(i-1:i), 'black');
        axis(koord);
        hold on
        i=i+1;
        pause(0.001)
    end
end