% krozni robni pogoj
% enostranska in dvostranska kontrola
% majhna perturbacija zacetnih polozajev

n = 50;
kd = 0.2;
kv = 0.2;

s = 30;
v0 = 25;
obseg = s*n;

% nakljucne perturbacije zacetnih odmikov in hitrosti od ravnovesja z intervala (-a,a)
a = 1;
Y0 = (-a + 2.*a.*rand(2*n,1));

% odmiki (hitrosti za vse enake)
Y0(2:2:end) = zeros(n,1);

% hitrosti (odmiki za vse enaki)
%Y0(1:2:end) = zeros(n,1);

% konstrukcija matrik sistemov cfm in bcm
A = matrika_cfm(kd,kv,n);
B = matrika_bcm(kd,kv,n);

% zapis diferencialnih enacb
odefun1 = @(t,Y) B*Y;
odefun2 = @(t,Y) A*Y;

% resitev sistema na casovnem intervalu [t0 tk]
t0 = 0;
tk = 50;
t_span = linspace(t0, tk, 200);
[T1,Y1] = ode45(odefun1, t_span, Y0);
[T2,Y2] = ode45(odefun2, t_span, Y0);

% animacija prometa
realen = 0;
relativen = 1;
figure('Name', 'prikaz prometa cfm')
plot_animacija_prometa(Y2,T2,realen,s,v0,[0 obseg 0 T2(end)]);
xlabel('razdalja (m)')
ylabel('cas (s)')
pause(10);

figure('Name', 'prikaz prometa bcm')
plot_animacija_prometa(Y1,T1,relativen,s,v0,[0 obseg 0 T2(end)]);
xlabel('indeks vozila')
ylabel('cas (s)')
pause(10);

figure('Name', 'prikaz prometa hitrosti cfm')
plot_animacija_prometa_hitrosti(Y2,T2,s);
xlabel('indeks vozila')
ylabel('cas (s)')
pause(10);

figure('Name', 'prikaz prometa hitrosti bcm')
plot_animacija_prometa_hitrosti(Y1,T2,s);
xlabel('indeks vozila')
ylabel('cas (s)')
pause(10)

% prehod iz cfm v bcm

% hitrost, pri kateri kmalu nastane zastoj (vozila se skoraj ustavijo)
v1 = 5;

% koeficient za varnostno razdaljo, pod katero kmalu nastane zastoj
k = 1/2;

figure('Name', 'stabilizacija tik pred zastojem')
plot_prehod(Y2,T2,odefun1,v0,s,v1,k,realen);
xlabel('razdalja (m)')
ylabel('cas (s)')
