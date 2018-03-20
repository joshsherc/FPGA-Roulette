LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
LIBRARY WORK;
USE WORK.ALL;

--------------------------------------------------------------
--
--  This is a skeleton you can use for the win subblock.  This block determines
--  whether each of the 3 bets is a winner.  As described in the lab
--  handout, the first bet is a "straight-up" bet, teh second bet is 
--  a colour bet, and the third bet is a "dozen" bet.
--
--  This should be a purely combinational block.  There is no clock.
--  Remember the rules associated with Pattern 1 in the lectures.
--
---------------------------------------------------------------

ENTITY win IS
        PORT(spin_result_latched : in unsigned(5 downto 0);  -- result of the spin (the winning number)
             bet1_value : in unsigned(5 downto 0); -- value for bet 1
             bet2_colour : in std_logic;  -- colour for bet 2
             bet3_dozen : in unsigned(1 downto 0);  -- dozen for bet 3
             bet1_wins : out std_logic;  -- whether bet 1 is a winner
             bet2_wins : out std_logic;  -- whether bet 2 is a winner
             bet3_wins : out std_logic); -- whether bet 3 is a winner
END win;


ARCHITECTURE behavioural OF win IS

BEGIN

	process(spin_result_latched, bet1_value) -- bet1
	BEGIN
		if(bet1_value = spin_result_latched) then
			bet1_wins <= '1'; 
		else 
			bet1_wins <= '0'; 
		end if;
	end process; 
	
	
	process(spin_result_latched,bet2_colour) -- bet2
	BEGIN 
		if((spin_result_latched >= x"1" AND spin_result_latched <= x"A")) OR ((spin_result_latched >= x"13" AND spin_result_latched <= x"1C"))  then
			if ((spin_result_latched(0) ='1') AND (bet2_colour = '1')) then
				bet2_wins <= '1';
			elsif((spin_result_latched(0)= '0') AND (bet2_colour = '0')) then
				bet2_wins <= '1';
			else 
				bet2_wins <= '0'; 
			end if; 
		elsif ((spin_result_latched >= x"B" AND spin_result_latched <= x"12")) OR ((spin_result_latched >= x"1D" AND spin_result_latched <= x"24"))then
			if(spin_result_latched(0) = '0') AND (bet2_colour = '1') then 
				bet2_wins <= '1'; 
			elsif(spin_result_latched(0) = '1') AND (bet2_colour ='0')then 
				bet2_wins <='1'; 
			else 
				bet2_wins <= '0';
			end if; 
		else 
			bet2_wins <= '0';
		end if; 
	end process; 

	
	process(spin_result_latched, bet3_dozen) -- bet3
	BEGIN 
	if(spin_result_latched = 0) then
		bet3_wins <= '0'; 
	elsif ((spin_result_latched > x"0") AND (spin_result_latched<x"D")) then
		if ( bet3_dozen = "00") then
			bet3_wins <= '1';
		else 
			bet3_wins <= '0';
		end if;
	elsif ((spin_result_latched>x"B") AND (spin_result_latched<x"19")) then
		if(bet3_dozen = "01") then
			bet3_wins <= '1'; 
		else 
			bet3_wins <= '0';
		end if;
	else 
		if(bet3_dozen = "10") then 
			bet3_wins <= '1'; 
		else 
			bet3_wins <= '0'; 
		end if;

	end if;
end process;
END behavioural; 
