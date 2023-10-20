module washing_machine_controller(
    input wire clk,             // Clock input
    input wire reset,           // Reset signal
    input wire start_button,    // Start button signal
    input wire mode_selection,  // Mode selection input
    input wire coin_inserted,   // Coin insertion input
    output wire ready_signal,   // Ready signal
    output wire soak_signal,    // Soak state signal
    output wire wash_signal,    // Wash state signal
    output wire rinse_signal,   // Rinse state signal
    output wire spin_signal     // Spin state signal
);

    // Define state machine states
    typedef enum logic [2:0] {
        IDLE,
        READY,
        SOAK,
        WASH,
        RINSE,
        SPIN
    } state_t;

    // Define mode states
    typedef enum logic [1:0] {
        MODE1,
        MODE2,
        MODE3
    } mode_t;

    // Registers for state and mode
    reg [2:0] state;
    reg [1:0] mode;

    // Timer counter and values
    reg [15:0] timer_counter;
    reg [15:0] mode1_time;
    reg [15:0] mode2_time;
    reg [15:0] mode3_time;

    // FSM logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            mode <= MODE1;
        end else begin
            case (state)
                IDLE: begin
                    if (coin_inserted)
                        state <= READY;
                end
                READY: begin
                    if (start_button) begin
                        case (mode)
                            MODE1: state <= SOAK;
                            MODE2: state <= WASH;
                            MODE3: state <= RINSE;
                        endcase
                    end
                end
                SOAK, WASH, RINSE, SPIN: begin
                    if (timer_counter == 0)
                        case (state)
                            SOAK: state <= WASH;
                            WASH: state <= RINSE;
                            RINSE: state <= SPIN;
                            SPIN: state <= IDLE;
                        endcase
                end
            endcase
        end
    end

    // Mode selection logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            mode <= MODE1;
        else if (mode_selection)
            mode <= mode_selection;
    end

    // Timer logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            timer_counter <= 0;
        else if (start_button)
            timer_counter <= timer_counter - 1;
    end

    // Mode-specific timing values
    always_comb begin
        case (mode)
            MODE1: begin
                mode1_time = ...; // Set the appropriate time duration for MODE1
            end
            MODE2: begin
                mode2_time = ...; // Set the appropriate time duration for MODE2
            end
            MODE3: begin
                mode3_time = ...; // Set the appropriate time duration for MODE3
            end
        endcase
    end

    // Output signals
    assign ready_signal = (state == READY);
    assign soak_signal = (state == SOAK);
    assign wash_signal = (state == WASH);
    assign rinse_signal = (state == RINSE);
    assign spin_signal = (state == SPIN);

endmodule

