
# TOSSIM simulator  

TOSSIM simulates entire TinyOS applications. It works by replacing components with simulation implementations. The level at which components are replaced is very flexible: for example, there is a simulation implementation of millisecond timers that replaces HilTimerMilliC, while there is also an implementation for atmega128 platforms that replaces the HPL components of the hardware clocks. The former is general and can be used for any platform, but lacks the fidelity of capturing an actual chip's behavior, as the latter does.  

# including files of this repo for running simulation

- sendAck.h
- sendAckAppC.nc
- sendAckC.nc
- topology.txt

Finally, we can use :~$ `make micaz sim` command to compile and build files for tossim simulation after that run the python simulation file

## micaz mote  

![micaz](http://iotco.net/micaz.png)  
