import numpy as np
import random

# Golden model for YCBCR to RGB
# NOTE: this is using the ITU-R BT.709 standard
def ycbcr_to_rgb(y, cb, cr):
    y = int(y, 16)
    cb = int(cb, 16)
    cr = int(cr, 16)

    # Scale the inputs down to 0-1
    y /= 255.0
    cb /= 255.0
    cr /= 255.0

    # Convert to rgb
    r = y + 1.402 * (cr - 0.5)
    g = y - 0.344136 * (cb - 0.5) - 0.714136 * (cr - 0.5)
    b = y + 1.772 * (cb - 0.5)

    # Clip the values to the range [0, 1]
    r = np.clip(r, 0, 1)
    g = np.clip(g, 0, 1)
    b = np.clip(b, 0, 1)

    # Scale the values back up to 0-255
    r = format(int(r * 255), '02X')
    g = format(int(g * 255), '02X')
    b = format(int(b * 255), '02X')

    return r, g, b

# Generate a random ycbcr value [y, cb, cr]
def random_ycbcr():
    group = [format(random.randint(0, 255), '02X') for _ in range(3)]
    return group

def generate_infile():
    infile = open("ycbcr_infile.txt", "w")
    outfile = open("ycbcr_model_outfile.txt", "w")

    num_values = 10

    # Use a set to ensure each ycbcr value is unique
    ycbcr_values = set()

    while len(ycbcr_values) < num_values:
        ycbcr = tuple(random_ycbcr())
        ycbcr_values.add(ycbcr)

    ycbcr_values = [list(value) for value in ycbcr_values]

    for value in ycbcr_values:
        y, cb, cr = value
        infile.write(f"{y} {cb} {cr}\n")
        r,g,b = ycbcr_to_rgb(y, cb, cr)
        outfile.write(f"{r} {g} {b}\n")

    infile.close()
    outfile.close()


def get_error():
    #TODO: Ideally this should know where the vhdl outfile lives but that will be workspace setup dependent I guess
    #      Needs thinking about, for now you just need to copy the vhdl outfile to this directory
    model_outfile = open("ycbcr_model_outfile.txt", "r")
    vhdl_outfile  = open("ycbcr_vhdl_outfile.txt.txt", "r")

    absolute_error_r = [] 
    absolute_error_g = []
    absolute_error_b = []

    for line_model, line_vhdl in zip(model_outfile, vhdl_outfile):
        r_m, g_m, b_m = [int(val) for val in line_model.split(" ")]
        # Couldn't work out how to add spaces between the hex characters in stupid vhdl lol
        r_v = int(line_vhdl[0:2], 16)
        g_v = int(line_vhdl[2:4], 16)
        b_v = int(line_vhdl[4:6], 16) 

        absolute_error_r.append(np.abs(r_v - r_m))
        absolute_error_g.append(np.abs(g_v - g_m))
        absolute_error_b.append(np.abs(b_v - b_m))
    
    model_outfile.close()
    vhdl_outfile.close()

    mean_abs_err_r = np.mean(absolute_error_r)
    mean_abs_err_g = np.mean(absolute_error_g)
    mean_abs_err_b = np.mean(absolute_error_b)

    print(mean_abs_err_r)
    print(mean_abs_err_g)
    print(mean_abs_err_b)

if __name__ == "__main__":
    generate_infile()