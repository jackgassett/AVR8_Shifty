----------------------------------------------------------------------------------
-- Company: Gadget Factory
-- Engineer: Jack Gassett
-- 
-- Create Date:    10:03:01 01/20/2010 
-- Design Name: 
-- Module Name:    BPW5007_Button_LED_Core - Behavioral 
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
-- License Creative Commons Attribution
-- Please give attribution to the original author and Gadget Factory (www.gadgetfactory.net)
-- This work is licensed under the Creative Commons Attribution 3.0 United States License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/us/ or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BPW5007_Button_LED_Core is
	Generic (
				wing_slot_g : std_logic_vector(3 downto 0) := x"0"
	);
   Port ( nReset 	: in  STD_LOGIC;
			clk 			: in  STD_LOGIC;
         adr 			: in  STD_LOGIC_VECTOR (15 downto 0);
         dbus_in 		: in  STD_LOGIC_VECTOR (7 downto 0);
         dbus_out 	: out  STD_LOGIC_VECTOR (7 downto 0);
         iore 			: in  STD_LOGIC;
         iowe 			: in  STD_LOGIC;
			
			--Routes the pushbuttons back out
			buttons_out	: out std_logic_vector (4 downto 1);
			
			--Passes back which Wing Slot this core is connected to.
			wing_slot	: out std_logic_vector(3 downto 0);
			
			--The Pins array groups pins in correct order and indicates direction of the actual Wing pins
			pins_in		: in std_logic_vector(7 downto 0);
			pins_out		: out std_logic_vector(7 downto 0);	
			pins_dir		: out std_logic_vector(7 downto 0);

			
         st_irq 		: out  STD_LOGIC
	);
end BPW5007_Button_LED_Core;

architecture Behavioral of BPW5007_Button_LED_Core is

signal Control_reg	: std_logic_vector(15 downto 0):= "0000000000001111";
signal wing_slot_reg	: std_logic_vector(3 downto 0) := wing_slot_g;

begin
	-- Button/LED registers
	Registers:process(clk, nreset)
	begin
		if (nReset = '0') then
			Control_reg <= (others => '0');
		elsif (clk='1' and clk'event) then
			wing_slot <= wing_slot_reg;	
			pins_dir <= "10101010";
			
			dbus_out <= "ZZZZZZZZ";

			Control_reg(4) <= pins_in(7);		--Pushbutton 1 input
			Control_reg(5) <= pins_in(5);		--Pushbutton 2 input
			Control_reg(6) <= pins_in(3);		--Pushbutton 3 input
			Control_reg(7) <= pins_in(1);		--Pushbutton 4 input	
			
			pins_out(0) <= Control_reg(3);		--LED 4 output
			pins_out(2) <= Control_reg(2);		--LED 3 output
			pins_out(4) <= Control_reg(1);		--LED 2 output
			pins_out(6) <= Control_reg(0);		--LED 1 output

			buttons_out(1) <= Control_reg(4);		--Pushbutton 1 output						
			buttons_out(2) <= Control_reg(5);		--Pushbutton 2 output						
			buttons_out(3) <= Control_reg(6);		--Pushbutton 3 output						
			buttons_out(4) <= Control_reg(7);		--Pushbutton 4 output			

			-- Write registers
			if (iowe = '1') then
				case (adr) is
					when x"3001" =>
						-- Don't allow buttons to be written
						Control_reg(3 downto 0) <= dbus_in(3 downto 0);
--						Control_reg(15 downto 12) <= dbus_in(15 downto 12);						
--						wing_slot_reg <= dbus_in(11 downto 9);				
--						Control_reg(8) <= dbus_in(8);												
					when x"3002" =>
						Control_reg(15 downto 8) <= dbus_in(7 downto 0);
						Control_reg(15 downto 12) <= dbus_in(7 downto 4);						
--						wing_slot_reg <= dbus_in(3 downto 1);			
						Control_reg(8) <= dbus_in(0);
					when x"3000" =>
						wing_slot_reg <= dbus_in(3 downto 0);						
					when others =>
				end case;
			
			-- Read registers
			elsif (iore = '1') then
				case (adr) is 
					when x"3001" =>
						dbus_out <= Control_reg(7 downto 0);
--						dbus_out(15 downto 12) <= Control_reg(15 downto 12);						
--						dbus_out(11 downto 9) <= wing_slot_reg;						
--						dbus_out(8 downto 0) <= Control_reg(8 downto 0);												
					when x"3002" =>
						dbus_out(7 downto 4) <= Control_reg(15 downto 12);
--						dbus_out(3 downto 1) <= wing_slot_reg;
						dbus_out(0) <= Control_reg(8);	
					when x"3000" =>
						dbus_out(3 downto 0) <= wing_slot_reg;
					when others =>
						dbus_out <= "ZZZZZZZZ";
				end case;		
			end if;
		end if;
	end process;
end Behavioral;

