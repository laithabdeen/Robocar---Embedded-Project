//__CONFIG(FOSC_HS & WDTE_OFF & PWRTE_OFF & CP_OFF & BOREN_ON & LVP_OFF & CPD_OFF & WRT_OFF & DEBUG_OFF);

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

  //STATUS= STATUS | 0x20;

  TRISD=0x00;  // all as output

  TRISC=0xC0;  //tx=1,rx=1

  adcon0=0;

  adcon1=0;

  PORTD=0;

  CCPPWM_init();

  serial_interface();





  while(1) {

      result=reciever();

      transmitter(result);



      if(result == 'F')

      {   //FORWARD

        PORTD= 0x55;

      }

      else if( result == 'R')

      {      //REVERSE

        PORTD= 0xAA;

      }

      else if ( result == 'W')

       {        //RIGHT

        PORTD = 0x41;

      }

      else if ( result == 'L')

       {        //LEFT

        PORTD = 0x14;

      }

      else if ( result == 'S')

       {        //STOP

        PORTD = 0x00;

      }

      else if ( result == 'Q')

      {

       CCPR1L = 64; //set dutycycle 25%

      }

      else if ( result == 'T')

      {

       CCPR1L = 128;  //set dutycycle 50%

      }

      else if ( result == 'E')

      {

       CCPR1L = 192;  //set dutycycle 75%

      }

      else if ( result == 'Z')

      {

        CCPR1L = 255;  //set dutycycle 100%

      }



  }

 }



void serial_interface(){

 TXSTA = 0x20; //Asynchronous mode, Low power BRGH=0, 8-bit selection

 RCSTA = 0x90; // Serial port enable, continous recieve enabled, 8-bit selection

 SPBRG= 12; //Low power,, 9600 baudrate

 //TXIF_bit=RCIF_bit= 0;
 PIR1= PIR1 & 0xEF; //TXIF_bit=0;
 PIR1= PIR1 & 0xDF;  //RCIF_bit=0;
}



void transmitter(unsigned char tx) {

 TXREG= tx;

 while (!TXIF);

 PIR1= PIR1 & 0xEF; //TXIF_bit=0;

}



unsigned char reciever(){

     while(!RCIF);

     PIR1= PIR1 & 0xDF;  //RCIF_bit=0;

     return RCREG;

}



void CCPPWM_init(void){ //Configure CCP1 and CCP2 at 2ms period with 50% duty cycle
  T2CON = 0x07;//enable Timer2 at Fosc/4 with 1:16 prescaler (8 uS percount 2000uS to count 250 counts)
  CCP1CON = 0x0C;//enable PWM for CCP1
  CCP2CON = 0x0C;//enable PWM for CCP2
  PR2 = 250;// 250 counts =8uS *250 =2ms period
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
