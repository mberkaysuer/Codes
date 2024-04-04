----------------------------------------------------------------------------------
-- Engineer: Mustafa Berkay SÜER
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity UART_Demo is
  generic (
	CLK_FREQ 	: integer := 100_000_000;
	BAUD_RATE	: integer := 115_200;
	STOP_BIT	: integer := 1  );
  Port ( 
   Tx_Start_Tick_I	: in std_logic;
   D_1_in			: in std_logic_vector(7 downto 0);
   D_2_in           : in std_logic_vector(7 downto 0);
   Clk              : in std_logic;
   Data_1_out       : out std_logic_vector(7 downto 0);
   Data_2_out       : out std_logic_vector(7 downto 0)
  );
end UART_Demo;

architecture Behavioral of UART_Demo is
component uart 
generic (
CLK_FREQ 	: integer := 100_000_000;
BAUD_RATE	: integer := 115_200;
STOP_BIT	: integer := 1
);


port (
Tx_Done_Tick_O      : out  std_logic; 
Tx_O				: out std_logic;
Data_out			: out std_logic_vector(7 downto 0);
Rx_Done_Tick_O      : out std_logic;

Clk                 : in   std_logic;
Tx_Start_Tick_I     : in   std_logic ; 
D_in                : in   std_logic_vector(7 downto 0);  
Rx_I				: in   std_logic);
end component;

signal Rx_1			     : std_logic := '1';
signal Rx_2              : std_logic := '1';
signal Tx_1              : std_logic := '1';
signal Tx_2              : std_logic := '1';
signal Tx_Done_Tick_O_2    : std_logic :='0';
signal Rx_Done_Tick_O_2    : std_logic :='0';
signal Tx_Done_Tick_O_1    : std_logic :='0';
signal Rx_Done_Tick_O_1    : std_logic :='0';

begin
UART_1 : uart
generic map(
CLK_FREQ 	=> CLK_FREQ ,
BAUD_RATE	=> BAUD_RATE,
STOP_BIT	=> STOP_BIT)

port map(

Tx_Done_Tick_O        =>Tx_Done_Tick_O_1,
Tx_O			      => Tx_1,
Data_out		      => Data_1_out,
Rx_Done_Tick_O        => Rx_Done_Tick_O_1,
Clk                   => Clk,
Tx_Start_Tick_I       => Tx_Start_Tick_I,
D_in                  => D_1_in,
Rx_I                  => Rx_1       );

UART_2 : uart
generic map(

CLK_FREQ 	=> CLK_FREQ ,
BAUD_RATE	=> BAUD_RATE,
STOP_BIT	=> STOP_BIT
)
port map(
Tx_Done_Tick_O        =>Tx_Done_Tick_O_2,
Tx_O			      => Tx_2,
Data_out		      => Data_2_out,
Rx_Done_Tick_O        => Rx_Done_Tick_O_2,
Clk                   => Clk,
Tx_Start_Tick_I       =>Tx_Start_Tick_I,
D_in                  => D_2_in,
Rx_I                  => Rx_2   
);

Rx_2<=Tx_1; 
Rx_1<=Tx_2; 

--data_process : process (Clk) 
--begin 
--if rising_edge(Clk) then 
--Rx_2<=Tx_1; 
--Rx_1<=Tx_2; 
--end if;
--end process data_process;

end Behavioral;
