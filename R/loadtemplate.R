#' Read template properties from a local xml file
#'
#' @description Read template properties from a local xml file
#'
#' @param filename the name of the xml file to be read
#'
#' @export
#'
#' @import XML
#' @import xml2
#' 
#' @importFrom utils head
#' @importFrom magrittr %>%
#'
#' @keywords data
#'


##
## Begin emilie2 code
##


loadtemplate <- function(filename) {
  
  # extract metadata from the template file
  
  xml <- read_xml(x = filename)
  
  template_xpath <- "//hdf5:Dataset[@Name='template']/hdf5:Data/hdf5:DataFromFile"
  t_m1_xpath <- "//hdf5:Group[@Name='meta']/hdf5:Attribute[@Name='m1']/hdf5:Data/hdf5:DataFromFile"
  t_m2_xpath <- "//hdf5:Group[@Name='meta']/hdf5:Attribute[@Name='m2']/hdf5:Data/hdf5:DataFromFile"
  t_a1_xpath <- "//hdf5:Group[@Name='meta']/hdf5:Attribute[@Name='a1']/hdf5:Data/hdf5:DataFromFile"
  t_a2_xpath <- "//hdf5:Group[@Name='meta']/hdf5:Attribute[@Name='a2']/hdf5:Data/hdf5:DataFromFile"
  t_approx_xpath <- "//hdf5:Group[@Name='meta']/hdf5:Attribute[@Name='approx']/hdf5:Data/hdf5:DataFromFile"

  template <- xml_find_all(x=xml, xpath = template_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% strsplit(., " ") 
  t_m1 <- xml_find_all(x=xml, xpath = t_m1_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% as.numeric(.)
  t_m2 <- xml_find_all(x=xml, xpath = t_m2_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% as.numeric(.)
  t_a1 <- xml_find_all(x=xml, xpath = t_a1_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% as.numeric(.)
  t_a2 <- xml_find_all(x=xml, xpath = t_a2_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% as.numeric(.)
  t_approx <- xml_find_all(x=xml, xpath = t_a2_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) 

  #divide template into plus and cross templates
  
  l <- length(template[[1]])
  
  template_p <- as.numeric(template[[1]][1:l/2])
  template_c <- as.numeric(template[[1]][l/2+1:l])
 
  return(list(template_p, template_c, t_m1, t_m2, t_a1, t_a2, t_approx))

}


##
## End emilie2 code
##
