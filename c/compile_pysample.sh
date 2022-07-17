# gcc -std=c11 -Wall -Wextra -pedantic -c -fPIC sample.c -o sample.o
# gcc -I/usr/include/python3.8 -std=c11 -Wall -Wextra -pedantic pysample.c -shared `pkg-config --libs=python-3.8` -o pysample.o