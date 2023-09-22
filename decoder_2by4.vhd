----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:54:12 09/20/2023 
-- Design Name: 
-- Module Name:    decoder_2by4 - Behavioral 
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

entity decoder_2by4 is
    port(
        input : in std_logic_vector(1 downto 0);
        output : out std_logic_vector( 3 downto 0)
    );
end decoder_2by4;

architecture Behavioral of decoder_2by4 is

begin
    with input select
    output <= "0111" when "00",
    "1011" when "01",
    "1101" when "10",
    "1110" when others;

end Behavioral;

