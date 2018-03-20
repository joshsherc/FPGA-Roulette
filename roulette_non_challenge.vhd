LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

----------------------------------------------------------------------
--
--  This is the top level template for Lab 2.  Use the schematic on Page 4
--  of the lab handout to guide you in creating this structural description.
--  The combinational blocks have already been designed in previous tasks,
--  and the spinwheel block is given to you.  Your task is to combine these
--  blocks, as well as add the various registers shown on the schemetic, and
--  wire them up properly.  The result will be a roulette game you can play
--  on your DE2.
--
-----------------------------------------------------------------------

ENTITY roulette IS
	PORT(   CLOCK_50 : IN STD_LOGIC; -- the fast clock for spinning wheel
		KEY : IN STD_LOGIC_VECTOR(3 downto 0);  -- includes slow_clock and reset
		SW : IN STD_LOGIC_VECTOR(17 downto 0);
		LEDG : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);  -- ledg
		HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 7
		HEX6 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 6
		HEX5 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 5
		HEX4 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 4
		HEX3 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 3
		HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 2
		HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);  -- digit 1
		HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)   -- digit 0
	);
END roulette;

ARCHITECTURE structural OF roulette IS

Signal S0, S1, S2  : UNSIGNED(5 downto 0);
Signal S3, S5, S6, S7 : STD_LOGIC;
Signal S4  : UNSIGNED(1 downto 0);
Signal S8, S9, S10  : UNSIGNED(2 downto 0);
Signal money, newMoney : UNSIGNED(11 downto 0);

Signal slowclk : STD_LOGIC;

BEGIN
			HEX5 <= "1111111";
			HEX4 <= "1111111";
			HEX3 <= "1111111";
			--s5, s6, s7
			ledg(0) <= S5;
			ledg(1) <= S6;
			ledg(2) <= S7;
			
Debouncer:  Entity work.debounce port map(
				clk => CLOCK_50,
				button => key(0),
				result => slowclk);
				
SpinWheel:  Entity work.spinwheel port map(
				resetb => key(3),
				fast_clock => CLOCK_50,
				spin_result => S0);
				
SixBitReg1: Entity work.register12 port map(
				d(5 downto 0) => S0,
				clr => key(3),
				clk => slowclk,
				q(5 downto 0) => S1);
				
SixBitReg2: Entity work.register12 port map(
				d(5 downto 0) => UNSIGNED(SW(8 downto 3)),
				clr => key(3),
				clk => slowclk,
				q(5 downto 0) => S2);	
				
OnebitDFF : Entity work.register12 port map(
				d(0) => SW(12), --just 1 bit, dont need to cast 
				clr => key(3),
				clk => slowclk,
				q(0) => S3);	
				

TwoBitReg1: Entity work.register12 port map(
				d(1 downto 0) => UNSIGNED(SW(17 downto 16)),
				clr => key(3),
				clk => slowclk,
				q(1 downto 0) => S4);
				
ThreeBitReg1: Entity work.register12 port map(
				d(2 downto 0) => UNSIGNED(SW(2 downto 0)),
				clr => key(3),
				clk => slowclk,
				q(2 downto 0) => S8);
				
ThreeBitReg2: Entity work.register12 port map(
				d(2 downto 0) => UNSIGNED(SW(11 downto 9)),
				clr => key(3),
				clk => slowclk,
				q(2 downto 0) => S9);

ThreeBitReg3: Entity work.register12 port map(
				d(2 downto 0) => UNSIGNED(SW(15 downto 13)),
				clr => key(3),
				clk => slowclk,
				q(2 downto 0) => S10);
				
TwelveBitReg: Entity work.registerNewMoney port map(
				d(11 downto 0) => newMoney,
				clr => key(3),
				clk => slowclk,
				q(11 downto 0) => money);
				
WinBlock   : Entity work.win port map(
				spin_result_latched => S1,
				bet1_value => S2,
				bet2_colour => S3,
				bet3_dozen => S4,
				bet1_wins => S5,
				bet2_wins => S6,
				bet3_wins => S7);
				
newBalBlk : Entity work.new_balance port map(
				money => money,
				value1 => S8,
				value2 => S9,
				value3 => S10,
				bet1_wins => S5,
				bet2_wins => S6,
				bet3_wins => S7,
				new_money => newMoney);
				
SegDecOne: Entity work.digit7seg port map(
			  digit => ("00" & S1(5 downto 4)),
			  seg7 => HEX7);

SegDecTwo: Entity work.digit7seg port map(
			  digit => S1(3 downto 0),
			  seg7 => HEX6);

SegDecThr: Entity work.digit7seg port map(
			  digit => newMoney(11 downto 8),
			  seg7 => HEX2);
			  
SegDecFor: Entity work.digit7seg port map(
			  digit => newMoney(7 downto 4),
			  seg7 => HEX1);
			  
SegDecFiv: Entity work.digit7seg port map(
			  digit => newMoney(3 downto 0),
			  seg7 => HEX0);

			  
 
END;
