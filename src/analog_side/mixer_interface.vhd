----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2023 14:52:58
-- Design Name: 
-- Module Name: mixer_interface - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
library work;
use work.array_pck.all;


entity mixer_interface is

  Port ( 
    clk      :in    STD_LOGIC;
    rst      :in    STD_LOGIC;
    wr       :in    STD_LOGIC;
    out_addr     :in    integer ;
    ch_addr      :in    integer;
    gain_in  :in    std_logic_vector(3 downto 0);
    mixer_inputs : in array_12(9 downto 0);
    outputs : out array_12(9 downto 0)  -- 12-bit wide outputs

  );
end mixer_interface;

architecture Behavioral of mixer_interface is

signal gain_int : std_logic_vector(3 downto 0) := (others => '0');
signal mixer_gains_0i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_1i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_2i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_3i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_4i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_5i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_6i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_7i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_8i :  array_4(9 downto 0) := (others => (others => '0'));
signal mixer_gains_9i :  array_4(9 downto 0) := (others => (others => '0'));

begin

process (clk) is
begin
    if rising_edge (clk) then
        if wr = '1' then
           case out_addr is
            when 0 =>
                mixer_gains_0i(ch_addr) <= gain_in;
            when 1 =>
                mixer_gains_1i(ch_addr) <= gain_in;
            when 2 =>
                mixer_gains_2i(ch_addr) <= gain_in;
            when 3 =>
                mixer_gains_3i(ch_addr) <= gain_in;
            when 4 =>
                mixer_gains_4i(ch_addr) <= gain_in;
            when 5 =>
                mixer_gains_5i(ch_addr) <= gain_in;
            when 6 =>
                mixer_gains_6i(ch_addr) <= gain_in;
            when 7 =>
                mixer_gains_7i(ch_addr) <= gain_in;
            when 8 =>
                mixer_gains_8i(ch_addr) <= gain_in;
            when 9 =>
                mixer_gains_9i(ch_addr) <= gain_in;
            when others => -- 'U', 'X', '-', etc.
                mixer_gains_9i(ch_addr) <= (others => '0');
        end case;
       end if;
    
    end if;
end process;

analog_matrix : entity work.analog_matrix
    Port map (
         clk => clk,
         reset => rst,
         mixer_inputs => mixer_inputs,
         mixer_gains_0 => mixer_gains_0i,
         mixer_gains_1 => mixer_gains_1i,
         mixer_gains_2 => mixer_gains_2i,
         mixer_gains_3 => mixer_gains_3i,
         mixer_gains_4 => mixer_gains_4i,
         mixer_gains_5 => mixer_gains_5i,
         mixer_gains_6 => mixer_gains_6i,
         mixer_gains_7 => mixer_gains_7i,
         mixer_gains_8 => mixer_gains_8i,
         mixer_gains_9 => mixer_gains_9i,
        outputs => outputs
    );


end Behavioral;
