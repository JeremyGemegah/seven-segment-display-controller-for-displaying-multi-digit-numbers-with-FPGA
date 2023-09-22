----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:32:57 09/20/2023 
-- Design Name: 
-- Module Name:    top - Behavioral 
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

entity top is
    port(
        clk,clr: in std_logic;
		input : in std_logic_vector(7 downto 0);
        an0,an1,an2,an3,a,b,c,d,e,f,g,h : out std_logic
    );
end top;

architecture Behavioral of top is



------------------------------------------------------------------------------------
-------------------------------Declaration of components----------------------------


    component display_datapath is
        port(
                x1,x2,x3,x4 : in std_logic_vector(3 downto 0);
                an0,an1,an2,an3, a,b,c,d,e,f,g,h: out std_logic;
                    clk,clr: in std_logic
    
        );
    end component;


    component even_odd_counter is
        port(
            input : in std_logic_vector(7 downto 0);
            registerw,registerx,registery,registerz : out std_logic_vector(7 downto 0);
            current_state: out std_logic_vector(2 downto 0);
            clk,clr : in std_logic
        );
        end component;

-------------------------------------------------------------------------------------
-------------------------------Declaration of signals--------------------------------

signal x1,x2,x3,x4 : std_logic_vector(3 downto 0);
signal regx,regy : std_logic_vector(7 downto 0);

begin

-------------------------------------------------------------------------------------
----------------------Assigning of values--------------------------------------------

x1 <= regy(7 downto 4);
x2 <= regy(3 downto 0);
x3 <= regx(7 downto 4);
x4 <= regx(3 downto 0);


odd_Numders_Double_Even_Numbers: even_odd_counter port map(
    input => input,
    registerw => open,
    registerz => open,
    registerx => regx,
    registery => regy,
    current_state => open,
    clk => clk,
    clr => clr

);

seven_segment_display: display_datapath port map(
    x1 => x1,
    x2 => x2,
    x3 => x3,
    x4 => x4,
    clk => clk,
    clr => clr,
    an0 => an0,
    an1 => an1,
    an2 => an2,
    an3 => an3,
    a => a,
    b => b,
    c => c,
    d => d,
    e => e,
    f => f,
    g => g,
    h => h
);


end Behavioral;

