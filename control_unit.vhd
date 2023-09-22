----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:08 09/19/2023 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

entity control_unit is
port(
	output: out std_logic_vector(10 downto 0);
	state: out std_logic_vector(2 downto 0);
	ee,e0,clr,clk: in std_logic
	);
end control_unit;

architecture Behavioral of control_unit is
type state_type is (st0,st1,st2,st3,st4,st5,st6,st7);
signal ps,ns : state_type;
signal reset, w,x,y,z,sub, mux3: std_logic;
signal mux1 : std_logic_vector(1 downto 0);
signal mux2 : std_logic_vector(1 downto 0);



begin

output(0) <= reset;
output(1) <= w;
output(2) <= x;
output(3) <= y;
output(4) <= z;
output(5) <= sub;
output(6) <= mux1(0);
output(7) <= mux1(1);
output(8) <= mux2(0);
output(9) <= mux2(1);
output(10) <=mux3;

sync_process: process(clk, clr, ns)
	begin
		if(clr ='1') then
			ps <= st0;
		elsif(rising_edge(clk)) then
			ps <= ns;
		end if;
end process sync_process;

comb_process: process(ps, e0, ee)
	begin
	 reset <= '0';
	 w <= '0';
	 x <= '0'; 
	 y<= '0'; 
	 z <= '0'; 
	 sub <= '0';
	 mux1 <= "00"; 
	 mux2 <= "00"; 
	 mux3 <= '0';
	 
	case ps is 
		when st0 =>
			reset <= '1';
			ns <= st1;
		when st1 =>
			z <= '1';
			mux3 <= '1';
			ns <= st2;
		when st2 => 
			 if(e0 = '1') then
				ns <= st3;
			else
				ns <= st7;
			end if;
		when st3 =>
			w <= '1';
			mux1 <= "10";
			mux2 <= "10";
			sub <= '1';
			if(ee = '1') then
				ns <= st4;
			else 
				ns <= st5;
			end if;
		when st4 => 
			x <= '1';
			mux1 <= "10";
			mux2 <= "01";
			sub <= '0';
			ns <= st6;
		when st5 => 
			 y <= '1';
			 mux1 <= "01";
			 mux2 <="00";
			 sub  <= '0';
			 ns <= st6;
			 
		when st6 =>
			z <= '1';
			mux1 <= "00";
			mux2 <= "00";
			mux3 <= '0';
			sub <= '1';
			ns <= st2;
		when st7 =>
			ns <= st7;
		when others =>
				 reset <= '0';
				 w <= '0';
				 x <= '0'; 
				 y<= '0'; 
				 z <= '0'; 
				 sub <= '0';
				 mux1 <= "00"; 
				 mux2 <= "00"; 
				 mux3 <= '0';
				ns <= st0;
			
		end case;
		
end process comb_process;

with ps select 
state <= "000" when st0,
			"001" when st1,
			"010" when st2,
			"011" when st3,
			"100" when st4,
			"101" when st5,
			"110" when st6,
			"111" when st7,
			"000" when others;


end Behavioral;

