module Cronometro(Reset,Conta,Pausa,Para,Clock,Decimal,Unidade,Dezena,Centena,estado,counterDecimal,counterUnidade,counterDezena,counterCentena,prox_estado);
	
	input Reset,Conta,Pausa,Para,Clock;

	output reg[3:0] Decimal,Unidade ,Dezena,Centena;	
	
	output reg [3:0] counterDecimal; 
	output reg [3:0] counterUnidade;
	output reg [3:0] counterDezena ;
	output reg [3:0] counterCentena;
	
	parameter[1:0] INIT = 2'b00;
	parameter[1:0] CONT = 2'b01;
	parameter[1:0] PAUS = 2'b10;
	parameter[1:0] PARA = 2'b11;
	
	
	output reg[1:0]estado,prox_estado;
	
	
	
	
	initial begin 
	
		estado<= INIT;
		prox_estado<=INIT;
		
	end
	
	
	
	always@ (posedge Clock or posedge Reset or posedge Conta or posedge Pausa or posedge Para) begin

	if(Reset)if(Conta)if(Pausa)if(Para)// não da pra colocar &&
		estado=prox_estado;
	
	
	
	
	case(estado)
		INIT:begin
		
			counterDecimal=4'b0000;
			counterUnidade=4'b0000;
			counterDezena=4'b0000;
			counterCentena=4'b0000;
		
			Decimal=4'b0000;
			Unidade= 4'b0000;
			Dezena=4'b0000;
			Centena=4'b0000;
		end
		
		CONT:begin
		
			counterDecimal=counterDecimal+4'b0001;
			
			if(counterDecimal==4'b1010) begin
				counterDecimal=4'b0000;
				counterUnidade=counterUnidade+4'b0001;
			end
			if(counterUnidade==4'b1010) begin
				counterUnidade=4'b0000;
				counterDezena=counterDezena+4'b0001;
			end
			if(counterDezena==4'b1010) begin
				counterDezena=4'b0000;
				counterCentena=counterCentena+4'b0001;
			end
			if(counterCentena==4'b1010) begin
				counterCentena=4'b0000;
				
			end
		
		
		
		
			Decimal=counterDecimal;
			Unidade= counterUnidade;
			Dezena=counterDezena;
			Centena=counterCentena;
		
				
		end
		
		PAUS:begin
		
			counterDecimal=counterDecimal+4'b0001;
			if(counterDecimal==4'b1010) begin
				counterDecimal=4'b0000;
				counterUnidade=counterUnidade+4'b0001;
			end
			if(counterUnidade==4'b1010) begin
				counterUnidade=4'b0000;
				counterDezena=counterDezena+4'b0001;
			end
			if(counterDezena==4'b1010) begin
				counterDezena=4'b0000;
				counterCentena=counterCentena+4'b0001;
			end
			if(counterCentena==4'b1010) begin
				counterCentena=4'b0000;			
			end
			
		end
		
		
		
		
		PARA:begin
		
			counterDecimal=4'b0000;
			counterUnidade=4'b0000;
			counterDezena=4'b0000;
			counterCentena=4'b0000;
		
			Decimal=4'b0000;
			Unidade= 4'b0000;
			Dezena=4'b0000;
			Centena=4'b0000;
		end
		
		
		endcase
		
		
		
	end
	
	always@(negedge Reset,negedge Conta,negedge Pausa,negedge Para)begin
	
	if(Reset==0)begin
		if(estado==CONT)prox_estado<=INIT;
		else if(estado == PAUS) prox_estado<=INIT;
	end

	else if(Conta==0)begin
		if( estado==INIT)prox_estado<=CONT;
	end
	
	
	else if(Pausa==0)begin
		if(estado==CONT)prox_estado<=PAUS;
		else if(estado==PAUS)prox_estado<=CONT;
	end
	
	
	else if(Para==0)prox_estado<=PARA;
	
	
	
	
	
	end
	
	

	
	
	
	endmodule
