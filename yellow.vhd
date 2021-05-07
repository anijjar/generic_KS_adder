LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY yellow IS
   PORT (
      i_G, i_P, i_G_last, i_P_last : IN STD_LOGIC;
      o_G, o_P : OUT STD_LOGIC
   );
END yellow;

ARCHITECTURE arch OF yellow IS
BEGIN
   o_G <= i_G or (i_G_last and i_P);
   o_P <= i_P and i_P_last;
END ARCHITECTURE;