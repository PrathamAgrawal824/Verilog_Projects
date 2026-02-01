# Asynchronous FIFO (Async FIFO)

This project implements an **asynchronous FIFO** designed to safely transfer
data between two independent clock domains using **Gray-coded pointers** and
**double-flop synchronization** for reliable clock domain crossing (CDC).

The objective of this design is to understand and implement industry-standard
techniques used in hardware systems where write and read clocks are unrelated.

---

## Key Features

- Independent **write and read clock domains**
- **Binary pointers** for local address generation
- **Gray-coded pointers** for safe clock domain crossing
- **Double-flop synchronizers** to reduce metastability risk
- Reliable **full and empty detection**
- Parameterized data width and FIFO depth
- Simple and deterministic **testbench verification**

---

## Design Overview

In an asynchronous FIFO, write and read operations occur on unrelated clocks,
which introduces the risk of metastability and data corruption if not handled
carefully.

To address this:

- Binary pointers are used locally for memory addressing and arithmetic
- Pointers are converted to **Gray code** before crossing clock domains to
  ensure only one bit changes per increment
- Gray-coded pointers are synchronized using **two flip-flops** in the
  receiving clock domain
- An extra pointer MSB is used to track wrap-around and distinguish between
  **full** and **empty** FIFO states

