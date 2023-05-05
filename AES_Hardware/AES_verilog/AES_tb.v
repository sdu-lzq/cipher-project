`timescale 1ns/1ns
`include "AES.v"

module AES_tb;
parameter CLOCK = 10;
//AES_ENC(Din,Key,Dout,Drin,Krin,Reset,ENK,CLK,BSY,Drout);

reg  [127:0] Din;
reg  [127:0] Key;
reg  Drin;
reg  Krin;
reg  Reset;
reg  EN;
reg  CLK;
wire [127:0] Dout;
wire BSY;
wire Drout;

AES_ENC AES_E(
  .Din(Din),
  .Key(Key),
  .Dout(Dout),
  .Drin(Drin),
  .Krin(Krin),
  .Reset(Reset),
  .ENK(EN),
  .CLK(CLK),
  .BSY(BSY),
  .Drout(Drout)
);


reg [127:0] Keyd,plain_text;
initial Keyd = 128'h000102030405060708090a0b0c0d0e0f; 
initial plain_text = 128'h00112233445566778899aabbccddeeff;

initial CLK = 1;
always #(CLOCK/2)
  CLK <= ~CLK;


initial begin

#(CLOCK/2)
//Reset
EN <= 0;
Reset <= 0;
Krin <= 0;
Drin <=0;
//将所有的信号置0

#(CLOCK)
Reset <=1;
EN <=1 ;
Key <= Keyd;
Krin<=1;

#(CLOCK)
Krin <= 0;
Din <= plain_text;
Drin <=1;
//将数据输入

#(CLOCK)

#(CLOCK*10)
$finish;
end

initial begin
    $dumpfile("wave.vcd");
    //check the wave of the module.
    $dumpvars;
end


endmodule
