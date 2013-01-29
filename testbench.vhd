library IEEE;
use IEEE.std_logic_1164.all;

-- Test bench for Sigasi Tutorial Project.
entity testbench is
	generic(half_iterations : integer := 50);
end entity testbench;

architecture STR of testbench is
	signal data_out : std_logic_vector(7 downto 0);
	signal data_in  : std_logic_vector(7 downto 0);
	signal valid    : std_logic;
	signal start    : std_logic;
	signal clk      : std_logic;
	signal rst      : std_logic;

begin
	clock_generator_instance : entity work.clock_generator(BEH)
		generic map(
			PERIOD => 50 ns
		)
		port map(
			clk => clk
		);

	dut_instance : entity work.dut(RTL)
		generic map(
			iterations => half_iterations * 2
		)
		port map(
			data_out => data_out,
			data_in  => data_in,
			valid    => valid,
			start    => start,
			clk      => clk,
			rst      => rst
		);

end architecture STR;
