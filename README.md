MIPS32 5-Stage Pipelined Processor (Basic Design)
📌 Overview

This project implements a basic MIPS32 processor using a 5-stage pipelined datapath in Verilog HDL.
The design follows the classical MIPS architecture and focuses on instruction flow, datapath design, and pipeline operation.

⚠️ Note:
This implementation does not include hazard detection or forwarding units.
Instruction sequences are assumed to be hazard-free and manually scheduled.

🧾 1. MIPS32 Architectural Specification
1.1 Register Organization

32 general-purpose registers (GPRs)

Register width: 32 bits

Registers: R0 to R31

R0 is hardwired to constant 0 (cannot be written)

1.2 Program Counter (PC)

Special-purpose 32-bit register

Holds the address of the next instruction to be fetched

1.3 Memory Assumptions

Word size: 32 bits

Memory is word-addressable

Only load and store instructions access memory

1.4 Key Architectural Characteristics

No flag registers

Few addressing modes

Load/store architecture

Simple and regular instruction encoding

🧠 2. Instruction Set Overview
2.1 Load & Store Instructions
LW   R2, 124(R8)     // R2 = Mem[R8 + 124]
SW   R5, -10(R25)    // Mem[R25 - 10] = R5

2.2 Arithmetic & Logic Instructions (Register Type)
ADD  R1, R2, R3      // R1 = R2 + R3
SUB  R12, R10, R8
AND  R20, R1, R5
OR   R11, R5, R6
MUL  R5, R6, R7
SLT  R5, R11, R12

2.3 Arithmetic & Logic Instructions (Immediate Type)
ADDI R1, R2, 25
SUBI R5, R1, 150
SLTI R2, R10, 10

2.4 Branch Instructions
BEQZ  R1, LOOP       // Branch if R1 == 0
BNEQZ R5, LABEL      // Branch if R5 != 0

2.5 Jump Instruction
J LOOP               // Unconditional jump

2.6 Miscellaneous
HLT                  // Halt execution

🧩 3. Instruction Encoding

All MIPS32 instructions are 32 bits wide and classified into three formats:

3.1 R-Type Instruction Format
| opcode | rs | rt | rd | shamt | funct |
|  6b    |5b  |5b  |5b  | 5b    | 6b    |


Uses three registers

Two source registers, one destination register

funct field specifies the operation

3.2 I-Type Instruction Format
| opcode | rs | rt | immediate |
|  6b    |5b  |5b  |   16b     |


Used for immediate, load/store, and branch instructions

Immediate field is sign-extended

3.3 J-Type Instruction Format
| opcode | address |
|  6b    |  26b    |


Used for jump instructions

Address combined with PC for target calculation

🧭 4. Addressing Modes in MIPS32
Addressing Mode	Example
Register	ADD R1, R2, R3
Immediate	ADDI R1, R2, 100
Base (Register + Offset)	LW R5, 150(R7)
PC-Relative	BEQZ R3, LABEL
Pseudo-Direct	J LOOP
🏗️ 5. Datapath Architecture
5.1 Non-Pipelined Datapath

Characteristics

One instruction executes completely before the next begins

Single long clock cycle

Simple but inefficient

Used as a reference model to understand instruction flow.

5.2 5-Stage Pipelined Datapath

Pipeline Registers

IF/ID

ID/EX

EX/MEM

MEM/WB

Advantages

Overlapping instruction execution

Improved throughput

Better hardware utilization

⚠️ No hazard detection or forwarding logic included.

🔄 6. Instruction Cycle (Pipeline Stages)
6.1 IF — Instruction Fetch

Fetch instruction from Instruction Memory

Compute PC + 4

6.2 ID — Instruction Decode & Register Fetch

Decode instruction fields

Read register operands

Sign-extend immediate

6.3 EX — Execute / Address Calculation

ALU performs arithmetic/logic

Branch condition evaluated

Effective address computed

6.4 MEM — Memory Access

Data memory read/write

Branch completion

6.5 WB — Write Back

Write ALU result or memory data to register file
