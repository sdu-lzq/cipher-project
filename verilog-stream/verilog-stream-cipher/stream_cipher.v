
module A5(
    input wire rest,
    input wire clk,  //时钟信号
    input wire [63:0] Key,  //初始化密钥
    output  wire code
);



reg[18:0] A;
reg[21:0] B;
reg[22:0] C;
reg X;
reg Y;
reg Z;
reg  re;
reg condition1;
reg condition2;
reg condition3;
reg feedback1,feedback2,feedback3;


always @(posedge clk or rest ) begin
    if(rest)
    begin
    A = Key[18:0];
    B = Key[40:19];
    C = Key[63:41];
    end
    //initialize the key
    X = A[8];
    Y = B[10];
    Z = C[10];
    //generate round key
    re = A[18]^B[21]^C[22];
    //feedback condition judgement
    //use clocking bit 
    condition1 = ((~X)&(~Y))|(X&Z)|(Y&(~Z));
    condition2 = ((~Y)&(~Z))|((~X)&Y)|(X&Y);
    condition3 = ((~Y)&(~Z))|(X&Z)|(Y&(~X));
    if(condition1 == 1'b1)
    begin
        feedback1 = A[18]^A[17]^A[16]^A[13];
        A = {A[17:0],feedback1};
    end
    if(condition2 == 1'b1)
    begin
        feedback2 = B[21]^B[20];
        B = {B[20:0],feedback2};
    end
    if(condition3 == 1'b1)
    begin
        feedback3 = C[21]^C[20]^C[22]^C[7];
        C = {C[21:0],feedback3};
    end
    
end
    assign code = re;

endmodule

