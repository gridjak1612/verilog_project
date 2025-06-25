Overview

This repository implements a Vending Machine with Change System in Verilog HDL. The project models a simple vending machine that dispenses a water bottle costing 15 Rs, accepts 5 Rs and 10 Rs coins, and returns change as needed. The design includes both the main Verilog module and a testbench for simulation and verification

Features

Accepts 5 Rs and 10 Rs coins
Dispenses a water bottle (cost: 15 Rs)
Returns change for overpayment or incomplete transactions
Finite State Machine (FSM) implementation
Ready-to-run testbench for simulation

How It Works

The vending machine operates in three states based on the total amount inserted:
State	   Amount in Machine	      Next Actions & Outputs
S0	     0 Rs	                    Wait for input; transitions to S1 (5 Rs) or S2 (10 Rs)
S1	     5 Rs	                    Wait for more coins; returns change if no further coins; dispenses bottle if 10 Rs added
S2	     10 Rs	                  Wait for more coins; returns change if no further coins; dispenses bottle and returns change if overpaid



Input Encoding:
2'b01 = 5 Rs
2'b10 = 10 Rs

Outputs:
out (1: bottle dispensed, 0: not dispensed)
change (2 bits: 00 = 0 Rs, 01 = 5 Rs, 10 = 10 Rs)


WHY DID THE VERILOG VENDING MACHINE GET LAUGHS AT THE CIRCUIT PARTY? IT KEPT SPITTING OUT BOTTLES AND CHANGE LIKE IT WAS TRYING TO TIP ITSELF!
