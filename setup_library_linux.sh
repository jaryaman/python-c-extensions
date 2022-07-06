# gcc -Wall -g -c -shared -o libsample.so -fPIC sample.c 

gcc -std=c11 -Wall -Wextra -pedantic -c -fPIC sample.c -o sample.o
gcc -shared sample.o -o sample.so
