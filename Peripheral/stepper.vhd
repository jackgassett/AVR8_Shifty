--**********************************************************************************************
--  Stepper Controller Peripheral for the AVR Core
--  Version 0.1
--  Designed by Girish Pundlik.
--
--
-- License Creative Commons Attribution
-- Please give attribution to the original author and Gadget Factory (www.gadgetfactory.net)
-- This work is licensed under the Creative Commons Attribution 3.0 United States License. To view a copy of this license, visit http://creativecommons.org/licenses/by/3.0/us/ or send a letter to Creative Commons, 171 Second Street, Suite 300, San Francisco, California, 94105, USA.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity stepper is 
	Generic (
		wing_slot_g : std_logic_vector(3 downto 0) := x"0";
		timebase_g	: std_logic_vector(15 downto 0) := (others => '0');
		period_g		: std_logic_vector(15 downto 0) := (others => '0')
	);
	port(
		ireset     : in std_logic;
		cp2	     : in std_logic;
		adr        : in std_logic_vector(15 downto 0);
		dbus_in    : in std_logic_vector(7 downto 0);
		dbus_out   : out std_logic_vector(7 downto 0);
		iore       : in std_logic;
		iowe       : in std_logic;

	  -- External connections
		st_home		: in  std_logic;
		st_dir		: out std_logic;
		st_ms2		: out std_logic;
		st_ms1		: out std_logic;
		st_rst		: out std_logic;
		st_step		: out std_logic;
		st_enable	: out std_logic;
		st_sleep		: out std_logic;

		--Wing Specific signals
		wing_slot : out std_logic_vector (3 downto 0);
		pins_in	: in std_logic_vector(7 downto 0);			
		pins_out	: out std_logic_vector(7 downto 0);	
		pins_dir	: out std_logic_vector(7 downto 0);	
		
	  -- IRQ
		st_irq     	: out std_logic
		);								
end stepper;



architecture RTL of stepper is

signal prescale_o : std_logic;
signal halfperiod_o 	: std_logic;
signal step_o 		: std_logic;
signal irq_o		: std_logic;

signal Control_reg	: std_logic_vector(15 downto 0) := (others => '0');
signal Timebase_reg	: std_logic_vector(15 downto 0) := timebase_g;
signal Period_reg		: std_logic_vector(15 downto 0) := period_g;
signal StepCnt_reg	: std_logic_vector(15 downto 0) := (others => '0');
signal Steps_reg		: std_logic_vector(15 downto 0) := (others => '0');
--signal Control_reg	: std_logic_vector(15 downto 0) := "0000011010011011";
--signal Timebase_reg	: std_logic_vector(15 downto 0) := "0000000000001000";
--signal Period_reg		: std_logic_vector(15 downto 0) := "0101010101010101";
--signal StepCnt_reg	: std_logic_vector(15 downto 0) := "0000000000100000";
--signal st_home_reg	:	std_logic := 'Z';


signal PrescaleCnt	: std_logic_vector(15 downto 0);
signal HalfPeriodCnt	: std_logic_vector(15 downto 0);

signal wing_slot_reg	: std_logic_vector(3 downto 0) := wing_slot_g;

begin

pins_dir <= "10000000";

-- Wing Output signals
pins_out(0) <= Control_reg(7);		--/sleep
pins_out(1) <= not Control_reg(8);	--/en
pins_out(2) <= step_o;					--step
pins_out(3) <= Control_reg(4);		--/rst
pins_out(4) <= Control_reg(0);		--ms1
pins_out(5) <= Control_reg(1);		--ms2
pins_out(6) <= Control_reg(3);		--dir

-- General Output signals
st_dir	<= Control_reg(3);
st_ms2	<= Control_reg(1); 
st_ms1	<= Control_reg(0);
st_rst	<= Control_reg(4);
st_step	<= step_o;
st_sleep	<= Control_reg(7);
st_enable <= not Control_reg(8);

st_irq <= irq_o;


-- Input signals
--Control_reg(14) <= st_home;
								
-- Stepper registers
Registers:process(cp2,ireset)
begin
	if (ireset = '0') then
		Control_reg <= "0000000010010000";
