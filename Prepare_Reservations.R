
args <- commandArgs(trailingOnly=TRUE)
if (length(args)==2L) {
  input <- args[1]; out <- args[2]
} else if (interactive()) {
  input <- file.choose(); out <- file.path(dirname(input),'DWBI_prepared')
} else stop('Provide input CSV and output folder')
hotel <- read.csv(input,stringsAsFactors=FALSE,na.strings=c('','NA','NULL'))
cols <- c('Booking_ID','no_of_adults','no_of_children','no_of_weekend_nights',
 'no_of_week_nights','type_of_meal_plan','required_car_parking_space',
 'room_type_reserved','lead_time','arrival_year','arrival_month','arrival_date',
 'market_segment_type','repeated_guest','no_of_previous_cancellations',
 'no_of_previous_bookings_not_canceled','avg_price_per_room',
 'no_of_special_requests','booking_status')
stopifnot(all(cols %in% names(hotel)))
hotel <- hotel[cols]
stopifnot(nrow(hotel)==36275L,!anyNA(hotel),!anyDuplicated(hotel$Booking_ID))
stopifnot(all(hotel$booking_status %in% c('Canceled','Not_Canceled')))
txt <- sprintf('%04d-%02d-%02d',as.integer(hotel$arrival_year),
               as.integer(hotel$arrival_month),as.integer(hotel$arrival_date))
dt <- as.Date(txt,format='%Y-%m-%d')
valid <- !is.na(dt) & format(dt,'%Y-%m-%d')==txt
dt[is.na(valid) | !valid] <- as.Date(NA)
hotel$arrival_date_full <- dt
hotel$invalid_arrival_date <- as.integer(is.na(dt))
hotel$total_nights <- hotel$no_of_weekend_nights+hotel$no_of_week_nights
hotel$total_guests <- hotel$no_of_adults+hotel$no_of_children
hotel$cancellation_flag <- as.integer(hotel$booking_status=='Canceled')
stopifnot(sum(hotel$invalid_arrival_date)==37L,
          sum(hotel$cancellation_flag)==11885L,
          sum(hotel$total_nights)==109370L,sum(hotel$total_guests)==70745L)
dir.create(out,recursive=TRUE,showWarnings=FALSE)
target <- file.path(out,'Hotel_Reservations_Cleaned.csv')
stopifnot(tolower(normalizePath(input,winslash='/')) !=
          tolower(normalizePath(target,winslash='/',mustWork=FALSE)))
write.csv(hotel,target,row.names=FALSE,na='',fileEncoding='UTF-8')
stopifnot(nrow(read.csv(target))==36275L)
print(data.frame(rows=nrow(hotel),cancelled=sum(hotel$cancellation_flag),
                 invalid_dates=sum(hotel$invalid_arrival_date)))
message('Copy the output CSV and supplied calendar JSON to the SQL Server import folder.')

csv_path <- file.choose()
cat("Selected file:", csv_path, "\n")
cat(readLines(csv_path, n = 3), sep = "\n")

d <- read.csv(
  csv_path,
  colClasses = "character",
  check.names = FALSE,
  na.strings = "",
  stringsAsFactors = FALSE
)

stopifnot(nrow(d) == 36275, ncol(d) == 24)
stopifnot(!any(grepl("[\t\r\n]", unlist(d)), na.rm = TRUE))

tsv_path <- sub("\\.csv$", ".tsv", csv_path, ignore.case = TRUE)
con <- file(tsv_path, open = "wb")

write.table(
  d, file = con, sep = "\t", eol = "\n",
  quote = FALSE, row.names = FALSE, na = ""
)

close(con)
cat("Created:", tsv_path, "\n")