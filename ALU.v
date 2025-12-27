module ALU (
    input  [15:0] X,
    input  [15:0] Y,
    output [15:0] Z,
    output        Sign,
    output        Zero,
    output        Carry,
    output        Parity,
    output        Overflow
);

    // 16-bit addition
    assign {Carry, Z} = X + Y;

    // Status flags
    assign Sign     = Z[15];
    assign Zero     = ~|Z;        // 1 when Z == 0
    assign Parity   = ^~Z;        // even parity
    assign Overflow = ( X[15] &  Y[15] & ~Z[15]) |
                      (~X[15] & ~Y[15] &  Z[15]);

endmodule
