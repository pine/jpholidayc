require "tempfile"

class MockedCache < JpHoliday::Cache
  def initialize(name : String)
    @tempfile = Tempfile.new(name)
    @cache_path = @tempfile.path
    @cache_dir = File.dirname(@cache_path)
  end

  def dispose
    @tempfile.delete
  end
end
