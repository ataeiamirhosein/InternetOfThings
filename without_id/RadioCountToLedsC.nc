/*
 *@author Amirhosein Ataei
 *@id 10722472
 *@date March 22 2020
 */

#include "Timer.h"
#include "RadioCountToLeds.h"

module BlinkC @safe() {
  uses {
	uses interface Leds;
	uses interface Boot;
	uses interface Receive as Receive1;
	uses interface Receive as Receive2;
	uses interface Receive as Receive3;
	uses interface AMSend as AMSend1;
	uses interface AMSend as AMSend2;
	uses interface AMSend as AMSend3;
	uses interface Timer<TMilli> as Timer0;
	uses interface Timer<TMilli> as Timer1;
    uses interface Timer<TMilli> as Timer2;
    uses interface SplitControl as AMControl1;
    uses interface SplitControl as AMControl2;
    uses interface SplitControl as AMControl3;
    uses interface Packet as Packet1;
    uses interface Packet as Packet2;
    uses interface Packet as Packet3;
  }
}

implementation
{

	message_t packet;

  bool locked;
  uint16_t counter = 0;
  
  event void Boot.booted()
  {
  	call AMControl1.start();
  	call AMControl2.start();
  	call AMControl3.start();
    
  }

  event void AMControl1.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer0.startPeriodic(1000);
    }
    else {
      call AMControl1.start();
    }
  }

  event void AMControl1.stopDone(error_t err) {
    // do nothing
  }

  event void AMControl2.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer1.startPeriodic(1000/3);
    }
    else {
      call AMControl2.start();
    }
  }
  
  event void AMControl2.stopDone(error_t err) {
    // do nothing
  }

  event void AMControl3.startDone(error_t err) {
    if (err == SUCCESS) {
      call Timer2.startPeriodic(200);
    }
    else {
      call AMControl3.start();
    }
  }

  event void AMControl3.stopDone(error_t err) {
    // do nothing
  }

  event void Timer0.fired()
  {
    dbg("BlinkC", "Timer 0 fired @ %s.\n", sim_time_string());
    counter++;
    if (locked) {
      return;
    }
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet1.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      rcm->counter = counter;
      rcm->id = 1;
      if (call AMSend1.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
	dbg("BlinkC", "BlinkC: packet sent.\n", counter);	
	locked = TRUE;
      }
    }
  }
  
  event void Timer1.fired()
  {
    dbg("BlinkC", "Timer 1 fired @ %s.\n", sim_time_string());
    counter++;
    if (locked) {
      return;
    }
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet2.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      rcm->counter = counter;
      rcm->id = 2;
      if (call AMSend2.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
	dbg("BlinkC", "BlinkC: packet sent.\n", counter);	
	locked = TRUE;
      }
    }
  }
  
  
  event void Timer2.fired()
  {
    dbg("BlinkC", "Timer 2 fired @ %s.\n", sim_time_string());
    counter++;
    if (locked) {
      return;
    }
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet3.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) {
	return;
      }
      
      rcm->counter = counter;
      rcm->id = 3;
      if (call AMSend3.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
	dbg("BlinkC", "BlinkC: packet sent.\n", counter);	
	locked = TRUE;
      }
    }
  }
  
  event message_t* Receive1.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    dbg("BlinkC", "Received packet of length %hhu.\n", len);
    if (len != sizeof(radio_count_msg_t)) {return bufPtr;}
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)payload;
      if(counter % 10 == 0){
      	call Leds.led0Off();
      	call Leds.led1Off();
      	call Leds.led2Off();
      }
      else{
      	if(rcm->id == 1)
      		call Leds.led0Toggle();
      	if(rcm->id == 2)
      		call Leds.led1Toggle();
      	if(rcm->id == 3)
      		call Leds.led2Toggle();
      
      }
      return bufPtr;
    }
  }
  
  event void AMSend1.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }
  
  event message_t* Receive2.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    dbg("BlinkC", "Received packet of length %hhu.\n", len);
    if (len != sizeof(radio_count_msg_t)) {return bufPtr;}
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)payload;
      if(counter % 10 == 0){
      	call Leds.led0Off();
      	call Leds.led1Off();
      	call Leds.led2Off();
      }
      else{
      	if(rcm->id == 1)
      		call Leds.led0Toggle();
      	if(rcm->id == 2)
      		call Leds.led1Toggle();
      	if(rcm->id == 3)
      		call Leds.led2Toggle();
      
      }
      return bufPtr;
    }
  }
  
  event void AMSend2.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }
  
  event message_t* Receive3.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    dbg("BlinkC", "Received packet of length %hhu.\n", len);
    if (len != sizeof(radio_count_msg_t)) {return bufPtr;}
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)payload;
      if(counter % 10 == 0){
      	call Leds.led0Off();
      	call Leds.led1Off();
      	call Leds.led2Off();
      }
      else{
      	if(rcm->id == 1)
      		call Leds.led0Toggle();
      	if(rcm->id == 2)
      		call Leds.led1Toggle();
      	if(rcm->id == 3)
      		call Leds.led2Toggle();
      
      }
      return bufPtr;
    }
  }
  
  event void AMSend3.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }
}