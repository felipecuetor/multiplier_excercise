//=======================================================
//  MODULE Definition
//=======================================================
module SC_STATEMACHINE #(parameter DATAWIDTH_DECODER_SELECTION=3, parameter DATAWIDTH_MUX_SELECTION=3, parameter DATAWIDTH_ALU_SELECTION=4,  parameter DATAWIDTH_REGSHIFTER_SELECTION=2 ) (
	//////////// OUTPUTS //////////
	SC_STATEMACHINE_DecoderSelectionWrite_Out,
	SC_STATEMACHINE_MUXSelectionBUSA_Out,
	SC_STATEMACHINE_MUXSelectionBUSB_Out,
	SC_STATEMACHINE_ALUSelection_Out,
	SC_STATEMACHINE_RegSHIFTERLoad_OutLow,
	SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow,
	//////////// INPUTS //////////
	SC_STATEMACHINE_CLOCK_50,
	SC_STATEMACHINE_Reset_InHigh,
	SC_STATEMACHINE_Overflow_InLow,
	SC_STATEMACHINE_Carry_InLow,
	SC_STATEMACHINE_Negative_InLow,
	SC_STATEMACHINE_Zero_InLow
);	
//=======================================================
//  PARAMETER declarations
//=======================================================
// states declaration
	localparam State_RESET_0									= 0;
	localparam State_START_0									= 1;

	localparam State_INC_RegGEN0_1_0							= 2;
	localparam State_INC_RegGEN0_1_1							= 3;
	localparam State_INC_RegGEN0_1_2							= 4;
	
	localparam State_MOV_RegGEN1_RegFIX0_0					= 5;
	localparam State_MOV_RegGEN1_RegFIX0_1					= 6;
	localparam State_MOV_RegGEN1_RegFIX0_2					= 7;
	
	localparam State_MOV_RegGEN2_RegFIX1_0					= 8;
	localparam State_MOV_RegGEN2_RegFIX1_1					= 9;
	localparam State_MOV_RegGEN2_RegFIX1_2					= 10;
	
	localparam State_AND_RegGEN0_RegGEN2_0					= 11;
	localparam State_AND_RegGEN0_RegGEN2_1					= 12;
	localparam State_AND_RegGEN0_RegGEN2_2					= 13;
	
	localparam State_INC_RegGEN0_2_0							= 14;
	localparam State_INC_RegGEN0_2_1							= 15;
	localparam State_INC_RegGEN0_2_2							= 16;
	
	localparam State_ADD_RegGEN3_RegGEN3_RegGEN1_0		= 17;		
	localparam State_ADD_RegGEN3_RegGEN3_RegGEN1_1		= 18;		
	localparam State_ADD_RegGEN3_RegGEN3_RegGEN1_2		= 19;
	
	localparam State_SHL_RegGEN1_0							= 20;
	localparam State_SHL_RegGEN1_1							= 21;
	localparam State_SHL_RegGEN1_2							= 22;
	localparam State_SHL_RegGEN1_3							= 23;
	
	localparam State_SHR_RegGEN2_0							= 24;
	localparam State_SHR_RegGEN2_1							= 25;
	localparam State_SHR_RegGEN2_2							= 26;
	localparam State_SHR_RegGEN2_3							= 27;	
	
	localparam State_MOV_RegGEN2_RegGEN2_0					= 28;
	localparam State_MOV_RegGEN2_RegGEN2_1					= 29;
	localparam State_MOV_RegGEN2_RegGEN2_2					= 30;
	
	localparam State_END_0										= 31;


