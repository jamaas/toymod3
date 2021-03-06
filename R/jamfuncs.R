#' Test function level 1
#' @param num.sim first variable for function 1
#' @param num.per second variable for function 1
#' @param num.day third variable for function 1
#' @export fun1

fun1 <- function (num.sim=10, num.per=8, num.day=5,...) {
    final.results <- data.frame (foreach::`%dopar%`(
            foreach::`%:%`(foreach::foreach(j = 1:num.sim,
                           .combine = cbind,
                           .export = c (ls(globalenv())),
                           .packages= c("toymod3")),
                           foreach::foreach (i = 1:num.per, .combine=rbind)),
            {
                out3 <- replicate(num.day, eval(call("fun2")))
                                            }
                           )
            )
            ## save outputs for subsequent analyses if required
            saveRDS(final.results, file = paste("./outputs/", num.day ,"_",
                                        num.per, "_", num.sim, "_",
                                        format(Sys.time(), "%d_%m_%Y"),
                                        ".rds", sep=""))
return(final.results)
}

#' Test function level 2
#' @param var21 first variable for function 2
#' @param var22 second variable for function 2
#' @export fun2

fun2 <- function (var21=0.5, var22=5, ...) {
    out2 <- ifelse (rpois(1, var21) > 0, var22 * fun3(...), 0)
}

#' Test function level 3
#' @param var31 first variable for function 3
#' @param var32 second variable for function 3
#' @param var33 third variable for function 3
#' @param fun3on turn the formula on or off
#' @export fun3

fun3 <- function (...) {
    out3 <- ifelse (fun3on==TRUE, var31, 1)
}

