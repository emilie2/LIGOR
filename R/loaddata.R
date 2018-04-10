#' Read the event properties from a local xml file
#'
#' @description Read the event properties from a local xml file
#'
#' @param filename the name of the xml file to be read
#' @param ifo to specify which detector we are looking at, namely \code{H1} or \code{L1}
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


#The input filename should be a LOSC .xml file 
#The detector should be H1, H2, or L1.
#
#The return value is:
#  STRAIN, TIME
#
#STRAIN is a vector of strain values
#TIME is a vector of time values to match the STRAIN vector

loaddata <- function(filename, ifo=None) {

  xml <- read_xml(x = filename)
  strain_xpath <- "//hdf5:Dataset[@Name='Strain']/hdf5:Data/hdf5:DataFromFile"
  gpsStart_xpath <- "//hdf5:Dataset[@Name='GPSstart']/hdf5:Data/hdf5:DataFromFile"
  ts_xpath <- "//hdf5:Dataset[@Name='Strain']/hdf5:Attribute[@Name='Xspacing']/hdf5:Data/hdf5:DataFromFile"
  qmask_xpath <- "//hdf5:Dataset[@Name='DQmask']/hdf5:Data/hdf5:DataFromFile"
  shortnameList_xpath <- "//hdf5:Dataset[@Name='DQShortnames']/hdf5:Data/hdf5:DataFromFile"
  injmask_xpath <- "//hdf5:Dataset[@Name='Injmask']/hdf5:Data/hdf5:DataFromFile"
  injnameList_xpath <- "//hdf5:Dataset[@Name='InjShortnames']/hdf5:Data/hdf5:DataFromFile"

  strain <- xml_find_all(x=xml, xpath = strain_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% strsplit(., " ") 
  gpsStart <- xml_find_all(x=xml, xpath = gpsStart_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% as.numeric(.)
  ts <- xml_find_all(x=xml, xpath = ts_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% as.numeric(.)
  qmask <- xml_find_all(x=xml, xpath = qmask_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% strsplit(., " ")
  shortnameList <- xml_find_all(x=xml, xpath = shortnameList_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("[\"]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE)  %>% strsplit(., " ")
  injmask <- xml_find_all(x=xml, xpath = injmask_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE) %>% strsplit(., " ")
  injnameList <- xml_find_all(x=xml, xpath = injnameList_xpath) %>% xml_contents %>% gsub("[\n]","",.) %>% gsub("[\"]","",.) %>% gsub("^ *|(?<= ) | *$", "", ., perl = TRUE)  %>% strsplit(., " ")

  # create the time vector
  gpsEnd <- gpsStart + length(qmask[[1]])
  time = seq(gpsStart, gpsEnd, by=ts)
  
  # strain is a vector of strain values
  # time is a vector of time values to match the strain vector

  return(list(strain, time))

}


##
## End emilie2 code
##
