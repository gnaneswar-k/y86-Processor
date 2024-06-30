# y86 Processor

Intro to Processor Architecture (Spring 2023) Course Project

## Features

- **Architecture**: y86 Instruction Set Architecture
- **Instruction Type**: CISC
- **No. of Registers**: 15
- **Implementation**: Pipeline

### ALU

Implemented using *Structural* Logic.

1. 64-bit inputs.
2. Performs the following operations:
   1. `ADD`: Addition
   2. `SUB`: Subtraction
   3. `AND`: Bit-wise AND
   4. `XOR`: Bit-wise XOR
3. 3 flags:
   1. `OF`: Overflow Flag
   2. `SF`: Sign Flag
   3. `ZF`: Zero Flag

### Processor Stages

Implemented using *Behavioural* Logic.

1. 5 Stages of instructuon execution:
   1. Fetch
   2. Decode
   3. Execute
   4. Memory
   5. Write Back
2. Status Codes:
   1. 4 Status Codes:
      1. `HLT`: Halt Instruction
      2. `INS`: Invalid Instruction
      3. `ADR`: Invalid Instruction Memory Address
      4. `AOK`: All OK
   2. Except for `AOK`, processor halts in all other status codes.

### Pipeline Implementation

Handles following Pipeline Hazards:

1. Mispredicted Branch
2. Load/Use
3. Return
