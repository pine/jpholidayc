require "./jpholiday/*"

if ARGV.includes? "-v"
  puts "v#{JpHoliday::VERSION}"
  exit JpHoliday::EXIT_INFO
end

calendar = JpHoliday::Calendar.new

if calendar.is_holiday(Time.now)
  exit JpHoliday::EXIT_HOLIDAY
else
  exit JpHoliday::EXIT_WEEKDAY
end
