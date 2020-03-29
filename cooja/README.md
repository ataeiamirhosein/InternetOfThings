
# Internet Of Things cooja simulation (Report and Resault)

we have three file type in this simulation project which described below:  

in `.h` file we confine the stracture of radio count message functions for example the stracture of variable that is in my project in type of unsign integer 8 bit for variable that keep the **id** of each mote and 32 bit for the **counter**.  

also we have two file with `.nc` that one of them with name of describe `appC` and `C` files.  

in `~appC.nc` file we have configuration and implementation of things that is in project. (e.g. timer)    

for `~C.nc` file we have all the program code here for used module interfaces and running *events* that described sequently:  

**first section:** define header files (timer and our stracture header) and all of modules that we used during the project.  

**second section:** start to set variables and type of them like `locked` with type of boolian that we use for locking a message for sending.  

**third section:** implement events such as boot, according to our knowledge always we have an initial function in C family program that called at the begining of starting program that this project is boot. so, in boot event we call an AMControl.start() function to start the program.  

**forth section:** in AMControl.start we check the function and if no problem we go for periodically calling timers for each mote individually using specific `ID` according to use `TOS_NODE_ID`.  
we use:
- 1000 ms for mote 1.
- 1000/3 ms for mote 2.
- 200 ms for mote 3.  

**fifth section:** we fire the each timer and running counter also id of each motes to produce the packet and ready for send by broadcast with `AMSend.send()` function and argument `AM_BROADCAST_ADDR`.  

**sixth section:** we receive the packets by `Receive.receive()` function and compare for deciding to toggling the leds.  

finally we simulate the project with `cooja` and seee the resault of [cooja](https://anrg.usc.edu/contiki/index.php/Cooja_Simulator) simulation below:

## first result with cooja (in range)
we can see the leds according to each three mote turning on  
each mote broadcast a message to other motes and demonestrate on (picture 1) that the leds related to other motes turn on other motes this means that the broadcast message with other motes received from each of them and turn related led
- the led one with **green** light related to **mote two**.
- the led two with **red** light related to **mote one**.
- the led three with **blue** light related to **mote three**.

![screenshot from result of cooja](http://iotco.net/iothw1-1.jpg)  
(picture 1)


## second result with cooja (one out of range)
we can see when we change the position of one mote and set out of range in other motes the related led of out range mote is turned of

![screenshot from result of cooja](http://iotco.net/iothw1-2.jpg)  
(picture 2)

## cooja simulator

Cooja Simulator is a network simulator specifically designed for Wireless Sensor Networks.  

## including files of this repo for running simulation

- RadioCountToLeds.h
- RadioCountToLedsAppC.nc
- RadioCountToLedsC.nc
- Makefile

Finally, we can use  :~$ `make telosb` command to build a `main.exe` file for cooja simulation to see the test

## telosb mote

![telosb](http://iotco.net/telosb.png)  
