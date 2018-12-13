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

dl_url <- function(url) {
    structure(xml2::read_html(url), orig_input = )
}

#' Download legislative info related to legal codes
#' 
#' @param codes A vector of legal codes
#' @importFrom dplyr %>%
#' @export
leg_info <- function(codes) {
    clean_codes <- sanitize(codes)
    urls <- build_url(clean_codes)
    dl_url <- function(url, index) {
        structure(xml2::read_html(url),
                  orig_input = codes[index])
    }

    structure(purrr::imap(urls, dl_url),
              class = "ca_leg_info")
}

#' @export
as.character.ca_leg_info <- function(x, ..., detail = FALSE) {
    nodes <- if (detail) c("p, h4, h5, h6") else c("h4, h5, h6")
    purrr::map(x, ~rvest::html_nodes(., nodes) %>% rvest::html_text()) %>%
        purrr::map_chr(paste, collapse = "\n")
}

#' @export
print.ca_leg_info <- function(x, ..) {
    to_print <- stringr::str_wrap(as.character(x, detail = TRUE),
                                  width =  80, exdent = 4, indent = 4)
    disp <- function(index)
        cat("\n", attr(x[[index]], "orig_input"), "~~~~~~~~~~~~~\n",
            stringr::str_sub(to_print[[index]], 1, 350), "...\n")
    purrr::map(seq_along(x), disp)
    invisible(x)
}
