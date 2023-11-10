module washing_machine_tb;

  // Parameters
  reg clk;
  reg rst;
  reg start;
  reg cancel;
  reg lid_open;
  reg mode1;
  reg mode2;
  reg mode3;
  wire water_inlet;
  wire idle_op;
  wire ready_op;
  wire soak_op;
  wire wash_op;
  wire rinse_op;
  wire spin_op;
  wire coin_rtrn;

  // Instantiate the washing machine controller module
  washing_machine_controller dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .cancel(cancel),
    .lid_open(lid_open),
    .mode1(mode1),
    .mode2(mode2),
    .mode3(mode3),
    .water_inlet(water_inlet),
    .idle_op(idle_op),
    .ready_op(ready_op),
    .soak_op(soak_op),
    .wash_op(wash_op),
    .rinse_op(rinse_op),
    .spin_op(spin_op),
    .coin_rtrn(coin_rtrn)
  );

  // Clock generation
  always #5 clk = ~clk;

  // Initial values
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars(0,washing_machine_tb);
    clk = 0;
    rst = 1;
    start = 0;
    cancel = 0;
    lid_open = 0;
    mode1 = 0;
    mode2 = 0;
    mode3 = 0;

    // Reset the system
    #10 rst = 0;

    // Test a complete wash cycle with mode1
    #20 start = 1;
    #5 cancel = 1;
    #10 cancel = 0;
    #10 lid_open = 1;
    #15 lid_open = 0;
    #5 mode1 = 1;
    #100 start = 0;

    // Test a complete wash cycle with mode2
    #20 start = 1;
    #5 cancel = 1;
    #10 cancel = 0;
    #10 lid_open = 1;
    #15 lid_open = 0;
    #5 mode2 = 1;
    #100 start = 0;

    // Test a complete wash cycle with mode3
    #20 start = 1;
    #5 cancel = 1;
    #10 cancel = 0;
    #10 lid_open = 1;
    #15 lid_open = 0;
    #5 mode3 = 1;
    #100 start = 0;

    // Test cancellation during different states
    #20 start = 1;
    #5 cancel = 1;
    #10 cancel = 0;
    #100 start = 0;

    // Test lid open during different states
    #20 start = 1;
    #10 lid_open = 1;
    #15 lid_open = 0;
    #100 start = 0;

    #150 $finish; // End the simulation after 150 time units
  end

  // Display outputs
  always @(posedge clk) begin
    $display("Time = %0t, Water Inlet = %b, Idle Op = %b, Ready Op = %b, Soak Op = %b, Wash Op = %b, Rinse Op = %b, Spin Op = %b, Coin Return = %b", $time, water_inlet, idle_op, ready_op, soak_op, wash_op, rinse_op, spin_op, coin_rtrn);
  end

endmodule

