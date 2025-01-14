module controlador (
    input clk,
    input reset,
    input insere,
    input [3:0] numero, // Supondo 4 bits para as condições (ajustar conforme necessário)
    output reg led,
    output reg [3:0] state  // Supondo 4 bits para representar os estados
    output reg [6:0] diplay
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
    localparam falha = 4'b1111; // Exemplo de estado final

    // Registro para estado atual
    reg [3:0] current_state, next_state;

    // Lógica de transição de estados
    always @(posedge clk or posedge reset) begin
        if (reset) 
            current_state <= inicial; // Estado inicial
        else 
            current_state <= next_state;
    end

    // Lógica de próximo estado
    always @(*) begin
        case (current_state)
            inicial: begin
                if (numero
         == 4'b0000)
                    next_state = LIGADO_0_IC;
                else if (numero
         == 4'b0001)
                    next_state = certo1_erro0;
                else
                    next_state = inicial;
            end
            // Continue com os outros estados e transições...
            falha: begin
                next_state = falha; // Estado final
            end
            default: next_state = inicial; // Estado padrão
        endcase
    end

    // Saída do estado
    always @(*) begin
        state = current_state;
    end

endmodule
