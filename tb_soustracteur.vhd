-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 20 / 03 / 2017
-- Fichier : tb_soustracteur.vhd
-- Description : VHDL pour un complementeur a deux
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity tb_soustracteur is
    -- nothing
end;

architecture behavior of tb_soustracteur is
    -- signaux de tests
    signal s_A: std_logic_vector(4 downto 1);
    signal s_B: std_logic_vector(4 downto 1);
    signal s_Q: std_logic_vector(4 downto 1);
    signal s_OVF: std_logic;
    
    component soustracteur
        generic ( sN: integer := 8 );
        port (
            A:   in  std_logic_vector(sN downto 1);
            B:   in  std_logic_vector(sN downto 1);
            Q:   out std_logic_vector(sN downto 1);
            OVF: out std_logic
        );
    end component;
begin
    uut: soustracteur
        generic map(
            sN => 4
        )
        port map(
            A   => s_A,
            B   => s_B,
            Q   => s_Q,
            OVF => s_OVF
        );
    
    test_process: process
    begin
        -- -7 - 7 = -14, OVF = 1
        s_A <= "1001"; -- -7
        s_B <= "0111"; -- -7
        wait for 10 ns;
        
        -- 7 -7 = 0, OVF = 1
        s_A <= "0111";
        s_B <= "1001";
        wait for 10 ns;
        
        -- -7 -6 = -13, OVF = 0
        s_A <= "1001";
        s_B <= "1010";
        wait for 10 ns;
        
        -- 7 - 6 = 1, OVF = 0
        s_A <= "0111";
        s_B <= "0110";
        wait for 10 ns;
        
        -- 1 -1 = 0, OVF = 1
        s_A <= "0001";
        s_B <= "0001";
        wait for 10 ns;
        
        -- 1 - -1 = 2, OVF = ?
        s_A <= "0001";
        s_B <= "1111";
        wait for 10 ns;
        
        -- 0 - 0 = 0, OVF = 1
        s_A <= "0000";
        s_B <= "0000";
        wait for 10 ns;
        
        -- 7 - -7 = 14, OVF = 0 ?
    end process;
end ;