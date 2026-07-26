library(qrcode)
code <- qr_code("https://marclos.github.io/aquatic-ecology-SLC/")
plot(code, main="Aquatic Ecology Sessions")

library(ggplot2)


# Make your QR code
p <- plot(code)

# Add a title
p + labs(title = "Scan This Code")
