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
  begin
    case digit is

      when 8 =>
        segments <= "1111111";

      when others =>
        segments <= "0000000";

    end case;
  end process;

end architecture;