context("creating URLs for CA Leg website")

test_that("gets correct URL for clean input", {
    code <- "HSC"
    section <- "11364"
    url <- build_url(list(code = code, section = section))
    expect_identical(url, "https://leginfo.legislature.ca.gov/faces/codes_displaySection.xhtml?lawCode=HSC&sectionNum=11364")
})
