library IEEE;
use IEEE.std_logic_1164.all;

entity Test_Lab5 is
    port (
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        sw: in STD_LOGIC_VECTOR (3 downto 0);  -- Seleciona a letra (3 bits)
        key1: in STD_LOGIC;  -- Inicia a transmiss�o do c�digo Morse
        key0: in STD_LOGIC;  -- Reset ass�ncrono
        led: out STD_LOGIC  -- LED que exibe os pulsos de Morse
    );
end entity;

architecture FSM of Test_Lab5 is
    type state_type is (IDLE, SHIFT, COUNTER_0_5, COUNTER_1_5, COUNTER_LOW);
    signal current_state, next_state: state_type;
    signal counter_enable: STD_LOGIC := '0';
    signal shifter_enable: STD_LOGIC := '0';
    signal rollover: STD_LOGIC;  -- Sinal de rollover do contador
    signal shifter_output: STD_LOGIC_VECTOR(3 downto 0);  -- Sa�da do shift register

begin

    -- Inst�ncia do shift register
    U1: entity work.shifter
        port map (
            clk => clk,
            reset => reset,
            enable => shifter_enable,
            input => sw,  -- A letra � carregada com os switches
            output => shifter_output
        );

    -- Inst�ncia do contador
    U2: entity work.contador
        port map (
            clk => clk,
            reset => reset,
            enable => counter_enable,
            output => open,
            rollover => rollover
        );

    -- M�quina de Estados Finitos
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= IDLE;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- Transi��es entre estados
    process(current_state, key1, shifter_output, rollover)
    begin
        case current_state is
            when IDLE =>
                led <= '0';
                shifter_enable <= '0';
                counter_enable <= '0';
                if key1 = '1' then
                    next_state <= SHIFT;  -- Inicia a transmiss�o
                else
                    next_state <= IDLE;
                end if;

            when SHIFT =>
                shifter_enable <= '1';
                if shifter_output(3) = '1' then  -- Se o bit � um ponto
                    next_state <= COUNTER_0_5;
                else  -- Se o bit � um tra�o
                    next_state <= COUNTER_1_5;
                end if;

            when COUNTER_0_5 =>
                counter_enable <= '1';
                led <= '1';
                if rollover = '1' then  -- Quando o contador de 0,5 segundos termina
                    next_state <= COUNTER_LOW;
                else
                    next_state <= COUNTER_0_5;
                end if;

            when COUNTER_1_5 =>
                counter_enable <= '1';
                led <= '1';
                if rollover = '1' then  -- Quando o contador de 1,5 segundos termina
                    next_state <= COUNTER_LOW;
                else
                    next_state <= COUNTER_1_5;
                end if;

            when COUNTER_LOW =>
                led <= '0';  -- Apaga o LED por um curto per�odo
                counter_enable <= '0';
                shifter_enable <= '1';  -- L� o pr�ximo bit
                if shifter_output = "0000" then  -- Quando todos os bits s�o lidos
                    next_state <= IDLE;
                else
                    next_state <= SHIFT;
                end if;

            when others =>
                next_state <= IDLE;
        end case;
    end process;

end architecture;
