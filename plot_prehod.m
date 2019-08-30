function plot_prehod(Y,T,odefun1,v0,s,v1,k,prikaz)
    % izrise promet pod enostransko kontrolo do tik pred zastojem
    % preklopi na dvostransko kontrolo in preracuna sistem dif enacb
    % izrise nadaljevanje stabiliziranega prometa
    
    temp = size(Y);
    n = temp(2)/2;
    obseg = s*n;
    
    i=2;
    enostranska = true;
    while i < length(T)
        if min(Y(i,2:2:end))<-v0+v1 || min(diff(-Y(i,1:2:end))) < -s*(1-k)
            enostranska = false;
            k=i;
            break
        end
        if prikaz == 0
            % X za realno stanje (navpicna crta je miren avto)
            X = Y(i-1:i,1:2:end) - ((1:n)-1).*s + v0.*T(i-1:i);
            X = mod(X,obseg);
            idx = abs(X(2,:)-X(1,:)) < obseg/2;
            plot(X(:,idx),T(i-1:i), 'black', 'LineWidth',1);
            axis([0 obseg 0 T(end)]);
        else
            % V za relativno stanje (navpicna crta za gibanje z v0)
            V = Y(i-1:i,1:2:end) - ((1:n)-1).*s;
            V = mod(V,obseg);            
            idx = abs(V(2,:)-V(1,:)) < obseg/2;
            V = V./s;
            plot(V(:,idx),T(i-1:i), 'black', 'LineWidth',1);
            axis([0 n 0 T(end)]);
        end
        hold on
        i=i+1;
        pause(0.001)
    end

    % vklopimo dvostransko kontrolo
    if enostranska == false
        t_span_nov = T(k-1:end);
        Y_nov = Y(k-1,:);
        [T1,Y1] = ode45(odefun1, t_span_nov, Y_nov);
        i=2;
        while i <= length(T1)
            if prikaz == 0
                % X za realno stanje (navpicna crta je miren avto)
                X = Y1(i-1:i,1:2:end) - ((1:n)-1).*s + v0.*T1(i-1:i);
                X = mod(X,obseg);
                idx = abs(X(2,:)-X(1,:)) < obseg/2;
                plot(X(:,idx),T1(i-1:i), 'black');
                axis([0 obseg 0 T1(end)]);
            else
                % V za relativno stanje (navpicna crta za gibanje z v0)
                V = Y1(i-1:i,1:2:end) - ((1:n)-1).*s;
                V = mod(V,obseg);            
                idx = abs(V(2,:)-V(1,:)) < obseg/2;
                V = V./s;
                plot(V(:,idx),T1(i-1:i), 'black');
                axis([0 n 0 T1(end)]);
            end
            hold on
            i=i+1;
            pause(0.001)
        end
    end
end