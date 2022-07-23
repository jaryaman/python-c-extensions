/* pysample.c */
#include "Python.h"
#define PYSAMPLE_MODULE
#include "pysample.h"


static _PointAPIMethods _point_api = {
    PyPoint_AsPoint,
    PyPoint_FromPoint
};


/* Module method table */
static PyMethodDef SampleMethods[] = {
    {"Point", py_Point, METH_VARARGS, "Point object"},
    {"distance", py_distance, METH_VARARGS, "Pythagorean distance between point objects"},
    {"PyPoint_AsPoint", PyPoint_AsPoint, METH_VARARGS, "Point object as point"},
    {"PyPoint_FromPoint", PyPoint_FromPoint, METH_VARARGS, "Point object from point"},
    {NULL, NULL, 0, NULL}
};

/* Module structure */
static struct PyModuleDef samplemodule = {
    PyModuleDef_HEAD_INIT,
    "sample",           /* name of module */
    "A sample module",  /* Doc string (may be NULL) */
    -1,                 /* Size of per-interpreter state, or -1 */
    SampleMethods      /* Method table */
};



/* Module initialization function */
PyMODINIT_FUNC
PyInit_sample(void) {
    PyObject *m;
    PyObject *py_point_api;
    m = PyModule_Create(&samplemodule);
    if (m == NULL)
    return NULL;

    /* Add the Point C API functions */
    py_point_api = PyCapsule_New((void *) &_point_api, "sample._point_api", NULL);
    if (py_point_api) {
        PyModule_AddObject(m, "_point_api", py_point_api);
    }
    return m;
}
