LL = /usr/lib/arm-linux-gnueabihf/libc.so -dynamic-linker /lib/ld-linux-armhf.so.3
lib1 = /home/pi/cs3b/lib/barnett_12Feb20.a
sL = String_Length.o
sUC = String_toUpperCase.o
sLC = String_toLowerCase.o

rasm3: rasm3.o $(sUC) $(sLC)
	ld -o rasm3 rasm3.o $(sL) $(sUC) $(sLC) $(LL) $(lib1)

rasm3.o: rasm3.s
	as -g -o rasm3.o rasm3.s

$(sUC): String_toUpperCase.s
	as -g -o $(sUC) String_toUpperCase.s

$(sLC): String_toLowerCase.s
	as -g -o $(sLC) String_toLowerCase.s
