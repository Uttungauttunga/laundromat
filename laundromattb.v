`timescale 1ns / 1ps

module tb_washing_machine_controller;

    // Define testbench signals and variables
    reg clk;
    reg reset;
    reg start_button;
    reg mode_selection;
    reg coin_inserted;
    wire ready_signal;
    wire soak_signal;
    wire wash_signal;
    wire rinse_signal;
    wire spin_signal;

    // Instantiate the washing machine controller
    washing_machine_controller DUT (
        .clk(clk),
        .reset(reset),
        .start_button(start_button),
        .mode_selection(mode_selection),
        .coin_inserted(coin_inserted),
        .ready_signal(ready_signal),
        .soak_signal(soak_signal),
        .wash_signal(wash_signal),
        .rinse_signal(rinse_signal),
        .spin_signal(spin_signal)
    );

    // Define VCD file and variables
    initial begin
        $dumpfile("washing_machine_controller.vcd");
        $dumpvars(0, tb_washing_machine_controller);
    end

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test scenario
    initial begin
        // Initialize signals
        clk = 0;
        reset = 0;
        start_button = 0;
        mode_selection = 0;
        coin_inserted = 0;

        // Reset the controller
        reset = 1;
        #10 reset = 0;

        // Insert a coin to transition to READY state
        coin_inserted = 1;
        #10 coin_inserted = 0;

        // Select a mode (e.g., MODE2)
        mode_selection = 2;
        #10 mode_selection = 0;

        // Press the start button to start the washing cycle
        start_button = 1;
        #10 start_button = 0;

        // Simulate the washing cycle
        // You can advance time, change inputs, and check outputs as needed

        // Example: Advance time for 100 time units
        #100;

        // Stop the washing cycle (pressing the start button again)
        start_button = 1;
        #10 start_button = 0;

        // Simulate the rest of the washing cycle or other test scenarios

        // Finish the simulation
        $finish;
    end

endmodule
