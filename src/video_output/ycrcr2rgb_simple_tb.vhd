----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.10.2023 17:22:09
-- Design Name: 
-- Module Name: ycrcr2rgb_simple_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textio.all;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use ieee.std_logic_textio.all;

entity ycbcr2rgb_simple_tb is
end ycbcr2rgb_simple_tb;

architecture Behavioral of ycbcr2rgb_simple_tb is
    signal y, cb, cr, r, g, b : std_logic_vector(7 downto 0);
    
    file file_VECTORS : text;
    file file_RESULTS : text;
   
begin

    dut: entity work.ycbcr2rgb_simple
    port map(
        y => y,
        cb => cb,
        cr => cr, 
        r => r,
        g => g,
        b => b
    );
    
    PROC_SEQUENCER : process
        file     infile  : text open read_mode is "ycbcr_infile.txt";
        variable inline  : line;
        variable ok      : boolean;
        variable data    : std_logic_vector(7 downto 0);
        variable char    : character;
        file     outfile : text open write_mode is "ycbcr_vhdl_outfile.txt";
        variable outline : line;
        variable v_r     : std_logic_vector(7 downto 0);
        variable v_g     : std_logic_vector(7 downto 0);
        variable v_b     : std_logic_vector(7 downto 0);

    begin
        while not endfile(infile) loop
 
            readline(infile, inline);
 
            -- Skip empty lines and single-line comments
            if inline.all'length = 0 or inline.all(1) = '#' then
                next;
            end if;
             
            hread(inline, data, ok);
            assert ok
              report "Read 'y' failed for line: " & inline.all
              severity failure;
            y <= data;
             
            hread(inline, data, ok);
            assert ok
              report "Read 'cr' failed for line: " & inline.all
              severity failure;
            cb <= data;
             
            hread(inline, data, ok);
            assert ok
              report "Read 'cb' failed for line: " & inline.all
              severity failure;
            cr <= data;
            
            wait for 10 ns;

            read(inline, char, ok); -- Skip expected newline
            write(outline, to_hstring(r));
            write(outline, g);
            write(outline, b);
            writeline(outfile, outline);
        end loop;                       
        file_close(outfile);
        report "Closed ycbcr_vhdl_outfile.txt" severity NOTE;
    end process;

end Behavioral;
