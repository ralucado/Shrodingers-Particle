format short g
list = {'Electron','Neutron','Proton','Hydrogen','Neon','Other'};
[indx,tf] = listdlg('PromptString','Select a mass:',...
                           'SelectionMode','single',...
                           'ListString',list);
masses = {9.11*10^-34, 1.674929*10^-30, 3.47053*10^-30, 1.6735575*10^-30, 3.350920307*10^-25};
if indx == 6
    m = inputdlg('Insert "m" value (in g):');
    m = str2double(m{1});
else
    m = masses{indx};
end


prompt = {'Enter "a" value (in m):'};
dlgtitle = 'a';
definput = {'100e-12'};
A = inputdlg(prompt,dlgtitle,[1 40],definput);
a = str2double(A{1:1});

n = inputdlg('Insert "n" value:');
n = str2double(n{1});

X = inputdlg('Insert specific x value between -a/2 and a/2:');
X = str2double(X{1});


global h;
h = 6.625*10^-34;


fig = figure();
subplot(4, 2, [1 3]);
density = @(x) densitat(n,a,x);
fplot(density, [-a/2 a/2])
title('Probabilitat');

subplot(4, 2, [2 4]);
Y = arrayfun(@(x) energia(x,m,a),0:n*2);
stairs(Y)
title("Nivells d'energia");

%fM = figure();
%mom = @(x) moment(x,a);
%fsurf(mom)

subplot(4, 2, [6 8]);
wave = @(x) funciodona(n,a,x);
fplot(wave, [-a/2 a/2])
title("Funció d'ona");

caption = sprintf('\nProbability on point %g = %.3g\n\nEnergy on level %d = %.3g J\n\nLineal momentum on level %d = %.3g N*s', X, densitat(n,a,X),  n, energia(n,a,m), n, moment(n,a));
ax = subplot(4, 2, 5);
text(-0.25,0,caption);
set (ax, 'visible', 'off')

fprintf('Probability on point x=(%i)= %i\n', X, densitat(n,a,X))
fprintf('Energy on level %i: %i\n', n, energia(n,a,m))
fprintf('Lineal momentum on level %i: %i\n', n, moment(n,a))

function p = densitat(n,a,x)
    p = abs(funciodona(n,a,x))^2;
end
function p = funciodona(n,a,x)
    p = sqrt(2/a)*cos((n*pi*x)/a);
end
function e = energia(n,m,a)
    global h;
    e = (n^2 * h^2)/(8 * m * a^2);
end
function p = moment(n,a)
    global h;
    hbar = h/2*pi;
    p = (n*pi*hbar)/a;
end