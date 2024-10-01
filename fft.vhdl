library IEEE;
use IEEE.std_logic_1164.all;

entity flipflopt is
    port (
        Clk: in STD_LOGIC;
        T: in STD_LOGIC;
        Q: out STD_LOGIC;
        Clear: in STD_LOGIC
	);
end entity flipflopt;

architecture Behaviour of flipflopt is
signal output: STD_LOGIC;
begin
    process (Clk)
	begin
	if (rising_edge(Clk)) then
            if (Clear='1') then
                    output <= '0';
            elsif (T='1') then
                output <= not output;
            else
                output <= output;
            end if;
        end if;
    end process;
    Q <= output;
end architecture;