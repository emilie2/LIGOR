#' LIGOR package
#'
#' \code{LIGOR} is a package used
#' to intepret the LIGO data in R. It provides the following functions \code{\link{loaddata}},
#' \code{\link{whiten}} and \code{\link{loadtemplate}}.
#'
#' @seealso \code{\link{loaddata}}
#' @seealso \code{\link{whiten}}
#' @seealso \code{\link{loadtemplate}}
#' @useDynLib LIGOR
#' @importFrom Rcpp sourceCpp
#' @importFrom utils globalVariables
#' @docType package
#' @name LIGOR
NULL

utils::globalVariables(names = c("os",
                                 "Nonwindows",
                                 "Windows",
                                 "value",
                                 "agent",
                                 "count",
                                 "tz"))
