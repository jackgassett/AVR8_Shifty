--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:25:15 02/08/2011
-- Design Name:   
-- Module Name:   C:/dbdev/My Dropbox/GadgetFactory/AVR8/svn/trunk/AVR8_tb.vhd
-- Project Name:  AVR_Core
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_avr_core_v8
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY AVR8_tb IS
END AVR8_tb;
 
ARCHITECTURE behavior OF AVR8_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_avr_core_v8
    PORT(
         clk : IN  std_logic;
         porta : INOUT  std_logic_vector(7 downto 0);
         portb : INOUT  std_logic_vector(7 downto 0);
         portc : INOUT  std_logic_vector(7 downto 0);
         portd : INOUT  std_logic_vector(7 downto 0);
         porte : INOUT  std_logic_vector(7 downto 0);
         portf : INOUT  std_logic_vector(7 downto 0);
         rxd : IN  std_logic;
         txd : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rxd : std_logic := '0';

	--BiDirs
   signal porta : std_logic_vector(7 downto 0);
   signal portb : std_logic_vector(7 downto 0);
   signal portc : std_logic_vector(7 downto 0);
   signal portd : std_logic_vector(7 downto 0);
   signal porte : std_logic_vector(7 downto 0);
   signal portf : std_logic_vector(7 downto 0);

 	--Outputs
   signal txd : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_avr_core_v8 PORT MAP (
          clk => clk,
          porta => porta,
          portb => portb,
          portc => portc,
          portd => portd,
          porte => porte,
          portf => portf,
          rxd => rxd,
          txd => txd
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      wait;
   end process;

END;
