# Probably doesn't do anything yet - an old rough script from my dissertation that might come in useful

import matplotlib.pyplot as plot
import numpy as np

data = []

with open("DataOut.txt") as outfile:
    for line in outfile :
        data.append(int(line, 2))


#fig, ax = plot.subplots()
#ax.plot(data)
#plot.show()

#timestep = 0.00000001
#fourier = np.fft.fft(data)
#n = signal.size
#freq = np.fft.fftfreq(n, d=timestep)



fourier = np.fft.fft(data)
n = len(data)
timestep = 0.00000001
freq = np.fft.fftfreq(n, d=timestep)

plot.plot(freq, fourier.real**2 + fourier.imag**2)
plot.show()
