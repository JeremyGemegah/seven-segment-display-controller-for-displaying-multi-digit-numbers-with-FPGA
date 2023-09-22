----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:54:46 09/20/2023 
-- Design Name: 
-- Module Name:    counter_2bit - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
  use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity counter_2bit is
    port (
        clk,clr : in std_logic;
        count : out std_logic_vector(1 downto 0)
    );
end counter_2bit;

architecture Behavioral of counter_2bit is

    signal number: std_logic_vector( 1 downto 0);
    signal zero: std_logic_vector(1 downto 0);

begin
    zero <= "00";

    process(clk,clr)
        begin
            if(clr = '1') then
                number <= zero;
            elsif(rising_edge(clk)) then
                number <= number + 1;
            end if;
    end process;

    count <= number;




end Behavioral;