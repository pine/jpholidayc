require "../spec_helper"

class InitialMockedHolidayJp < JpHoliday::HolidayJp
  def initialize(@holiday_jp : Hash(String, Bool))
  end
end

describe JpHoliday::HolidayJp do
  describe "new" do
    it "# not cached" do
      cache : MockedCache?

      WebMock.stub(:get, JpHoliday::HolidayJp::URL)
        .to_return(body: "1970-01-01:
    date: 1970-01-01
    week: 木
    week_en: Thursday
    name: 元日
    name_en: \"New Year's Day\"")

      begin
        cache      = MockedCache.new("config")
        holiday_jp = JpHoliday::HolidayJp.new(cache)
        dt         = Time.new(1970, 1, 1)
        holiday_jp.is_holiday(dt).should eq(true)
      ensure
        cache.try &.dispose
      end

      WebMock.reset
    end

    it "# cached" do
      cache : MockedCache?

      begin
        cache = MockedCache.new("config")
        cache.set({ "1970-01-01" => true })

        holiday_jp = JpHoliday::HolidayJp.new(cache)
        dt         = Time.new(1970, 1, 1)
        holiday_jp.is_holiday(dt).should eq(true)
      ensure
        cache.try &.dispose
      end
    end
  end

  describe "is_holiday" do
    holiday_jp = InitialMockedHolidayJp.new({ "2016-11-13" => true } of String => Bool)

    it "# holiday" do
      dt = Time.new(2016, 11, 13)
      holiday_jp.is_holiday(dt).should eq(true)
    end

    it "# not holiday" do
      dt = Time.new(2016, 11, 14)
      holiday_jp.is_holiday(dt).should eq(false)
    end
  end
end
