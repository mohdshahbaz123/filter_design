>> % %poles of H(s) of required analogous LPF of degree 4
p1 = -0.206 + 1.039j;
p2 = -0.580 + 0.886j;
p3 = -0.880 + 0.589j;
p4 = -1.038 + 0.211j;
p5 = -1.040 - 0.199j;
p6 = -0.887 - 0.580j;
p7 = -0.591 - 0.879j;
p8 = -0.212 - 1.038j;

%BPF Band Edge specifications
Wp1 = 0.352;
Wp2 = 0.466;
Ws2 = 0.489;
Ws1 = 0.330;

%Parameters for Bandpass Transformation
W0 = sqrt(Wp1*Wp2);
B = Wp2-Wp1;
N = 8;
Wc = 1.062;
[num,den] = zp2tf([],[p1 p2 p3 p4 p5 p6 p7 p8],Wc^N);   %TF with poles p1-p8 and numerator Wc^N and no zeroes
                                                        %numerator chosen to make the DC Gain = 1

%Evaluating Frequency Response of Final Filter
syms s z;
analog_lpf(s) = poly2sym(num,s)/poly2sym(den,s);        %analog LPF Transfer Function
analog_bpf(s) = analog_lpf((s*s + W0*W0)/(B*s));        %bandstop transformation
discrete_bpf(z) = analog_bpf((z-1)/(z+1));              %bilinear transformation

%coeffs of analog bsf
[ns, ds] = numden(analog_bpf(s));                   %numerical simplification to collect coeffs
ns = sym2poly(expand(ns));                          
ds = sym2poly(expand(ds));                          %collect coeffs into matrix form
k = ds(1);    
ds1 = ds/k;
ns1 = ns/k;

%coeffs of discrete bsf
[nz, dz] = numden(discrete_bpf(z));                     %numerical simplification to collect coeffs                    
nz = sym2poly(expand(nz));
dz = sym2poly(expand(dz));                              %coeffs to matrix form
k = dz(1);                                              %normalisation factor
dz1 = dz/k;
nz1 = nz/k;
fvtool(nz1,dz1)                                           %frequency response

%magnitude plot (not in log scale) 
[H,f] = freqz(nz1,dz1,1024*1024, 320e3);
plot(f,abs(H))
grid
