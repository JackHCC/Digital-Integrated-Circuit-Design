# Practice

一些测试与练习的代码实现

## Practice1

根据图中电路，完成Verilog实现。

![](../0.Images/pr1-1.png)

## Practice2

![](../0.Images/pr2-1.png)

## Practice3

![](../0.Images/pr3-1.png)

## Practice4

![](../0.Images/pr4-1.png)



# Solution Conclusion

## State Machine

### 解题步骤

- 根据题目确定存在的**状态有多少种**，根据可能的种类来判断需要一个**多少位的参数变量来存储状态（parameter）**，例如：6中状态需要3位来存储。其中，参数一般用从0开始的二进制数递增方式表示。
- 定义一个**寄存器类型（reg）的状态变量**来表示当前所处的状态（state），其位数和状态参数一致。
- 确定时钟与复位信号同步与异步的选择，并且复位信号有效时需要将状态机置于初始状态，一般是（state0 = 0）的状态。
- 在复位信号无效的情况下，需要根据**所有状态作为case语句的各个分支**，并且在**各个分支下在根据不同的动作产生二级分支，一般动作（action）都是由输入的数据信号所决定**，一位的输入一般只有两种动作，只需要if……else……语句写即可，多于一位的输入信号会产生很多种动作导致状态的变化，一般用case语句来产生二级分支更好，并且在每个动作下除了状态的变化，还有一些参数需要变动的也在这些分支下取撰写。**注意每个动作最后需要加上default选项：用于判断x，z等情况。**
- 最后，**输出一般设置成wire类型，在过程快外用assign语句来赋值**，赋值的右式一般是state所处的状态，或者一些中间变量的组合。
- 注：还有将数据和控制分离的写法，**可以将state分支判断放在另一个always(\*)里面单独判断**，这种针对一位以上的输入，两位的状态机参考：[作业3](../8.Homework_Upgrade_Solution/3.Seq/Seq.v)。

### 实例分析

例如：练习4的状态机题解思路如下

```verilog
`timescale 1ns/1ns
module Detect111 (
    input   wire    X,
                    clk,
                    rst,
    output  wire    out
);
    // 定义一个寄存器类型（reg）的状态变量来表示当前所处的状态（state），其位数和状态参数一致，4种状态两位存储即可
    reg [1 : 0] state;

    // 根据题目确定存在的状态有多少种，根据可能的种类来判断需要一个多少位的参数变量来存储状态（parameter）
    parameter IDLE      = 2'b00;
    parameter State1    = 2'b01;
    parameter State2    = 2'b10;
    parameter State3    = 2'b11;

	// 确定时钟与复位信号同步与异步的选择，这里选择异步方式，注意rst高电平有效，需要posedge rst
    always @(posedge clk, posedge rst) begin
        // 复位信号有效时需要将状态机置于初始状态
        if(rst)
            state <= 0;
        else
            // 在复位信号无效的情况下，需要根据所有状态作为case语句的各个分支，这里即四个状态的IDLE，State1-3
            case (state)
                IDLE:
                    // 各个分支下在根据不同的动作产生二级分支，一般动作（action）都是由输入的数据信号所决定，一位的输入一般只有两种动作，只需要if……else……语句写即可
                    if(X)
                        state = State1;
                    else	// 包括X = 0，x，z
                        state = IDLE;
                State1:
                    if(X)
                        state = State2;
                    else
                        state = IDLE;
                State2:
                    if(X)
                        state = State3;
                    else
                        state = IDLE;
                State3:
                    state = State3;
            endcase
        
    end

    // 输出一般设置成wire类型，在过程快外用assign语句来赋值，赋值的右式一般是state所处的状态，或者一些中间变量的组合
    assign out = (state == State3);

endmodule
```

## DFF and Combinational Circuit

### 解题步骤

- 根据电路图判断输入输出端口，一般的D触发器（DFF，D flip-flop）的输出作为输出端口，如练习1，但是如果输出还需要做逻辑操作，那么一般最后会用一些组合后的变量作为最终的输出，那么D触发器的输出Q需要用中间变量存储，且是Reg类型。
- 输入端口一般包括时钟和复位信号，可采用同步或异步的方式设置复位信号，如果有其他输入信号一并加上，**输入信号都需要是net类型（如wire）**，**输出信号即D触发器Q端口或者Q端口继续组合产生的信号，输出信号一般设置为wire类型，也可以是reg类型，取决于最终再过程块中给输出赋值，还是assign给输出赋值**。中间需要定义的变量一**般只有D触发器的Q端口**，如果Q端口是输出端口则不需要再单独定义，且**中间变量都为reg类型**。
- 复位信号有效时，一般需要将定义的中间变量置零，复位信号无效时，电路正常工作，这时候需要在**过程块中写出所有Q端口的组合逻辑**，即**每个Q端口的输入是什么**。
- 最后**输出端口采用assign语句赋值（如果输出设置了wire类型）**，如果设置的reg类型，那么最终的输出也需要在过程块中赋值，且两种方式**等式右边是中间变量Q端口的组合**。

### 实例分析

例如：练习2的题解

```verilog
`timescale 1ns/1ns
module Counter (
    input   wire        clk,
                        rst,
    output  wire[2 : 0] Y 
);
    // 中间需要定义的变量一般只有D触发器的Q端口，且中间变量都为reg类型
    reg             Q1,
                    Q0;

    // 可采用同步或异步的方式设置复位信号,这里采用异步方式
    always @(posedge clk, posedge rst) begin
        // 位信号有效时，一般需要将定义的中间变量置零
        if(rst) begin
            Q0 <= 0;
            Q1 <= 0;
        end
        // 复位信号无效时，需要在过程块中写出所有Q端口的组合逻辑，即每个Q端口的输入是什么
        else begin
            Q0 <= ~Q0;
            Q1 <= Q0 ^ Q1;
        end   
    end

    // 输出端口采用assign语句赋值，等式右边是中间变量Q端口的组合
    assign Y[0]= Q0 | Q1;
    assign Y[1]= Q0;
    assign Y[2]= Q1; 
endmodule
```

## SRAM

双向SRAM通用代码段：

```Verilog
assign data_o   = rd_en? mem[addr] : 8'bz;

always @(posedge wr_en) begin
    mem[addr]   = data_in;
end  
```

如果是FIFO，`addr`需要改为相应的指针：

```verilog
assign data_o   = rd_en? mem[tail] : 8'bz;

always @(posedge wr_en) begin
    mem[head]   = data_in;
end 
```

