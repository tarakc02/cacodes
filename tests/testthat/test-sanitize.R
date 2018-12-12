context("Input is parsed into code + section")

test_that("standard codes are parsed correctly", {
    input <- c("PC 602", "VC 23153", "HS 11377(A)")    
    sanitized <- sanitize(input)

    expect_identical(
        sanitized,
        list(code    = c("PEN", "VEH", "HSC"),
             section = c("602", "23153", "11377"))
    )
})
