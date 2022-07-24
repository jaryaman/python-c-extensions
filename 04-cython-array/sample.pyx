cimport cython

# We include some performance-enhancing decorators...

@cython.boundscheck(False)  # used when you know the index won't go out of range
@cython.wraparound(False)   # eliminate the handling of negative array indices as wrapping around the end of the array
cpdef clip(double[:] a, double min, double max, double[:] out):  # both a C-level and Python-level function
    '''
    Clip the values in a to be between min and max. Result in out.

    When writing code that produces a result that is an array, it should be the responsibility of the caller to create
    the output array, freeing the code of knowing the details of the output array.
    '''
    if min > max:
        raise ValueError("min must be <= max")
    if a.shape[0] != out.shape[0]:
        raise ValueError("input and output arrays must be the same size")
    for i in range(a.shape[0]):
        # This implementation is simple, but slow
        # if a[i] < min:
        #     out[i] = min
        # elif a[i] > max:
        #     out[i] = max
        # else:
        #     out[i] = a[i]

         out[i] = (a[i] if a[i] < max else max) if a[i] > min else min


@cython.boundscheck(False)
@cython.wraparound(False)
cpdef clip2d(double[:,:] a, double min, double max, double[:,:] out):
    if min > max:
        raise ValueError("min must be <= max")
    for n in range(a.ndim):
        if a.shape[n] != out.shape[n]:
            raise TypeError("a and out have different shapes")
    for i in range(a.shape[0]):
        for j in range(a.shape[1]):
            if a[i,j] < min:
                out[i,j] = min
            elif a[i,j] > max:
                out[i,j] = max
            else:
                out[i,j] = a[i,j]
