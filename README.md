# Internet Of Things cooja simulation

i am **amirhosein ataei** student of **telecommunication** field in polimi with person code **10722472** and write these files on **22 march 2020** at **11pm** and i write the report of my simulation which describe below:

# Report and Resault
we have three file type in this project.  

in `.h` file we confine the stracture of radio count message functions for example the stracture of variable that is in my project in type of unsign integer 8 bit for variable that keep the id of each mote and 32 bit for the counter.  

also we have two file with `.nc` that one of them with name of describe appC 

## first resualt with cooja (in range)
we can see the leds according to each three mote turning on  
each mote broadcast a message to other motes and demonestrate on picture 1 that 

![screenshot from resualt of cooja](http://iotco.net/iothw1-1.jpg)
picture 1

## second resualt with cooja (out of range)
we can see the related led of out range mote is turned of

![screenshot from resualt of cooja](http://iotco.net/iothw1-2.jpg)
picture 2

## including files of this repo for running simulation

- RadioCountToLeds.h
- RadioCountToLedsAppC.nc
- RadioCountToLedsC.nc
- Makefile

:+1: we can use  :~$ `make telosb` command to build a main.ex file for cooja simulation
