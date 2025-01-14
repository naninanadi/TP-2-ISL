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

    // Instância do módulo Controlador
    Controlador dut (
        .clk(clk),
        .reset(reset),
        .insere(insere),
        .numero(numero),
        .estado(estado),
        .display(display),
        .led(led)
    );

    // Geração do clock
    initial begin
        clk = 0; // Inicializa o clock com 0
        forever #5 clk = ~clk; // Alterna o clock a cada 5 unidades de tempo (período total = 10ns)
    end

    // Geração do arquivo de onda e sequência de testes
    initial begin
        $dumpfile("Controlador_tb.vcd");
        $dumpvars(0, Controlador_tb);

        // Inicialização
        reset = 1;
        insere = 0;
        //numero = 4'b0000;
        #10; // Aguarda 20ns com reset ativo

        // Libera o reset e ativa a entrada
        reset = 0;
        insere = 1;

        // Teste 1: Insere sequência com números corretos e incorretos
        numero = 4'b0101; // Número correto: 5
        #10;
        numero = 4'b0111; // Número incorreto: 7
        #10;
        numero = 4'b1000; // Número correto: 8
        #10;
        numero = 4'b1010; // Número inválido: 10 (>9)
        #10;
        numero = 4'b0000; // Número incorreto: 0
        #10;

        // Teste 2: Resetar e iniciar novamente
        reset = 1;
        #10;
        reset = 0;

        // Teste 3: Sequência completa para sucesso total
        numero = 4'b0101; // Número correto: 5
        #10;
        numero = 4'b1000; // Número correto: 8
        #10;
        numero = 4'b1001; // Número correto: 9
        #10;
        numero = 4'b0010; // Número correto: 2
        #10;
        numero = 4'b0000; // Número correto: 0
        #10;
        numero = 4'b0100; // Número correto: 4
        #10;

        // Teste 4: Reset no meio da sequência
        reset = 1;
        #10;
        reset = 0;

        //Sequência para sucesso parcial
        numero = 4'b0101; // Número correto: 5
        #10;
        numero = 4'b1000; // Número correto: 8
        #10;
        numero = 4'b1001; // Número correto: 9
        #10;
        numero = 4'b0010; // Número correto: 2
        #10;
        numero = 4'b0001; // Número incorreto: 1
        #10;
        numero = 4'b0000; // Número correto: 0
        #10;
        numero = 4'b0100; // Número correto: 4
        #10;

        // Finaliza a simulação
        $finish;
    end

endmodule