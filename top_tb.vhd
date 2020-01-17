library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture sim of top_tb is

  constant clk_hz : integer := 12e6;
  constant clk_period : time := 1 sec / clk_hz;

  signal clk : std_logic := '1';

begin

  CLOCK_PROC : process
  begin

    wait for clk_period / 2;
    clk <= not clk;

  end process;

end architecture;