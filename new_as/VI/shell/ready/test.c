#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>




int main(){
	char *shellcode = "\xeb\x17\x31\xc0\x31\xdb\x31\xd2\xb0\x04\xb3\x01\x59\xb2\x09\xcd\x80\x31"
										"\xc0\x31\xdb\xb0\x01\xcd\x80\xe8\xe4\xff\xff\xff\x48\x69\x2c\x20\x6d\x61"
										"\x6e\x21\x0a";
// 	char *shcode = 
// 	char *args[2];
// 	args[0] = command;
// 	args[1] = 0;
	printf("%ld\n", strlen(shellcode));
	mprotect(shellcode, strlen(shellcode), 7);
	(*(void(*)()) shellcode)();
	//execve(command, args, 0);
	return 0;
}