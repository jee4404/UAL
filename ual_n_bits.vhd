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
    
    -- signaux pour le calculd es flags
    signal s_calc_flags: std_logic_vector(N downto 1);
    
    -- signaux internes de l'UAL
    signal s_R: std_logic_vector(N downto 1);

    -- signaux pour le comparateur d'egalite
    signal s_eq_Q: std_logic;

    -- signaux pour le comparateur de sup
    signal s_sup_Q: std_logic;

    -- declaration des composants
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
            Q:   out std_logic_vector(sN downto 1);
	    OVF: out std_logic
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
    
    component comparateur_sup
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
    
    component calcul_flags
        generic(
           N: integer := 8
        );
        port(
            A:  in  std_logic_vector(N downto 1);
            SF: out std_logic;
            ZF: out std_logic;
            PF: out std_logic
        );
    end component;

begin
    -- instantiation des composants
    c_calcul_flags: calcul_flags
	generic map(
	    N => N
	)
	port map
	(
	    A  => s_calc_flags,
        SF => SF,
        ZF => ZF,
	    PF => PF
	);

    c_additionneur: additionneur_n_bits
        generic map(
            N => N
        )
        port map(
            A    => A,
            B    => B,
            Q    => s_add_Q,
            Cout => CF,
            Cin  => '0'
        );

    c_soustracteur: soustracteur
        generic map(
            sN => N
        )
        port map(
            A   => A,
            B   => B,
            Q   => s_sub_Q,
            OVF => OVF
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

    c_comparateur_eq: comparateur_eq
        generic map(
            N => N
        )
        port map(
            A => A,
            B => B,
            C => s_eq_Q
        );

    c_comparateur_sup_A: comparateur_sup
        generic map(
            N => N
        )
        port map(
            A => A,
            B => B,
            C => s_sup_Q
        );

    -- mise a jour des drapeaux et de la sortie
    flag_process: process(s_R) 
    begin
        s_calc_flags <= s_R;
        R <= s_R;
    end process;

    -- operations arithmetiques
    s_R <= s_add_Q  when C = "000" -- addition
    else s_sub_Q  when C = "001"   -- soustraction
    else (N downto 2 => '0') & s_eq_Q  when C = "010"   -- egalite
    else (N downto 2 => '0') & s_sup_Q when C = "011"   -- superiorite
    else s_rolA_Q when C = "100"   -- decalage a gauche de A
    else s_rolB_Q when C = "101"   -- decalage a gauche de B
    else s_rorA_Q when C = "110"   -- decalage a droite de A
    else s_rorB_Q when C = "111"   -- decalage a droite de B
    else (N downto 1 => '0');
end;
