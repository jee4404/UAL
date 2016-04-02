-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 20 / 03 / 2017
-- Fichier : Not1.vhd
-- Description : VHDL pour un complementeur a deux
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity tb_complement_deux is 
    -- gna
end;

architecture behavior of tb_complement_deux is
    signal s_VEC_BIN: STD_LOGIC_VECTOR(4 downto 1);
    signal s_BIN_C2:  STD_LOGIC_VECTOR(4 downto 1);
    signal s_OVF:     STD_LOGIC;
    
    component complement_deux
        generic ( cN : integer := 8);
        port (
            VEC_BIN:   in  STD_LOGIC_VECTOR(cN downto 1);
            BIN_C2:    out STD_LOGIC_VECTOR(cN downto 1);
            OVF:       out STD_LOGIC
        );
    end component;

begin
    uut: complement_deux
        generic map(
            cN => 4
        )
        port map(
            VEC_BIN  => s_VEC_BIN,
            BIN_C2   => s_BIN_C2,
            OVF      => s_OVF
        );
        
    test_process: process
    begin  
        -- complement a deux de 0000
        s_VEC_BIN <= "0000";
        wait for 10 ns;
        
        s_VEC_BIN <= "0001";
        wait for 10 ns;
        
        s_VEC_BIN <= "0010";
        wait for 10 ns;
        
        s_VEC_BIN <= "0011";
        wait for 10 ns;
        
        s_VEC_BIN <= "0100";
        wait for 10 ns;
        
        s_VEC_BIN <= "0101";
        wait for 10 ns;
        
        s_VEC_BIN <= "0110";
        wait for 10 ns;
        
        s_VEC_BIN <= "0111";
        wait for 10 ns;
        
        s_VEC_BIN <= "1000";
        wait for 10 ns;
        
        s_VEC_BIN <= "1001";
        wait for 10 ns;
        
        s_VEC_BIN <= "1010";
        wait for 10 ns;
        
        s_VEC_BIN <= "1011";
        wait for 10 ns;
        
        s_VEC_BIN <= "1100";
        wait for 10 ns;
        
        s_VEC_BIN <= "1101";
        wait for 10 ns;
        
        s_VEC_BIN <= "1110";
        wait for 10 ns;
        
        s_VEC_BIN <= "1111";
        wait for 10 ns;
        
    end process;
end;