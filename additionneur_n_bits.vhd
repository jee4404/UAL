-- Cadre : Conception des circuits integrés ( GEN 1333 )
-- par : Antoine Shaneen
-- Date : 07 / 12 / 2005
-- Fichier : additionneur_n_bits.vhd
-- Description : VHDL pour un additionneur générique (n bits)
-- en utilisant un type de description structurelle.
-------------------------------------------------------------------------------
-- Librairie a inclure
library ieee;
use ieee.std_logic_1164.all;
--
-------------------------------------------------------------------------------
-- Déclaration de l'entité de l'additionneur générique (n bits) paramétrable
entity additionneur_n_bits is
    generic ( N : integer := 8);
    --generic ( N : positive);
    port (
        -- Entrées:
        A:    in std_logic_vector(N downto 1);
        B:    in std_logic_vector(N downto 1);
        Cin:  in std_logic;
        -- Sorties:
        Q:    out std_logic_vector(N downto 1);
        Cout: out std_logic
    );
end additionneur_n_bits;

-------------------------------------------------------------------------------
-- Architecture structurelle de l'additionneur générique (n bits).
architecture structurelle of additionneur_n_bits is
-- Declaration des composants
-- On ne declare pas un additionneur de 1-bit si c'est definit dans package
    component additionneur
        port(A, B, Cin : in std_logic; Q, Cout:out std_logic);
    end component;

    -- zone de déclaration
    signal CS : std_logic_vector(N downto 0); -- pour garder le carry
begin
    CS(0) <= Cin;
    Cout  <= CS(N);
    --instantiation de l'additionneur de 1 bit N fois
    sommateur: for i in 1 to N generate
        somme_de_n_bits: additionneur
        port map (
            A => A(i),
            B => B(i),
            Cin => CS(i-1),
            Q => Q(i),
            Cout => CS(i)
        );
    end generate sommateur;
end structurelle;
