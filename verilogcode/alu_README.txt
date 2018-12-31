When you run any of the testbenches here are what the variables 
represent:

a is the first number.
b is the second number.
s is the sum of the full adder.
cout is the carry out. You don't have to look at the cout.
op is the opcode.
choice is just the output to my two to one multiplexer. Ignore it.
q is the output of the 4 to 1 multiplexer, it will show the actual output of the opcode.

In alu_zero.v:
I have two testbenches so that it's easier for you to grade the circuit.
the first testbench is for add, sub, and slt
the second one is for and and or
just comment out one of the testbenches and run the other
