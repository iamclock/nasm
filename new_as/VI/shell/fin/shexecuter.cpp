
#include <iostream>
#include <fstream>
#include <cstdio>
#include <cstdlib>
#include <sys/mman.h>




using std::cout;
using std::cin;
using std::ifstream;





void print_array(char *array, int n){
// 	bool f=false;
	;
	for(int i=0; i<n; ++i){
		if(!(i%10))
			cout << '\n';
		printf("%2x ", (unsigned char)array[i]);
// 		cout << std::hex << (unsigned int)array[i] << ' ';
			 // << std::dec << " - " << (int)array[i] << '\n';
		/*if(f==true){
			f=false;
			cout << ' ';
		}
		else
			f=true;
		*/
	}
	cout << std::dec << '\n';
}







int main(){
	char *shcode = new char[100];
	ifstream file;
	file.open("shcode");
	if(!(file.is_open())){
		cout << "file wasn't open. Maybe incorrect file name\n";
		return 0;
	}
	int n=0;
	
	for(int i=0; !file.eof(); ++i){
		file.get(shcode[i]);
		n = i;
	}
	
	print_array(shcode, n);
	
	cout << n << '\n';
	
	void *ptr = (void*)((long int)shcode&(~4095));
	mprotect(ptr, 1024, 7);
	(*(void(*)()) shcode)();
	return 0;
}








