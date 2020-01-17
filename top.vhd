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

  digit <= 0;

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
    case digit is

      when 0 =>
        segments(A) <= '1';
        segments(B) <= '1';
        segments(C) <= '1';
        segments(D) <= '1';
        segments(E) <= '1';
        segments(F) <= '1';
        segments(G) <= '0';

      when 8 =>
        segments <= "1111111";

      when others =>
        segments <= "0000000";

    end case;
  end process;

end architecture;