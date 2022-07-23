# Define wrappers that bridge the Python interpreter to the underlying C code declared in csample.pxd. This is analogous
# to a .c file, i.e. it contains implementations.

# Import low-level declarations. The cimport statement is used by cython to import definitions from the .pxd file.
cimport csample

# Import some functionality from Python and the C stdlib
from cpython.pycapsule cimport *
from libc.stdlib cimport malloc, free

## Wrappers

# C data types attached to arguments are optional, but you get free type checking if you include them
def gcd(unsigned int x, unsigned int y):
    return csample.gcd(x, y)

def in_mandel(x, y, unsigned int n):
    return csample.in_mandel(x, y, n)

def divide(x, y):
    cdef int rem  # cdef to define a C data type
    quot = csample.divide(x, y, &rem)
    return quot, rem

def avg(double[:] a):  # a is a one-dimensional array of doubles
    cdef:
        int sz
        double result

    sz = a.size

    # A block executing without the GIL. Inside this block, it is illegal to work with any kind of normal Python object.
    # Only objects declared with cdef can be used. In addition, external functions must explicitly declare that they can
    # execute without the GIL, see the .pxd file.
    with nogil:
        result = csample.avg(
        <double *> &a[0],  # cast pointer to a different type. Used to ensure that avg() receives a pointer of the correct type
        sz
        )
    return result

### Create a Point object and return as an opaque pointer, using a capsule

# Destructor for cleaning up Point objects.
cdef del_Point(object obj):  # this function is cdef and therefore will not be visible to the outside world
    pt = <csample.Point *> PyCapsule_GetPointer(obj, "Point")
    free(<void *> pt)

######
## This implementation, while straightforward, will not allow a user to inspect any attributes
# def Point(double x, double y):
#     cdef csample.Point *p
#     p = <csample.Point *> malloc(sizeof(csample.Point))
#     if p == NULL:
#         raise MemoryError("No memory to make a Point")
#     p.x = x
#     p.y = y
#     return PyCapsule_New(<void *>p, "Point", <PyCapsule_Destructor>del_Point)

# def distance(p1, p2):
#     pt1 = <csample.Point *> PyCapsule_GetPointer(p1, "Point")
#     pt2 = <csample.Point *> PyCapsule_GetPointer(p2, "Point")
#     return csample.distance(pt1, pt2)
######

cdef class Point:
    cdef csample.Point *_c_point
    def __cinit__(self, double x, double y):
        self._c_point = <csample.Point *> malloc(sizeof(csample.Point))
        self._c_point.x = x
        self._c_point.y = y

    def __dealloc__(self):
        free(self._c_point)

    property x:
        def __get__(self):
            return self._c_point.x

        def __set__(self, value):
            self._c_point.x = value

    property y:
        def __get__(self):
            return self._c_point.y

        def __set__(self, value):
            self._c_point.y = value

def distance(Point p1, Point p2):
    return csample.distance(p1._c_point, p2._c_point)