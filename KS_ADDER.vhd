LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY KS_ADDER IS
   GENERIC (
      BITS : INTEGER := 32
   );
   PORT (
      i_CIN : IN STD_LOGIC;
      i_A, i_B : IN STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0);
      o_S : OUT STD_LOGIC_VECTOR(BITS - 1 DOWNTO 0);
      o_COUT : OUT STD_LOGIC
   );
END KS_ADDER;

ARCHITECTURE rtl OF KS_ADDER IS
   CONSTANT DEPTH : INTEGER := INTEGER(ceil(log2(real(BITS))));
   TYPE arr IS ARRAY(INTEGER RANGE 0 TO DEPTH) OF STD_LOGIC_VECTOR(0 TO BITS - 1);
   SIGNAL s_P, s_G : arr := (OTHERS => (OTHERS => '0'));
BEGIN
   gen_row : FOR i IN 0 TO DEPTH + 1 GENERATE
      gen_col : FOR j IN 0 TO BITS - 1 GENERATE
         pre_processing : IF i = 0 GENERATE
            R : ENTITY work.red PORT MAP (
               i_A => i_A(j),
               i_B => i_B(j),
               o_P => s_P(0)(j),
               o_G => s_G(0)(j)
               );
         END GENERATE;
         carry_look_ahead_net : IF i > 0 and i < DEPTH + 1 GENERATE
            -- Green
            gen_G : IF j < 2 ** (i - 1) GENERATE
               G : ENTITY work.Green PORT MAP(
                  i_P => s_P(i - 1)(j),
                  i_G => s_G(i - 1)(j),
                  o_P => s_P(i)(j),
                  o_G => s_G(i)(j)
                  );
            END GENERATE;
            -- Yellow
            gen_Y : IF j >= 2 ** (i - 1) GENERATE
               Y : ENTITY work.Yellow PORT MAP(
                  i_P => s_P(i - 1)(j),
                  i_G => s_G(i - 1)(j),
                  i_P_last => s_P(i - 1)(j - 2 ** (i - 1)),
                  i_G_last => s_G(i - 1)(j - 2 ** (i - 1)),
                  o_P => s_P(i)(j),
                  o_G => s_G(i)(j)
                  );
            END GENERATE;
         END GENERATE;
         post_processing : IF i = DEPTH + 1 GENERATE 
            S0 : IF j = 0 GENERATE o_S(j) <= s_P(0)(j) XOR i_CIN;
            END GENERATE;
            S : IF j > 0 GENERATE o_S(j) <= s_P(0)(j) XOR s_G(i - 1)(j - 1);
            END GENERATE;
         END GENERATE;
      END GENERATE;
   END GENERATE;
   o_COUT <= s_G(DEPTH)(BITS - 1) or (i_CIN and s_P(DEPTH)(BITS - 1));
END ARCHITECTURE rtl;