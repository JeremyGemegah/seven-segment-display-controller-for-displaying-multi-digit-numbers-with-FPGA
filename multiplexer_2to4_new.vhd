----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:47:07 09/20/2023 
-- Design Name: 
-- Module Name:    multiplexer_2to4_new - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplexer_2to4_new is
port (
	select_sig : in std_logic_vector(1 downto 0);
	opt_1,opt_2,opt_3,opt_4 : in std_logic_vector(3 downto 0);
	output : out std_logic_vector( 3 downto 0)
);
end multiplexer_2to4_new;

architecture Behavioral of multiplexer_2to4_new is

begin

with select_sig select 
		output <= opt_1 when "00",
					 opt_2 when "01",
					 opt_3 when "10",
					 opt_4 when others;



end Behavioral;