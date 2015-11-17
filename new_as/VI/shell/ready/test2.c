#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>
#include <stdlib.h>



int main(){
	/*char *shcode = "\xeb\x17\x31\xc0\x31\xdb\x31\xd2\xb0\x04\xb3\x01\x59\xb2\x09\xcd\x80\x31"
										"\xc0\x31\xdb\xb0\x01\xcd\x80\xe8\xe4\xff\xff\xff\x48\x69\x2c\x20\x6d\x61"
										"\x6e\x21\x0a";
	*/
	char *shcode = (char*) malloc(100), x;
	int i=0, n;
	FILE *file = fopen("shcode", "rt");
	if(file == NULL){
		printf("file wasn't open. Maybe incorrect file name\n");
		return 0;
	}
// 	fscanf(file, "%c", &x);
	
	n=0;
	while(1){
		x = fread(shcode, 1, 1, file);
		if(x){
			++shcode;
			++n;
		}
		else break;
	}
	fclose(file);
	
	shcode-=n;
	printf("%d\n", n);
// 	int i=0, n=40;
	for(i=0; i<n; ++i)
		printf("%02x ", (unsigned char)shcode[i]);
	puts("");
	
	
	void *ptr = (void*)((long int)shcode&(~4095));
	mprotect(ptr, n, 7);
// 	void (*fptr)(void) = (void(*)())shcode;
// 	(*fptr)();
	(*(void(*)()) shcode)();
	
	//execve(command, args, 0);
	return 0;
}