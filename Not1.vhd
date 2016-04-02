-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 20 / 03 / 2017
-- Fichier : Not1.vhd
-- Description : VHDL pour un inverseur elementaire
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity Not1 is
    port (
        x: in std_logic;
        y: out std_logic
    );
end entity Not1;

architecture implNot1 of Not1 is
begin
    y <= not x;
end architecture implNot1;
