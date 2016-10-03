library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



PACKAGE MYPROC IS

constant N_MAX_SHAPES : integer := 49;

type shapes_arr is array (0 to (N_MAX_SHAPES-1)) of std_logic_vector((32-1) downto 0);

PROCEDURE DRAW_GRID(SIGNAL X_cur,Y_cur:IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR(2 downto 0);  SIGNAL DRAW: OUT STD_LOGIC);
PROCEDURE DRAW_SHAPES(SIGNAL X_cur,Y_cur:IN INTEGER; SIGNAL SHAPES: shapes_arr; SIGNAL RGB:OUT STD_LOGIC_VECTOR(2 downto 0);  SIGNAL DRAW: OUT STD_LOGIC);

END MYPROC;



PACKAGE BODY MYPROC IS


PROCEDURE DRAW_SHAPES(SIGNAL X_cur,Y_cur:IN INTEGER; SIGNAL SHAPES: shapes_arr; SIGNAL RGB:OUT STD_LOGIC_VECTOR(2 downto 0);  SIGNAL DRAW: OUT STD_LOGIC) IS

constant N_SHAPE_TYPES : integer := 39;
constant SHAPE_W : integer := 15;
constant SHAPE_H : integer := 15;

type rom_type is array (0 to (N_SHAPE_TYPES*SHAPE_H -1)) of std_logic_vector(SHAPE_W-1 downto 0);
constant ROM: rom_type := (

-- Character '0' (ASCII 48), index: 0
"000000000000000",
"000000000000000",
"000001111100000",
"000011101110000",
"000011000110000",
"000011001110000",
"000011011110000",
"000011110110000",
"000011100110000",
"000011000110000",
"000011000110000",
"000001111100000",
"000000111000000",
"000000000000000",
"000000000000000",

-- Character '1' (ASCII 49), index: 1
"000000000000000",
"000000000000000",
"000000011000000",
"000001111000000",
"000011111000000",
"000000011000000",
"000000011000000",
"000000011000000",
"000000011000000",
"000000011000000",
"000000011000000",
"000001111110000",
"000001111110000",
"000000000000000",
"000000000000000",

-- Character '2' (ASCII 50), index: 2
"000000000000000",
"000000000000000",
"000001111100000",
"000001101110000",
"000000000110000",
"000000000110000",
"000000001100000",
"000000001100000",
"000000011000000",
"000000110000000",
"000001100000000",
"000011111110000",
"000011111110000",
"000000000000000",
"000000000000000",

-- Character '3' (ASCII 51), index: 3
"000000000000000",
"000000000000000",
"000011111100000",
"000001111100000",
"000000011100000",
"000000011000000",
"000000111000000",
"000000111100000",
"000000000110000",
"000000000110000",
"000000001110000",
"000011111100000",
"000001111000000",
"000000000000000",
"000000000000000",

-- Character '4' (ASCII 52), index: 4
"000000000000000",
"000000000000000",
"000000001100000",
"000000011100000",
"000000111100000",
"000000111100000",
"000001101100000",
"000011001100000",
"000111111111000",
"000011111110000",
"000000001100000",
"000000001100000",
"000000001100000",
"000000000000000",
"000000000000000",

-- Character '5' (ASCII 53), index: 5
"000000000000000",
"000000000000000",
"000001111110000",
"000001111100000",
"000001100000000",
"000001100000000",
"000001111000000",
"000000111100000",
"000000000110000",
"000000000110000",
"000000001110000",
"000011111100000",
"000001111000000",
"000000000000000",
"000000000000000",

-- Character '6' (ASCII 54), index: 6
"000000000000000",
"000000000000000",
"000000011100000",
"000000111000000",
"000001100000000",
"000011000000000",
"000011111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000001111100000",
"000000111000000",
"000000000000000",
"000000000000000",

-- Character '7' (ASCII 55), index: 7
"000000000000000",
"000000000000000",
"000011111110000",
"000011111110000",
"000000001100000",
"000000001100000",
"000000011000000",
"000000011000000",
"000000110000000",
"000000110000000",
"000001100000000",
"000001100000000",
"000001000000000",
"000000000000000",
"000000000000000",

-- Character '8' (ASCII 56), index: 8
"000000000000000",
"000000000000000",
"000001111100000",
"000011101110000",
"000011000110000",
"000011100110000",
"000001111100000",
"000001111100000",
"000011001110000",
"000011000110000",
"000011000110000",
"000011111100000",
"000000111000000",
"000000000000000",
"000000000000000",

-- Character '9' (ASCII 57), index: 9
"000000000000000",
"000000000000000",
"000001111100000",
"000011101110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000001111110000",
"000000010110000",
"000000001100000",
"000000011100000",
"000001111000000",
"000001100000000",
"000000000000000",
"000000000000000",

-- Character ':' (ASCII 58), index: 10
"000000000000000",
"000000000000000",
"000000000000000",
"000000000000000",
"000000000000000",
"000000111000000",
"000000111000000",
"000000000000000",
"000000000000000",
"000000000000000",
"000000111000000",
"000000111000000",
"000000000000000",
"000000000000000",
"000000000000000",

-- Character '%' (ASCII 37), index: 11
"000000000000000",
"000000000000000",
"000011100110000",
"000111101100000",
"000110111100000",
"000111111000000",
"000011111000000",
"000000111110000",
"000000111111000",
"000001111011000",
"000001111011000",
"000011001110000",
"000001000100000",
"000000000000000",
"000000000000000",

-- Character 'A' (ASCII 65), index: 12
"000000000000000",
"000000000000000",
"000000111000000",
"000000111000000",
"000000111000000",
"000001101100000",
"000001101100000",
"000001101100000",
"000011111110000",
"000011111110000",
"000011000110000",
"000110000011000",
"000110000011000",
"000000000000000",
"000000000000000",

-- Character 'B' (ASCII 66), index: 13
"000000000000000",
"000000000000000",
"000011111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011111110000",
"000001111000000",
"000000000000000",
"000000000000000",

-- Character 'C' (ASCII 67), index: 14
"000000000000000",
"000000000000000",
"000000111110000",
"000001111110000",
"000011100110000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000010000",
"000011100010000",
"000001111110000",
"000000011100000",
"000000000000000",
"000000000000000",

-- Character 'D' (ASCII 68), index: 15
"000000000000000",
"000000000000000",
"000011111000000",
"000011111100000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000111000",
"000011000110000",
"000011000110000",
"000011001110000",
"000011111100000",
"000011110000000",
"000000000000000",
"000000000000000",

-- Character 'E' (ASCII 69), index: 16
"000000000000000",
"000000000000000",
"000011111110000",
"000011111110000",
"000011000000000",
"000011000000000",
"000011111100000",
"000011111110000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011111110000",
"000001111110000",
"000000000000000",
"000000000000000",

-- Character 'F' (ASCII 70), index: 17
"000000000000000",
"000000000000000",
"000001111110000",
"000011111110000",
"000011000000000",
"000011000000000",
"000011111100000",
"000011111110000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000001000000000",
"000000000000000",
"000000000000000",

-- Character 'G' (ASCII 71), index: 18
"000000000000000",
"000000000000000",
"000000111110000",
"000001111110000",
"000011000110000",
"000011000000000",
"000011000000000",
"000011011110000",
"000011001110000",
"000011000110000",
"000011100110000",
"000001111110000",
"000000111100000",
"000000000000000",
"000000000000000",

-- Character 'H' (ASCII 72), index: 19
"000000000000000",
"000000000000000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011111110000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000010000010000",
"000000000000000",
"000000000000000",

-- Character 'I' (ASCII 73), index: 20
"000000000000000",
"000000000000000",
"000011111110000",
"000011111110000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000011111110000",
"000011111110000",
"000000000000000",
"000000000000000",

-- Character 'J' (ASCII 74), index: 21
"000000000000000",
"000000000000000",
"000011111110000",
"000001111110000",
"000000000110000",
"000000000110000",
"000000000110000",
"000000000110000",
"000000000110000",
"000000000110000",
"000000001100000",
"000011111100000",
"000001111000000",
"000000000000000",
"000000000000000",

-- Character 'K' (ASCII 75), index: 22
"000000000000000",
"000000000000000",
"000011000110000",
"000011000110000",
"000011001100000",
"000011011000000",
"000011111000000",
"000011111000000",
"000011011000000",
"000011001100000",
"000011001110000",
"000011000111000",
"000011000011000",
"000000000000000",
"000000000000000",

-- Character 'L' (ASCII 76), index: 23
"000000000000000",
"000000000000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000011000010000",
"000011000110000",
"000011000110000",
"000011111110000",
"000011111110000",
"000000000000000",
"000000000000000",

-- Character 'M' (ASCII 77), index: 24
"000000000000000",
"000000000000000",
"000011000110000",
"000011000110000",
"000011101110000",
"000011111110000",
"000011111110000",
"000011010110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000010000010000",
"000000000000000",
"000000000000000",

-- Character 'N' (ASCII 78), index: 25
"000000000000000",
"000000000000000",
"000011000110000",
"000011000110000",
"000011100110000",
"000011110110000",
"000011110110000",
"000011011110000",
"000011011110000",
"000011001110000",
"000011001110000",
"000011000110000",
"000010000010000",
"000000000000000",
"000000000000000",

-- Character 'O' (ASCII 79), index: 26
"000000000000000",
"000000000000000",
"000001111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000111000111000",
"000011000110000",
"000011000110000",
"000011000110000",
"000001111100000",
"000000111000000",
"000000000000000",
"000000000000000",

-- Character 'P' (ASCII 80), index: 27
"000000000000000",
"000000000000000",
"000011111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011111100000",
"000011111000000",
"000011000000000",
"000011000000000",
"000011000000000",
"000001000000000",
"000000000000000",
"000000000000000",

-- Character 'Q' (ASCII 81), index: 28
"000000000000000",
"000000000000000",
"000001111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000111000111000",
"000011000110000",
"000011000110000",
"000011000110000",
"000001111100000",
"000000111000000",
"000000011110000",
"000000001110000",

-- Character 'R' (ASCII 82), index: 29
"000000000000000",
"000000000000000",
"000011111100000",
"000011111110000",
"000011000110000",
"000011000110000",
"000011011100000",
"000011111000000",
"000011001100000",
"000011001100000",
"000011000110000",
"000011000110000",
"000001000010000",
"000000000000000",
"000000000000000",

-- Character 'S' (ASCII 83), index: 30
"000000000000000",
"000000000000000",
"000001111110000",
"000011111110000",
"000011000110000",
"000011100000000",
"000001111000000",
"000000111100000",
"000000001110000",
"000011000110000",
"000011000110000",
"000011111110000",
"000001111000000",
"000000000000000",
"000000000000000",

-- Character 'T' (ASCII 84), index: 31
"000000000000000",
"000000000000000",
"000111111111000",
"000111111111000",
"000110010011000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000000010000000",
"000001111100000",
"000001111100000",
"000000000000000",
"000000000000000",

-- Character 'U' (ASCII 85), index: 32
"000000000000000",
"000000000000000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011000110000",
"000011111110000",
"000000111000000",
"000000000000000",
"000000000000000",

-- Character 'V' (ASCII 86), index: 33
"000000000000000",
"000000000000000",
"000110000011000",
"000110000011000",
"000011000110000",
"000011000110000",
"000011000110000",
"000001101100000",
"000001101100000",
"000001111100000",
"000000111000000",
"000000111000000",
"000000010000000",
"000000000000000",
"000000000000000",

-- Character 'W' (ASCII 87), index: 34
"000000000000000",
"000000000000000",
"000110000011000",
"000110000011000",
"000110000011000",
"000110010011000",
"000011111010000",
"000011111110000",
"000011111110000",
"000011101110000",
"000011101110000",
"000011101110000",
"000001000100000",
"000000000000000",
"000000000000000",

-- Character 'X' (ASCII 88), index: 35
"000000000000000",
"000000000000000",
"000011000110000",
"000011000110000",
"000001101100000",
"000001111100000",
"000000111000000",
"000000111000000",
"000000111100000",
"000001101100000",
"000011000110000",
"000011000111000",
"000010000010000",
"000000000000000",
"000000000000000",

-- Character 'Y' (ASCII 89), index: 36
"000000000000000",
"000000000000000",
"000110000011000",
"000011000110000",
"000011000110000",
"000001101100000",
"000001111100000",
"000000111000000",
"000000111000000",
"000000111000000",
"000000111000000",
"000000111000000",
"000000010000000",
"000000000000000",
"000000000000000",

-- Character 'Z' (ASCII 90), index: 37
"000000000000000",
"000000000000000",
"000011111110000",
"000011111110000",
"000000001110000",
"000000001100000",
"000000011000000",
"000000110000000",
"000001110000000",
"000001100000000",
"000011000000000",
"000011111110000",
"000011111110000",
"000000000000000",
"000000000000000",

-- Ball, index: 38
"000001111100000", -- 
"000111111111000", -- 
"001111111111100", -- 
"011111111111110", -- 
"011111111111110", -- 
"111111111111111", -- 
"111111111111111", -- 
"111111111111111", -- 
"111111111111111", -- 
"111111111111111", -- 
"011111111111110", -- 
"011111111111110", -- 
"001111111111100", -- 
"000111111111000", -- 
"000001111100000"

    );

