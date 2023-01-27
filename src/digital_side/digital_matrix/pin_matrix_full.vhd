----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.01.2023 15:46:15
-- Design Name: 
-- Module Name: pin_matrix_full - Behavioral
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
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pin_matrix_full is
generic (
    x_in : integer := 56;
    y_out : integer := 53
);
port
(
    Data_In  :in    std_logic_vector(x_in downto 0);
    en       :in    std_logic_vector(x_in downto 0);
    en_sel   :in    std_logic_vector(positive(ceil(log2(real(x_in)))) downto 0); --this is ugly, i should fix it
    Data_out :out   std_logic_vector(y_out downto 0)
    
);
end pin_matrix_full;

architecture Behavioral of pin_matrix_full is

type en_array is array (0 to 3) of std_logic_vector(x_in downto 0);
signal en_arr_data : en_array;

begin

  gen_code_label:
  for index in 0 to 3 generate
    begin
      row_inst : entity work.pin_matrix_n
      generic map ( width=>x_in)
      port map (Data_In=>Data_In, en=>en_arr_data(index), Data_out => Data_out(index));
  end generate;


end Behavioral;
