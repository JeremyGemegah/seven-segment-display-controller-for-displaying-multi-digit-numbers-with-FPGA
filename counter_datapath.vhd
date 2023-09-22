----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:40:16 09/20/2023 
-- Design Name: 
-- Module Name:    counter_datapath - Behavioral 
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

entity display_datapath is
    port(
            x1,x2,x3,x4 : in std_logic_vector(3 downto 0);
            an0,an1,an2,an3, a,b,c,d,e,f,g,h: out std_logic;
				clk,clr: in std_logic

    );
end display_datapath;

architecture Behavioral of display_datapath is

-------------------------------------------------------------------------------------
-----------------Declaration of components-------------------------------------------

    component counter_16 is
        port (
            clk,clr : in std_logic;
            new_clk : out std_logic
        );
    end component;

    component counter_2bit is
        port (
            clk,clr : in std_logic;
            count : out std_logic_vector(1 downto 0)
        );
    end component;

    component decoder_2by4 is
        port(
            input : in std_logic_vector(1 downto 0);
            output : out std_logic_vector( 3 downto 0)
        );
    end component;

    component multiplexer_2to4_new is
        port (
            select_sig : in std_logic_vector(1 downto 0);
            opt_1,opt_2,opt_3,opt_4 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector( 3 downto 0)
        );
        end component;


        component seven_segment_display is
            port (
                n1,n2,n3,n4: in std_logic;
                a,b,c,d,e,f,g,h: out std_logic
                
                
                );
            end component;

-------------------------------------------------------------------------------------------------
-------------------------------Declaration of signals--------------------------------------------
    
    signal display,anode: std_logic_vector(3 downto 0);
    signal mux_select: std_logic_vector(1 downto 0);
    signal new_clk: std_logic;




begin


-------------------------------------------------------------------------------------------------
-----------------------------Assigning of signals------------------------------------------------


    an0 <= anode(0);
    an1 <= anode(1);
    an2 <= anode(2);
    an3 <= anode(3);

    multiplexer: multiplexer_2to4_new port map(
        opt_1 => x1,
        opt_2 => x2,
        opt_3 => x3,
        opt_4 => x4,
        select_sig => mux_select,
        output => display
    );

    clock_divider: counter_16 port map(
        clr => clr,
        clk => clk,
        new_clk => new_clk
    );

    multiplexer_select_signal: counter_2bit port map(
        clk => new_clk,
        clr => clr,
        count => mux_select
    );

    decoder: decoder_2by4 port map(
        input => mux_select,
        output => anode
    );

    seven_segment_decoder: seven_segment_display port map(
        n1 => display(0),
        n2 => display(1),
        n3 => display(2),
        n4 => display(3),
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

