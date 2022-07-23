# Declarations of "external" C functions and structures. This is analogous to a .h file, i.e. it merely contains
# definitions. However, they do not *generate* extension code. Therefore wrappers must always be implemented in a pyx
# file.

cdef extern from "sample.h":
    int gcd(int, int)
    bint in_mandel(double, double, int)  # bint casts the output as a boolean
    int divide(int, int, int *)
    double avg(double *, int) nogil  # this will be used without the GIL

    ctypedef struct Point:
        double x
        double y

    double distance(Point *, Point *)