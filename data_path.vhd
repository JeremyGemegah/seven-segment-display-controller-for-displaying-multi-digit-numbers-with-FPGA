----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:43 09/19/2023 
-- Design Name: 
-- Module Name:    data_path - Behavioral 
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

entity data_path is
port(   input: in std_logic_vector( 7 downto 0);
		c_signals: in std_logic_vector(10 downto 0);
		registerx,registery,registerz,registerw : out std_logic_vector( 7 downto 0);
		state: in std_logic_vector(2 downto 0);
		current_state: out std_logic_vector(2 downto 0);
		clk: in std_logic;
		ee,e0: out std_logic
);
end data_path;

architecture Behavioral of data_path is



--------------------------------------------------------------
---------------Declaration of components----------------------

component adder is
port (
operand1,operand2 : in std_logic_vector(7 downto 0);
answer  : out std_logic_vector(7 downto 0);
sub		: in std_logic);
end component;




component registern is
port (
	input : in std_logic_vector( 7 downto 0);
	output: out std_logic_vector( 7 downto 0);
	load,clk,rt : in std_logic
);
end component;

component multiplexer_2to4 is
	port (
		select_sig : in std_logic_vector(1 downto 0);
		opt_1,opt_2,opt_3,opt_4 : in std_logic_vector(7 downto 0);
		output : out std_logic_vector( 7 downto 0)
	);
	end component;

	component multiplexer_1to2 is
		port(
			select_sig : in std_logic;
			opt_1,opt_2 : in std_logic_vector(7 downto 0);
			output : out std_logic_vector( 7 downto 0)
		);
	end component;
	
	component tristate_buffer is 
		port(
				input : in std_logic_vector( 7 downto 0);
				output : out std_logic_vector(7 downto 0);
				state : in std_logic_vector( 2 downto 0)
			);
			end component;



------------------------------------------------------------------------
-----------------Declaration of signals---------------------------------

signal result: std_logic_vector( 7 downto 0);
signal regw,regx,regy,regz,z_input,operand1,operand2: std_logic_vector(7 downto 0);
signal mux1,mux2 : std_logic_vector( 1 downto 0);
signal mux3,sub: std_logic;

begin

-----------------------------------------------------------------------
---------------------Assigning of signals and outputs------------------

e0 <= '1' when (regz /= b"00000000") else
		'0';

ee <= '1' when (regz(0) = '0') else
		'0';
		
mux1(0) <= c_signals(6);
mux1(1) <= c_signals(7);

mux2(0) <= c_signals(8);
mux2(1) <= c_signals(9);

mux3 <= c_signals(10);

 sub <= c_signals(5);



current_state <= state;




--------------------------------------------------------------------------
------------------instantiation of components-----------------------------



register_w: registern port map ( input => result,
											output => regw,
											load => c_signals(1),
											clk => clk,
											rt => c_signals(0));
											
register_x: registern port map ( input => result,
											output =>regx,
											load => c_signals(2),
											clk => clk,
											rt => c_signals(0));
											
											
register_y: registern port map ( input => result,
											output =>regy,
											load => c_signals(3),
											clk => clk,
											rt => c_signals(0));

register_z: registern port map ( input => z_input,
											output =>regz,
											load => c_signals(4),
											clk => clk,
											rt => c_signals(0));	
											
register_z_tristate: tristate_buffer port map (
	input => regz,
	state => state,
	output => registerz
);

register_y_tristate: tristate_buffer port map (
	input => regy,
	state => state,
	output => registery
);

register_x_tristate: tristate_buffer port map (
	input => regx,
	state => state,
	output => registerx
);

register_w_tristate: tristate_buffer port map (
	input => regw,
	state => state,
	output => registerw
);




---------------------------------------------------------------------------
-------------multiplexers for adder----------------------------------------


first_operand: multiplexer_2to4 port map(
	select_sig => mux1,
	opt_1 => regz,
	opt_2 => regy,
	opt_3 => regx,
	opt_4 => "00000000",
	output => operand1
);

second_operand: multiplexer_2to4 port map(
	select_sig => mux2,
	opt_1 => "00000001",
	opt_2 => "00000010",
	opt_3 => regy,
	opt_4 => "00000000",
	output => operand2		
);

multiplexer_for_z: multiplexer_1to2 port map(
	select_sig => mux3,
	opt_1 => result,
	opt_2 => input,
	output => z_input
);
					

											

adder_subtractor : adder port map(
							operand1 => operand1,
							operand2 => operand2,
							sub => sub,
							answer => result
						);


end Behavioral;

