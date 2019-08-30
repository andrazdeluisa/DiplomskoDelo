% krozni robni pogoj
% enostranska kontrola
% prilagodljiva varnostna razdalja
% majhna perturbacija zacetnih polozajev

n = 50;
kd = 0.2;
kv = 0.2;

% reakcijski cas
%T = 30/25;
T = 2.5;

v0 = 25;
s = v0*T;
obseg = s*n;

% nakljucne perturbacije zacetnih odmikov in hitrosti od ravnovesja z intervala (-a,a)
a = 1;
Y0 = (-a + 2.*a.*rand(2*n,1));

% odmiki (hitrosti za vse enake)
Y0(2:2:end) = zeros(n,1);

% konstrukcija matrike sistema cfm
A = matrika_cfm_adapt(kd,kv,n,T);

% zapis diferencialnih enacb
odefun = @(t,Y) A*Y;

% resitev sistema na casovnem intervalu [t0 tk]
t0 = 0;
tk = 100;
t_span = linspace(t0, tk, 200);
[T1,Y1] = ode45(odefun, t_span, Y0);

% animacija prometa
realen = 0;
relativen = 1;
figure('Name', 'adaptivna varnostna razdalja ')
plot_animacija_prometa(Y1,T1,realen,s,v0,[0 obseg 0 T1(end)]);
xlabel('razdalja (m)')
ylabel('cas (s)')