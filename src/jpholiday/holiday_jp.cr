require "http/client"
require "yaml"

require "./cache"
require "./exit_code"

class JpHoliday::HolidayJp
  URL = "https://raw.githubusercontent.com/k1LoW/holiday_jp/master/holidays.yml"

  @holiday_jp : Hash(String, Bool)

  def initialize
    cache = Cache.new

    if dat = cache.get
      @holiday_jp = dat
      return
    end

    res = HTTP::Client.get(URL)
    dat = {} of String => Bool

    if res.success?
      obj = YAML.parse(res.body)
      dat = obj.as_h.keys.map { |k| {k.to_s, true} }.to_h
      cache.set(dat)
    else
      puts "#{res.status_code} #{res.status_message}"
      exit EXIT_ERROR
    end

    @holiday_jp = dat
  end

  def is_holiday(dt : Time) : Bool
    @holiday_jp.has_key? dt.to_s("%Y-%m-%d")
  end
end