variable XREL :integer := 0;
variable YREL :integer := 0;
variable SHAPE_TYPE :integer := 0;

BEGIN

for i in SHAPES'range loop

	SHAPE_TYPE := to_integer(unsigned( SHAPES(i)(9 downto 2) ));

	if (to_integer(unsigned(SHAPES(i))) /= 0 and SHAPE_TYPE < N_SHAPE_TYPES) then

		XREL := X_cur -(to_integer(unsigned( SHAPES(i)(31 downto 22) )) - SHAPE_W/2);
		YREL := Y_cur -(to_integer(unsigned( SHAPES(i)(21 downto 13) )) - SHAPE_H/2) +SHAPE_H*SHAPE_TYPE;

		if (XREL > -1 and XREL < SHAPE_W and YREL > (SHAPE_TYPE*SHAPE_H -1) and YREL < (SHAPE_TYPE +1)*SHAPE_H) then

			if ROM(YREL)(SHAPE_W -1 -XREL) = '1' then
				DRAW <= '1';
				RGB <= SHAPES(i)(12 downto 10);
				exit;
			else
				DRAW <= '0';
			end if ;
		  
		else
		  	DRAW <= '0';
		end if ;

	else
		DRAW <= '0';
	end if;

end loop;

END DRAW_SHAPES;



