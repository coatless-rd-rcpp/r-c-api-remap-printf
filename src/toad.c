#include <R.h>
#include <Rdefines.h>
#include "my_code.h"

SEXP hello_world_c() {
  printf("Hello World!\n");
  return(R_NilValue);
}
