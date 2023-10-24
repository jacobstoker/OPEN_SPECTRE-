
# Return frequency in Hz for a given frequency control word
def get_freq(fcw, f_clk, accum_w):
    f_out = int((fcw * f_clk) / pow(2, accum_w))
    return f_out

# Return frequency control word for a given frequency in Hz
def get_fcw(f_out, f_clk, accum_w):
    fcw = int( (f_out * pow(2, accum_w)) / f_clk)
    return fcw


f_clk = 40e6 # 40 MHz clock
accum_w = 29 # 29-bit accumulator (minimum needed to produce 50KHz)

print(get_fcw(50, f_clk, accum_w))