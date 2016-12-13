require "json"

class JpHoliday::Cache
  DATA_DIR   = "~/.jpholidayc"
  CACHE_DAYS = 5
  CACHE_FILE = "cache"

  def initialize
    @cache_dir = File.expand_path(DATA_DIR)
    @cache_path = File.join(@cache_dir, CACHE_FILE)

    Dir.mkdir_p @cache_dir
  end

  def get : Hash(String, Bool)?
    begin
      dat = Container.from_json(File.read(@cache_path, encoding: "utf-8"))
      if dat.expires <= Time.now
        nil
      else
        dat.val
      end
    rescue e : JSON::ParseException
      nil
    rescue e : Errno
      unless e.errno == Errno::ENOENT
        raise e
      end
      nil
    end
  end

  def set(val : Hash(String, Bool))
    expires = Time.now + CACHE_DAYS.days
    dat = Container.new(expires, val)

    File.write(@cache_path, dat.to_json, encoding: "utf-8")
  end

  class Container
    JSON.mapping(
      expires: Time,
      val: Hash(String, Bool),
    )

    def initialize(@expires : Time, @val : Hash(String, Bool))
    end
  end
end
