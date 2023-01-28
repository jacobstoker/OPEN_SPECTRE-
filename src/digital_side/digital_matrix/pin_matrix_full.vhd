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
    x_in : integer :=8;
    y_out : integer := 8
);
port
(
    Data_In  :in    std_logic_vector(x_in - 1 downto 0);
    en       :in    std_logic_vector(x_in -1 downto 0);
    mux_sel  :in    std_logic_vector((x_in * 3)-1 downto 0);
    dmux_sel  :in    std_logic_vector((y_out * 3)-1 downto 0);
    en_sel   :in    std_logic_vector(positive(ceil(log2(real(x_in)))) downto 0); --this is ugly, i should fix it
    Data_out :out   std_logic_vector((y_out * 8)-1 downto 0)
    
);
end pin_matrix_full;

architecture Behavioral of pin_matrix_full is

type en_array is array (0 to y_out-1) of std_logic_vector(x_in-1 downto 0);
signal en_arr_data : en_array;


signal matrix_in : std_logic_vector (x_in -1 downto 0);
signal matrix_out : std_logic_vector (y_out -1 downto 0);

begin

  gen_code_matrix:
  for index in 0 to y_out-1 generate
    begin
      row_inst : entity work.pin_matrix_n
      generic map ( width=>x_in-1)
      port map (Data_In=>matrix_in, en=>en_arr_data(index), Data_out => matrix_out(index));
  end generate;
  
    gen_code_mux:
  for index in 0 to (x_in-1) generate
    begin
      mux_inst : entity work.mux_8_to_1
      port map (data=>Data_In, sel=>mux_sel(((index+1) * 3)-1 downto (index * 3)), mux_out => matrix_in(index));  

      end generate;
  
    gen_code_demux:
  for index in 0 to (y_out-1) generate
    begin
      demux_inst : entity work.demux_1_to_8
      port map (data=>matrix_out(index), sel=>dmux_sel(((index+1) * 3)-1 downto (index * 3)), demux_out => Data_out( ((index + 1) * 8)-1 downto (index * 8) ));
     --  port map (data=>matrix_out(index), sel=>dmux_sel(((index+1) * 3)-1 downto (index * 3)), demux_out => Data_out( (index + 1 * 8)-1 downto (index * 8) ) );

  end generate;


end Behavioral;
