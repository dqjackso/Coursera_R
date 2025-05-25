# Get the ZIP
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

# Unzip the file
unzip("NEI_data.zip")

# Read data into R environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot1.R
plot(aggregate(Emissions ~ year, data=NEI,FUN=sum),
     col = "black",
     type = "b",
     main = "Total PM2.5 Emmissions")

axis(1, at = c(1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008))

# Get the ZIP
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

# Unzip the file
unzip("NEI_data.zip")

# Read data into R environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot2.R
plot(aggregate(Emissions ~ year, data = subset(NEI, fips == "24510"),FUN=sum),
     col = "purple",
     type = "b",
     main = "Baltimore, MD Total PM2.5 Emmissions")

axis(1, at = c(1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008))

# Get the ZIP
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

# Unzip the file
unzip("NEI_data.zip")

# Read data into R environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)
library(tidyverse)

Baltimore <- subset(NEI, fips == "24510")

point <- subset(Baltimore, type == "POINT")
p <- aggregate(Emissions ~ year, data = point, FUN = sum)
p$Type <- "POINT"

nonpoint <- subset(Baltimore, type == "NONPOINT")
n <- aggregate(Emissions ~ year, data = nonpoint, FUN = sum)
n$Type <- "NONPOINT"

on_road <- subset(Baltimore, type == "ON-ROAD")
o <- aggregate(Emissions ~ year, data = on_road, FUN = sum)
o$Type <- "ON-ROAD"

non_road <- subset(Baltimore, type == "NON-ROAD")
non <- aggregate(Emissions ~ year, data = non_road, FUN = sum)
non$Type <- "NON-ROAD"

df_list <- list(p,n,o,non)
combined <- reduce(df_list, full_join)

ggplot(combined, aes(year, Emissions, colour = Type)) + geom_point() + geom_line() + labs(title = "Total PM2.5 Emissions by Type", x = "Year", y = "Total Emissions") + theme_minimal()

# Get the ZIP
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

# Unzip the file
unzip("NEI_data.zip")

# Read data into R environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot4.R
coal_code_subset <- SCC[grep("Coal", SCC$EI.Sector), ]

coal_data <- subset(NEI, SCC %in% coal_code_subset$SCC)

coal_totals <- aggregate(Emissions ~ year, data = coal_data, FUN = sum)

ggplot(coal_totals, aes(year, Emissions, colour = year)) + geom_point() + geom_line() + labs(title = "Coal PM2.5 Emissions", x = "Year", y = "Total Emissions") + theme_minimal()

# Get the ZIP
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

# Unzip the file
unzip("NEI_data.zip")

# Read data into R environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot5.R
vehicle_code_subset <- SCC[grep("Vehicles", SCC$EI.Sector), ]

baltimore_vehicle_data <- subset(Baltimore, SCC %in% vehicle_code_subset$SCC)

baltimore_vehicle_totals <- aggregate(Emissions ~ year, data = baltimore_vehicle_data, FUN = sum)

ggplot(baltimore_vehicle_totals, aes(year, Emissions, colour = year)) + geom_point() + geom_line() + labs(title = "Vehicle PM2.5 Emissions in Baltimore, MD", x = "Year", y = "Total Emissions") + theme_minimal()

# Get the ZIP
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI_data.zip")

# Unzip the file
unzip("NEI_data.zip")

# Read data into R environment
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot6.R
LA <- subset(NEI, fips == "06037")
Baltimore <- subset(NEI, fips == "24510")

vehicle_code_subset <- SCC[grep("Vehicles", SCC$EI.Sector), ]

LA_vehicle_data <- subset(LA, SCC %in% vehicle_code_subset$SCC)

LA_vehicle_totals <- aggregate(Emissions ~ year, data = LA_vehicle_data, FUN = sum)

baltimore_vehicle_data <- subset(Baltimore, SCC %in% vehicle_code_subset$SCC)

baltimore_vehicle_totals <- aggregate(Emissions ~ year, data = baltimore_vehicle_data, FUN = sum)

par(mfrow = c(1,2))

with(LA_vehicle_totals, plot(Emissions ~ year,
                             col = "red",
                             type = "b",
                             main = "LA PM2.5 Emmissions"))

with(LA_vehicle_totals, abline(lm(Emissions ~ year), col = "green"))

with(baltimore_vehicle_totals, plot(Emissions ~ year,
                                    col = "blue",
                                    type = "b",
                                    main = "Baltimore PM2.5 Emmissions"))

with(baltimore_vehicle_totals, abline(lm(Emissions ~ year), col = "green"))