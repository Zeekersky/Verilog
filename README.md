# Verilog Learning

This set of 4 assignments is designed to take learners from beginner to expert in Verilog systematically.

## Assignment Questions:

### Assignment 1 (Structural Verilog Assignment):

1. **Problem 1**: Implement a structural Verilog model for a 3-input AND gate, 3-input OR gate.  
2. **Problem 2**: Implement a structural Verilog model for a 4-bit magnitude comparator.  
3. **Problem 3**: Develop a structural Verilog model for a half adder and subtractor using basic gates and a full adder/subtractor using basic gates.  
4. **Problem 4**: Implement a structural Verilog model for a 4-to-1 multiplexer and 3-to-8 decoder.  
5. **Problem 5**: Create a structural Verilog model for a 4-bit barrel shifter with (1-bit and 2-bit) left and right shift.  
6. **Problem 6**: Create a structural Verilog model for a simple-bit ALU that supports addition, subtraction, multiplication, logical AND, logical OR, and logical XOR. Use Op-Code to specify the operation.  

---

### Assignment 2 (Behavioral Verilog Assignment):

1. **Problem 1**: Write behavioral Verilog code to multiply a 4-bit input by 2.  
2. **Problem 2**: Implement a behavioral Verilog code for a 4-to-2 encoder and 2-to-4 decoder.  
3. **Problem 3**: Design an 8-to-1 multiplexer using a `case` statement in behavioral Verilog.  
4. **Problem 4**: Design an 8-to-3 priority encoder using the `if-else` statement in behavioral Verilog.  
5. **Problem 5**: Write behavioral Verilog code for a 4-bit Carry Look-Ahead Adder.  
6. **Problem 6**: Design behavioral Verilog code for a 4-bit Wallace Tree Multiplier.  

---

### Assignment 3 (Sequential Logic Assignment):

1. **Problem 1**: Implement a Verilog module of an SR latch with asynchronous enable and reset.  
2. **Problem 2**: Implement the Verilog module of an improved version of the D latch as shown in [Figure 1](https://github.com/Zeekersky/Verilog/blob/main/Figure1.png). Specify delays of 1 ns for each gate. Demonstrate the correct operation with your simulator.  
3. **Problem 3**: Design a Verilog module of a counter that counts from 7 to 0 (e.g., 7, 6, 5, 4, 3, 2, 1, 0).  
4. **Problem 4**: Implement a Verilog module of an UP/DOWN modulo-8 Gray Code Counter as shown in Table 2, with an input `UP`. If `UP = 1`, the counter advances sequentially; if `UP = 0`, it retains the previous value.  
5. **Problem 5**: Implement an N-bit bidirectional shift register using D flip-flops. (*Hint: Use a parameterized module to implement N.*)  
6. **Problem 6**: Implement a single-port memory with 128 addressable spaces and 16-bit addressability in Verilog. The memory should have the following inputs: clock, write enable, write address register, and read address register. It should also have two outputs: read and write data registers.  

---

### Assignment 4 (FSM-Based Assignment):

1. **Problem 1**: Implement a Verilog-based Moore machine as shown in [Figure 5](https://github.com/Zeekersky/Verilog/blob/main/Figure2.png).  
2. **Problem 2**: Implement a Verilog-based Mealy machine as given in [Figure 3](https://github.com/Zeekersky/Verilog/blob/main/Figure2.png).  
3. **Problem 3**: Implement an FSM in Verilog that detects the input sequence `1101` on the input variable `x`. The FSM should detect the sequence every time it occurs, even if embedded within other bits. When the desired sequence is detected, the output `Z` should be 1; otherwise, it should be 0. Resetting the state machine should return it to the initial state `S0`.  
4. **Problem 4**: Design a system with two 1-bit input signals (PA and PB) and one 1-bit output signal (O). The output should follow the modular equation `2N(P_A) + N(P_B) = 1 (mod 4)`. Here, `N(P_A)` and `N(P_B)` represent the total occurrences of `PA` and `PB` being high (logic 1) at each positive clock edge, respectively. The output `O` is set to 1 when the equation is satisfied and 0 otherwise.  

#### Example:
- **1st cycle**: PA = 0 (N(P_A) = 0), PB = 0 (N(P_B) = 0)  
  → 2N(P_A) + N(P_B) = 0 (mod 4) → O = 0  
- **2nd cycle**: PA = 1 (N(P_A) = 1), PB = 1 (N(P_B) = 1)  
  → 2N(P_A) + N(P_B) = 3 (mod 4) → O = 0  
- **3rd cycle**: PA = 1 (N(P_A) = 2), PB = 0 (N(P_B) = 1)  
  → 2N(P_A) + N(P_B) = 5 (mod 4) → O = 1  
- **4th cycle**: PA = 0 (N(P_A) = 2), PB = 1 (N(P_B) = 2)  
  → 2N(P_A) + N(P_B) = 6 (mod 4) → O = 0  

The Verilog codes are implemented in this repo based on the above description. 
