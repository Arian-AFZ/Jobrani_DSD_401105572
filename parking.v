module parking (
    input clk, reset, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited,
    output reg [9:0] uni_parked_cars, parked_cars, uni_vacated_space, vacated_space,
    output reg uni_is_vacated_space, is_vacated_space,
    output reg [4:0] hour
    );

    reg [9:0] uni_capacity, capacity;
    reg [7:0] clocks;

    always @(posedge clk or negedge reset) begin
        if (!reset || (hour == 5'd24)) begin
            uni_parked_cars <= 0;
            parked_cars <= 0;
            clocks <= 0;
            hour <= 5'd8;
        end
        else begin
            clocks <= clocks + 8'b1;
            if ((clocks % 8'd10) == 0)
                hour <= hour + 5'b1;
            if (car_entered) begin
                if (is_uni_car_entered && (uni_parked_cars < uni_capacity))
                    uni_parked_cars <= uni_parked_cars + 10'b1;
                else if (!is_uni_car_entered && (parked_cars < capacity))
                    parked_cars <= parked_cars + 10'b1;
            end
            if (car_exited) begin
                if (is_uni_car_exited && (uni_parked_cars > 0))
                    uni_parked_cars <= uni_parked_cars - 10'b1;
                else if (!is_uni_car_exited && (parked_cars > 0))
                    parked_cars <= parked_cars - 10'b1;
            end
        end
    end

    always @(*) begin
        if (hour < 5'd13) begin
            uni_capacity = 10'd500;
            capacity = 10'd200;
        end
        else if (hour < 5'd14) begin
            uni_capacity = 10'd450;
            capacity = 10'd250;
        end
        else if (hour < 5'd15) begin
            uni_capacity = 10'd400;
            capacity = 10'd300;
        end
        else if (hour < 5'd16) begin
            uni_capacity = 10'd350;
            capacity = 10'd350;
        end
        else begin
            uni_capacity = 10'd200;
            capacity = 10'd500;
        end
    end

    always @(*) begin
        uni_vacated_space = uni_capacity - uni_parked_cars;
        vacated_space = capacity - parked_cars;
        uni_is_vacated_space = (uni_vacated_space > 0);
        is_vacated_space = (vacated_space > 0);
    end

endmodule