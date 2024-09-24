library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont is
    generic(n:natural:=4; k:natural:=15);
    port (
        Clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        Q: out STD_LOGIC_VECTOR(n-1 downto 0);
        rollover: out STD_LOGIC 
    );
end entity;

architecture Behaviour of cont is
    signal output: STD_LOGIC_VECTOR (n-1 downto 0);
begin
    process(Clk, reset)
    begin
        if(reset='1') then
            output <= (others => '0');
        elsif(rising_edge(Clk)) then
            if(output=k-1) then
                rollover <= '1';
                output <= (others => '0');
            else
                rollover <= '0';
                output <= output+1;
            end if;
        end if;
    end process;
    Q <= output;
end architecture;