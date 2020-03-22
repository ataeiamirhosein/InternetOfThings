/*
 *@author Amirhosein Ataei
 *@id 10722472
 *@date March 22 2020
 */

#include "RadioCountToLeds.h"

configuration RadioCountToLedsAppC
{
}

implementation
{
  components MainC, RadioCountToLedsC as App, LedsC;

  components new AMSenderC(AM_RADIO_COUNT_MSG) as AMSenderC1;
  components new AMSenderC(AM_RADIO_COUNT_MSG) as AMSenderC2;
  components new AMSenderC(AM_RADIO_COUNT_MSG) as AMSenderC3;
  
  components new AMReceiverC(AM_RADIO_COUNT_MSG) as AMReceiverC1;
  components new AMReceiverC(AM_RADIO_COUNT_MSG) as AMReceiverC2;
  components new AMReceiverC(AM_RADIO_COUNT_MSG) as AMReceiverC3;
  
  components new TimerMilliC() as Timer0;
  components new TimerMilliC() as Timer1;
  components new TimerMilliC() as Timer2;
  
  components ActiveMessageC as ActiveMessageC1;
  components ActiveMessageC as ActiveMessageC2;
  components ActiveMessageC as ActiveMessageC3;

  App.Boot -> MainC.Boot;
  
  App.Receive1 -> AMReceiverC1;
  App.Receive2 -> AMReceiverC2;
  App.Receive3 -> AMReceiverC3;
  
  App.AMSend1 -> AMSenderC1;
  App.AMSend2 -> AMSenderC2;
  App.AMSend3 -> AMSenderC3;
  
  App.AMControl1 -> ActiveMessageC1;
  App.AMControl2 -> ActiveMessageC2;
  App.AMControl3 -> ActiveMessageC3;
  
  App.Leds -> LedsC;
  
  App.Timer0 -> Timer0;
  App.Timer1 -> Timer1;
  App.Timer2 -> Timer2;
  
  App.Packet1 -> AMSenderC1;
  App.Packet2 -> AMSenderC2;
  App.Packet3 -> AMSenderC3;
}