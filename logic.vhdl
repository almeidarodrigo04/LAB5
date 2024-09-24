library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logic is
    port (
        clk: in std_logic;
        reset: in std_logic;
        enable: in STD_LOGIC;
        k: NATURAL
    );
end entity;

architecture Behaviour of logic is

begin 
    r: part4
    port map(
        letra =>
        enable =>
    );
    process(enable) 
        variable PT: STD_LOGIC;
        begin 
            if(enable='1') then
                PT := vec(0);
                if(PT='1') then
                    k <= 25000000;
                else 
                    k <= 75000000;
                end if;
            end if;
        end process;
    c1: cont 
    port map(
        Clk =>
        Enable
    );

    c2: cont 
    shift

end architecture;