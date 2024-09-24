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
        generic(n: natural := 4; k: natural := 15);
        port (
            Clk: in STD_LOGIC;
            Enable: in STD_LOGIC;
            reset: in STD_LOGIC;
            Q: out STD_LOGIC_VECTOR(n-1 downto 0);
            rollover: out STD_LOGIC
        );
    end component;

    signal pt: natural := 1;
    signal q_signal: STD_LOGIC_VECTOR(26 downto 0); -- Para armazenar o valor de 'Q' do componente cont
    signal rollover_signal: STD_LOGIC;

begin

    -- Instância única do componente cont
    cont_inst: cont 
        generic map(
            n => 27,
            k => pt
        )
        port map(
            Clk => clock,
            Enable => enable,
            reset => RESET,
            Q => q_signal,
            rollover => rollover_signal
        );

    -- Processo de controle
    process(letra)
        variable vec: STD_LOGIC_VECTOR (3 downto 0); -- Agora 'vec' é uma variável
    begin
        if (enable = '1' and RESET = '0') then
            case letra is 
                when "000" => 
                    vec := "10XX";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= rollover_signal; -- Usa o rollover da instância para controlar o led

                when "001" =>
                    vec := "0111"; -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;

                when "010" =>
                    vec := "0101";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;

                when "011" =>
                    vec := "011X";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;

                when "100" =>
                    vec := "1XXX";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;

                when "101" =>
                    vec := "1101";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;

                when "110" => 
                    vec := "001X";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;

                when "111" =>
                    vec := "1111";  -- Atribuindo à variável
                    if(vec(0) = '1') then
                        pt <= 25000000;
                    else
                        pt <= 75000000;     
                    end if;
                    led <= not rollover_signal;
            end case;
        end if;
    end process; 
end architecture Behaviour;
