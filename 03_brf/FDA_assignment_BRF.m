% Unnormalized frequency specs
s1 = 24.8e3;
p1 = 22.8e3;
s2 = 30.8e3;
p2 = 32.8e3;
fs = 250e3;
% Defining Chebyschev Parameters
del1 = 0.15;
del2 = 0.15;
D1 = (1/(1-del1)^2)-1;
D2 = (1/del2^2)-1;


% Normalized angular Frequency Specs
wp1 = (p1/fs)*2*pi;
ws1 = (s1/fs)*2*pi;
ws2 = (s2/fs)*2*pi;
wp2 = (p2/fs)*2*pi;

% Equivalent analog filter specs
Wp1 = tan(wp1/2);
Ws1 = tan(ws1/2);
Ws2 = tan(ws2/2);
Wp2 = tan(wp2/2);

% Equivalent LPF specs
B = Wp2 - Wp1;
W0 = sqrt(Wp1*Wp2);
Wpl1 = B*Wp1/(W0*W0-Wp1*Wp1);
Wsl1 = B*Ws1/(W0*W0-Ws1*Ws1);
Wsl2 = B*Ws2/(W0*W0-Ws2*Ws2);
Wpl2 = B*Wp2/(W0*W0-Wp2*Wp2);
Wpl = abs(Wpl1);
Wsl = min(abs(Wsl1),abs(Wsl2));

% transfer function modulus square parameters

eps = sqrt(D1);
N1 = acosh(sqrt(D2/D1))/acosh(Wsl/Wpl);
N = ceil(N1);

% poles calculation of analogous LPF filter

Bt = (1/N)*asinh(1/eps);
k = 0:1:(2*N-1);
A = (2*k+1)*(pi/(2*N));
S = Wpl*sin(A)*sinh(Bt) + Wpl*cos(A)*cosh(Bt)*j; 
P = zeros(1,N);
amp = 1;
z = 0;
for l = 1:(2*N)
    if real(S(l))<0 
        z = z + 1;
        P(z) = S(l);
        amp = amp*S(l);
    end     
end

% LPF transfer function
syms s z;

[num,den] = zp2tf([],P,amp);
H_lpf(s) = poly2sym(num,s)/poly2sym(den,s);
H_brf(s) = H_lpf(B*s/(s*s + W0*W0));
H_brf_dis(z) = H_brf((z-1)/(z+1));

%coefficients calc of analof brf
[ns, ds] = numden(H_brf(s));
ns = sym2poly(expand(ns));
ds = sym2poly(expand(ds));
k = ds(1);
ds = ds/k;
ns = ns/k;

%coefficients calc of discrete brf
[nz, dz] = numden(H_brf_dis(z));
nz = sym2poly(expand(nz));
dz = sym2poly(expand(dz));
k = dz(1);
dz = dz/k;
nz = nz/k;
fvtool(nz,dz)
% 
%magnitude plot
[H,f] = freqz(nz,dz,1024*1024, 250e3);
plot(f,abs(H))
grid
