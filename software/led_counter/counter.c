/*
 * counter.c
 *
 *  Created on: Oct 6, 2021
 *      Author: quartus
 */

#include "io.h"
#include <stdio.h>
#include "system.h"

#include "sys/alt_irq.h"
#include <stdint.h>
int counter = 0;

uint16_t redPicture[240*320];
uint16_t greenPicture[240*320];
uint16_t bluePicture[240*320];

void LCD_Write_Command(int command) {
    IOWR_16DIRECT(DMA_LCD_0_BASE,0b000*4,command); // Adapt this line
}

void LCD_Write_Data(int data) {
    IOWR_16DIRECT(DMA_LCD_0_BASE,0b001*4,data); // Adapt this line
}

void init_LCD() {

  IOWR_8DIRECT(DMA_LCD_0_BASE,0b111*4,0b000); // set reset on and 16 bits mode
  while (counter<100){}   // include delay of at least 120 ms use your timer or a loop
  IOWR_8DIRECT(DMA_LCD_0_BASE,0b111*4,0b100); // set reset off and 16 bits mode and enable LED_CS
  while (counter<200){}   // include delay of at least 120 ms use your timer or a loop

  LCD_Write_Command(0x0028);     //display OFF
  LCD_Write_Command(0x0011);     //exit SLEEP mode
  LCD_Write_Data(0x0000);

  LCD_Write_Command(0x00CB);     //Power Control A
  LCD_Write_Data(0x0039);     //always 0x39
  LCD_Write_Data(0x002C);     //always 0x2C
  LCD_Write_Data(0x0000);     //always 0x00
  LCD_Write_Data(0x0034);     //Vcore = 1.6V
  LCD_Write_Data(0x0002);     //DDVDH = 5.6V

  LCD_Write_Command(0x00CF);     //Power Control B
  LCD_Write_Data(0x0000);     //always 0x00
  LCD_Write_Data(0x0081);     //PCEQ off
  LCD_Write_Data(0x0030);     //ESD protection

  LCD_Write_Command(0x00E8);     //Driver timing control A
  LCD_Write_Data(0x0085);     //non - overlap
  LCD_Write_Data(0x0001);     //EQ timing
  LCD_Write_Data(0x0079);     //Pre-charge timing


  LCD_Write_Command(0x00EA);     //Driver timing control B
  LCD_Write_Data(0x0000);        //Gate driver timing
  LCD_Write_Data(0x0000);        //always 0x00

  LCD_Write_Command(0x00ED); //Power‐On sequence control
  LCD_Write_Data(0x0064);        //soft start
  LCD_Write_Data(0x0003);        //power on sequence
  LCD_Write_Data(0x0012);        //power on sequence
  LCD_Write_Data(0x0081);        //DDVDH enhance on

  LCD_Write_Command(0x00F7);     //Pump ratio control
  LCD_Write_Data(0x0020);     //DDVDH=2xVCI

  LCD_Write_Command(0x00C0);    //power control 1
  LCD_Write_Data(0x0026);
  LCD_Write_Data(0x0004);     //second parameter for ILI9340 (ignored by ILI9341)

  LCD_Write_Command(0x00C1);     //power control 2
  LCD_Write_Data(0x0011);

  LCD_Write_Command(0x00C5);     //VCOM control 1
  LCD_Write_Data(0x0035);
  LCD_Write_Data(0x003E);

  LCD_Write_Command(0x00C7);     //VCOM control 2
  LCD_Write_Data(0x00BE);

  LCD_Write_Command(0x00B1);     //frame rate control
  LCD_Write_Data(0x0000);
  LCD_Write_Data(0x0010);

  LCD_Write_Command(0x003A);    //pixel format = 16 bit per pixel
  LCD_Write_Data(0x0055);

  LCD_Write_Command(0x00B6);     //display function control
  LCD_Write_Data(0x000A);
  LCD_Write_Data(0x00A2);

  LCD_Write_Command(0x00F2);     //3G Gamma control
  LCD_Write_Data(0x0002);         //off

  LCD_Write_Command(0x0026);     //Gamma curve 3
  LCD_Write_Data(0x0001);

  LCD_Write_Command(0x0036);     //memory access control = BGR
  LCD_Write_Data(0x0000);

  LCD_Write_Command(0x002A);     //column address set
  LCD_Write_Data(0x0000);
  LCD_Write_Data(0x0000);        //start 0x0000
  LCD_Write_Data(0x0000);
  LCD_Write_Data(0x00EF);        //end 0x00EF

  LCD_Write_Command(0x002B);    //page address set
  LCD_Write_Data(0x0000);
  LCD_Write_Data(0x0000);        //start 0x0000
  LCD_Write_Data(0x0001);
  LCD_Write_Data(0x003F);        //end 0x013F

  LCD_Write_Command(0x0029);

}