PROCEDURE DRAW_GRID(SIGNAL X_cur,Y_cur:IN INTEGER; SIGNAL RGB:OUT STD_LOGIC_VECTOR(2 downto 0);  SIGNAL DRAW: OUT STD_LOGIC)  IS

constant Y_upper_margin : integer := 50;
constant Y_lower_margin : integer := 10;
constant X_margin : integer := 30;
constant stroke_width : integer := 15;
constant box_width : integer := 45;
constant box_height : integer := 45;

constant grid_height : integer := (stroke_width*(6+1) +box_height*6);
constant grid_width : integer := (stroke_width*(7+1) +box_width*7);

BEGIN
	IF (X_cur > X_margin and X_cur < X_margin+grid_width and
	   (Y_cur > Y_upper_margin) and Y_cur < Y_upper_margin+grid_height) THEN


		if ((X_cur > X_margin +(stroke_width*0 +box_width*0) and X_cur < X_margin +(stroke_width*(0+1) +box_width*0)) or
			(X_cur > X_margin +(stroke_width*1 +box_width*1) and X_cur < X_margin +(stroke_width*(1+1) +box_width*1)) or
			(X_cur > X_margin +(stroke_width*2 +box_width*2) and X_cur < X_margin +(stroke_width*(2+1) +box_width*2)) or
			(X_cur > X_margin +(stroke_width*3 +box_width*3) and X_cur < X_margin +(stroke_width*(3+1) +box_width*3)) or
			(X_cur > X_margin +(stroke_width*4 +box_width*4) and X_cur < X_margin +(stroke_width*(4+1) +box_width*4)) or
			(X_cur > X_margin +(stroke_width*5 +box_width*5) and X_cur < X_margin +(stroke_width*(5+1) +box_width*5)) or
			(X_cur > X_margin +(stroke_width*6 +box_width*6) and X_cur < X_margin +(stroke_width*(6+1) +box_width*6)) or
			(X_cur > X_margin +(stroke_width*7 +box_width*7) and X_cur < X_margin +(stroke_width*(7+1) +box_width*7))) then
			
			RGB<="100";
			DRAW<='1';

		elsif ((Y_cur > Y_upper_margin +(stroke_width*0 +box_height*0) and Y_cur < Y_upper_margin +(stroke_width*(0+1) +box_height*0)) or
			(Y_cur > Y_upper_margin +(stroke_width*1 +box_height*1) and Y_cur < Y_upper_margin +(stroke_width*(1+1) +box_height*1)) or
			(Y_cur > Y_upper_margin +(stroke_width*2 +box_height*2) and Y_cur < Y_upper_margin +(stroke_width*(2+1) +box_height*2)) or
			(Y_cur > Y_upper_margin +(stroke_width*3 +box_height*3) and Y_cur < Y_upper_margin +(stroke_width*(3+1) +box_height*3)) or
			(Y_cur > Y_upper_margin +(stroke_width*4 +box_height*4) and Y_cur < Y_upper_margin +(stroke_width*(4+1) +box_height*4)) or
			(Y_cur > Y_upper_margin +(stroke_width*5 +box_height*5) and Y_cur < Y_upper_margin +(stroke_width*(5+1) +box_height*5)) or
			(Y_cur > Y_upper_margin +(stroke_width*6 +box_height*6) and Y_cur < Y_upper_margin +(stroke_width*(6+1) +box_height*6))) then
			
			RGB<="100";
			DRAW<='1';

		else
			DRAW<='0';
		end if ;
	ELSE
		DRAW<='0';
	END IF;
END DRAW_GRID;



END MYPROC;