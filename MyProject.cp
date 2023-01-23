#line 1 "C:/Users/TTC/Desktop/CCP PWM/MyProject.c"


void serial_interface();

void transmitter(unsigned char);

void CCPPWM_init(void);

void CCPPWM_init(void);

unsigned char reciever();

void ms_delay(unsigned int);



unsigned char result;

unsigned char k;

unsigned int j;



void main(void){



 TRISD=0x00;

 TRISC=0xC0;

 adcon0=0;

 adcon1=0;

 PORTD=0;

 CCPPWM_init();

 serial_interface();





 while(1) {

 result=reciever();

 transmitter(result);



 if(result == 'F')

 {

 PORTD= 0x55;

 }

 else if( result == 'R')

 {

 PORTD= 0xAA;

 }

 else if ( result == 'W')

 {

 PORTD = 0x41;

 }

 else if ( result == 'L')

 {

 PORTD = 0x14;

 }

 else if ( result == 'S')

 {

 PORTD = 0x00;

 }

 else if ( result == 'Q')

 {

 CCPR1L = 64;

 }

 else if ( result == 'T')

 {

 CCPR1L = 128;

 }

 else if ( result == 'E')

 {

 CCPR1L = 192;

 }

 else if ( result == 'Z')

 {

 CCPR1L = 255;

 }



 }

 }



void serial_interface(){

 TXSTA = 0x20;

 RCSTA = 0x90;

 SPBRG= 12;


 PIR1= PIR1 & 0xEF;
 PIR1= PIR1 & 0xDF;
}



void transmitter(unsigned char tx) {

 TXREG= tx;

 while (!TXIF);

 PIR1= PIR1 & 0xEF;

}



unsigned char reciever(){

 while(!RCIF);

 PIR1= PIR1 & 0xDF;

 return RCREG;

}



void CCPPWM_init(void){
 T2CON = 0x07;
 CCP1CON = 0x0C;
 CCP2CON = 0x0C;
 PR2 = 250;
 TRISC = 0x00;
 CCPR1L= 125;
 CCPR2L= 125;
}






void ms_delay(unsigned int delay){

 for(k=0; k<50; k++){

 for(j=0;j<1000;j++){

 k=k;

 j=j;

 }

 }

}
