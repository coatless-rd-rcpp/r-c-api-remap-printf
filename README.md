## R's C API: Redirecting and Capturing Print Output

<!-- badges: start -->
[![R-CMD-check](https://github.com/coatless-rd-rcpp/r-c-api-remap-printf/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/coatless-rd-rcpp/r-c-api-remap-printf/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The `printf2Rprintf` package provides a demostration of how to write code
using R's C API. The main focus is on control the information stream
specified for output. Work on this example was largely driven by
a [StackOverflow question](https://stackoverflow.com/a/48312733/1345455) related
to capturing print output.

### Usage

To install the package, you must first have a compiler on your system that is 
compatible with R. For help on obtaining a compiler consult either
[macOS](http://thecoatlessprofessor.com/programming/r-compiler-tools-for-rcpp-on-os-x/)
or 
[Windows](http://thecoatlessprofessor.com/programming/rcpp/install-rtools-for-rcpp/)
guides.

With a compiler in hand, one can then install the package from GitHub by:

```r
# install.packages("remotes")
remotes::install_github("coatless-rd-rcpp/r-c-api-remap-printf")
library("printf2Rprintf")
```

### Implementation Details

The main portion of the code requires defining a macro that sets `printf` to 
direct into `Rprintf` and  include the [`#define STRICT_R_HEADERS` to avoid errors](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Error-handling).

```c
// Load in the R header
#include <R.h>
// Note: This loads R_ext/Print.h that we need

// Define strict headers
#define STRICT_R_HEADERS
// Map printf to Rprintf
#define printf Rprintf

// Function prototype with void parameter list to avoid warnings
extern SEXP hello_world_c(void);

// Sample C function that prints: Hello World!
SEXP hello_world_c(void) {
  printf("Hello World!\n");
  return(R_NilValue);
}
```

For details on R's management of printing, please see [Section 6.5 Printing
](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Printing) of [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html)

From here, the capture can be passed off to either [`capture.output()`](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/capture.output.html),
which directly assigns output to a variable, or [`sink()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sink.html),
which redirects output to a file whose contents must then be read back in using
[`readLines()`](https://stat.ethz.ch/R-manual/R-devel/library/base/html/readLines.html).
The latter makes it possible to have a clear enclose over multiple lines of
code to capture output while the prior is focused on securing output present
from an inputted expression. 

```r
# Capture output for a function directly
captured_data = capture.output(hello_world())

# Using sink around multiple function calls to redirect output
# to a single file
sink("sink-examp.txt")
hello_world()
sink()

input_data = readLines("sink-examp.txt")

all.equal(input_data, captured_data)
```

## License

GPL (\>= 2)
