LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY green IS
   PORT (
      i_P, i_G : IN STD_LOGIC;
      o_P, o_G : OUT STD_LOGIC
   );
END green;

ARCHITECTURE arch OF green IS
BEGIN
   o_P <= i_P;
   o_G <= i_G;
END ARCHITECTURE;