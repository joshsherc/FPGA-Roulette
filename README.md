# FPGA-Roulette


In our implementation, we will consider only three types of bets: (1) straight-up, (2) colour, and (3) dozen.
In a straight-up bet, the player bets on a single number from 0 to 36. If that number is the result of the spin,
then the player wins. Otherwise, the player loses. The payoff from this type of
bet is 35:1 (i.e. if the player bets $10 in a straight-up bet and wins, the player
gets $350 back plus the original $10).


The second type of bet we will consider is a colour bet. Each number is
associated with a colour (red or black). In a standard game, for numbers in the
range [1,10] or [19,28], odd numbers are red and even numbers are black. For
numbers in the range [11,18] or [29,36], the odd numbers are black and the
even numbers are red (you can see this in the diagram to the right). The
number 0 is green. The player can bet that either a red number will come up or
a black number will come up. The payoff from this type of bet is 1:1 (i.e. if the
player bets $10 and correctly predicts the colour of the winning number, he or
she will receive a payout of $10 plus the original $10 bet).


The third type of bet is called a “dozen” bet. The player can bet that the
winning number will be in one of the following ranges: [1,12], [13,24], or
[25,36]. If the player is right, the payoff for this kind of bet is 2:1 (so if the
player bets $10 and predicts the correct dozen, he or she will receive a payout
of $20 plus the original $10 bet). 


There are all sorts of other bets available in the real game, but we will not consider them here.


Our implementation will contain circuitry that keeps track of the player’s money, allows the user to bet,
comes up with a “random” winning number (since a roulette wheel is unfortunately not part of a standard
DE2 board, we will use a different technique to choose the winning number), calculates whether each bet
wins or looses, and pays off the user appropriately. To make the lab achievable in two weeks, we will
make the following simplifications:

1. As described earlier, we will assume the European version of the game, which does not have a 00
on the wheel. Thus, the winning number can be any integer in the range [0,36].
2. We will assume only the three previously-mentioned types of bets. Further, we will assume that,
before each spin, the user will make exactly three bets: bet #1 will always be a straight-up bet, bet
#2 will always be a colour bet, and bet #3 will always be a dozen bet. Each bet is independent.
3. For each of the three bets, the maximum amount that can be bet is $7 (we are very low-rollers here
in ENSC) and the minimum bet is $0 (effectively meaning no bet). Note that this means that the
value of the bet can be represented by a 3-bit number.
4. All inputs of our circuit (switches) will be in binary and all outputs will be in base-16 (on the hex
digits). Although this may make it more challenging to use, it will make the coding a lot easier.
5. The user starts out with $32.
6. You do not need to implement code that checks for the legality of a bet, or whether the user goes
below $0 (if you want to add code to do this, it is not hard, so go ahead).


To make the betting process more clear, consider the following example. Suppose the player starts with
$32 dollars (in base-16, that is 0x20). Before the spin, suppose the player makes the following three bets:
1. Bet 1: Straight-up Bet. The player bets $3 that the number 10 will come up.
2. Bet 2: Colour Bet. The player bets $4 that the winning number will be black.
3. Bet 3: Dozen Bet. The player bets $2 that the winning number will be in the range [25,36].

Then the wheel is spun. Suppose the winning number (the number that comes up when the wheel is spun)
is 10. In that case, the following is true:

1. Bet 1: The player wins this bet (lucky!) since he or she bet on 10, and a 10 came up. Since the
original bet was $3, and a straight-up bet pays off 35:1 as described on the first page of this
handout, the player wins 35*$3 = $105 from bet #1.
2. Bet 2: The player is extra lucky, since the winning number 10 is black (see the discussion on the
previous page) and he or she had bet $4 on black coming up. Since the payout of a colour bet is
1:1, the player wins $4 from bet #2
3. Bet 3: In this case, the bet did not win, since the winning number 10 is not in the range [25, 36].
Therefore the player loses his or her $2 bet.


After all the bets are counted, the player gets $105 from bet 1, gets $4 from bet 2, and looses $2 from bet 3.
Since the initial balance was $32, the new balance is 32+105+4-2 = $139. Encouraged by his or her
success, the player could then play another spin (and another and another…).
