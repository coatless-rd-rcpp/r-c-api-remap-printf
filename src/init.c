#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* .Call calls */
extern SEXP hello_world_c();

static const R_CallMethodDef CallEntries[] = {
  {"hello_world_c", (DL_FUNC) &hello_world_c, 0},
  {NULL, NULL, 0}
};

void R_init_printf2Rprintf(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
