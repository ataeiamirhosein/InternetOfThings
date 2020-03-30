# Internet Of Things TOSSIM simulation (Report and Resault)

we have three important file type in this simulation project which described below:  

in `.h` file we confine the stracture of functions.

also we have two file with `.nc` that one of them with name of describe `appC` and `C` files.

in `~appC.nc` file we have configuration and implementation of things that is in project. (e.g. timer)
for `~C.nc` file we have all the program code here for used module interfaces and running events.

## Result  

we can see the result of tossim below in CLI  

![screenshot from result of tossim](http://iotco.net/tos.png)  

## TOSSIM simulator  

TOSSIM simulates entire TinyOS applications. It works by replacing components with simulation implementations. The level at which components are replaced is very flexible: for example, there is a simulation implementation of millisecond timers that replaces HilTimerMilliC, while there is also an implementation for atmega128 platforms that replaces the HPL components of the hardware clocks. The former is general and can be used for any platform, but lacks the fidelity of capturing an actual chip's behavior, as the latter does.  

## including files of this repo for running simulation

- sendAck.h
- sendAckAppC.nc
- sendAckC.nc
- topology.txt

Finally, we can use :~$ `make micaz sim` command to compile and build files for tossim simulation after that run the python simulation file

## micaz mote  

![micaz](http://iotco.net/micaz.png)  
