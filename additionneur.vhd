-- Fichier : additionneur.vhd : VHDL structurelle pour un additionneur
library ieee;
use ieee.std_logic_1164.all;
-- Déclaration de l'entité de l'additionneur:
entity additionneur is
    port (
        -- Entrées:
        A: in STD_LOGIC;
        B: in STD_LOGIC;
        Cin: in STD_LOGIC;
        -- Sorties:
        Q: out STD_LOGIC;
        Cout: out STD_LOGIC
    );
end additionneur;

-- Architecture style structurelle de l'additionneur:
architecture structurelle of additionneur is
    -- déclaration des composants
    component Xor2
        port(x, y : in STD_LOGIC; z:out STD_LOGIC);
    end component;
    
    component and2
        port(x, y : in STD_LOGIC; z:out STD_LOGIC);
    end component;
    
    component or2
        port(x, y : in STD_LOGIC; z:out STD_LOGIC);
    end component;
    -- instantiation
    -- signaux internes
    signal s1, s2, s3: STD_LOGIC;
begin
    xor_1: Xor2 port map(A,B,s1);
    xor_2: Xor2 port map(s1,Cin,Q);
    and_1: And2 port map(A,B,s3);
    and_2: And2 port map(s1, Cin, s2);
    or_1 : Or2  port map(s2,s3,Cout);
end structurelle;
