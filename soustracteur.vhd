-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 27 / 03 / 2017
-- Fichier : soustracteur.vhd
-- Description : VHDL pour un complementeur a deux
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity soustracteur is
    generic( 
        sN: integer := 8
    );
    port(
        A:   in  std_logic_vector(sN downto 1); -- vecteur 1 d'entree
        B:   in  std_logic_vector(sN downto 1); -- vecteur 2 a soustraire au vecteur d'entree
        Q:   out std_logic_vector(sN downto 1); -- resultat de la soustraction
        OVF: out std_logic                      -- debordement produit par la soustraction, est le bit de signe
                                                -- lors que vaut 1
    );
end;

architecture behavior of soustracteur is
    component complement_deux
        generic (
            cN : integer := 8
        );
        port (
            VEC_BIN:   in  std_logic_vector(cN downto 1);
            BIN_C2:    out std_logic_vector(cN downto 1);
            OVF:       out std_logic
        );
    end component;
    
    component additionneur_n_bits
        generic(
            N : integer := 8
        );
        port(
            A:    in  std_logic_vector(N downto 1);
            B:    in  std_logic_vector(N downto 1);
            Cin:  in  std_logic;
            Q:    out std_logic_vector(N downto 1);
            Cout: out std_logic
        );
    end component;
    
    -- signaux de controle
    signal s_COMPB: std_logic_vector(sN downto 1); -- signal entre sortie complement 2 et additionneur
    signal s_Q:     std_logic_vector(sN downto 1);
begin
    comp2: complement_deux
        generic map(
            cN => sN
        )
        port map(
            VEC_BIN => B,
            BIN_C2  => s_COMPB,
            OVF     => open
        );
        
    adder: additionneur_n_bits
        generic map(
            N => sN
        )
        port map(
            A    => A,
            B    => s_COMPB,
            Q    => s_Q,
            Cin  => '0',
            Cout => open
        );
    OVF <= '1' when (A(sN) = s_COMPB(sN)) and (s_Q(sN) /= A(sN)) else '0';
    Q   <= s_Q;
end behavior;
