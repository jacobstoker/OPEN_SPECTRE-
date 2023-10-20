##### Common Modules:
| Module | Notes | Built |Tested |
| ------ | ------ |-----|-----|
| inverter | n-bit wide |YES| YES|
| xor | n-bit wide |YES| YES|
| mux func | 32:1 mux |YES| YES|
| debouncer | counter based |YES| NO|
| rotary encoder | not tested on HW |YES| YES (sim)|

##### Digital Side Modules:
| Module | Notes | Circuits PDF | Built |Tested |
| ------ | ------ |-----|-----|-----|
| 800us delay | clk'd delay ||YES|YES|
| Overlay Gates |  |pg5|YES|YES|
| XY counters |9 bit counter  |pg5(xorgates & invertors)|YES|YES|
| XY invert logic |  |pg5(xorgates & invertors)|YES|YES|
| Edge Detector/Monostables | 1clk edge, make longer |pg 5|YES|YES|
| Slowcounter* | counters with rates of 6,3,1.5,8,4 & 2Hz ||YES|YES|
| Video In Comparitor|8/10bit luma only video signal to 7bit comparitor with span controll|pg 13| YES* need to check operation | NO* check test cases| 
| Inverters |4x digital inverters (1bit)|pg5| YES (common module) | YES |
| Flipflops ||pg5| YES | NO |
| Video Timing Generator || |YES|YES|
| Digital Crosspoint ||throughout |YES|YES|
| Pinmatrix ||throughout |YES|YES|

* check counter frequencies, solve slower than 1hz freqs

##### Analogue Side Modules:
| Module | Notes | Circuits PDF | Built |Tested |
| ------ | ------ |-----|-----|-----|
| random voltage gen | ||YES|YES|
| video out attenuators | ||YES|YES|
| analoge pin matrix/mixer | ||YES|sort of|
| shape gen| ||Almost done|NO|

##### Other Modules:
| Module | Notes | Circuits PDF | Built |Tested |
| ------ | ------ |-----|-----|-----|
| YCCRCB to RGB | ||YES|YES|
| Audio in|*filter extern and use adc for level?||YES|YES|
| Register interface to digital side| ||YES|YES|

##### Tools and scripts:

| Module | Notes | Design Stage | Built |Tested |
| ------ | ------ |-----|-----|-----|
| make_coe_wave.py | makes xilinx coe for rom IP |pre synth|YES|YES|
| write_file_ex.vhd | logs video signal to csv file |simulation|YES|YES|
| vga_sim.py* | reads csv from above makes image |simulation|YES|YES|
* it is way too hard to see what is happening from the signal traces alone, so this python script turns a single frame of video. [Simulated Images](https://github.com/cfoge/OPEN_SPECTRE-/tree/MVP_1/src/synth_tools/sim_images)
![VGA simulator output](src/synth_tools/sim_images/play2.png) 
