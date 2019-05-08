n = input('Insert "n" value:\n');
a = input('Insert "a" value:\n');
m = input('Insert "m" value:\n');
global h;
h = 6.625*10^-34;
fD = figure();
density = @(x) densitat(n,a,x);
fplot(density)
fE = figure()
energy = @(x) energia(x,m,a);
fsurf(energy)
fM = figure()
mom = @(x) moment(x,a);
fsurf(mom)
fW = figure()
wave = @(x) funciodona(n,a,x);
fplot(wave, [-a/2 a/2])

function p = densitat(n,a,x)
    p = abs(funciodona(n,a,x)^2);
end
function p = funciodona(n,a,x)
    p = sqrt(2/a)*cos((n*pi*x)/a);
end
function e = energia(n,m,a)
    global h;
    e = (n^2 * h^2)/(8 * m * a^2);
end
function p = moment(n,a)
    hbar = h/2*pi;
    p = (n*pi*hbar)/a;
end