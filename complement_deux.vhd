-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 20 / 03 / 2017
-- Fichier : complement_deux.vhd
-- Description : VHDL pour un complementeur a deux
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity complement_deux is 
    generic ( cN : integer := 8);
    port (
        VEC_BIN:   in  std_logic_vector(cN downto 1);
        BIN_C2:    out std_logic_vector(cN downto 1);
        OVF:       out std_logic
    );
end;

architecture structurelle of complement_deux is
    -- additionneur sur n bits
    component additionneur_n_bits
        generic ( N : integer := 8);
        port (
            -- Entrees:
            A:   in std_logic_vector(N downto 1);
            B:   in std_logic_vector(N downto 1);
            Cin: in std_logic;
            -- Sorties:
            Q:    out std_logic_vector(N downto 1);
            Cout: out std_logic
        );
    end component;
    
    signal s_VEC_BIN: std_logic_vector(cN downto 1);
    signal s_B:       std_logic_vector(cN downto 1); -- signal pour ajouter 1
    signal s_BIN_C2:  std_logic_vector(cN downto 1); -- signal pour router sortie additionneur vers sortie compelement
    signal s_Cout:    std_logic;                     -- sortie pour router sortie carry out additionneur vers OVF

begin
    additionneur_n: additionneur_n_bits
        generic map(
            N => cN
        )
        port map(
            A    => s_VEC_BIN,
            B    => s_B,
            Cin  => '0',
            Q    => s_BIN_C2,
            Cout => s_Cout
        );
        
    -- inversion du vecteur d'entree
    s_VEC_BIN <= not VEC_BIN;
    -- signal a un pour addition
    s_B <= (cN downto 2 => '0') & '1';

    main_process: process(s_BIN_C2, s_Cout)
    begin
        -- signal C2 vers sortie complement a deux
        BIN_C2 <= s_BIN_C2;
    
        -- signal 
        OVF <= s_Cout;
    end process;
end structurelle;
