% Unnormalized frequency specsb
s1 = 24.8e3;
s2 = 30.8e3;
p1 = s1-2e3;
p2 = s2+2e3;

fs = 250e3;

del = 0.15;
extra = 12;
% Normalized angular Frequency Specs
wp1 = (p1/fs)*2*pi;
ws1 = (s1/fs)*2*pi;
ws2 = (s2/fs)*2*pi;
wp2 = (p2/fs)*2*pi;

del_w = wp2 - ws2;
A = -20*log10(del);
N_min = ceil((A-8)/(2.285*del_w));
% if rem(N_min,2) == 0
%     N_min = N_min + 1;
% end
L = (N_min + 1) + extra;  % extra is for taking care of non ideality in ideal LPF
wc2 = (wp2 + ws2)/2;
wc1 = (ws1 + wp1)/2;
if(A < 21)
    alpha = 0;
elseif(A > 50)
    alpha = 0.1102*(A-8.7);
else
    alpha = 0.5842*(A - 21)^0.4 + 0.07886*(A - 21);
end
win_h = (kaiser(L,alpha))';
ideal_br = ideal_hp(wc2,L) + ideal_lp(wc1,L);
fir_h = win_h.*ideal_br;
fvtool(fir_h);

%magnitude plot
 [H,f] = freqz(fir_h,1,1024,fs);
 plot(f,abs(H))
 grid


