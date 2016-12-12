require "./jpholiday/*"

calendar = JpHoliday::Calendar.new

if calendar.is_holiday(Time.now)
  exit JpHoliday::EXIT_HOLIDAY
else
  exit JpHoliday::EXIT_WEEKDAY
end
