library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity part4 is
    port(
        letra: in STD_LOGIC_VECTOR (2 downto 0);
        enable: in STD_LOGIC;
        clock: in STD_LOGIC;
        RESET: in std_logic;
        led: out STD_LOGIC
    );
end entity part4;

architecture Behaviour of part4 is
    component cont is
        generic(n:natural:=4; k:natural:=15);
        port (
            Clk: in STD_LOGIC;
            Enable: in STD_LOGIC;
            reset: in STD_LOGIC;
            Q: out STD_LOGIC_VECTOR(n-1 downto 0);
            rollover: out STD_LOGIC
        );
    end component;
begin

    process(letra)
        variable tam: NATURAL:=0;
        variable pt: Natural:=1;
        variable vec: STD_LOGIC_VECTOR (3 downto 0);
    begin
        if(enable='1' and reset='0') then
            case letra is 
                when "000" => 
                    tam:=2;
                    vec:="10XX";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        )
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => led
                        );
                    end loop;
                when "001" =>
                    tam:=4;
                    vec:="0111";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        )
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop;
                when "010" =>
                    tam:=4;
                    vec:="0101"; 
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        )
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop;
                when "011" =>
                    tam:=3;
                    vec:="011X";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        )
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop;
                when "100" =>
                    tam:=1;
                    vec:="1XXX";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        );
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop;
                when "101" =>
                    tam:=4;
                    vec:="1101";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        );
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop;
                when "110" => 
                    tam:=3;
                    vec:="001X";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        );
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop; 
                when "111" =>
                    tam:=4;
                    vec:="1111";
                    for i in 0 to tam-1 loop
                        if(vec(i)='1') then
                            pt := 25000000;
                        else
                            pt := 75000000;     
                        end if;
                        led <= '0';       
                        c: cont 
                        generic map(
                            n => 27,
                            k => pt
                        )
                        port map(
                            Clk => clock,
                            enable => enable,
                            reset => reset,
                            q =>
                            rollover => not led
                        );
                    end loop;
            end case;
        end if;
    end process; 
end architecture Behaviour;