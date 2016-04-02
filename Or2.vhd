library ieee;
use ieee.std_logic_1164.all;
entity Or2 is
port (x, y: in std_ulogic; z: out std_ulogic);
end entity Or2;
architecture implOr2 of Or2 is
begin
z <= x or y;
end architecture implOr2;