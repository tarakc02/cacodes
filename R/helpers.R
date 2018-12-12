lookup_code_type <- function(code_type) {
    dict <- c(
        PC = "PEN",
        VC = "VEH",
        HS = "HSC",
        BP = "BPC",
        MC = "MVC",
        FG = "FGC",
        IC = "INS",
        WI = "WIC",
        WC = "WAT",
        LC = "LAB",
        UI = "UIC",
        #CO = "",
        EL = "ELEC",
        GC = "GOV",
        #SD = "",
        RT = "RTC"
    )
    unname(dict[code_type])
}

