#include <iostream>
#include <fstream>
/*
#include <>
#include <>
#include <>
#include <>
*/


using std::cout;
using std::cin;
using std::ifstream;




void print(ifstream &file){
	char x;
	bool f;
	file >> x;
	while(!file.eof()){
		cout << std::hex << (int)x;// << " - " << x;
		file >> x;
		if(f==true){
			f=false;
			cout << ' ';
		}
		else
			f=true;
	}
	cout << '\n';
}


void print_array(char *array, int n){
	bool f=false;
	
	for(int i=0; i!=n; ++i){
		cout << std::hex << (int)array[i];// << std::dec << " - " << (int)array[i] << '\n';
		if(f==true){
			f=false;
			cout << ' ';
		}
		else
			f=true;
	}
	cout << '\n';
	
}



int main(int argc, char *argv[]){
	char *file_name = new char[100], *array = new char[1000];
	int n;
	if(argc < 2){
		cout << "First argument must be shellcode file name. Enter it now: ";
		cin >> file_name;
	}
	else
		file_name = argv[1];
	ifstream file;
	file.open(file_name);
	if(!(file.is_open())){
		cout << "file wasn't open. Maybe incorrect file name\n";
		return 0;
	}
// 	print(file);
	for(int i=0; !file.eof(); ++i){
		file >> array[i];
		n = i;
	}
	
	cout << n << '\n';
	print_array(array, n);
	
	file.close();
	return 0;
}










