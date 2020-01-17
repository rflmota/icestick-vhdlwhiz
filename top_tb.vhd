library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture sim of top_tb is

  constant clk_hz : integer := 12e6;
  constant clk_period : time := 1 sec / clk_hz;

  signal clk : std_logic := '1';
  signal rst_n : std_logic := '0';
  signal segments : std_logic_vector(6 downto 0);
  signal digit_sel : std_logic;

  signal sig : integer := 0;

begin

  -- Device under test
  DUT : entity work.top(rtl)
  port map (
    clk => clk,
    rst_n => rst_n,
    segments => segments,
    digit_sel => digit_sel
  );

  CLOCK_PROC : process
  begin

    wait for clk_period / 2;
    clk <= not clk;

  end process;

  RESET_PROC : process
  begin

    wait for 10 ns;
    rst_n <= '1';
    wait;

  end process;

  TEMP_PROC : process
    variable var : integer := 0;
  begin

    var := 0;
    sig <= 0;

    wait for 10 ns;

    var := var + 1;
    sig <= sig + 1;

    var := var + 1;
    sig <= sig + 1;




    wait;
  end process;

end architecture;