/*
 *@author Amirhosein Ataei
 *@date March 22 2020
 */

#include "Timer.h"
#include "RadioCountToLeds.h"

module RadioCountToLedsC @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Timer<TMilli> as MilliTimer;
    interface SplitControl as AMControl;
    interface Packet;
  }
}

implementation {

  message_t packet;

  bool locked;
  uint16_t counter = 0;
  
  event void Boot.booted() {
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
  	if (err == SUCCESS) {
          if ( TOS_NODE_ID == 1 ) {call MilliTimer.startPeriodic(1000);}
          
            if( TOS_NODE_ID == 2 ) {call MilliTimer.startPeriodic(1000/3);}
            
              if ( TOS_NODE_ID == 3 ) {call MilliTimer.startPeriodic(200);}   
        }
    else {
       call AMControl.start();
         }
  }

  event void AMControl.stopDone(error_t err) {
    
  }
  
  event void MilliTimer.fired() {
    counter++;
    dbg("RadioCountToLedsC", "RadioCountToLedsC: timer fired, counter is %hu.\n", counter);
    if (locked) { return; }
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));
      if (rcm == NULL) { return; }

      rcm->counter = counter;
      rcm->NodeId = TOS_NODE_ID;
         
      if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
	dbg("RadioCountToLedsC", "RadioCountToLedsC: packet sent.\n", counter);	
	locked = TRUE;
      }
    }
  }

  event message_t* Receive.receive(message_t* bufPtr, 
				   void* payload, uint8_t len) {
    dbg("RadioCountToLedsC", "Received packet of length %hhu.\n", len);
    if (len != sizeof(radio_count_msg_t)) {return bufPtr;}
    else {
      radio_count_msg_t* rcm = (radio_count_msg_t*)payload;
     
      if (rcm->NodeId ==1) {      
		call Leds.led0On();      
		}
		
			if (rcm->NodeId ==2){
				call Leds.led1On();
				}
			
				if(rcm->NodeId ==3){
					call Leds.led2On();
					}

	  if (counter % 10 == 0){
	  	call Leds.led0Off();
	  	call Leds.led1Off();
	  	call Leds.led2Off();
	  } 	
      return bufPtr;
    }
  }

  event void AMSend.sendDone(message_t* bufPtr, error_t error) {
    if (&packet == bufPtr) {
      locked = FALSE;
    }
  }
}
