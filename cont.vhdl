library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity cont is
    generic(n:natural:=4; k:natural:=15);
    port (
        Clk: in STD_LOGIC;
        Enable: in STD_LOGIC;
        reset: in STD_LOGIC;
        Q: out STD_LOGIC_VECTOR(n-1 downto 0);
        rollover: out STD_LOGIC
    );
end entity;

architecture Behaviour of cont is
    signal output: STD_LOGIC_VECTOR (n-1 downto 0);
    signal seg: NATURAL :=0;
begin
    process(Clk, reset)
    begin
        if(reset='1') then
            output <= (others => '0');
            seg <= 0;
        elsif (rising_edge(Clk)) then
            if (Enable='1' and rollover='0') then
                seg <= seg+1;
                if (seg = k) then
                    output <= (others => '0');
                    rollover <= '1';
                else
                    output <= output+1;
                    rollover <= '0';
                end if;
            else
                seg <= seg;
            end if;
        end if;
    end process;
    Q <= output;
end architecture Behaviour;