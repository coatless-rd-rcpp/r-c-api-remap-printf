#include <R.h>
#include <Rdefines.h>
#include "header-file.h"

extern SEXP hello_world_c(void);  // Function prototype with void parameter list

SEXP hello_world_c(void) {
  printf("Hello World!\n");
  return(R_NilValue);
}
