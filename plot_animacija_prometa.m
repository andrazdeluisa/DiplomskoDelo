function plot_animacija_prometa(Y,T,prikaz,s,v0,koord,odebeljeno1,odebeljeno2)
    % izrise animacijo realnega ali relativnega stanja v prometu za izbrano kontrolo
    % na x-osi je pozicija vozil, na y-osi je cas
    
    temp = size(Y);
    n = temp(2)/2;
    obseg = s*n;
    
    i=2;
    while i <= length(T)
        if prikaz == 0
            % X za realno stanje (navpicna crta je miren avto)
            X = Y(i-1:i,1:2:end) - ((1:n)-1).*s + v0.*T(i-1:i);
            X = mod(X,obseg);
            idx = abs(X(2,:)-X(1,:)) < obseg/2;
            plot(X(:,idx),T(i-1:i), 'black');
            if nargin == 7 && idx(odebeljeno1+1)==1
                plot(X(:,odebeljeno1+1),T(i-1:i), 'black', 'LineWidth',1.5);
            end
            if nargin == 8 && idx(odebeljeno1+1)==1
                plot(X(:,odebeljeno1+1),T(i-1:i), 'black', 'LineWidth',1.5);
            end
            if nargin == 8 && idx(odebeljeno2+1)==1
                plot(X(:,odebeljeno2+1),T(i-1:i), 'black', 'LineWidth',1.5);
            end
        else
            % V za relativno stanje (navpicna crta za gibanje z v0)
            V = Y(i-1:i,1:2:end) - ((1:n)-1).*s;
            V = mod(V,obseg);            
            idx = abs(V(2,:)-V(1,:)) < obseg/3;
            V = V./s;
            plot(V(:,idx),T(i-1:i), 'black');
            koord(2) = n;
            if nargin == 7 && idx(odebeljeno+1)==1
                plot(V(:,odebeljeno+1),T(i-1:i), 'black', 'LineWidth',1.5);
            end
            if nargin == 8 && idx(odebeljeno1+1)==1
                plot(X(:,odebeljeno1+1),T(i-1:i), 'black', 'LineWidth',1.5);
            end
            if nargin == 8 && idx(odebeljeno2+1)==1
                plot(X(:,odebeljeno2+1),T(i-1:i), 'black', 'LineWidth',1.5);
            end
        end
        axis(koord);
        hold on
        i=i+1;
        pause(0.001)
    end
end