library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity main_system is
    port(
        clk: in STD_LOGIC;
        reset: in STD_LOGIC;
        input_letter: in STD_LOGIC_VECTOR(2 downto 0); -- vetor para ser lido nos switches
        signal_out: out STD_LOGIC  -- LED que será acesso
    );
end entity;

architecture Behaviour of main_system is
	signal start : STD_LOGIC; --sinal para indicar que o sistema pode emitir o código morse(ativar em 1 ao resetar o sistema, desativar em 0 quando no estado do SHIFT o número de bits for alcançado
    signal shift_output: STD_LOGIC_VECTOR(3 downto 0); --sinal para saída do shift register
    signal enable_shifter: STD_LOGIC := '0'; -- sinal que habilita o shift register.
    signal enable_counter05, enable_counter15, enable_counter_low: STD_LOGIC := '0'; -- sinal que habilita os contadores. Esses só devem estar ativos no estado dos contadores(ativar um por estado de contador), nos demais estados esses devem estar desativados.
    signal reset_counter05, reset_counter15, reset_counter_low: STD_LOGIC := '0'; -- sinal que reseta os contadores. Esses só devem estar desativados no estado dos contadores(desativar um por estado de contador), nos demais estados eles devem estar desligados
    signal rollover_counter05, rollover_counter15, rollover_counter_low: STD_LOGIC := '0'; -- sinal de rollover indicando que o contador terminou sua contagem
    signal current_bit: STD_LOGIC := '0'; -- sinal corresponde ao bit atual sendo lido pela saída do shift register
    signal input_vector: STD_LOGIC_VECTOR(3 downto 0); -- mapeamento dos bits pelas switches
    signal character_size: integer range 0 to 4 := 0;  --tamanho do vetor de caracteres da letra

begin
	-- Nesse processo estou lendo a entrada(input_letter) e armazenando em um registrador(input_vector) os bits correspondentes as letras
    process(input_letter)
    begin
        case input_letter is
            when "000" => 
				input_vector <= "0100"; -- A ".-", coloqueo ponto como 0 e traço como 1, completei com zero os caracteres que não importam para ter tamanho fixo de 4
				character_size <= 2; -- Como a letra A só tem dois caracteres, . e - então esse registrador armazena 2(é um sinal representando um número inteiro)
            when "001" =>
				input_vector <= "1000"; -- B Mesma lógica aqui. Posso ter cometido algum erro ao transcrever as demais letras, mas: ponto=0 traço=1 completar com 0 até ter 4 bits
				character_size <= 4;
            when "010" =>
				input_vector <= "1010"; -- C
				character_size <= 4;
            when "011" =>
				input_vector <= "1000"; -- D
				character_size <= 3;
            when "100" => 
				input_vector <= "0000"; -- E
				character_size <= 1;
            when "101" => 
				input_vector <= "0010"; -- F
				character_size <= 4;
            when "110" => 
				input_vector <= "1100"; -- G
				character_size <= 3;
            when "111" => 	input_vector <= "0000"; -- H
				character_size <= 4;
            when others => -- é sempre importante colocar condição adversa, mesmo que todas tenham sido atendidas definir para demais casos(other) garante que a implementação seja como desejada
				input_vector <= "0000"; -- Don't care
				character_size <= 0;
        end case;
    end process;

	--Nessa parte estou criando instâncias para o shift register, counter05, counter15 e conterlow
    shift: entity work.shifter
        port map (
            clk => clk,
            reset => reset,
            enable => enable_shifter,
            input => input_vector,
            output => shift_output
        );

	--mudar esse contador para que tenha 0.5 segundos
    counter05: entity work.contador
        generic map (
            n => --mudar aqui,
            k => --mudar aqui,  
            c => --mudaraqui
        )
        port map (
            clk => clk,
            reset => reset_counter05, 
            enable => enable_counter05,
            output => open,
            rollover => rollover_counter05
        );

	--mudar esse contador para que tenha 1.5 segundos
    counter15: entity work.contador
        generic map (
            n => --mudar aqui,
            k => --mudar aqui,  
            c => --mudaraqui
        )
        port map (
            clk => clk,
            reset => reset_counter15, 
            enable => enable_counter15,
            output => open,
            rollover => rollover_counter15
        );

	--mudar esse contador para que tenha 0.1 segundos ou qualquer outra quantidade de tempo que quiserem
    counter_low: entity work.contador
        generic map (
            n => --mudar aqui,
            k => --mudar aqui,  
            c => --mudaraqui
        )
        port map (
            clk => clk,
            reset => reset_counter15, 
            enable => enable_counter15,
            output => open,
            rollover => rollover_counter15
        );

    process(clk, reset)
        type state_type is (IDLE, COUNT_5, COUNT_7, COUNT_LOW, SHIFT); --definição dos estados, instrução de alto nível para abstração, basicamente colocando nome nos estados ao invés de simplesmente chamar de 00, 01, 10, 11...
        variable state: state_type := IDLE; --criando a variável estado e atribuíndo valor inicial para IDLE
        variable bit_counter: integer range 0 to 4 := 0;--criando a vari´ável para contar os bits que o shift register leu
    begin
		--reset assincrono. Nesse estado a variável start é setado para 1, estado para IDLE, apagar LED, resetar contadores, resetar contador de bits e desabilitar contadores
        if reset = '1' then
	    start <= '1';
            state := IDLE;
            signal_out <= '0';
            enable_counter5 <= '0';
            enable_counter7 <= '0';
            enable_counter_low <= '0';
            enable_shifter <= '0';
            bit_counter := 0;
            reset_counter5 <= '1'; 
            reset_counter7 <= '1';
            reset_counter_low <= '1';
		-- durante as transições de clock os estados podem ser transicionados
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
					--Deixar todos os contadores desabilitados e resetados
					--Coloque o seu código aqui
					--caso o sinal start estiver em 0 se manter no estado idle(state := IDLE;)
					--caso o sinal start estiver em 1 mudará para o estado SHIF
						--Observação:
							--Habilitar o shift
							--ler o bit atual(current_bit <= shift_output(3);)
							--Mudar o estado para SHIFT(state := SHIFT;)
                    end if;
                when COUNT_05 =>
                    --Ligar LED, Habilitar contador para esse estado, desativar o reset e desabilitar o shifter
					--quando o contador terminar de contar(rollover_counter05), desabiltiar o contador e mudar estado para COUNT_LOW
					--Coloque o seu código aqui

                when COUNT_15 =>
                    --Mesma coisa do COUNT_05 mas para o COUNT_15, mesma lógica, sinais e contadores diferentes.
					--Coloque o seu código aqui

                when COUNT_LOW =>
                    --Quase a mesma coisa do COUNT_05 mas para o COUNT_LOW, mesma lógica, sinais e contadores diferentes.
					--Diferença é que o LED ficará apagado e o próximo estado é o shift
					--Habilitar o shifter e ler o primeiro digito dele, assim como no current_bit
					--Coloque o seu código aqui

                when SHIFT =>
					--resetar os contadores, todos eles
					--desabilitar o shifter
					--Nesse estado o bit_counter deve ser atualizdo(bit_counter := bit_counter + 1;), deixo para vocês descobrir o lugar certo para fazer isso.
					--caso o bit_counter for igual character_size, todos os bits foram lidos
						--voltar para o estado IDLE. Dois sinais/variáveis devem ser setados para 0, deixar para vocês pensarem para não entregar a solução pronta
					--caso contrário a mudança de estado dependerá do bit atual(current_bit) se for zero vai para o estado COUNT_05, se não COUNT_15
					--Coloque o seu código aqui
            end case;
        end if;
    end process;
--O código está quase todo escrito, mas...
--O importante é vocês entenderem o que são os estados e a lógica por trás das transições
--Entender o uso do shift register e dos contadores para o problema.
--Se conseguirem entender isso e souberem explicar tudo o que aconteceu aqui vocês estarão bem para a segunda parte da disciplina.
end architecture Behaviour;
