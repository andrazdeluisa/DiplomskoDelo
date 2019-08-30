% krozni robni pogoj
% enostranska in dvostranska kontrola
% vkljucevanje v promet (in izlocanje)

n = 50;
kd = 0.2;
kv = 0.2;

s = 30;
v0 = 25;
obseg = s*n;

% indeks vkljucenega vozila
m1 = n-2;
% indeks izlocenega vozila
m2 = n-20;

% konstrukcija matrik sistemov cfm in bcm
A = matrika_cfm(kd,kv,n);
B = matrika_bcm(kd,kv,n);

% zapis diferencialnih enacb
odefun1 = @(t,Y) B*Y;
odefun2 = @(t,Y) A*Y;

% resitev sistema na casovnem intervalu [t0 tk]
t0 = 0;
tk = 5;
tk2 = 20;
tk3 = 40;

Y0 = zeros(2*n,1);
t_span = linspace(t0, tk,30);
[T1,Y1] = ode45(odefun1, t_span, Y0);
[T2,Y2] = ode45(odefun2, t_span, Y0);

realen = 0;
relativen = 1;
prikaz = realen;

figure('Name', 'vkljucevanje v promet')
plot_animacija_prometa(Y1,T1,prikaz,s,v0,[0 obseg 0 tk3],m2);
hold on

Y0(end+1) = 0;
Y0(end+1) = 0;

s1 = obseg/(n+1);

% mesto, na katerega se vkljuci vozilo (m1 >= 0)
Y0(1:2:2*m1-1) = -(0:m1-1)'.*(s-s1);
Y0(2*m1+1) = -m1*(s-s1) + obseg/(n*2);
Y0(2*m1+3:2:end) = -(m1:n-1)'.*(s-s1) + s1;

% konstrukcija matrik sistemov cfm in bcm z enim vozilom vec
A1 = matrika_cfm(kd,kv,n+1);
B1 = matrika_bcm(kd,kv,n+1);

% zapis diferencialnih enacb
odefun3 = @(t,Y) B1*Y;
odefun4 = @(t,Y) A1*Y;

t_span2 = linspace(tk, tk2);
[T3,Y3] = ode45(odefun3, t_span2, Y0);

plot_animacija_prometa(Y3,T3,prikaz,s1,v0, [0 obseg 0 tk3],m1,m2);

% izlocimo vozilo m2 iz prometa
Y0 = Y3(end,:);
Y0(1:2:2*m2-1) = Y0(1:2:2*m2-1) - (0:m2-1).*(s1-s);
Y0(2*m2+1:2:end-2) = Y0(2*m2+3:2:end) - (m2+1:n).*s1 + (m2:n-1).*s;
Y0 = Y0(1:end-2);

t_span3 = linspace(tk2,tk3);
[T5,Y5] = ode45(odefun1, t_span3, Y0);
plot_animacija_prometa(Y5,T5,prikaz,s,v0,[0 obseg 0 tk3],m1-1);

xlabel('razdalja (m)')
ylabel('cas (s)')