--		Timebase_reg <= "0000000000001000";
--		Period_reg <= "0101010101010101";
--		StepCnt_reg <= "0000000000100000";
		Timebase_reg <= timebase_g;
		Period_reg <= period_g;
		StepCnt_reg <= (others => '0');
		
		dbus_out <= "ZZZZZZZZ";
		
	elsif (cp2='1' and cp2'event) then
		Control_reg(14) <= st_home;
		Control_reg(14) <= pins_in(7);		--home		
		Control_reg(15) <= irq_o;
		wing_slot <= wing_slot_reg;		
		-- Write registers
		if (iowe = '1') then
			case (adr) is
				when x"2000" =>
					wing_slot_reg <= dbus_in(3 downto 0);
				when x"2001" =>
					Control_reg(7 downto 0) <= dbus_in;
				when x"2002" =>
					Control_reg(13 downto 8) <= dbus_in(5 downto 0);
					Control_reg(15) <= dbus_in(7);
				when x"2003" =>
					Timebase_reg(7 downto 0) <= dbus_in;
				when x"2004" =>
					Timebase_reg(15 downto 8) <= dbus_in;
				when x"2005" =>
					Period_reg(7 downto 0) <= dbus_in;
				when x"2006" =>
					Period_reg(15 downto 8) <= dbus_in;
				when x"2007" =>
					StepCnt_reg(7 downto 0) <= dbus_in;
				when x"2008" =>
					StepCnt_reg(15 downto 8) <= dbus_in;
--				when "001000" =>
--					Steps_reg(7 downto 0) <= dbus_in;
--				when "001001" =>
--					Steps_reg(15 downto 8) <= dbus_in;
				when others =>
			end case;
		-- Read registers
		elsif (iore = '1') then
			case (adr) is 
				when x"2000" =>
					dbus_out(3 downto 0) <= wing_slot_reg;
				when x"2001" =>
					dbus_out <= Control_reg(7 downto 0);
				when x"2002" =>
					dbus_out <= Control_reg(15 downto 8);
				when x"2003" =>
					dbus_out <= Timebase_reg(7 downto 0);
				when x"2004" =>
					dbus_out <= Timebase_reg(15 downto 8);
				when x"2005" =>
					dbus_out <= Period_reg(7 downto 0);
				when x"2006" =>
					dbus_out <= Period_reg(15 downto 8);
				when x"2007" =>
					dbus_out <= StepCnt_reg(7 downto 0);
				when x"2008" =>
					dbus_out <= StepCnt_reg(15 downto 8);
				when x"2009" =>
					dbus_out <= Steps_reg(7 downto 0);
				when x"2010" =>
					dbus_out <= Steps_reg(15 downto 8);
				when others =>
					dbus_out <= "ZZZZZZZZ";
			end case;		
		end if;
	end if;
end process;
	
-- Prescaler
Prescaler:process(cp2,ireset)
begin
	if(ireset='0') then
		PrescaleCnt <= (others => '0');
	elsif  (cp2='1' and cp2'event) then
		if (Control_reg(8)='1') then
			PrescaleCnt <= PrescaleCnt+1;
			if (PrescaleCnt=Timebase_reg) then
				PrescaleCnt <= "0000000000000001";
				prescale_o <= '1';
			else
				prescale_o <= '0';
			end if;
		end if;
	end if; 
end process;

-- Half period counter
Halfperiod:process(prescale_o,ireset)
begin
	if  (ireset='0') then
		HalfPeriodCnt <= (others => '0');
	elsif (prescale_o='1' and prescale_o'event) then
		if (Control_reg(8)='1') then
			HalfPeriodCnt <= HalfPeriodCnt+1;
			if (HalfPeriodCnt=('0'&Period_reg(15 downto 1))) then
				HalfPeriodCnt <= "0000000000000001";
				halfperiod_o <= '1';
			else
				halfperiod_o <= '0';
			end if;
		end if; 
	end if;
end process;

-- Step output
Step_out:process(halfperiod_o,ireset)
begin
	if (ireset='0') then
		step_o <= '1';
		Steps_reg <= (others => '0');
	elsif  (halfperiod_o='1' and halfperiod_o'event) then
		if (Control_reg(8)='1') then
			step_o <= not step_o;
			if (step_o = '1') then
				Steps_reg <= Steps_reg+1;
			end if;
		end if;
	end if;
end process;

-- Stepper interrupt
Int_out:process(cp2,ireset)
begin
	if (ireset='0') then
		irq_o <= '0';
	elsif  (cp2='1' and cp2'event) then
			case (Control_reg(6 downto 5)) is
				when "01" =>
					if (halfperiod_o='1') then
						irq_o <= '1';
					end if;
				when "10" =>
					if (Control_reg(14)='1') then
						irq_o <= '1';
					end if;
				when "11" =>
					if (Steps_reg = StepCnt_reg) then
						irq_o <= '1';
					end if;
				when others =>
			end case;
	end if;
end process;

end RTL;
