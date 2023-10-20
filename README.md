# laundromat
THE PROJECT GIVEN IN SEM-5 UNDER DIGITAL SYSTEM DESIGN COURSE

# Washing Machine Controller

## Project Description

This project is a washing machine controller that manages the washing cycle with different modes of operation. It utilizes a Finite State Machine (FSM) block and a Timer block to control the various states and timings of the washing machine.

The controller supports the following functionalities:
1. The washing machine has the following states: idle, soak, wash, rinse, spin.
2. It offers three modes of operation: mode1, mode2, and mode3.
3. Different time durations are allocated to each mode of operation.

## System Flow Chart

The washing machine controller operates based on the following components:
1. **Finite State Machine (FSM) Block:** This block handles state transitions and receives signals from both the user and the timer.
2. **Timer Block:** Responsible for generating the correct time periods required for each cycle. It includes an up-counter and combinational logic to produce the necessary time signals based on count values. The timer values are determined by the clock frequency used in the system.

## Timer Block Design

The timer block can be implemented as a function or a task within the washing machine controller module itself. The primary purpose of the timer block is to ensure that state transitions occur after the completion of the required count values unless there is an interrupt. You may need to consider clock frequency and use combinational logic to generate the timing signals accurately.

## Controller Operation

The operation of the washing machine controller is as follows:
1. Initially, the FSM is in the **IDLE state**.
2. Once a coin is inserted, the FSM transitions to the **READY state**.
3. In the READY state, users can select one of the three washing modes: mode1, mode2, or mode3. The selected mode determines the timing allocated to each state.
4. If no mode is selected, the controller remains in the READY state.
5. If the washing process is canceled at this point, the coin is returned, and the FSM returns to the IDLE state.
6. Once the washing process starts, canceling it results in a loss of the coin, and the washing machine proceeds with the current cycle.


Mention any contributors, libraries, or tools that were used or inspired during the development o