//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_DECODER_SELECTION-1:0] SC_STATEMACHINE_DecoderSelectionWrite_Out;
	output reg	[DATAWIDTH_MUX_SELECTION-1:0] SC_STATEMACHINE_MUXSelectionBUSA_Out;
	output reg	[DATAWIDTH_MUX_SELECTION-1:0] SC_STATEMACHINE_MUXSelectionBUSB_Out;
	output reg	[DATAWIDTH_ALU_SELECTION-1:0] SC_STATEMACHINE_ALUSelection_Out;
	output reg	SC_STATEMACHINE_RegSHIFTERLoad_OutLow;
	output reg	[DATAWIDTH_REGSHIFTER_SELECTION-1:0] SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow;
	input			SC_STATEMACHINE_CLOCK_50;
	input			SC_STATEMACHINE_Reset_InHigh;
	input			SC_STATEMACHINE_Overflow_InLow;	
	input			SC_STATEMACHINE_Carry_InLow;	
	input			SC_STATEMACHINE_Negative_InLow;	
	input			SC_STATEMACHINE_Zero_InLow;		
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [7:0] State_Register;
	reg [7:0] State_Signal;
	//wire [15:0] State_uInstruction;

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC : COMBINATIONAL
	always @(*)
	case (State_Register)
	//TO INIT REGISTERS
		// 
		State_RESET_0: State_Signal = State_START_0;
		State_START_0: State_Signal = State_INC_RegGEN0_1_0;
		
		State_INC_RegGEN0_1_0: State_Signal = State_INC_RegGEN0_1_1;
		State_INC_RegGEN0_1_1: State_Signal = State_INC_RegGEN0_1_2;		
		State_INC_RegGEN0_1_2: State_Signal = State_MOV_RegGEN1_RegFIX0_0;
		
		State_MOV_RegGEN1_RegFIX0_0: State_Signal = State_MOV_RegGEN1_RegFIX0_1;
		State_MOV_RegGEN1_RegFIX0_1: State_Signal = State_MOV_RegGEN1_RegFIX0_2;
		State_MOV_RegGEN1_RegFIX0_2: State_Signal = State_MOV_RegGEN2_RegFIX1_0;
		
		State_MOV_RegGEN2_RegFIX1_0: State_Signal = State_MOV_RegGEN2_RegFIX1_1;
		State_MOV_RegGEN2_RegFIX1_1: State_Signal = State_MOV_RegGEN2_RegFIX1_2;
		State_MOV_RegGEN2_RegFIX1_2: State_Signal = State_AND_RegGEN0_RegGEN2_0;
		
		State_AND_RegGEN0_RegGEN2_0: if(SC_STATEMACHINE_Zero_InLow == 0) State_Signal = State_END_0;
											  else State_Signal = State_AND_RegGEN0_RegGEN2_1;
		State_AND_RegGEN0_RegGEN2_1: State_Signal = State_AND_RegGEN0_RegGEN2_2;
		State_AND_RegGEN0_RegGEN2_2: if(SC_STATEMACHINE_Zero_InLow == 0) State_Signal = State_INC_RegGEN0_2_0;
											  else State_Signal = State_ADD_RegGEN3_RegGEN3_RegGEN1_0;
		
		State_INC_RegGEN0_2_0: State_Signal = State_INC_RegGEN0_2_1;
		State_INC_RegGEN0_2_1: State_Signal = State_INC_RegGEN0_2_2;		
		State_INC_RegGEN0_2_2: State_Signal = State_SHL_RegGEN1_0;
		
		State_ADD_RegGEN3_RegGEN3_RegGEN1_0: State_Signal = State_ADD_RegGEN3_RegGEN3_RegGEN1_1;
		State_ADD_RegGEN3_RegGEN3_RegGEN1_1: State_Signal = State_ADD_RegGEN3_RegGEN3_RegGEN1_2;
		State_ADD_RegGEN3_RegGEN3_RegGEN1_2: State_Signal = State_SHL_RegGEN1_0;
		
		State_SHL_RegGEN1_0: State_Signal = State_SHL_RegGEN1_1;
		State_SHL_RegGEN1_1: State_Signal = State_SHL_RegGEN1_2;
		State_SHL_RegGEN1_2: State_Signal = State_SHL_RegGEN1_3;
		State_SHL_RegGEN1_3: State_Signal = State_SHR_RegGEN2_0;
		
		State_SHR_RegGEN2_0: State_Signal = State_SHR_RegGEN2_1;
		State_SHR_RegGEN2_1: State_Signal = State_SHR_RegGEN2_2;
		State_SHR_RegGEN2_2: State_Signal = State_SHR_RegGEN2_3;
		State_SHR_RegGEN2_3: State_Signal = State_MOV_RegGEN2_RegGEN2_0;
		
		State_MOV_RegGEN2_RegGEN2_0: State_Signal = State_MOV_RegGEN2_RegGEN2_1;
		State_MOV_RegGEN2_RegGEN2_1: State_Signal = State_MOV_RegGEN2_RegGEN2_2;
		State_MOV_RegGEN2_RegGEN2_2: State_Signal = State_AND_RegGEN0_RegGEN2_0;
		
		default : State_Signal = State_RESET_0;
	endcase
	
