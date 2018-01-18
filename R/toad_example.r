#' @useDynLib printf2Rprintf
"_PACKAGE"

#' printf Redirected to Rprinft
#'
#' This function provides a proof of concept of a C redirect
#' @export
#' @examples
#' # Gregor's suggestion
#' captured_data = capture.output(hello_world())
#'
#' # Using sink around multiple function calls to redirect output
#' # to a single file
#' sink("sink-examp.txt")
#' hello_world()
#' sink()
#'
#' input_data = readLines("sink-examp.txt")
#'
#' all.equal(input_data, captured_data)
hello_world <- function() {
  result <- .Call("hello_world_c")
}
