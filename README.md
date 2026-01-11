# MIPS32 5-Stage Pipeline Processor

## 1. Project Specification

### 1.1 ISA Specification
- Architecture: MIPS32
- Instruction length: 32 bits
- Data width: 32 bits
- Addressing mode: Byte-addressable memory
- Register file:
  - 32 general-purpose registers
  - Each register is 32 bits wide

### 1.2 Pipeline Specification
- Pipeline depth: 5 stages
- Pipeline registers:
  - IF/ID
  - ID/EX
  - EX/MEM
  - MEM/WB
- Clocking scheme: Single global clock
- Reset: Synchronous reset

### 1.3 Supported Instructions
- **R-type**: add, sub, and, or, slt
- **I-type**: lw, sw, addi
- **Branch**: beq (basic comparison)

⚠️ Instruction sequences must be manually scheduled to avoid hazards.

---

## 2. Architectural Overview

The processor is based on the classical **MIPS32 datapath** and is implemented
as a **5-stage pipelined processor** using Verilog HDL.

To clearly understand the benefits of pipelining, both **non-pipelined** and
**pipelined** datapaths are shown.

---

## 2.1 MIPS32 Non-Pipelined Datapath

![MIPS32 Non-Pipelined Datapath](MIPS32-Non_Pipelined.png)

### Description
In the non-pipelined datapath, **only one instruction is executed at a time**.
All stages of instruction execution are completed within a **single clock cycle**.

### Key Characteristics
- No overlap between instruction executions
- Long clock period determined by worst-case delay
- Simple control logic
- Low instruction throughput

### Functional Flow
1. Instruction fetch using Program Counter (PC)
2. Instruction decode and register read
3. ALU operation
4. Data memory access (if required)
5. Write-back to register file

This architecture serves as a **baseline reference** for understanding pipelining.

---

## 2.2 MIPS32 5-Stage Pipelined Datapath

![MIPS32 Pipelined Datapath](MIPS32-Pipelined.png)

### Description
The pipelined datapath divides instruction execution into **five stages**,
allowing **multiple instructions to execute concurrently**, each in a different stage.

Pipeline registers isolate each stage and store intermediate values and control signals.

### Pipeline Registers
- **IF/ID**: Instruction and PC+4
- **ID/EX**: Register operands, immediate, control signals
- **EX/MEM**: ALU result and memory control
- **MEM/WB**: Data to be written back to registers

### Advantages
- Higher instruction throughput
- Better utilization of hardware resources
- Reduced clock period compared to non-pipelined design

 This implementation assumes **hazard-free instruction execution**.

---

## 3. Pipeline Microarchitecture (Stage-wise)

### 3.1 Instruction Fetch (IF) Stage
**Purpose**
- Fetch instruction from instruction memory
- Compute next program counter value (PC + 4)

**Hardware Components**
- Program Counter (PC)
- Instruction Memory
- Adder for PC increment

**Pipeline Register**
- IF/ID stores fetched instruction and PC+4

---

### 3.2 Instruction Decode (ID) Stage
**Purpose**
- Decode instruction
- Read source registers
- Generate immediate value

**Hardware Components**
- Instruction Register (IR)
- Register File
- Sign Extension Unit

**Operations**
- Extract opcode, rs, rt, rd fields
- Read operands A and B
- Sign-extend immediate value

**Pipeline Register**
- ID/EX stores operands, immediate, and control signals

---

### 3.3 Execute (EX) Stage
**Purpose**
- Perform arithmetic or logical operations
- Evaluate branch condition
- Compute branch target address

**Hardware Components**
- ALU
- ALU Control Logic
- Operand selection multiplexers

**Operations**
- ALU performs computation based on instruction
- Branch comparison for `beq`

**Pipeline Register**
- EX/MEM stores ALU output and control signals

---

### 3.4 Memory Access (MEM) Stage
**Purpose**
- Access data memory for load and store instructions

**Hardware Components**
- Data Memory

**Operations**
- Read memory for `lw`
- Write memory for `sw`

**Pipeline Register**
- MEM/WB stores memory data or ALU result

---

### 3.5 Write Back (WB) Stage
**Purpose**
- Write final result back to the register file

**Hardware Components**
- Write-back multiplexer

**Operations**
- Select between ALU result and memory output
- Write selected data into destination register

---



