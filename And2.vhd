library ieee;
use ieee.std_logic_1164.all;
entity And2 is
port (x, y: in std_ulogic; z: out std_ulogic);
end entity And2;
architecture implAnd2 of And2 is
begin
z <= x and y;
end architecture implAnd2;
