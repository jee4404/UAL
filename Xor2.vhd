library ieee;
use ieee.std_logic_1164.all;
entity Xor2 is
port (x, y: in std_ulogic; z: out std_ulogic);
end entity Xor2;
architecture implXor2 of Xor2 is
begin
z <= x xor y;
end architecture implXor2;
