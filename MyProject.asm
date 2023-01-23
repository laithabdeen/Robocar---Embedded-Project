
_main:

;MyProject.c,25 :: 		void main(void){
;MyProject.c,29 :: 		TRISD=0x00;  // all as output
	CLRF       TRISD+0
;MyProject.c,31 :: 		TRISC=0xC0;  //tx=1,rx=1
	MOVLW      192
	MOVWF      TRISC+0
;MyProject.c,33 :: 		adcon0=0;
	CLRF       ADCON0+0
;MyProject.c,35 :: 		adcon1=0;
	CLRF       ADCON1+0
;MyProject.c,37 :: 		PORTD=0;
	CLRF       PORTD+0
;MyProject.c,39 :: 		CCPPWM_init();
	CALL       _CCPPWM_init+0
;MyProject.c,41 :: 		serial_interface();
	CALL       _serial_interface+0
;MyProject.c,47 :: 		while(1) {
L_main0:
;MyProject.c,49 :: 		result=reciever();
	CALL       _reciever+0
	MOVF       R0+0, 0
	MOVWF      _result+0
;MyProject.c,51 :: 		transmitter(result);
	MOVF       R0+0, 0
	MOVWF      FARG_transmitter+0
	CALL       _transmitter+0
;MyProject.c,55 :: 		if(result == 'F')
	MOVF       _result+0, 0
	XORLW      70
	BTFSS      STATUS+0, 2
	GOTO       L_main2
;MyProject.c,59 :: 		PORTD= 0x55;
	MOVLW      85
	MOVWF      PORTD+0
;MyProject.c,61 :: 		}
	GOTO       L_main3
L_main2:
;MyProject.c,63 :: 		else if( result == 'R')
	MOVF       _result+0, 0
	XORLW      82
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;MyProject.c,67 :: 		PORTD= 0xAA;
	MOVLW      170
	MOVWF      PORTD+0
;MyProject.c,69 :: 		}
	GOTO       L_main5
L_main4:
;MyProject.c,71 :: 		else if ( result == 'W')
	MOVF       _result+0, 0
	XORLW      87
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;MyProject.c,75 :: 		PORTD = 0x41;
	MOVLW      65
	MOVWF      PORTD+0
;MyProject.c,77 :: 		}
	GOTO       L_main7
L_main6:
;MyProject.c,79 :: 		else if ( result == 'L')
	MOVF       _result+0, 0
	XORLW      76
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;MyProject.c,83 :: 		PORTD = 0x14;
	MOVLW      20
	MOVWF      PORTD+0
;MyProject.c,85 :: 		}
	GOTO       L_main9
L_main8:
;MyProject.c,87 :: 		else if ( result == 'S')
	MOVF       _result+0, 0
	XORLW      83
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;MyProject.c,91 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;MyProject.c,93 :: 		}
	GOTO       L_main11
L_main10:
;MyProject.c,95 :: 		else if ( result == 'Q')
	MOVF       _result+0, 0
	XORLW      81
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;MyProject.c,99 :: 		CCPR1L = 64; //set dutycycle 25%
	MOVLW      64
	MOVWF      CCPR1L+0
;MyProject.c,101 :: 		}
	GOTO       L_main13
L_main12:
;MyProject.c,103 :: 		else if ( result == 'T')
	MOVF       _result+0, 0
	XORLW      84
	BTFSS      STATUS+0, 2
	GOTO       L_main14
;MyProject.c,107 :: 		CCPR1L = 128;  //set dutycycle 50%
	MOVLW      128
	MOVWF      CCPR1L+0
;MyProject.c,109 :: 		}
	GOTO       L_main15
L_main14:
;MyProject.c,111 :: 		else if ( result == 'E')
	MOVF       _result+0, 0
	XORLW      69
	BTFSS      STATUS+0, 2
	GOTO       L_main16
;MyProject.c,115 :: 		CCPR1L = 192;  //set dutycycle 75%
	MOVLW      192
	MOVWF      CCPR1L+0
;MyProject.c,117 :: 		}
	GOTO       L_main17
L_main16:
;MyProject.c,119 :: 		else if ( result == 'Z')
	MOVF       _result+0, 0
	XORLW      90
	BTFSS      STATUS+0, 2
	GOTO       L_main18
;MyProject.c,123 :: 		CCPR1L = 255;  //set dutycycle 100%
	MOVLW      255
	MOVWF      CCPR1L+0
;MyProject.c,125 :: 		}
L_main18:
L_main17:
L_main15:
L_main13:
L_main11:
L_main9:
L_main7:
L_main5:
L_main3:
;MyProject.c,129 :: 		}
	GOTO       L_main0
;MyProject.c,131 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_serial_interface:

