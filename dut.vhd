library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- This is the DUT, the Design Under Test.
-- It is an example for the Sigasi Pro tool. 
-- Learn more at http://www.sigasi.com
entity dut is
	generic(
		iterations : integer := 10
	);
	port(
		data_out : out unsigned(7 downto 0);
		data_in  : in  unsigned(7 downto 0);
		valid    : out std_logic;       -- DUT will assert this signal when result is valid for processing.
		start    : in  std_logic;       -- 始める (comment in multi-byte characters)
		clk      : in  std_logic;
		rst      : in  std_logic
	);
end entity dut;

use work.constants.all;
architecture RTL of dut is
	signal count  : integer range 0 to MAX_COUNT;
	signal color  : color_t;
	signal result : unsigned(7 downto 0);
begin
	assert iterations <= MAX_COUNT;

	COUNTER : process(clk) is
		variable state : state_t;
	begin
		if rst = '1' then
			state := idle;
			count <= 0;
			valid <= '0';
			result <= (others => '0');
		elsif rising_edge(clk) then
			case state is
				when idle =>
					valid <= '0';
					result <= (others => '0');
				when preparing =>
					if start = '1' then
						count <= 0;
						state := running;
					end if;
				when running =>
					if count = iterations then
						state  := ready;
						result <= result * data_in;
					end if;
					count <= count + 1;
				when ready =>
					data_out <= result;
					valid <= '1';
					state := idle;
			end case;
		end if;
	end process COUNTER;

end architecture RTL;
