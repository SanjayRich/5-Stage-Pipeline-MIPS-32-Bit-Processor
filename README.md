# MIPS32 5-Stage Pipeline Processor (Basic Implementation)

## 1. Project Specification

### 1.1 ISA Specification
- Architecture: MIPS32
- Word size: 32 bits
- Instruction length: 32 bits
- Addressing: Byte-addressable memory
- Register file:
  - 32 general-purpose registers
  - Register width: 32 bits

### 1.2 Pipeline Specification
- Pipeline depth: 5 stages
- Pipeline registers:
  - IF/ID
  - ID/EX
  - EX/MEM
  - MEM/WB
- Clocking: Single global clock
- Reset: Synchronous reset

### 1.3 Supported Instructions
- **R-type**: add, sub, and, or, slt
- **I-type**: lw, sw, addi
- **Branch**: beq (basic comparison)

 Instruction sequences must be hazard-free.

---

## 2. Architectural Overview

The processor follows the classical **MIPS 5-stage pipelined architecture**.
All pipeline stages are implemented within a **single Verilog module**, with
explicit pipeline registers separating each stage.

### 2.1 Pipeline Stages
1. Instruction Fetch (IF)
2. Instruction Decode / Register Fetch (ID)
3. Execute (EX)
4. Memory Access (MEM)
5. Write Back (WB)

### 2.2 Design Assumptions
- No data hazard detection
- No forwarding unit
- No pipeline stalling or flushing
- Program instructions are manually scheduled to avoid hazards

---

## 3. Pipeline Microarchitecture (Stage-wise)

### 3.1 Instruction Fetch (IF) Stage
**Purpose:**
- Fetch instruction from instruction memory
- Compute next program counter (PC + 4)

**Hardware Components:**
- Program Counter (PC)
- Instruction Memory
- PC Adder

**Operations:**
- PC is used to read instruction memory
- PC is incremented by 4
- Instruction and PC+4 are stored in IF/ID register

---

### 3.2 Instruction Decode (ID) Stage
**Purpose:**
- Decode instruction fields
- Read source registers
- Generate immediate value

**Hardware Components:**
- Instruction decoder
- Register file
- Sign extension unit

**Operations:**
- Extract opcode, rs, rt, rd, immediate
- Read register operands
- Sign-extend immediate
- Values stored in ID/EX pipeline register

---

### 3.3 Execute (EX) Stage
**Purpose:**
- Perform arithmetic or logical operation
- Compute branch target
- Evaluate branch condition

**Hardware Components:**
- ALU
- ALU control logic
- Branch comparator

**Operations:**
- ALU performs operation based on instruction type
- Branch condition evaluated (for beq)
- Results stored in EX/MEM register

---

### 3.4 Memory Access (MEM) Stage
**Purpose:**
- Access data memory for load/store instructions

**Hardware Components:**
- Data memory

**Operations:**
- Read memory for `lw`
- Write memory for `sw`
- ALU result and memory data stored in MEM/WB register

---

### 3.5 Write Back (WB) Stage
**Purpose:**
- Write result back to register file

**Hardware Components:**
- Write-back multiplexer

**Operations:**
- Select between ALU result or memory output
- Write data into destination register

---






