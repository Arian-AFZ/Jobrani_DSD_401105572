module parking_tb;

    reg clk, reset, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited;
    wire [9:0] uni_parked_cars, parked_cars, uni_vacated_space, vacated_space;
    wire uni_is_vacated_space, is_vacated_space;
    wire [4:0] hour;

    parking uut (
        clk, reset, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited,
        uni_parked_cars, parked_cars, uni_vacated_space, vacated_space,
        uni_is_vacated_space, is_vacated_space, hour
    );

    integer i;

    initial begin
        clk = 0;
        reset = 0;
        car_entered = 0;
        is_uni_car_entered = 0;
        car_exited = 0;
        is_uni_car_exited = 0;

        #10 reset = 1;
        #5;
        // 8-13 o'clock
        for (i = 0; i < 5; i = i + 1) begin
            #10 car_entered = 1; is_uni_car_entered = 1; // Faculty car enters
            #50 car_entered = 1; is_uni_car_entered = 0; // Public car enters
            #10 car_entered = 0; car_exited = 1; is_uni_car_exited = 1; // Faculty car exits
            #10 car_exited = 0;
        end

        #100; // Skip to 14 o'clock
        #10 car_entered = 1; is_uni_car_entered = 0; // Public car enters
        #90 car_entered = 0;

        #100; // Skip to 16 o'clock
        for (i = 0; i < 7; i = i + 1) begin
            #10 car_exited = 1; is_uni_car_exited = 1; // Faculty car exits
            #30 car_exited = 1; is_uni_car_exited = 0; // Public car exits
            #60 car_exited = 0;
        end
        // Now: 23 o'clock

        #110; // Skip to 24 o'clock
        #10; // Back to 8 o'clock
        $stop;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor (
            $time, " hour: %d, uni_parked_cars: %d, parked_cars: %d, uni_vacated_space: %d, vacated_space: %d, uni_is_vacated_space: %d, is_vacated_space: %d",
            hour, uni_parked_cars, parked_cars, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space
        );
    end

endmodule