// STATE REGISTER : SEQUENTIAL
	always @ ( posedge SC_STATEMACHINE_CLOCK_50 , posedge SC_STATEMACHINE_Reset_InHigh)
	if (SC_STATEMACHINE_Reset_InHigh==1)
		State_Register <= State_RESET_0;
	else
		State_Register <= State_Signal;
		
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

//	assign State_uInstruction = {State_uInstruction,StateMachine_MUXSelectionBUSA_Out,StateMachine_MUXSelectionBUSB_Out,StateMachine_ALUSelection_Out,StateMachine_RegSHIFTERLoad_OutLow,StateMachine_RegSHIFTERShiftSelection_OutLow}
	always @ (*)
	case (State_Register)
//=========================================================
// RESET STATE
//=========================================================
	State_RESET_0 :	
		begin	
		//=========================================================
		// WRITE DATA: FROM BUSC TO GENERAL REGISTERS
		//=========================================================
			// 111 NO GenREG Selected; 000 GenREG_0, ... 011 GenREG_3;
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
		//=========================================================
		// READ DATA: FROM REGISTER(FIXED OR GENERAL) TO BUSA or BUS_B or BOTH OF THEM
		//=========================================================
			// TO BUS A: 000 RegGen_0; 001 RegGen_1; 010 RegGen_2; 011 RegGen_3; 100 RegFIX_0; 101 RegFIX_1; 110 NA; 111 NA;
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			// TO BUS B: 000 RegGen_0; 001 RegGen_1; 010 RegGen_2; 011 RegGen_3; 100 RegFIX_0; 101 RegFIX_1; 110 NA; 111 NA;
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
		//=========================================================
		// ALU OPERATION: 
		//=========================================================
			// 0000 BUSA; 0001 OR; 0010 AND; 0011 NOT A; 0100 XOR; 0101-0111 A; 1000 ADD; 1001 SUB; 1010 INC; 1011 DEC; 1100-1111 A;
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
		//=========================================================
		// SHIFT REGISTER CONTROL: LOAD DATA IN REGSHIFER and REGSHIFER SELECTION
		//=========================================================
			// LOAD: 1 NO LOAD;  0 LOAD;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			// SHIFT: 01 ShiftLeft; 10 ShiftRight; 00-11 NOTHING
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end

//=========================================================
// START STATE
//=========================================================
	State_START_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end
//=========================================================
// MUL: RegGEN3 = RegFIX0 * RegFIX1
//=========================================================
// SE ASUME MULIPLICACION DE NUMEROS POSITIVOS
// RegFIX0: INDICADOR DE LSB PARA REGGEN2
// RegFIX1: Multiplicando
// RegGEN2: Multiplicador
// RegGEN3: ACUMULADOR PARCIAL DE LA MULTIPLICACION

