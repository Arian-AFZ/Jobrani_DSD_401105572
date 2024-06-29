# Jobrani_DSD_401105572 (Q8)

A Verilog module for managing a university parking lot.

## Parking Capacity

The total capacity is 700. Between 8 to 13 o'clock, 200 spaces are available to the public; while from 13 to 16 o'clock, every hour, the public capacity increases by 50 and at 16 'oclock, it jumps to 500. The parking closes at 00:00 and reopens at 8:00.

## I/O

Inputs: car_entered, is_uni_car_entered, car_exited, is_uni_car_exited

Outputs: uni_parked_cars, parked_cars, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space, hour

## Implementation Details

The first `always` block, which operates with the clock, is for managing the entry and exit of cars and calculating the number of parked cars related to the university and the public. There is a reset mechanism in this block that works with the reset signal or when the clock reaches 24, setting the clock to 8 (the start of the parking operation). Otherwise, with every ten clock cycles, an hour passes, and in each clock cycle, a car can enter or exit. Based on the input `is_uni_car_entered` or `is_uni_car_exited`, we determine which category's capacity to change. In the second `always` block, the total capacity of the university and the public is determined according to the current time. Finally, in the last block, the empty capacity of both categories of cars is calculated. In the design of this module, care has been taken to ensure that no variable is assigned a value in more than one block.

## Testbench

The testbench, every hour from 8 to 13, admits five university cars and one public car, and exits one university car. Then it skips to 14:00 and admits eight public cars at this hour. After that, it skips to 16:00 and until 23:00, every hour, it exits three university cars and six public cars.

## Synthesis

For synthesis, we compile the Verilog file in the Quartus FPGA software and utilise its TimeQuest Timing Analyzer to find the restricted maximum frequency, which is found to be 26.77 MHz for this module. The reason for such low maximum frequency could be that the module performs several operations within a single clock cycle, such as arithmetic operations, condition checks, and register updates. These can contribute to a longer combinational path, which requires a longer time to settle before the next clock edge.
