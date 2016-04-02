-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy MOurard
-- Date : 20 / 03 / 2016
-- Fichier : tb_additionneur_n_bits.vhd
-- Description : Banc de test VHDL pour un additionneur générique (n bits)
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity tb_additionneur_n_bits is
    --generic ( tb_N : integer := 8);
end tb_additionneur_n_bits;

architecture behavior of tb_additionneur_n_bits is
    -- signaux pour tester l'additionneur
    signal s_A:    std_logic_vector(3 downto 1);
    signal s_B:    std_logic_vector(3 downto 1);
    signal s_Cin:  std_logic;
    signal s_Q:    std_logic_vector(3 downto 1);
    signal s_Cout: std_logic := '0';
    
    -- composant additionneur a tester
    component additionneur_n_bits
        generic ( N : integer := 8);
        port(
            A: in std_logic_vector(N downto 1);
            B: in std_logic_vector(N downto 1);
            Cin: in std_logic;
            -- Sorties:
            Q: out std_logic_vector(N downto 1);
            Cout: out std_logic
        );
    end component;
begin
    -- instantiation de l'additionneur
    uut: additionneur_n_bits
        generic map(
            N => 3
        )
        port map(
            A    => s_A,
            B    => s_B,
            Cin  => s_Cin,
            Q    => s_Q,
            Cout => s_Cout
        );
    
    -- processus de test pour l'additionneur
    test_process: process
    begin
        -- Q == 000, Cout = 0
        s_A   <= "000";
        s_B   <= "000";
        s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 001, Cout = 0
        s_A   <= "001";
        s_B   <= "000";
        --s_Cin <= '0';
        wait for 10 ns;
                
        -- Q == 010, Cout = 0
        s_A   <= "001";
        s_B   <= "001";
--        s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 011, Cout = 0
        s_A   <= "010";
        s_B   <= "001";
        --s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 100, Cout = 0
        s_A   <= "011";
        s_B   <= "001";
--        s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 101, Cout = 0
        s_A   <= "011";
        s_B   <= "010";
--        s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 110, Cout = 0
        s_A   <= "010";
        s_B   <= "100";
--        s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 111, Cout = 0
        s_A   <= "011";
        s_B   <= "100";
        --s_Cin <= '0';
        wait for 10 ns;
        
        -- Q == 000, Cout = 1
        s_A   <= "111";
        s_B   <= "001";
        --s_Cin <= '1';
        wait for 10 ns;
        
        -- Q == 010, Cout = 1
        s_A   <= "001";
        s_A   <= "001";
        
        wait for 10 ns;
    end process;
end;