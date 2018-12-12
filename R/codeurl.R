build_url <- function (sanitized_codes) {
    paste0("https://leginfo.legislature.ca.gov/faces/codes_displaySection.xhtml?lawCode=",
           sanitized_codes$code,
           "&sectionNum=",
           sanitized_codes$section)

}

sanitize <- function(codes) {
    matches <- stringr::str_match(codes, "([A-Z]{2})\\s+([0-9]+).*?$")
    code_type <- matches[, 2, drop = TRUE]
    code_num  <- matches[, 3, drop = TRUE]
    code_type <- lookup_code_type(code_type)
    list(code = code_type, section = code_num)
}

#' Download legislative info related to legal codes
#' 
#' @param codes A vector of legal codes
#' @importFrom dplyr %>%
leg_info <- function(codes) {
    codes %>%
        sanitize %>%
        build_url %>%
        map(xml2::read_html) %>%
        map(~rvest::html_nodes(., "h4") %>% rvest::html_text()) %>%
        map_chr(paste, collapse = "\n")
}
