module Controlador (
    input clk,
    input reset,
    input insere,
    input [3:0] numero, 
    output reg [3:0] estado,
    output reg [6:0] display,
    output reg led
);

    // Definir os estados com parâmetros
    localparam inicial = 4'b0000;
    localparam certo1_erro0 = 4'b0001;
    localparam certo2_erro0 = 4'b0010;
    localparam certo3_erro0 = 4'b0011;
    localparam certo4_erro0 = 4'b0100;
    localparam certo5_erro0 = 4'b0101;
    localparam sucessototal = 4'b0110;
    localparam certo0_erro1 = 4'b0111;
    localparam certo1_erro1 = 4'b1000;
    localparam certo2_erro1 = 4'b1001;
    localparam certo3_erro1 = 4'b1010;
    localparam certo4_erro1 = 4'b1011;
    localparam certo5_erro1 = 4'b1100;
    localparam sucessoparcial = 4'b1110;
    localparam falha = 4'b1111;

    // Registro para estado atual e próximo
    reg [3:0] estadoatual, proximoestado;

    // Lógica de transição de estados
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            estadoatual <= inicial;
        end else begin
            estadoatual <= proximoestado;
        end
    end

    

    // Lógica de próximo estado
    always @(*) begin

        

        if (insere) begin
            case (estadoatual)
                inicial: begin
                    led = 0; // Valor padrão
                    if ((numero != 4'b0101) && (numero <= 9)) begin
                        proximoestado = certo0_erro1;
                        led = 1;
                    end else if (numero == 4'b0101) begin
                        proximoestado = certo1_erro0;
                        led = 0;
                    end else begin
                        proximoestado = inicial;
                    end
                end
                certo1_erro0: begin
                    if ((numero != 4'b1000) && (numero <= 9)) begin
                        proximoestado = certo1_erro1;
                        led = 1;
                    end else if (numero == 4'b1000) begin
                        proximoestado = certo2_erro0;
                        led = 0;
                    end else begin
                        proximoestado = certo1_erro0;
                    end
                end
                certo2_erro0: begin
                    if ((numero != 4'b1001) && (numero <= 9)) begin
                        proximoestado = certo2_erro1;
                        led = 1;
                    end else if (numero == 4'b1001) begin
                        proximoestado = certo3_erro0;
                        led = 0;
                    end else begin
                        proximoestado = certo2_erro0;
                    end
                end
                certo3_erro0: begin
                    if ((numero != 4'b0010) && (numero <= 9)) begin
                        proximoestado = certo3_erro1;
                        led = 1;
                    end else if (numero == 4'b0010) begin
                        proximoestado = certo4_erro0;
                        led = 0;
                    end else begin
                        proximoestado = certo3_erro0;
                    end
                end
                certo4_erro0: begin
                    if ((numero != 4'b0000) && (numero <= 9)) begin
                        proximoestado = certo4_erro1;
                        led = 1;
                    end else if (numero == 4'b0000) begin
                        proximoestado = certo5_erro0;
                        led = 0;
                    end else begin
                        proximoestado = certo4_erro0;
                    end
                end
                certo5_erro0: begin
                    if ((numero != 4'b0100) && (numero <= 9)) begin
                        proximoestado = certo5_erro1;
                        led = 1;
                    end else if (numero == 4'b0100) begin
                        proximoestado = sucessototal;
                        led = 0;
                    end else begin
                        proximoestado = certo5_erro0;
                    end
                end
                sucessototal: begin
                    proximoestado = sucessototal;
                end
                certo0_erro1: begin
                    if((numero != 4'b0101) && (numero <= 9)) begin
                        proximoestado = falha;
                    end else if (numero == 4'b0101) begin
                        proximoestado = certo1_erro1;
                    end else begin
                        proximoestado = certo0_erro1;
                    end
                end
                certo1_erro1: begin
                    if((numero != 4'b1000) && (numero <= 9)) begin
                        proximoestado = falha;
                    end else if (numero == 4'b1000) begin
                        proximoestado = certo2_erro1;
                    end else begin
                        proximoestado = certo1_erro1;
                    end
                end
                certo2_erro1: begin
                    if((numero != 4'b0110) && (numero <= 9)) begin
                        proximoestado = falha;
                    end else if (numero == 4'b0110) begin
                        proximoestado = certo3_erro1;
                    end else begin
                        proximoestado = certo2_erro1;
                    end
                end
                certo3_erro1: begin
                    if((numero != 4'b0010) && (numero <= 9)) begin
                        proximoestado = falha;
                    end else if (numero == 4'b0010) begin
                        proximoestado = certo4_erro1;
                    end else begin
                        proximoestado = certo3_erro1;
                    end
                end
                certo4_erro1: begin
                    if((numero != 4'b0000) && (numero <= 9)) begin
                        proximoestado = falha;
                    end else if (numero == 4'b0000) begin
                        proximoestado = certo5_erro1;
                    end else begin
                        proximoestado = certo4_erro1;
                    end
                end
                certo5_erro1: begin
                    if((numero != 4'b0100) && (numero <= 9)) begin
                        proximoestado = falha;
                    end else if (numero == 4'b0100) begin
                        proximoestado = sucessoparcial;
                    end else begin
                        proximoestado = certo5_erro1;
                    end
                end
                sucessoparcial: begin
                    proximoestado = sucessoparcial;
                end
                falha: begin
                    proximoestado = falha;
                end
                default: proximoestado = inicial;
            endcase
        end else begin
            proximoestado = estadoatual; // Quando `insere` não é ativo, o estado não muda
        end
    end

    // Lógica de saída
    always @(*) begin
        estado = estadoatual;
        case (estado)
            inicial: display = 7'b0000001;
            sucessototal: display = 7'b0100100;
            sucessoparcial: display = 7'b0011000;
            falha: display = 7'b0111000;
            default: begin
                case (numero)
                    4'b0000: display = 7'b0000001;
                    4'b0001: display = 7'b1001111;
                    4'b0010: display = 7'b0010010;
                    4'b0011: display = 7'b0000110;
                    4'b0100: display = 7'b1001100;
                    4'b0101: display = 7'b0100100;
                    4'b0110: display = 7'b0100000;
                    4'b0111: display = 7'b0001111;
                    4'b1000: display = 7'b0000000;
                    4'b1001: display = 7'b0000010;
                    default: display = 7'b1111110;
                endcase
            end
        endcase
    end

    // Debug (simulação)
always @(posedge clk) begin
    $display("Numero inserido: %d, led: %d", numero, led);
    if (reset) begin
        $display("Reset: estado = %b", estadoatual);
    end else begin
        $display("Estado Atual: %b, Proximo Estado: %b", estadoatual, proximoestado);
    end
end

endmodule