#' Basic hello, world example.
#'
#' In terms of a more detailed explanation,
#' this function does some really cool hello-saying.
#'
#' @param phrase The phrase to replace "World" with?
#'
#' @examples
#' hello()
#' hello('world')
#'
#' @export
hello = function(phrase = "World") {
    print(sprintf('Hello, %s', phrase))
}