//=========================================================
//  			RegGEN0 = RegGEN0+1; (USADO SOLO PARA INICIALIZAR)
//=========================================================
	State_INC_RegGEN0_1_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b000;				//Selecciona RegGEN0
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1010;					//ALU como INC A
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_INC_RegGEN0_1_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b000;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1010;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_INC_RegGEN0_1_2 :
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b000;		//Asigna a RegGEN0
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;	
		end		
//=========================================================
// 			RegGEN1 = RegFIX0;
//=========================================================
	State_MOV_RegGEN1_RegFIX0_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b100;				//Selecciona RegFIX0
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//ALU como WIRE
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN1_RegFIX0_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b101;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN1_RegFIX0_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b001;		//Asigna a RegGEN1
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;	
		end		
//=========================================================
// 			RegGEN2 = RegFIX1;
//=========================================================
	State_MOV_RegGEN2_RegFIX1_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b101;				//Selecciona RegFIX1
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//ALU como WIRE
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN2_RegFIX1_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b101;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN2_RegFIX1_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b010;		//Asigna a RegGEN2
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;
		end
//=========================================================
// 			RegGEN0 = RegGEN0 & RegGEN2;
//=========================================================
	State_AND_RegGEN0_RegGEN2_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b000;				//Selecciona RegGEN0
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b010;				//Selecciona RegGEN2
			SC_STATEMACHINE_ALUSelection_Out = 4'b0010;					//ALU como AND
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_AND_RegGEN0_RegGEN2_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b000;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b010;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0010;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_AND_RegGEN0_RegGEN2_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b000;		//Asigna a RegGEN0
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;
		end
//=========================================================
//  			RegGEN0 = RegGEN0+1; (USADO DENTRO DEL CICLO PARA ARREGLAR RegGEN0)
//=========================================================
	State_INC_RegGEN0_2_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b000;				//Selecciona RegGEN0
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1010;					//ALU como INC A
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_INC_RegGEN0_2_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b000;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1010;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_INC_RegGEN0_2_2 :
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b000;		//Asigna a RegGEN0
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;	
		end
		
//=========================================================
// 	RegGEN1 = {RegGEN1[[DATAWIDTH_BUS-2:0],0]} 
//=========================================================
	State_SHL_RegGEN1_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b001;				//Selecciona RegGEN1
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//ALU como WIRE
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_SHL_RegGEN1_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b001;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_SHL_RegGEN1_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;		
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b001;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b01;	//Shift a la izquierda	
		end
	State_SHL_RegGEN1_3 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b001;		//Asigna a RegGEN1
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11; 
		end

//=========================================================
//    RegGEN2 = {0,RegGEN2[[DATAWIDTH_BUS-1:1]]} 
//=========================================================
	State_SHR_RegGEN2_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b010;				//Selecciona RegGEN2
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//ALU como WIRE
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_SHR_RegGEN2_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b010;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_SHR_RegGEN2_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;		
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b010;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b10;	//Shift a la derecha	
		end
	State_SHR_RegGEN2_3 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b010;		//Asigna a RegGEN2
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11; 		
		end		
//=========================================================
//  				RegGEN3 = RegGEN3 + RegGEN1;
//=========================================================
	State_ADD_RegGEN3_RegGEN3_RegGEN1_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b011;				//BusA = RegGEN3
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b001;				//BusB = RegGEN1
			SC_STATEMACHINE_ALUSelection_Out = 4'b1000;					//ALU como ADD
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_ADD_RegGEN3_RegGEN3_RegGEN1_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b011;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b001;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1000;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//Carga en RegSHIFTER
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_ADD_RegGEN3_RegGEN3_RegGEN1_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b011;		//Asigna a RegGEN3
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					//Espera a la siguiente operacion
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11; 		
		end		
		
//=========================================================
// END STATE
//=========================================================
	State_END_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end	
//=========================================================
// DEFAULT
//=========================================================
	default:	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;
		end
endcase

endmodule
