from jinja2 import Environment, FileSystemLoader
import os
import sys
import re
import math

def get_vhdl_constants(filename):
    if not os.path.exists(filename):
        raise FileNotFoundError(f"VHDL package {filename} does not exist")
 
    constants = {}
    constant_pattern = r"\s+constant\s+(\w+)\s*:\s*\w+\s*:=\s*([\d\w]+);"

    with open(filename, 'r') as vhdl_file:
        for line in vhdl_file:
            match = re.match(constant_pattern, line)
            if match:
                name, value = match.groups()
                value = int(value)
                constants[name] = value 
    return constants

def create_sin_lut_values(PHASE_ACCUMULATOR_WIDTH, AMPLITUDE_WIDTH):
    num_entries = pow(2, PHASE_ACCUMULATOR_WIDTH)
    sin_increment = (2 * math.pi) / num_entries

    x_val = 0    # Value in radians that's directly incremented
    sin_val = 0  # Stores the sin() of the x_value
    sin_amplitudes = []

    for idx in range(num_entries):
        x_val          = sin_increment * idx
        sin_val        = math.sin(x_val)
        sin_val_scaled = (sin_val + 1) * (pow(2, AMPLITUDE_WIDTH-1)-1)
        sin_val_binary = format(int(sin_val_scaled), f'0{AMPLITUDE_WIDTH}b')
        sin_amplitudes.append(sin_val_binary)
    return sin_amplitudes

def generate_file():

    template_file = "sin_LUT_pkg_template.vhd"
    output_file   = "../sin_LUT_pkg.vhd"

    if not os.path.exists(template_file):
        raise FileNotFoundError(f"Template {template_file} does not exist")

    constants = get_vhdl_constants("../oscillator_pkg.vhd")

    # Check all the constants we need have been found
    expected_constants = ["OSC_INDEX_WIDTH", "OSC_AMPLITUDE_WIDTH"]
    missing_constants  = [const for const in expected_constants if const not in constants]
    if missing_constants:
        print("ERROR: Bad assumptions made about the constant names in 'oscillator_pkg.vhd'")
        print(f"Missing constant(s):")
        for constant in missing_constants:
            print(f"- {constant}")
        sys.exit()

    sin_amplitudes = create_sin_lut_values(constants["OSC_INDEX_WIDTH"], constants["OSC_AMPLITUDE_WIDTH"])

    env = Environment(loader=FileSystemLoader('.'), trim_blocks=True, lstrip_blocks=True)
    template = env.get_template(template_file)
    rendered_file = template.render(amplitudes = sin_amplitudes, 
                                    index_width = constants["OSC_INDEX_WIDTH"], 
                                    amplitude_width = constants["OSC_AMPLITUDE_WIDTH"])
    with open(output_file, "w") as output_file:
        output_file.write(rendered_file)


if __name__ == "__main__":
    generate_file()
