/*
ALU zero delay simulation
*/

// this is the full adder for alu
module fulladder(a,b,c,s,cout);
input a,b,c;
output s, cout;
wire axorb, bandc, canda, aandb; 
xor 
    z1(axorb, a, b),
    z2(s, axorb, c);
and 
    z3(bandc, b, c),
    z4(canda, c, a),
    z5(aandb, a, b);
or 
    z6(cout, bandc, canda, aandb);
endmodule 

//2 to 1 mux
module twotoone(first, second, select, choice);
input first, second, select;
output choice;
wire fsel, ssel, notsel;

not y1(notsel, select);
and y2(fsel, first, notsel);
and y3(ssel, second, select);
or y4(choice, ssel, fsel);
endmodule

//4 to 1 mux
module fourToOne(sel, sel2, zero, one, two, three, selected);
input sel, sel2, zero, one, two, three;
output selected;
wire notsel, notsel2, w1, w2, w3, w4;

not 
    x0(notsel, sel),
    x1(notsel2, sel2);
and x2(w1, zero, notsel2, notsel);
and x3(w2, two, sel, notsel2);
and x4(w3, one, notsel, sel2);
and x5(w4, three, sel2, sel);
or x6(selected, w1, w2, w3, w4);
endmodule

//this is a 1 bit alu 
module onealu(a, b, cin, s, cout, less, op, choice,q);
input a, b, cin, less; 
input [2:0] op;
output s, cout, choice, q;
wire aandb, aorb, notb;

not t6(notb, b);
and t5(aandb,a,b); // the and operation
or t4(aorb, a,b); // the or operation
twotoone t1(b, notb, op[2], choice); // creates the 2 to 1 mux
fulladder t2(a, choice, cin, s, cout); // the adder of the alu
fourToOne t3(op[1], op[0], aandb, aorb, s, less, q);
endmodule

module sixteenBitalu(a, b, s, cout, op, choice, q);
input [15:0] a, b;
input [2:0] op;
output [15:0] s, choice, c, q;
output cout;

onealu o1(a[0], b[0], op[2], s[0], c[0], s[15], op, choice[0],q[0]);
onealu o2(a[1], b[1], c[0], s[1], c[1], 0, op, choice[1],q[1]);
onealu o3(a[2], b[2], c[1], s[2], c[2], 0, op, choice[2], q[2]);
onealu o4(a[3], b[3], c[2], s[3], c[3], 0, op, choice[3], q[3]);

onealu o5(a[4], b[4], c[3], s[4], c[4], 0, op, choice[4], q[4]);
onealu o6(a[5], b[5], c[4], s[5], c[5], 0, op, choice[5], q[5]);
onealu o7(a[6], b[6], c[5], s[6], c[6], 0, op, choice[6], q[6]);
onealu o8(a[7], b[7], c[6], s[7], c[7], 0, op, choice[7], q[7]);

onealu o9(a[8], b[8], c[7], s[8], c[8], 0, op, choice[8], q[8]);
onealu o10(a[9], b[9], c[8], s[9], c[9], 0, op, choice[9], q[9]);
onealu o11(a[10], b[10], c[9], s[10], c[10], 0, op, choice[10], q[10]);
onealu o12(a[11], b[11], c[10], s[11], c[11], 0, op, choice[11], q[11]);

onealu o13(a[12], b[12], c[11], s[12], c[12], 0, op, choice[12], q[12]);
onealu o14(a[13], b[13], c[12], s[13], c[13], 0, op, choice[13], q[13]);
onealu o15(a[14], b[14], c[13], s[14], c[14], 0, op, choice[14], q[14]);
onealu o16(a[15], b[15], c[14], s[15], cout, 0, op, choice[15], q[15]);
endmodule

//testbench for slt add and sub
`timescale 1ns/1ns
module testbench();
output reg [15:0] a, b;
output reg [2:0] op;
input [15:0] s, choice, q;
input cout;
sixteenBitalu s1(a, b, s, cout, op, choice, q);
initial
  begin
  $monitor($time,, "a=%d, b=%d, s=%d, cout=%b, op=%b, choice=%b, q=%d", a, b, s, cout, op, choice, q);
  $display($time,, "a=%d, b=%d, s=%d, cout=%b, op=%b, choice=%b, q=%d", a, b, s, cout, op, choice, q);
    #20 a = 2; b = 3; op = 010;
    #20 a = 10; b = 7; op = 010;
    #20 a = 25; b = 657; op = 010;
    #20 a = 1234; b = 25768; op = 010;
    #20 a = 2; b = 3; op = 110;
    #20 a = 657; b = 25; op = 110;
    #20 a = 25768; b = 1234; op = 110;
    #20 a = 60000; b = 50000; op = 110;
    #20 a = 2; b = 3; op = 111;
    #20 a = 654; b = 111; op = 111;
    #20 a = 1234; b = 5678; op = 111;
    #20 a = 60000; b = 50000; op = 111;
    #20
  $display($time,, "a=%d, b=%d, s=%d, cout=%b, op=%b, choice=%b, q=%d", a, b, s, cout, op, choice, q);
  end
endmodule

//testbench for and and or 
`timescale 1ns/1ns
module testbench2();
output reg [15:0] a, b;
output reg [2:0] op;
input [15:0] s, choice, q;
input cout;
sixteenBitalu s2(a, b, s, cout, op, choice, q);
initial
  begin
  $monitor($time,, "a=%b, b=%b, s=%d, cout=%b, op=%b, choice=%b, q=%b", a, b, s, cout, op, choice, q);
  $display($time,, "a=%b, b=%b, s=%d, cout=%b, op=%b, choice=%b, q=%b", a, b, s, cout, op, choice, q);
    #20 a = 1010; b = 1011; op = 000;
    #20 a = 1111110010; b = 1101111; op = 000;
    #20 a = 10101011111001; b = 1000001111001001; op = 000;
    #20 a = 1110001111011010; b = 1110010100001000; op = 000;
    #20 a = 1010; b = 1011; op = 001;
    #20 a = 1111110010; b = 1101111; op = 001;
    #20 a = 10101011111001; b = 1000001111001001; op = 001;
    #20 a = 1110001111011010; b = 1110010100001000; op = 001;
    #20
  $display($time,, "a=%b, b=%b, s=%d, cout=%b, op=%b, choice=%b, q=%b", a, b, s, cout, op, choice, q);
  end
endmodule
