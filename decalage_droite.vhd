-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 27 / 03 / 2017
-- Fichier : decalage_droite.vhd
-- Description : VHDL pour un decalage a droite
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity decalage_droite is
    generic(
        N: integer := 8
    );
    port(
        A: in  std_logic_vector(N downto 1);
        B: out std_logic_vector(N downto 1)
    );
end;

architecture behavior of decalage_droite is
    signal s_tmp: std_logic_vector(N downto 1);
begin
    main_process: process(A)
    begin
        s_tmp(N) <= '0';
        -- on copie le vecteur d'entree
        -- dans le vecteur temporaire, sauf le MSB
        shift_loop: for i in N downto 2 loop
            s_tmp(i-1) <= A(i);
        end loop shift_loop;
    end process;
    B <= s_tmp;
end;
