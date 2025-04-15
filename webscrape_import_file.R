
# Import libraries
library(readxl)
library(openxlsx)
library(rvest)

# Aim - to download the RTT WLMDS Management information file on NHSE's Statistics webpage 

# Webpage url - to search
rtt_url <- "https://www.england.nhs.uk/statistics/statistical-work-areas/rtt-waiting-times/wlmds/" 

# Folder path including file name for the Excel file to be downloaded
folder_path <- "Files/rtt_file.xlsx"

# create variable to later add the file URL
rtt_xlsx_url <- NULL 

# read the (HTML) content of the webpage
read_page_content <- read_html(rtt_url)

