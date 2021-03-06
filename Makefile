LL = /usr/lib/arm-linux-gnueabihf/libc.so -dynamic-linker /lib/ld-linux-armhf.so.3
lib1 = /home/pi/cs3b/lib/barnett_12Feb20.a
sUC = String_toUpperCase.o
sLC = String_toLowerCase.o

#rasm3: rasm3.o $(sUC) $(sLC) String_Length.o String_indexOf_2.o String_indexOf_1.o String_indexOf_3.o String_lastIndexOf_1.o String_lastIndexOf_2.o String_lastIndexOf_3.o String_concat.o String_replace.o
#	ld -o rasm3 rasm3.o String_Length.o String_indexOf_3.o String_indexOf_1.o String_indexOf_2.o String_lastIndexOf_1.o String_lastIndexOf_2.o String_lastIndexOf_3.o String_concat.o String_replace.o $(sUC) $(sLC) $(LL) $(lib1)

rasm3: rasm3.o String2.a $(sUC) $(sLC) String_Length.o String_indexOf_2.o String_indexOf_1.o String_indexOf_3.o String_lastIndexOf_1.o String_lastIndexOf_2.o String_lastIndexOf_3.o String_concat.o String_replace.o
	make ar
	ld -o rasm3 rasm3.o $(LL) $(lib1) String2.a

rasm3.o: rasm3.s
	as -g -o rasm3.o rasm3.s

String_Length.o: String_Length.s
	as -g -o String_Length.o String_Length.s

$(sUC): String_toUpperCase.s
	as -g -o $(sUC) String_toUpperCase.s

$(sLC): String_toLowerCase.s
	as -g -o $(sLC) String_toLowerCase.s

String_indexOf_1.o: String_indexOf_1.s
	as -g -o String_indexOf_1.o String_indexOf_1.s

String_indexOf_2.o: String_indexOf_2.s
	as -g -o String_indexOf_2.o String_indexOf_2.s

String_indexOf_3.o: String_indexOf_3.s
	as -g -o String_indexOf_3.o String_indexOf_3.s

String_lastIndexOf_1.o: String_lastIndexOf_1.s
	as -g -o String_lastIndexOf_1.o String_lastIndexOf_1.s

String_lastIndexOf_2.o: String_lastIndexOf_2.s
	as -g -o String_lastIndexOf_2.o String_lastIndexOf_2.s

String_lastIndexOf_3.o: String_lastIndexOf_3.s
	as -g -o String_lastIndexOf_3.o String_lastIndexOf_3.s

String_concat.o: String_concat.s
	as -g -o String_concat.o String_concat.s

String_replace.o: String_replace.s
	as -g -o String_replace.o String_replace.s

ar: 
	rm -f String2.a
	ar r String2.a *.o
	ar d String2.a rasm3.o

clean: 
	rm *.o rasm3
