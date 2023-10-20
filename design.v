module washing_machine_controller (
    input clk, // System clock
    input rst, // System reset
    input start, // Start signal to begin the washing process
    input cancel, // Cancel signal to stop the washing process
    input lid_open, // Signal indicating whether the lid is open
    input mode1, // Mode 1 selection signal
    input mode2, // Mode 2 selection signal
    input mode3, // Mode 3 selection signal
    output reg water_inlet, // Water intake control signal
    output reg idle_op, // Idle state signal
    output reg ready_op, // Ready state signal
    output reg soak_op, // Soaking operation signal
    output reg wash_op, // Washing operation signal
    output reg rinse_op, // Rinsing operation signal
    output reg spin_op, // Spinning operation signal
    output reg coin_rtrn // Coin return signal
);

// Declare the states as parameters
parameter IDLE = 3'b000;
parameter READY = 3'b001;
parameter SOAK = 3'b010;
parameter WASH = 3'b011;
parameter RINSE = 3'b100;
parameter SPIN = 3'b101;

// Declare the state register
reg [2:0] state, next_state;

// Default values
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// Next state logic
always @ (*) begin
    case (state)
        IDLE: begin
            if (start) begin
                next_state = READY;
            end else begin
                next_state = IDLE;
            end
        end
        READY: begin
            if (cancel) begin
                coin_rtrn = 1'b1;
                next_state = IDLE;
            end else if (mode1) begin
                // Set timing for mode 1
                next_state = SOAK;
            end else if (mode2) begin
                // Set timing for mode 2
                next_state = WASH;
            end else if (mode3) begin
                // Set timing for mode 3
                next_state = RINSE;
            end else begin
                next_state = READY;
            end
        end
        SOAK: begin
            // Add logic for SOAK state
            if (lid_open) begin
                // Pause the washing process
                next_state = IDLE;
            end else begin
                // Continue with the current state
                next_state = WASH; // Transition to the next state
            end
        end
        WASH: begin
            // Add logic for WASH state
            // Transition to RINSE state
            next_state = RINSE;
        end
        RINSE: begin
            // Add logic for RINSE state
            // Transition to SPIN state
            next_state = SPIN;
        end
        SPIN: begin
            // Add logic for SPIN state
            // Transition back to IDLE state
            next_state = IDLE;
        end
        default: next_state = IDLE;
    endcase
end

// Output logic
always @ (state) begin
    case (state)
        IDLE: begin
            idle_op = 1'b1;
            ready_op = 1'b0;
            soak_op = 1'b0;
            wash_op = 1'b0;
            rinse_op = 1'b0;
            spin_op = 1'b0;
            water_inlet = 1'b0;
            coin_rtrn = 1'b0;
        end
        READY: begin
            idle_op = 1'b0;
            ready_op = 1'b1;
            soak_op = 1'b0;
            wash_op = 1'b0;
            rinse_op = 1'b0;
            spin_op = 1'b0;
            water_inlet = 1'b0;
            coin_rtrn = 1'b0;
        end
        SOAK: begin
            idle_op = 1'b0;
            ready_op = 1'b0;
            soak_op = 1'b1;
            wash_op = 1'b0;
            rinse_op = 1'b0;
            spin_op = 1'b0;
            water_inlet = 1'b1; // Activate water inlet during soak state
            coin_rtrn = 1'b0;
        end
        WASH: begin
            idle_op = 1'b0;
            ready_op = 1'b0;
            soak_op = 1'b0;
            wash_op = 1'b1;
            rinse_op = 1'b0;
            spin_op = 1'b0;
            water_inlet = 1'b0;
            coin_rtrn = 1'b0;
        end
        RINSE: begin
            idle_op = 1'b0;
            ready_op = 1'b0;
            soak_op = 1'b0;
            wash_op = 1'b0;
            rinse_op = 1'b1;
            spin_op = 1'b0;
            water_inlet = 1'b1; // Activate water inlet during rinse state
            coin_rtrn = 1'b0;
        end
        SPIN: begin
            idle_op = 1'b0;
            ready_op = 1'b0;
            soak_op = 1'b0;
            wash_op = 1'b0;
            rinse_op = 1'b0;
            spin_op = 1'b1;
            water_inlet = 1'b0;
            coin_rtrn = 1'b0;
        end
        default: begin
            idle_op = 1'b0;
            ready_op = 1'b0;
            soak_op = 1'b0;
            wash_op = 1'b0;
            rinse_op = 1'b0;
            spin_op = 1'b0;
            water_inlet = 1'b0;
            coin_rtrn = 1'b0;
        end
    endcase
end

endmodule

