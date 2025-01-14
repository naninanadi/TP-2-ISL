`timescale 1ns / 1ps

module Controlador_tb;

    // Declaração de variáveis de entrada e saída
    reg clk;
    reg reset;
    reg insere;
    reg [3:0] numero;
    wire [3:0] estado;
    wire [6:0] display;
    wire led;

    // Instância do módulo controlador
    Controlador dut (
        .clk(clk),
        .reset(reset),
        .insere(insere),
        .numero(numero),
        .estado(estado),
        .display(display),
        .led(led)
    );

    // Geração do arquivo de onda
    initial begin
        $dumpfile("Controlador_tb.vcd");
        $dumpvars(0, Controlador_tb);

        // Inicialização
        reset = 1;
        insere = 0;
        numero = 4'b0000;
        #5;

        // Libera o reset
        reset = 0;
        #5;

        // Teste 1: Insere número correto (5)
        insere = 1;
        numero = 4'b0101; // Número 5
        #5;
        //Insere um errado
        numero = 4'b0111; // Número 7
        #5;
        //Insere outro número correto (8)
        numero = 4'b1000; // Número 8
        #5;
        //Insere número inválido (>9)
        numero = 4'b1010; // 10 (inválido)
        #5;
        //Insere um errado (0)
        numero = 4'b0000; // Número 0
        #5;

        reset = 1;
        insere = 0;
        numero = 4'b0000;
        #5;

        reset = 0;

        // Teste 5: Insere sequência para sucesso total
        numero = 4'b0101; // 5
        #5;
        numero = 4'b1000; // 8
        #5;
        numero = 4'b1001; // 9
        #5;
        numero = 4'b0010; // 2
        #5;
        numero = 4'b0000; // 0
        #5;
        numero = 4'b0100; // 4
        #5;

        // Teste 6: Resetar o sistema no meio
        reset = 1;
        #5;
        reset = 0;
        #5

        // Finaliza a simulação
        $finish;
    end

endmodule