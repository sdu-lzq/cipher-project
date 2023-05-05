//here we use a assign to combine 4 Sbox together.
//We have achieve 32bit look-up table

module SubBytes(x,y);
    input [31:0] x;
    output [31:0] y;
    //default set is wire 
    //use function to multiple excute the block
    function [7:0] S;//function_id return back value
    input [7:0] x   ;
        case (x)
        0:S= 99;   1:S=124;   2:S=119;   3:S=123;   4:S=242;   5:S=107;   6:S=111;   7:S=197;
        8:S= 48;   9:S=  1;  10:S=103;  11:S= 43;  12:S=254;  13:S=215;  14:S=171;  15:S=118;
       16:S=202;  17:S=130;;;18:S=201;  19:S=125;  20:S=250;  21:S= 89;  22:S= 71;  23:S=240;
       24:S=173;  25:S=212;  26:S=162;  27:S=175;  28:S=156;  29:S=164;  30:S=114;  31:S=192;
       32:S=183;  33:S=253;  34:S=147;  35:S= 38;  36:S= 54;  37:S= 63;  38:S=247;  39:S=204;
       40:S= 52;  41:S=165;  42:S=229;  43:S=241;  44:S=113;  45:S=216;  46:S= 49;  47:S= 21;
       48:S=  4;  49:S=199;  50:S= 35;  51:S=195;  52:S= 24;  53:S=150;  54:S=  5;  55:S=154;
       56:S=  7;  57:S= 18;  58:S=128;  59:S=226;  60:S=235;  61:S= 39;  62:S=178;  63:S=117;
       64:S=  9;  65:S=131;  66:S= 44;  67:S= 26;  68:S= 27;  69:S=110;  70:S= 90;  71:S=160;
       72:S= 82;  73:S= 59;  74:S=214;  75:S=179;  76:S= 41;  77:S=227;  78:S= 47;  79:S=132;
       80:S= 83;  81:S=209;  82:S=  0;  83:S=237;  84:S= 32;  85:S=252;  86:S=177;  87:S= 91;
       88:S=106;  89:S=203;  90:S=190;  91:S= 57;  92:S= 74;  93:S= 76;  94:S= 88;  95:S=207;
       96:S=208;  97:S=239;  98:S=170;  99:S=251; 100:S= 67; 101:S= 77; 102:S= 51; 103:S=133;
      104:S= 69; 105:S=249; 106:S=  2; 107:S=127; 108:S= 80; 109:S= 60; 110:S=159; 111:S=168;
      112:S= 81; 113:S=163; 114:S= 64; 115:S=143; 116:S=146; 117:S=157; 118:S= 56; 119:S=245;
      120:S=188; 121:S=182; 122:S=218; 123:S= 33; 124:S= 16; 125:S=255; 126:S=243; 127:S=210;
      128:S=205; 129:S= 12; 130:S= 19; 131:S=236; 132:S= 95; 133:S=151; 134:S= 68; 135:S= 23;
      136:S=196; 137:S=167; 138:S=126; 139:S= 61; 140:S=100; 141:S= 93; 142:S= 25; 143:S=115;
      144:S= 96; 145:S=129; 146:S= 79; 147:S=220; 148:S= 34; 149:S= 42; 150:S=144; 151:S=136;
      152:S= 70; 153:S=238; 154:S=184; 155:S= 20; 156:S=222; 157:S= 94; 158:S= 11; 159:S=219;
      160:S=224; 161:S= 50; 162:S= 58; 163:S= 10; 164:S= 73; 165:S=  6; 166:S= 36; 167:S= 92;
      168:S=194; 169:S=211; 170:S=172; 171:S= 98; 172:S=145; 173:S=149; 174:S=228; 175:S=121;
      176:S=231; 177:S=200; 178:S= 55; 179:S=109; 180:S=141; 181:S=213; 182:S= 78; 183:S=169;
      184:S=108; 185:S= 86; 186:S=244; 187:S=234; 188:S=101; 189:S=122; 190:S=174; 191:S=  8;
      192:S=186; 193:S=120; 194:S= 37; 195:S= 46; 196:S= 28; 197:S=166; 198:S=180; 199:S=198;
      200:S=232; 201:S=221; 202:S=116; 203:S= 31; 204:S= 75; 205:S=189; 206:S=139; 207:S=138;
      208:S=112; 209:S= 62; 210:S=181; 211:S=102; 212:S= 72; 213:S=  3; 214:S=246; 215:S= 14;
      216:S= 97; 217:S= 53; 218:S= 87; 219:S=185; 220:S=134; 221:S=193; 222:S= 29; 223:S=158;
      224:S=225; 225:S=248; 226:S=152; 227:S= 17; 228:S=105; 229:S=217; 230:S=142; 231:S=148;
      232:S=155; 233:S= 30; 234:S=135; 235:S=233; 236:S=206; 237:S= 85; 238:S= 40; 239:S=223;
      240:S=140; 241:S=161; 242:S=137; 243:S= 13; 244:S=191; 245:S=230; 246:S= 66; 247:S=104;
      248:S= 65; 249:S=153; 250:S= 45; 251:S= 15; 252:S=176; 253:S= 84; 254:S=187; 255:S= 22;
    endcase
    endfunction

    assign y = {S(x[31:24]),S(x[23:16]),S(x[15:8]),S(x[7:0])};
    //continuous assign a value,and the value is type wire
    endmodule



