# Full-Duplex UART – Basic FPGA Implementation

This repository contains a **basic full-duplex UART (Universal Asynchronous Receiver/Transmitter)** designed using **SystemVerilog**.  
The design enables serial communication between an FPGA board and an external device (PC) and demonstrates the fundamental principles of UART transmission and reception.

This project emphasizes a **simple, functional implementation** suitable for learning and FPGA experimentation.

---

## Specifications

- **Mode:** Full-Duplex  
- **Data Frame:** 8 bits  
- **Clock Frequency:** 100 MHz  
- **Frame Format:** 1 Start bit, 1 Stop bit, No parity  
- **Baud Rate:** 9600 bps  
- **Number of Flags:** 2  

---

## Features

- Separate **Transmitter (TX)** and **Receiver (RX)** modules  
- **Top Module** integrating TX and RX for full-duplex operation  
- Testbenches for verifying transmitter, receiver, and top module functionality  
- Verified via **simulation and FPGA hardware testing**  

---

## Design Overview

The UART design consists of:

- **Transmitter (TX):** Converts parallel 8-bit input data into serial output  
- **Receiver (RX):** Converts serial input data into parallel output  
- **Top Module:** Integrates TX and RX for full-duplex communication  
- **Baud Rate Generator:** Controls timing for accurate data transmission  
- **Testbench Modules:** Verify functionality for individual and integrated modules  

---