void sendPixel(uint16_t red, uint16_t green, uint16_t blue) {
	LCD_Write_Data(((blue >> 3)<<11) + ((green >> 2)<<5) + (red >> 3));
}
void sendPicture(uint16_t red, uint16_t green, uint16_t blue){
	counter = 0;
	for (int i = 0; i < (320*240); i++){
		sendPixel(red, green, blue);
	}
	printf("Refresh time is %d ms\n", counter*10);
}
void timer_interrupt(void *context, alt_u32 id){

	counter++; // increase the counter;
	// acknowledge IRQ on the timer;
	IOWR_16DIRECT(TIMER_0_BASE,0,0); //Reset the flag interrupt
}
int RGBtoBGR (uint16_t red, uint16_t green, uint16_t blue){
	return (((blue >> 3)<<11) + ((green >> 2)<<5) + (red >> 3));
}
void initPictures(){
	for (int j = 0; j < (240); j++){
		for (int i = 0; i < 320; i++){
			if (i > 120){
				if (j > 160){
					IOWR_16DIRECT(redPicture,(i*240+j)*2,RGBtoBGR(255,0,0)); // Adapt this line
					IOWR_16DIRECT(greenPicture,(i*240+j)*2,RGBtoBGR(0,255,0)); // Adapt this line
					IOWR_16DIRECT(bluePicture,(i*240+j)*2,RGBtoBGR(0,0,255)); // Adapt this line
				}
				else{
					IOWR_16DIRECT(redPicture,(i*240+j)*2,RGBtoBGR(255,255,0)); // Adapt this line
					IOWR_16DIRECT(greenPicture,(i*240+j)*2,RGBtoBGR(0,255,255)); // Adapt this line
					IOWR_16DIRECT(bluePicture,(i*240+j)*2,RGBtoBGR(255,0,255)); // Adapt this line
				}
			}else{
				if (j > 160){
					IOWR_16DIRECT(redPicture,(i*240+j)*2,RGBtoBGR(255,128,0)); // Adapt this line
					IOWR_16DIRECT(greenPicture,(i*240+j)*2,RGBtoBGR(128,255,0)); // Adapt this line
					IOWR_16DIRECT(bluePicture,(i*240+j)*2,RGBtoBGR(128,0,255)); // Adapt this line
				}
				else{
					IOWR_16DIRECT(redPicture,(i*240+j)*2,RGBtoBGR(255,255,128)); // Adapt this line
					IOWR_16DIRECT(greenPicture,(i*240+j)*2,RGBtoBGR(0,128,255)); // Adapt this line
					IOWR_16DIRECT(bluePicture,(i*240+j)*2,RGBtoBGR(255,0,128)); // Adapt this line
				}
			}
		}
		//Force to store into the sdram fuck


		//On the cache
		//redPicture[i] = RGBtoBGR(255,0,0);
		//greenPicture[i] = RGBtoBGR(0,255,0);
		//bluePicture[i] = RGBtoBGR(0,0,255);
	}
}
void sendPictureTab(uint16_t* tab){
	counter = 0;
	for (int i = 0; i < (320*240); i++){
		LCD_Write_Data(tab[i]);
	}
	printf("Refresh time is %d ms\n", counter*10);
}
int main(){

	printf("Lets start counting \n");
	// set all to output

	IOWR_32DIRECT(GPIO_PARALLEL_PORT_0_BASE, 0b000*4, 0xFFFFFFFF); //Set to outputs
	IOWR_32DIRECT(GPIO_PARALLEL_PORT_0_BASE, 0b010*4, 0xFFFFFFFF); //Set all to 1

	alt_irq_register(TIMER_0_IRQ,(void*)2,(alt_isr_func)timer_interrupt);

	IOWR_16DIRECT(TIMER_0_BASE,4,0b111); // enbale timer 0
	initPictures();
	init_LCD();


	LCD_Write_Command(0x002C);

	printf("addr = %d \n", redPicture);
	printf("& = %d \n", &redPicture);

	LCD_Write_Data(0x0000);
	IOWR_32DIRECT(DMA_LCD_0_BASE,0b010*4,greenPicture); //Give the picture data pointer
	IOWR_32DIRECT(DMA_LCD_0_BASE,0b011*4,320*240*2); //Give the size
	IOWR_32DIRECT(DMA_LCD_0_BASE,0b100*4,0b001); //Start transfer
	while(1){

		//sendPictureTab(redPicture);
		//sendPictureTab(bluePicture);

		IOWR_32DIRECT(GPIO_PARALLEL_PORT_0_BASE, 0b010*4, counter);// write counter value on the parallel port;
		//counter++;
		//printf("counter = %d \n", counter);
	}
}
