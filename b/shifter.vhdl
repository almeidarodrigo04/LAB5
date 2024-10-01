library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shifter is
    port (
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        enable: in STD_LOGIC;
        input: in STD_LOGIC_VECTOR (3 downto 0);
        output: out STD_LOGIC_VECTOR (3 downto 0)
    );
end entity;

architecture Behaviour of shifter is
    signal aux : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin    
        if(reset='1') then 
            aux <= input;
        elsif(rising_edge(clk)) then
            if(enable='1') then
                aux <= aux(2 downto 0) & aux(3);  
            end if;
        end if;
    end process;
    output <= aux;
end architecture;