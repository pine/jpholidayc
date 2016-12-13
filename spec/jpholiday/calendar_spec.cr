require "../spec_helper"

class NonCommunicatedCalendar < JpHoliday::Calendar
  def is_national_holiday(dt : Time) : Bool
    false
  end
end

class NationalMockedCalendar < JpHoliday::Calendar
  setter mocked_is_national_holiday : Bool?

  def is_national_holiday(dt : Time) : Bool
    @mocked_is_national_holiday.not_nil!
  end
end

describe JpHoliday::Calendar do
  describe "is_holiday" do
    it "# saturday" do
      cal = NonCommunicatedCalendar.new
      dt  = Time.new(2016, 12, 10) # saturday
      cal.is_holiday(dt).should eq(true)
    end

    it "# sunday" do
      cal = NonCommunicatedCalendar.new
      dt  = Time.new(2016, 12, 11) # sunday
      cal.is_holiday(dt).should eq(true)
    end

    it "# monday" do
      cal = NonCommunicatedCalendar.new
      dt  = Time.new(2016, 12, 12) # monday
      cal.is_holiday(dt).should eq(false)
    end

    it "# national" do
      cal = NationalMockedCalendar.new
      dt  = Time.new(2016, 12, 12) # monday

      cal.mocked_is_national_holiday = true
      cal.is_holiday(dt).should eq(true)

      cal.mocked_is_national_holiday = false
      cal.is_holiday(dt).should eq(false)
    end
  end
end
