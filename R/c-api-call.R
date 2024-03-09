#' Calling a Function Written with R's C API
#'
#' This function provides an example of how to call a function written using
#' R's C API. The function itself redirects output from the printf() stream to
#' R's Rprintf() so that it can be captured and manipulated.
#' @export
#' @examples
#' # Gregor's suggestion
#' captured_data = capture.output(hello_world())
#'
#' # Using sink around multiple function calls to redirect output
#' # to a single file
#' fileTemp = tempfile("sink-examp.txt")
#' sink(fileTemp)
#' hello_world()
#' sink()
#'
#' input_data = readLines(fileTemp)
#'
#' all.equal(input_data, captured_data)
hello_world <- function() {
  result <- .Call("hello_world_c")
}

