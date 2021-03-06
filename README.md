# Filter Design
> This is an filter design assignment. 
> We have designed filter with the specifications as per the filter number M = 46 assigned. 
> We are using matlab program for frequency response, kaiser window function generation, plots and so on. 

## The Filter Specifications:
We wish to build a series of discrete time filters to extract specific bands of an analog signal, or to suppress specific parts of the analog signal. 

>   Passband AND Stopband tolerances are 0.15 in magnitude.
      That is, the filter magnitude response (note: NOT magnitude squared) must lie between 1.15 and 0.85 in the passband; and between 0 and 0.15 in the stopband.                     For the IIR Filter, the passband magnitude response must lie between 1 and 0.85.      
>   For bandpass filters & bandstop filters the transition band is 2 kHz on either side of the passband.

## The First Filter Specifications:

- An analog signal is bandlimited to 140 kHz.
- Sampling rate of 320 kHz.
- The first filter to be designed is a bandpass filter.         
- Filter numbers 1 to 75 have a monotonic passband, whereas filter numbers 76 to 150 have an equiripple passband.                                                               
- For filter numbers m and 75+m; m going from 1 to 75; the passband is from BL(m) kHz to BH(m) kHz, where BL(m) and BH(m) are numbers determined from m as follows.
- Define: q(m) = greatest integer strictly less than 0.1m. 
  For example, q(5) = 0, q(30) = 2 r(m) = m – 10q(m).
  For example, r(5) = 5, r(30) = 10 BL(m) = 5 + 1.4 q(m) + 4 r(m).
  For example, BL(30) = 5 + 1.4 (2) + 4 (10) = 47.8; BH(m) = BL(m) + 10. 
  
## The Second Filter Specifications: 
- An analog signal is bandlimited to 110 kHz. 
- Sampling rate of 250 kHz.
-  The second filter to be designed is a bandstop filter. 
-  Filter numbers 1 to 75 have an equiripple passband, whereas filter numbers 76 to 150 have a monotonic passband. 
-  For filter numbers m and 75+m; m going from 1 to 75; the stopband is from BL(m) kHz to BH(m) kHz, where BL(m) and BH(m) are numbers determined from m as follows. 
-  Define: q(m) = greatest integer strictly less than 0.1m. 
   For example, q(5) = 0, q(30) = 2 r(m) = m – 10q(m).
   For example, r(5) = 5, r(30) = 10 BL(m) = 5 + 1.2 q(m) + 2.5 r(m).
   For example, BL(30) = 5 + 1.2 (2) + 2.5 (10) = 32.4 BH(m) = BL(m) + 6. 
- Use either Butterworth or Chebyshev approximation to design the IIR Filter as appropriate.
- For the FIR Filter, use the Kaiser window .
