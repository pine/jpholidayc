require "./holiday_jp"

class JpHoliday::Calendar
  def is_holiday(dt : Time) : Bool
    if dt.saturday? || dt.sunday?
      true
    elsif is_national_holiday(dt)
      true
    else
      false
    end
  end

  def is_national_holiday(dt : Time) : Bool
    holiday_jp = HolidayJp.new
    holiday_jp.is_holiday(dt)
  end
end
