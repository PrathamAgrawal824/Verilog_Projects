# Toy CPU — Single-Cycle 8-Instruction ISA (FPGA Assignment)

A single-cycle CPU with a custom 8-instruction ISA, designed and implemented in Verilog HDL, verified through RTL simulation in Xilinx Vivado, and demonstrated on a Digilent ZYBO (Zynq-7010) FPGA development board.

Built as a take-home assignment for an FPGA Internship application at Manastu Space.

## Overview

- **ISA**: 8 custom instructions — ADD, SUB, AND, OR, MOVI, LOAD, STORE, BEQ
- **Instruction format**: 10-bit (`opcode[3] | rd[2] | rs[2] | imm[3]`)
- **Registers**: 4 general-purpose 8-bit registers (R0–R3)
- **Datapath**: Program Counter, Instruction Memory, Decoder, Control Unit, Register File, ALU, Data Memory
- **Verification**: Deliberately constructed test program exercising all 8 instructions, including a confirmed-taken conditional branch; results cross-checked against manually derived expected values
- **Hardware**: Synthesized and implemented on ZYBO (xc7z010clg400-1); program counter and branch behavior demonstrated live via onboard LEDs

## Project Structure

```
TOY_CPU.srcs/
├── sources_1/new/        → RTL source files (PC, ALU, registers, decoder, control_unit, data_mem, cpu_top, Zybo_wrapper)
├── constrs_1/new/        → XDC constraints file for ZYBO board
└── sim_1/new/            → Testbench

TOY_CPU.xpr                → Vivado project file
```

## Getting Started

1. Open `TOY_CPU.xpr` in Xilinx Vivado (WebPACK edition supported)
2. Run Behavioral Simulation to verify functionality in `sim_1`
3. To target hardware: set `Zybo_wrapper` as the top module, run Synthesis → Implementation → Generate Bitstream, then program a connected ZYBO board via Hardware Manager

## Full Report

A detailed design report  covering ISA design rationale, datapath architecture, control unit logic, key design decisions and bugs found during development, simulation results, and hardware implementation  is included separately in the assignment submission.

## Author

Pratham Agrawal — B.Tech Electronics and Communication Engineering, MANIT Bhopal
