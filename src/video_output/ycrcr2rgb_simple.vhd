----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2023 16:15:50
-- Design Name: 
-- Module Name: ycrcr2rgb_simple - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ycrcr2rgb_simple is
  Port ( 
        y : in std_logic_vector(7 downto 0);
        cr : in std_logic_vector(7 downto 0);
        cb : in std_logic_vector(7 downto 0);
        r : out std_logic_vector(7 downto 0);
        g : out std_logic_vector(7 downto 0);
        b : out std_logic_vector(7 downto 0)
  );
end ycrcr2rgb_simple;

architecture Behavioral of ycrcr2rgb_simple is

signal y_i  : integer range 0 to 255;
signal cr_i : integer range 0 to 255;
signal cb_i : integer range 0 to 255;

signal r_i : integer range 0 to 255;
signal g_i : integer range 0 to 255;
signal b_i : integer range 0 to 255;

begin
y_i <= to_integer(unsigned(y));
cr_i <= to_integer(unsigned(cr));
cb_i <= to_integer(unsigned(cb));

r_i <= ((298 * y_i) / 256)  + ((405 * cr_i) / 256) -222;
g_i <= ((298 * y_i) / 256) - ((100 * cb_i) / 256)  - ((208* cr_i) / 256) +135;
b_i <= ((298 * y_i) / 256)  + ((516 * cb_i) / 256) -276;

process (r_i, g_i, b_i) is
begin
    if r_i < 0 then
        r <= std_logic_vector(to_unsigned(0, r'length)); 
    elsif  r_i > 255 then
        r <= std_logic_vector(to_unsigned(255, r'length));
    else
        r <= std_logic_vector(to_unsigned(r_i, r'length));
    end if;
    
    if g_i < 0 then
        g <= std_logic_vector(to_unsigned(0, g'length)); 
    elsif  g_i > 255 then
        g <= std_logic_vector(to_unsigned(255, g'length));
    else
        g <= std_logic_vector(to_unsigned(g_i, g'length));
    end if;
    
        if b_i < 0 then
        b <= std_logic_vector(to_unsigned(0, b'length)); 
    elsif  b_i > 255 then
        b <= std_logic_vector(to_unsigned(255, b'length));
    else
        b <= std_logic_vector(to_unsigned(b_i, b'length));
    end if;
    
end process;

end Behavioral;
