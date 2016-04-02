-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Remy Mourard
-- Date : 27 / 03 / 2017
-- Fichier : comparateur_eq.vhd
-- Description : VHDL pour l'unite arithemetique et logique
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;

entity ual_n_bits is
    generic(
        N: integer := 8
    );
    port(
        -- entrees
        A:   in  std_logic_vector(N downto 1);
        B:   in  std_logic_vector(N downto 1);
        C:   in  std_logic_vector(3 downto 1);
        -- sorties
        R:   out std_logic_vector(N downto 1);
        OVF: out std_logic;
        CF:  out std_logic;
        ZF:  out std_logic;
        SF:  out std_logic;
        PF:  out std_logic
    );
end;

architecture behavior of ual_n_bits is
    -- signaux pour l'addition
    signal s_add_Q:  std_logic_vector(N downto 1);
    -- signaux pour la soustration
    signal s_sub_Q:  std_logic_vector(N downto 1);
    -- signaux pour le decalage a gauche de A
    signal s_rolA_Q: std_logic_vector(N downto 1);
    -- signaux pour le decalage a gauche de B
    signal s_rolB_Q: std_logic_vector(N downto 1);
    -- signaux pour le decalage a droite de A
    signal s_rorA_Q: std_logic_vector(N downto 1);
    -- signaux pour le decalage a droitee de B
    signal s_rorB_Q: std_logic_vector(N downto 1);

    component additionneur_n_bits
        generic ( N : integer := 8);
        port (
            A:   in std_logic_vector(N downto 1);
            B:   in std_logic_vector(N downto 1);
            Cin: in std_logic;
            -- Sorties:
            Q:    out std_logic_vector(N downto 1);
            Cout: out std_logic
        );
    end component;

    component soustracteur
        generic( 
            sN: integer := 8
        );
        port(
            A:   in  std_logic_vector(sN downto 1);
            B:   in  std_logic_vector(sN downto 1);
            Q:   out std_logic_vector(sN downto 1)
        );
    end component;

    component comparateur_eq
        generic(
            N: integer := 8
        );
        port(
            A: in  std_logic_vector(N downto 1);
            B: in  std_logic_vector(N downto 1);
            C: out std_logic
        );
    end component;

    component decalage_gauche
        generic(
            N: integer := 8
        );
        port(
            A: in  std_logic_vector(N downto 1);
            B: out std_logic_vector(N downto 1)
        );
    end component;

    component decalage_droite
        generic(
            N: integer := 8
        );
        port(
            A: in  std_logic_vector(N downto 1);
            B: out std_logic_vector(N downto 1)
        );
    end component;

begin
    c_additionneur: additionneur_n_bits
        generic map(
            N => N
        )
        port map(
            A    => A,
            B    => B,
            Q    => s_add_Q,
            Cout => open,
            Cin  => '0'
        );

    c_soustracteur: soustracteur
        generic map(
            sN => N
        )
        port map(
            A => A,
            B => B,
            Q => s_sub_Q
        );

    c_decalage_gauche_A: decalage_gauche
        generic map(
            N => N
        )
        port map(
            A => A,
            B => s_rolA_Q
        );

    c_decalage_gauche_B: decalage_gauche
        generic map(
            N => N
        )
        port map(
            A => B,
            B => s_rolB_Q
        );

    c_decalage_droite_A: decalage_droite
        generic map(
            N => N
        )
        port map(
            A => A,
            B => s_rorA_Q
        );

    c_decalage_droite_B: decalage_droite
        generic map(
            N => N
        )
        port map(
            A => A,
            B => s_rorB_Q
        );

    R <= s_add_Q  when C = "000" -- addition
    else s_sub_Q  when C = "001" -- soustraction
    else s_rolA_Q when C = "100" -- decalage a gauche de A
    else s_rolB_Q when C = "101" -- decalage a gauche de B
    else s_rorA_Q when C = "110" -- decalage a droite de A
    else s_rorB_Q when C = "111" -- decalage a droite de B
    else (N downto 1 => '0');
end;