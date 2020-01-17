library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  generic (
    clk_hz : integer := 12e6
  );
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    segments : out std_logic_vector(6 downto 0);
    digit_sel : out std_logic
  );
end top;

architecture rtl of top is

  -- Internal reset
  signal rst : std_logic;

  -- Shift register for generating the internal reset
  signal shift_reg : std_logic_vector(7 downto 0);

  signal digit : integer range 0 to 9;

  -- For timing the 7-seg counting
  constant tick_counter_max : integer := clk_hz - 1;
  signal tick_counter : integer range 0 to tick_counter_max;
  signal tick : std_logic;

begin

  BCD_FSM_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        digit <= 0;

      else

        if tick = '1' then
          if digit = 9 then
            digit <= 0;
          else
            digit <= digit + 1;
          end if;
        end if;

      end if;
    end if;
  end process;

  TICK_PROC : process(clk)
  begin
    if rising_edge(clk) then
      if rst = '1' then
        tick_counter <= 0;
        tick <= '0';

      else

        if tick_counter = tick_counter_max then
          tick_counter <= 0;
          tick <= '1';
        else
          tick_counter <= tick_counter + 1;
          tick <= '0';
        end if;

      end if;
    end if;
  end process;

  SHIFT_REG_PROC : process(clk)
  begin
    if rising_edge(clk) then
      shift_reg <= shift_reg(6 downto 0) & rst_n;
    end if;
  end process;

  RESET_PROC : process(shift_reg)
  begin
    if shift_reg = "11111111" then
      rst <= '0';
    else
      rst <= '1';
    end if;
  end process;

  ENCODER_PROC : process(digit)

    -- Segments from the PmodSSD datasheet
    constant A : integer := 0;
    constant B : integer := 1;
    constant C : integer := 2;
    constant D : integer := 3;
    constant E : integer := 4;
    constant F : integer := 5;
    constant G : integer := 6;

  begin
    segments <= (others => '1');

    case digit is

      when 0 =>
        segments(G) <= '0';

      when 1 =>
        segments <= (others => '0');
        segments(B) <= '1';
        segments(C) <= '1';

      when 2 =>
        segments(C) <= '0';
        segments(F) <= '0';

      when 3 =>
        segments(E) <= '0';
        segments(F) <= '0';

      when 4 =>
        segments(A) <= '0';
        segments(D) <= '0';
        segments(E) <= '0';

      when 5 =>
        segments(B) <= '0';
        segments(E) <= '0';

      when 6 =>
        segments(B) <= '0';

      when 7 =>
        segments(D) <= '0';
        segments(E) <= '0';
        segments(F) <= '0';
        segments(G) <= '0';

      when 8 =>

      when 9 =>
        segments(E) <= '0';

      when others =>
        segments <= (others => '0');

    end case;
  end process;

end architecture;