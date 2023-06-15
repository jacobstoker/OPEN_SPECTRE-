library ieee;

use ieee.std_logic_1164.all;

entity shift_sipo is

  port (
    Clock, SinA, SinB, rst : in std_logic;

    Pout : out std_logic_vector(7 downto 0));

end shift_sipo;

architecture exam of shift_sipo is

  signal temp : std_logic_vector(7 downto 0);
  signal Sin  : std_logic;

begin

  process (Clock)

  begin

    Sin <= SinA NAND SinB;

    if (Clock'event and Clock = '1') then
    if rst = '1' then
        temp <= (others => '0');
    else
      temp <= temp(6 downto 0) & Sin;

    end if;

    end if;

  end process;

  Pout <= temp;

end exam;