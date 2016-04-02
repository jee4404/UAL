-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 27 / 03 / 2017
-- Fichier : calcul_flags.vhd
-- Description : VHDL pour le calcul des drapeaux
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity calcul_flags is
    generic(
        N: integer := 8
    );
    port(
        A:  in  std_logic_vector(N downto 1);
        SF: out std_logic;
        ZF: out std_logic;
        PF: out std_logic
    );
end;

architecture behavior of calcul_flags is
    -- compteur de bit a 1 pour le PF
    signal s_pf_counter: integer := 0;
    -- accumulateur des valeurs du vecteur pour le ZF
    signal s_zf_counter: integer := 0;
begin
    main_process: process(A)
    variable v_pf_counter: integer := 0;
    variable v_zf_counter: integer := 0;
    begin
        v_pf_counter := 0;
        v_zf_counter := 0;

        -- boucle sur le vecteur
        flag_loop: for i in 1 to N loop

            if( A(i) = '1' ) then
                v_pf_counter := v_pf_counter + 1;
            else
                v_zf_counter := v_zf_counter + 1;
            end if;
            
        end loop flag_loop;

        s_pf_counter <= v_pf_counter;
        s_zf_counter <= v_zf_counter;
    end process;

    ZF <= '1'when (s_zf_counter = N) and (s_pf_counter = 0) else '0'; -- si on a compte autant de 0 que de bits dans le vecteur, le vecteur est nul
    PF <= '1' when (s_pf_counter /= 0) and ((s_pf_counter mod 2) = 0) else '0'; -- si on a compte un nombre pair de vecteur, PF = 1
--    end process;
    SF <= A(N); -- le SF vaut toujours le MSB
end;
