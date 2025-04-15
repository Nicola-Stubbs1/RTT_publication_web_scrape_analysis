
# Import libraries
library(readxl)
library(openxlsx)
library(tidyverse)
library(rvest)

# Aim - to download the RTT WLMDS Management information file on NHSE's Statistics webpage 

# Webpage url - to search
rtt_url <- "https://www.england.nhs.uk/statistics/statistical-work-areas/rtt-waiting-times/wlmds/" 

# Folder path including file name for the Excel file to be downloaded
folder_path <- "Files/rtt_file.xlsx"

# Adding this section to change text later on if changes to url text (This feeds in to the matching links section)
start_text_rtt_url <- "https://www.england.nhs.uk/statistics/"
end_text_rtt_url <- ".xlsx"

# create variable to later add the file URL
rtt_xlsx_url <- NULL 

# read the (HTML) content of the webpage
read_page_content <- read_html(rtt_url)

#--------- AI help with CSS & HTML -------------
# Find all hyperlink elements (<a> tags)
links <- read_page_content %>% html_elements("a") 
  
# Extract the 'href' attribute (the URL) from each link
hrefs <- links %>% html_attr("href")
  
# Remove potential NA values - links without an href attribute
hrefs <- hrefs[!is.na(hrefs)]
# number of links found
print(paste("Found", length(hrefs), "total links."))
  
# Filter the links - Must start with "https://www.england.nhs.uk/statistics/" 
# &  end with ".xlsx"
matching_links <- hrefs[
  startsWith(hrefs, start_text_rtt_url) & 
    str_ends(tolower(hrefs), end_text_rtt_url)
  ]
  
  # --- Handle the results ---
num_found <- length(matching_links)
  
#---------------------------------------------------

# Counts the matching links then if else statements manage how to handle the link
# == 1 - use the link, more than one match, use the first match (may need to change this or make the start & end text more dynamic)
# else print message - no links
if (num_found == 1) {
    found_xlsx_url <- matching_links[1]
    print(paste("Found one matching .xlsx link:", found_xlsx_url))
  } else if (num_found > 1){
    # Found multiple matching links
    print(paste("Warning: Found multiple (", num_found, ") matching .xlsx links:"))
    for(i in 1:num_found) {
      print(paste("- ", matching_links[i]))
    }
    # Uses the first match
    found_xlsx_url <- matching_links[1] 
  } else {
  print("No .xlsx links starting with 'https://' found on the page.")
  }

########################################
#    TO ADD EXCEL DOWNLOAD THEN IMPORT 
#  Considerations on which sheets and cleaning data
