% krozni pogoj
% enostranska kontrola
% racunanje parametrov kd in kv, za katere je metoda stabilna
% za vsak kv izracunamo maksimalen kd za negativni realni del lastnih
% vrednosti

n = 10;
kv_span = linspace(0,0.4);

% aproksimacija za velike n
f = @(kv) kv.^2.*2.*pi.^2./n.^2;

% tocna vrednost
g = @(kv) 2.*kv.^2.*sin(pi/n).^2./(1-sin(pi/n).^2);

plot(kv_span, f(kv_span),'black--');
axis([0 0.4 0 0.05])
grid on
hold on

plot(kv_span, g(kv_span),'black');

legend('predlagana aproksimacija', 'tocna vrednost')
xlabel('k_v')
ylabel('k_d')