library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    segments : out std_logic_vector(6 downto 0);
    digit_sel : out std_logic
  );
end top;

architecture rtl of top is

  signal digit : integer;

begin

  digit <= 7;

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