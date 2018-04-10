#' Whiten the data
#'
#' @description Divide the data by the noise amplitude spectrum in the Fourier domain
#'
#' @param strain the strain of a given detector, namely \code{H1} or \code{L1}
#' @param interp_psd the corresponding template
#' @param dt the frequency step size
#'
#' @export
#'
#' @importFrom utils head
#' @importFrom RSEIS INVRft
#' @importFrom RSEIS FRWDft
#'
#' @keywords ts
#'


##
## Begin emilie2 code
##

whiten <- function(strain, interp_psd, dt) {
  
  strain_noNA <- strain[!is.na(strain)]
  
  f_Nyquist <- 1 / 2 / dt
  freqs <- f_Nyquist*c(seq(length(strain_noNA)/2), -rev(seq(length(strain_noNA)/2)))/(length(strain_noNA)/2)

  # transform to frequency domain
  hf = FRWDft(strain_noNA,length(strain_noNA),0,dt)$G
  
  # divide by asd
  white_hf = hf/sqrt(interp_psd(freqs)/dt/2)
  
  # transform back while taking care of normalization 
  white_hf_noNA <- white_hf[!is.na(white_hf)]
  white_ht = INVRft(Re(white_hf_noNA), length(strain_noNA),0,dt)

  return (Re(white_ht$g))
  
}


##
## End emilie2 code
##