module MixColumns(x,y);
    input [31:0] x;
    output [31:0] y;

    wire [7:0] a3,a2,a1,a0;

    assign a3 = x[31:24];
    assign a2 = x[23:16];
    assign a1 = x[15: 8];
    assign a0 = x[ 7: 0];

    function [7:0] SS;
        input [7:0] data;
        SS = {data[6],data[5],data[4],data[3]^data[7],data[2]^data[7],data[1],data[0]^data[7],data[7]};
    endfunction
    
    // function [7:0] SSS;
    //     input [7:0] data;
    //     SSS = {data[6]^data[7],data[5]^data[6],data[4]^data[7]^data[5],data[3]^data[7]^data[4],data[2]^data[3],data[1]^data[2],data[0]^data[7]^data[1],data[7]^data[0]};
    // endfunction
    assign y = {SS(a3)^(SS(a2)^a2)^a1^a0,a3^SS(a2)^(SS(a1)^a1)^a0,a3^a2^SS(a1)^(SS(a0)^a0),(SS(a3)^a3)^a2^a1^SS(a0)};
    //assign y = {SS(a3)^SSS(a2)^a1^a0,a3^SS(a2)^SSS(a1)^a0,a3^a2^SS(a1)^SSS(a0),SSS(a3)^a2^a1^SS(a0)};
    endmodule

//do not expand the encrypt process,do only one round one time
module Enc(di,ki,Round,dn,ko);
    input [127:0] di;
    input [127:0] ki;
    input [9:0] Round;
    output [127:0] dn;
    output [127:0] ko;

    wire [127:0] sb,sr,mx;
    wire [31:0] kp;

 //subBytes
  SubBytes SB3 (di[127:96], sb[127:96]);
  SubBytes SB2 (di[ 95:64], sb[ 95:64]);
  SubBytes SB1 (di[ 63:32], sb[ 63:32]);
  SubBytes SB0 (di[ 31: 0], sb[ 31: 0]);

//shift_rows
  assign sr = {sb[127:120], sb[ 87: 80], sb[ 47: 40], sb[  7:  0],
               sb[ 95: 88], sb[ 55: 48], sb[ 15:  8], sb[103: 96],
               sb[ 63: 56], sb[ 23: 16], sb[111:104], sb[ 71: 64],
               sb[ 31: 24], sb[119:112], sb[ 79: 72], sb[ 39: 32]};

MixColumns MX3 (sr[127:96],mx[127:96]);
MixColumns MX2 (sr[95:64],mx[95:64]);
MixColumns MX1 (sr[63:32],mx[63:32]);
MixColumns MX0 (sr[31:0],mx[31:0]);

assign dn = ((Round[0] == 1)? sr:mx)^ki;
//The last round don't have the mixcolumn.


function [7:0] rcon;
input [9:0] x;//the round now
casex (x)
    10'bxxxxxxxxx1: rcon = 8'h01;
    10'bxxxxxxxx1x: rcon = 8'h02;
    10'bxxxxxxx1xx: rcon = 8'h04;
    10'bxxxxxx1xxx: rcon = 8'h08;
    10'bxxxxx1xxxx: rcon = 8'h10;
    10'bxxxx1xxxxx: rcon = 8'h20;
    10'bxxx1xxxxxx: rcon = 8'h40;
    10'bxx1xxxxxxx: rcon = 8'h80;
    10'bx1xxxxxxxx: rcon = 8'h1b;
    10'b1xxxxxxxxx: rcon = 8'h36;
endcase
endfunction


SubBytes SBk ({ki[23:16],ki[15:8],ki[7:0],ki[31:24]},kp);

  assign ko[127:96] = ki[127:96] ^ {kp[31:24] ^ rcon(Round), kp[23: 0]};
  assign ko[ 95:64] = ki[ 95:64] ^ ko[127:96];
  assign ko[ 63:32] = ki[ 63:32] ^ ko[ 95:64];
  assign ko[ 31: 0] = ki[ 31: 0] ^ ko[ 63:32];
endmodule


module AES_ENC(Din,Key,Dout,Drin,Krin,Reset,ENK,CLK,BSY,Drout);
  input [127:0] Din;
  input [127:0] Key;
  output [127:0] Dout;
  input Drin;
  input Krin;
  input Reset;
  input ENK;
  input CLK;
  output BSY;
  output Drout;

  reg [127:0] Drg;//Data temp
  reg [127:0] Krg;//Key register
  reg [127:0] KrgT;
  reg [9:0] Rrg;
  reg Droutrg,BSYrg;
  wire [127:0] Dnext,knext;

  Enc EC(Drg,KrgT,Rrg,Dnext,knext);

  assign Drout = Droutrg;
  assign Dout = Drg;
  assign BSY =  BSYrg;

always @(posedge CLK) begin
  if (Reset == 0) 
  begin
    Rrg <= 10'b0000000001;
    Droutrg <= 0;
    BSYrg <=0;
  end
  else if(ENK == 1)
  begin
    if(BSYrg==0)
    begin
      if (Krin == 1)
      begin
        Krg <= Key;
        KrgT <= Key;
        Droutrg <= 0;
      end
      else if (Drin == 1)
      begin
        Rrg <= {Rrg[8:0],Rrg[9]};
        KrgT <= knext;
        Drg <= Din^Krg;
        Droutrg <= 0;
        BSYrg <=1;
      end
    end
    else begin
      Drg <= Dnext;
      if (Rrg[0] == 1)begin
        KrgT <=Krg;
        Droutrg <=1;
        BSYrg<=0;
      end 
      else begin
        Rrg <= {Rrg[8:0],Rrg[9]};
        KrgT <= knext;
      end
    end
  end
end 
    
endmodule



