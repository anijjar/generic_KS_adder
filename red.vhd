LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY red IS
   PORT (
      i_A, i_B : IN STD_LOGIC;
      o_P, o_G : OUT STD_LOGIC
   );
END red;

ARCHITECTURE arch OF red IS
BEGIN
   o_P <= i_A XOR i_B;
   o_G <= i_A AND i_B;
END ARCHITECTURE;