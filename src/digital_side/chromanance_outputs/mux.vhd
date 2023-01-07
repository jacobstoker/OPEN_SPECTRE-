--2:1 mux

library ieee;
use ieee.std_logic_1164.all;

entity mux is
    port (
        sel: in std_logic;
        a: in std_logic;
        b: in std_logic;
        c: out std_logic
    );
end mux;

architecture beh of mux is
begin
    c <= a when sel='0' else b;
end beh;