;MyProject.c,135 :: 		void serial_interface(){
;MyProject.c,137 :: 		TXSTA = 0x20; //Asynchronous mode, Low power BRGH=0, 8-bit selection
	MOVLW      32
	MOVWF      TXSTA+0
;MyProject.c,139 :: 		RCSTA = 0x90; // Serial port enable, continous recieve enabled, 8-bit selection
	MOVLW      144
	MOVWF      RCSTA+0
;MyProject.c,141 :: 		SPBRG= 12; //Low power,, 9600 baudrate
	MOVLW      12
	MOVWF      SPBRG+0
;MyProject.c,144 :: 		PIR1= PIR1 & 0xEF; //TXIF_bit=0;
	MOVLW      239
	ANDWF      PIR1+0, 1
;MyProject.c,145 :: 		PIR1= PIR1 & 0xDF;  //RCIF_bit=0;
	MOVLW      223
	ANDWF      PIR1+0, 1
;MyProject.c,146 :: 		}
L_end_serial_interface:
	RETURN
; end of _serial_interface

_transmitter:

;MyProject.c,150 :: 		void transmitter(unsigned char tx) {
;MyProject.c,152 :: 		TXREG= tx;
	MOVF       FARG_transmitter_tx+0, 0
	MOVWF      TXREG+0
;MyProject.c,154 :: 		while (!TXIF);
L_transmitter20:
;MyProject.c,156 :: 		PIR1= PIR1 & 0xEF; //TXIF_bit=0;
	MOVLW      239
	ANDWF      PIR1+0, 1
;MyProject.c,158 :: 		}
L_end_transmitter:
	RETURN
; end of _transmitter

_reciever:

;MyProject.c,162 :: 		unsigned char reciever(){
;MyProject.c,164 :: 		while(!RCIF);
L_reciever22:
;MyProject.c,166 :: 		PIR1= PIR1 & 0xDF;  //RCIF_bit=0;
	MOVLW      223
	ANDWF      PIR1+0, 1
;MyProject.c,168 :: 		return RCREG;
	MOVF       RCREG+0, 0
	MOVWF      R0+0
;MyProject.c,170 :: 		}
L_end_reciever:
	RETURN
; end of _reciever

_CCPPWM_init:

;MyProject.c,174 :: 		void CCPPWM_init(void){ //Configure CCP1 and CCP2 at 2ms period with 50% duty cycle
;MyProject.c,175 :: 		T2CON = 0x07;//enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
	MOVLW      7
	MOVWF      T2CON+0
;MyProject.c,176 :: 		CCP1CON = 0x0C;//enable PWM for CCP1
	MOVLW      12
	MOVWF      CCP1CON+0
;MyProject.c,177 :: 		CCP2CON = 0x0C;//enable PWM for CCP2
	MOVLW      12
	MOVWF      CCP2CON+0
;MyProject.c,178 :: 		PR2 = 250;// 250 counts =8uS *250 =2ms period
	MOVLW      250
	MOVWF      PR2+0
;MyProject.c,179 :: 		TRISC = 0x00;
	CLRF       TRISC+0
;MyProject.c,180 :: 		CCPR1L= 125;
	MOVLW      125
	MOVWF      CCPR1L+0
;MyProject.c,181 :: 		CCPR2L= 125;
	MOVLW      125
	MOVWF      CCPR2L+0
;MyProject.c,182 :: 		}
L_end_CCPPWM_init:
	RETURN
; end of _CCPPWM_init

_ms_delay:

;MyProject.c,189 :: 		void ms_delay(unsigned int delay){
;MyProject.c,191 :: 		for(k=0; k<50; k++){
	CLRF       _k+0
L_ms_delay23:
	MOVLW      50
	SUBWF      _k+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_ms_delay24
;MyProject.c,193 :: 		for(j=0;j<1000;j++){
	CLRF       _j+0
	CLRF       _j+1
L_ms_delay26:
	MOVLW      3
	SUBWF      _j+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__ms_delay35
	MOVLW      232
	SUBWF      _j+0, 0
L__ms_delay35:
	BTFSC      STATUS+0, 0
	GOTO       L_ms_delay27
;MyProject.c,195 :: 		k=k;
;MyProject.c,197 :: 		j=j;
;MyProject.c,193 :: 		for(j=0;j<1000;j++){
	INCF       _j+0, 1
	BTFSC      STATUS+0, 2
	INCF       _j+1, 1
;MyProject.c,199 :: 		}
	GOTO       L_ms_delay26
L_ms_delay27:
;MyProject.c,191 :: 		for(k=0; k<50; k++){
	INCF       _k+0, 1
;MyProject.c,201 :: 		}
	GOTO       L_ms_delay23
L_ms_delay24:
;MyProject.c,203 :: 		}
L_end_ms_delay:
	RETURN
; end of _ms_delay
